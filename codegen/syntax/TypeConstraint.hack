/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<8c7bd96e36d5064cef37bc7c1102f847>>
 */
namespace Facebook\HHAST;
use namespace Facebook\TypeAssert;
use namespace HH\Lib\Dict;

<<__ConsistentConstruct>>
final class TypeConstraint extends Node {

  const string SYNTAX_KIND = 'type_constraint';

  private Token $_keyword;
  private ITypeSpecifierOrContexts $_type;

  public function __construct(
    Token $keyword,
    ITypeSpecifierOrContexts $type,
    ?__Private\SourceRef $source_ref = null,
  ) {
    $this->_keyword = $keyword;
    $this->_type = $type;
    parent::__construct($source_ref);
  }

  <<__Override>>
  public static function fromJSON(
    dict<string, mixed> $json,
    string $file,
    int $initial_offset,
    string $source,
    string $_type_hint,
  ): this {
    $offset = $initial_offset;
    $keyword = Node::fromJSON(
      /* HH_FIXME[4110] */ $json['constraint_keyword'],
      $file,
      $offset,
      $source,
      'Token',
    );
    $keyword = $keyword as nonnull;
    $offset += $keyword->getWidth();
    $type = Node::fromJSON(
      /* HH_FIXME[4110] */ $json['constraint_type'],
      $file,
      $offset,
      $source,
      'ITypeSpecifierOrContexts',
    );
    $type = $type as nonnull;
    $offset += $type->getWidth();
    $source_ref = shape(
      'file' => $file,
      'source' => $source,
      'offset' => $initial_offset,
      'width' => $offset - $initial_offset,
    );
    return new static(
      /* HH_IGNORE_ERROR[4110] */ $keyword,
      /* HH_IGNORE_ERROR[4110] */ $type,
      $source_ref,
    );
  }

  <<__Override>>
  public function getChildren(): dict<string, Node> {
    return dict[
      'keyword' => $this->_keyword,
      'type' => $this->_type,
    ]
      |> Dict\filter_nulls($$);
  }

  <<__Override>>
  public function rewriteChildren<Tret as ?Node>(
    (function(Node, vec<Node>): Tret) $rewriter,
    vec<Node> $parents = vec[],
  ): this {
    $parents[] = $this;
    $keyword = $rewriter($this->_keyword, $parents);
    $type = $rewriter($this->_type, $parents);
    if ($keyword === $this->_keyword && $type === $this->_type) {
      return $this;
    }
    return new static(
      /* HH_FIXME[4110] use `as` */ $keyword,
      /* HH_FIXME[4110] use `as` */ $type,
    );
  }

  public function getKeywordUNTYPED(): ?Node {
    return $this->_keyword;
  }

  public function withKeyword(Token $value): this {
    if ($value === $this->_keyword) {
      return $this;
    }
    return new static($value, $this->_type);
  }

  public function hasKeyword(): bool {
    return $this->_keyword !== null;
  }

  /**
   * @return AsToken | SuperToken
   */
  public function getKeyword(): Token {
    return TypeAssert\instance_of(Token::class, $this->_keyword);
  }

  /**
   * @return AsToken | SuperToken
   */
  public function getKeywordx(): Token {
    return $this->getKeyword();
  }

  public function getTypeUNTYPED(): ?Node {
    return $this->_type;
  }

  public function withType(ITypeSpecifierOrContexts $value): this {
    if ($value === $this->_type) {
      return $this;
    }
    return new static($this->_keyword, $value);
  }

  public function hasType(): bool {
    return $this->_type !== null;
  }

  /**
   * @return ClassnameTypeSpecifier | ClosureTypeSpecifier | Contexts |
   * GenericTypeSpecifier | LikeTypeSpecifier | NullableTypeSpecifier |
   * ShapeTypeSpecifier | SimpleTypeSpecifier | TypeConstant |
   * VarrayTypeSpecifier | VectorTypeSpecifier
   */
  public function getType(): ITypeSpecifierOrContexts {
    return TypeAssert\instance_of(
      ITypeSpecifierOrContexts::class,
      $this->_type,
    );
  }

  /**
   * @return ClassnameTypeSpecifier | ClosureTypeSpecifier | Contexts |
   * GenericTypeSpecifier | LikeTypeSpecifier | NullableTypeSpecifier |
   * ShapeTypeSpecifier | SimpleTypeSpecifier | TypeConstant |
   * VarrayTypeSpecifier | VectorTypeSpecifier
   */
  public function getTypex(): ITypeSpecifierOrContexts {
    return $this->getType();
  }
}
