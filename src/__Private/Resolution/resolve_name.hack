/*
 *  Copyright (c) 2017-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

namespace Facebook\HHAST\__Private\Resolution;

use namespace HH\Lib\{C, Str, Vec};
use type Facebook\HHAST\{Node, Script};

function resolve_name(
  string $name,
  Script $root,
  Node $node,
  dict<string, string> $used_namespaces,
): string {
  if (Str\starts_with($name, '\\')) {
    return Str\strip_prefix($name, '\\');
  }
  invariant(
    !Str\contains($name, '<'),
    'Call on the class name without generics',
  );

  $autoimports = keyset[
    'Awaitable',
    'ConstMap',
    'ConstSet',
    'ConstVector',
    'Container',
    'ImmMap',
    'ImmSet',
    'ImmVector',
    'KeyedContainer',
    'KeyedTraversable',
    'Map',
    'Set',
    'Stringish',
    'Traversable',
    'Vector',
  ];
  if (C\contains_key($autoimports, $name)) {
    return 'HH\\'.$name;
  }

  $ns = get_current_namespace($root, $node);

  if (Str\contains($name, '\\')) {
    $maybe_aliased = $name
      |> \explode("\\", $$)
      |> C\firstx($$);
    if (C\contains_key($used_namespaces, $maybe_aliased)) {
      return $name
        |> \explode('\\', $$)
        |> Vec\drop($$, 1)
        |> Str\join($$, '\\')
        |> $used_namespaces[$maybe_aliased].'\\'.$$;
    }

    if ($ns !== null) {
      return $ns.'\\'.$name;
    }
    return $name;
  }

  if ($ns !== null) {
    return $ns.'\\'.$name;
  }

  return $name;
}