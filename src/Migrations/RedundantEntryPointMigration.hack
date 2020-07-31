/*
 *  Copyright (c) 2017-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

namespace Facebook\HHAST;

use namespace HH\Lib\{C, Regex, Str, Vec};

final class RedundantEntryPointMigration extends BaseMigration {

  private static function getEntryPoint(Script $script): ?FunctionDeclaration {
    return $script->getDeclarations()
      ->getChildrenOfType(FunctionDeclaration::class)
      |> Vec\filter(
        $$,
        $f ==> C\any(
          $f->getAttributeSpec()?->getAttributes()?->getChildrenOfItems() ??
            vec[],
          $attr ==>
            $attr->getType() is NameToken &&
            $attr->getType() as NameToken->getText() === '__EntryPoint',
        ),
      )
      |> C\first($$);
  }

  <<__Override>>
  public function migrateFile(string $path, Script $script): Script {
    $old_ep = self::getEntryPoint($script);
    if ($old_ep is null) {
      return $script;
    }

    $lines =
      $old_ep->getBody() as CompoundStatement->getStatementsx()->getChildren();

    $req_line = null;
    if (Str\contains($lines[0]->getCode(), 'require')) {
      $req_line = $lines[0];
      $lines = Vec\drop($lines, 1);
    }

    if (C\count($lines) > 1) {
      return $script;
    }

    $line = C\onlyx($lines);
    if (!$line is ExpressionStatement) {
      return $script;
    }

    $expr = $line->getExpressionx();
    if ($expr is PrefixUnaryExpression && $expr->getOperator() is AwaitToken) {
      $expr = $expr->getOperandx();
    }

    if (
      $expr is FunctionCallExpression &&
      Str\contains($expr->getReceiver()->getCode(), 'Asio\\join')
    ) {
      $expr = C\onlyx($expr->getArgumentListx()->getChildrenOfItems());
    }

    if (!$expr is FunctionCallExpression) {
      return $script;
    }

    $name = $expr->getReceiver();
    if (!$name is NameToken) {
      return $script;
    }
    $name = $name->getText();

    $new_decl = vec[];
    $found = false;
    foreach ($script->getDeclarations()->getChildren() as $decl) {
      if ($decl === $old_ep) {
        // skip
        continue;
      }
      if (
        !$decl is FunctionDeclaration ||
        $decl->getDeclarationHeader()->getName()->getCode() !== $name
      ) {
        // copy without change
        $new_decl[] = $decl;
        continue;
      }
      $found = true;
      invariant(
        $decl->getAttributeSpec() is null,
        '%s already has attribs',
        $name,
      );
      $leading = $decl->getFirstTokenx()->getLeading();
      $decl = $decl->replaceDescendant(
        $decl->getFirstTokenx(),
        $decl->getFirstTokenx()->withLeading(null),
      );
      if ($req_line is nonnull) {
        $body = $decl->getBody() as CompoundStatement->getStatementsx();
        $decl = $decl->replaceDescendant(
          $body,
          NodeList::createMaybeEmptyList(Vec\concat(
            vec[$req_line],
            $body->getChildren()
          ))
        );
      }
      $new_decl[] = $decl->withAttributeSpec(
        new OldAttributeSpecification(
          new LessThanLessThanToken($leading, null),
          NodeList::createMaybeEmptyList(vec[
            new ListItem(
              new ConstructorCall(
                new NameToken(null, null, '__EntryPoint'),
                null,
                null,
                null,
              ),
              null,
            ),
          ]),
          new GreaterThanGreaterThanToken(
            null,
            NodeList::createMaybeEmptyList(vec[new EndOfLine("\n")]),
          ),
        ),
      );
    }

    invariant($found, '%s not found', $name);

    return $script->withDeclarations(NodeList::createMaybeEmptyList($new_decl));
  }
}
