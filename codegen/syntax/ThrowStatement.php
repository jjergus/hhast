<?hh
/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<b9c8efee87b5b26f74d782801d90d698>>
 */
namespace Facebook\HHAST;
use type Facebook\TypeAssert\TypeAssert;

final class ThrowStatement extends EditableSyntax {

  private EditableSyntax $_keyword;
  private EditableSyntax $_expression;
  private EditableSyntax $_semicolon;

  public function __construct(
    EditableSyntax $keyword,
    EditableSyntax $expression,
    EditableSyntax $semicolon,
  ) {
    parent::__construct('throw_statement');
    $this->_keyword = $keyword;
    $this->_expression = $expression;
    $this->_semicolon = $semicolon;
  }

  public static function from_json(
    array<string, mixed> $json,
    int $position,
    string $source,
  ): this {
    $keyword = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['throw_keyword'],
      $position,
      $source,
    );
    $position += $keyword->width();
    $expression = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['throw_expression'],
      $position,
      $source,
    );
    $position += $expression->width();
    $semicolon = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['throw_semicolon'],
      $position,
      $source,
    );
    $position += $semicolon->width();
    return new self($keyword, $expression, $semicolon);
  }

  public function children(): KeyedTraversable<string, EditableSyntax> {
    yield 'keyword' => $this->_keyword;
    yield 'expression' => $this->_expression;
    yield 'semicolon' => $this->_semicolon;
  }

  public function rewrite_children(
    self::TRewriter $rewriter,
    ?Traversable<EditableSyntax> $parents = null,
  ): this {
    $parents = $parents === null ? vec[] : vec($parents);
    $parents[] = $this;
    $keyword = $this->_keyword->rewrite($rewriter, $parents);
    $expression = $this->_expression->rewrite($rewriter, $parents);
    $semicolon = $this->_semicolon->rewrite($rewriter, $parents);
    if (
      $keyword === $this->_keyword &&
      $expression === $this->_expression &&
      $semicolon === $this->_semicolon
    ) {
      return $this;
    }
    return new self($keyword, $expression, $semicolon);
  }

  public function getKeywordUNTYPED(): EditableSyntax {
    return $this->_keyword;
  }

  public function withKeyword(EditableSyntax $value): this {
    if ($value === $this->_keyword) {
      return $this;
    }
    return new self($value, $this->_expression, $this->_semicolon);
  }

  public function hasKeyword(): bool {
    return !$this->_keyword->is_missing();
  }

  public function getKeyword(): ThrowToken {
    return TypeAssert::isInstanceOf(ThrowToken::class, $this->_keyword);
  }

  public function getExpressionUNTYPED(): EditableSyntax {
    return $this->_expression;
  }

  public function withExpression(EditableSyntax $value): this {
    if ($value === $this->_expression) {
      return $this;
    }
    return new self($this->_keyword, $value, $this->_semicolon);
  }

  public function hasExpression(): bool {
    return !$this->_expression->is_missing();
  }

  public function getExpression(): EditableSyntax {
    return TypeAssert::isInstanceOf(EditableSyntax::class, $this->_expression);
  }

  public function getSemicolonUNTYPED(): EditableSyntax {
    return $this->_semicolon;
  }

  public function withSemicolon(EditableSyntax $value): this {
    if ($value === $this->_semicolon) {
      return $this;
    }
    return new self($this->_keyword, $this->_expression, $value);
  }

  public function hasSemicolon(): bool {
    return !$this->_semicolon->is_missing();
  }

  public function getSemicolon(): SemicolonToken {
    return TypeAssert::isInstanceOf(SemicolonToken::class, $this->_semicolon);
  }
}