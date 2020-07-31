/*
 *  Copyright (c) 2017-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

namespace Facebook\HHAST;

use namespace HH\Lib\{C, Str, Vec};

final class AsyncifyEntryPointMigration extends BaseMigration {

  private static function getEntryPoint(Script $script): ?FunctionDeclaration {
    return $script->getDeclarations()
      ->getChildrenOfType(FunctionDeclaration::class)
      |> Vec\filter(
        $$,
        $f ==> C\any(
          $f->getAttributeSpec()?->getAttributes()?->getChildrenOfItems() ??
            vec[],
          $attr ==> $attr->getType() is NameToken &&
            $attr->getType() as NameToken->getText() === '__EntryPoint',
        ),
      )
      |> C\first($$);
  }

  <<__Override>>
  public function migrateFile(string $path, Script $script): Script {
    $old = self::getEntryPoint($script);
    if ($old is null) {
      return $script;
    }

    if (!Str\contains($old->getCode(), 'Asio\\join')) {
      return $script;
    }

    invariant(
      $old->getDeclarationHeader()->getModifiers() is null,
      '%s has modifiers',
      $path,
    );

    $new = $old->rewriteDescendants(
      ($node, $_) ==> {
        if (!$node is FunctionCallExpression) {
          return $node;
        }
        if (!Str\contains($node->getReceiver()->getCode(), 'Asio\\join')) {
          return $node;
        }
        return new PrefixUnaryExpression(
          new AwaitToken(
            $node->getFirstTokenx()->getLeading(),
            NodeList::createMaybeEmptyList(vec[new WhiteSpace(' ')]),
          ),
          $node->getArgumentListx()->getChildrenOfItems() |> C\onlyx($$),
        );
      },
      vec[],
    );

    if ($new !== $old) {
      $h = $new->getDeclarationHeader();
      $fun = $h->getKeyword();
      $rt = $h->getTypex();
      $inner = $rt->replace(
        $rt->getFirstTokenx(),
        $rt->getFirstTokenx()->withLeading(null),
      );
      $inner = $inner->replace(
        $inner->getLastTokenx(),
        $inner->getLastTokenx()->withTrailing(null),
      );
      $new = $new->withDeclarationHeader(
        $h
          ->withModifiers(
            NodeList::createMaybeEmptyList(
              vec[new AsyncToken(
                $fun->getLeading(),
                NodeList::createMaybeEmptyList(vec[new WhiteSpace(' ')]),
              )],
            ),
          )
          ->withType(
            new GenericTypeSpecifier(
              new NameToken(
                $rt->getFirstTokenx()->getLeading(),
                null,
                'Awaitable',
              ),
              new TypeArguments(
                new LessThanToken(null, null),
                NodeList::createMaybeEmptyList(vec[
                  new ListItem($inner, null),
                ]),
                new GreaterThanToken(null, $rt->getLastTokenx()->getTrailing()),
              ),
            ),
          )
          ->replaceDescendant($fun, $fun->withLeading(null)),
      );
    }

    return $script->replaceDescendant($old, $new);
  }
}
