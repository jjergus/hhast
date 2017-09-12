<?hh
/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<c027e152e11fcdd91e62ee804d32d7c6>>
 */
namespace Facebook\HHAST;
use type Facebook\TypeAssert\TypeAssert;

final class XHPAttribute extends EditableSyntax {

  private EditableSyntax $_name;
  private EditableSyntax $_equal;
  private EditableSyntax $_expression;

  public function __construct(
    EditableSyntax $name,
    EditableSyntax $equal,
    EditableSyntax $expression,
  ) {
    parent::__construct('xhp_attribute');
    $this->_name = $name;
    $this->_equal = $equal;
    $this->_expression = $expression;
  }

  public static function from_json(
    array<string, mixed> $json,
    int $position,
    string $source,
  ): this {
    $name = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['xhp_attribute_name'],
      $position,
      $source,
    );
    $position += $name->width();
    $equal = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['xhp_attribute_equal'],
      $position,
      $source,
    );
    $position += $equal->width();
    $expression = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['xhp_attribute_expression'],
      $position,
      $source,
    );
    $position += $expression->width();
    return new self($name, $equal, $expression);
  }

  public function children(): KeyedTraversable<string, EditableSyntax> {
    yield 'name' => $this->_name;
    yield 'equal' => $this->_equal;
    yield 'expression' => $this->_expression;
  }

  public function rewrite_children(
    self::TRewriter $rewriter,
    ?Traversable<EditableSyntax> $parents = null,
  ): this {
    $parents = $parents === null ? vec[] : vec($parents);
    $parents[] = $this;
    $name = $this->_name->rewrite($rewriter, $parents);
    $equal = $this->_equal->rewrite($rewriter, $parents);
    $expression = $this->_expression->rewrite($rewriter, $parents);
    if (
      $name === $this->_name &&
      $equal === $this->_equal &&
      $expression === $this->_expression
    ) {
      return $this;
    }
    return new self($name, $equal, $expression);
  }

  public function getNameUNTYPED(): EditableSyntax {
    return $this->_name;
  }

  public function withName(EditableSyntax $value): this {
    if ($value === $this->_name) {
      return $this;
    }
    return new self($value, $this->_equal, $this->_expression);
  }

  public function hasName(): bool {
    return !$this->_name->is_missing();
  }

  public function getName(): XHPElementNameToken {
    return TypeAssert::isInstanceOf(XHPElementNameToken::class, $this->_name);
  }

  public function getEqualUNTYPED(): EditableSyntax {
    return $this->_equal;
  }

  public function withEqual(EditableSyntax $value): this {
    if ($value === $this->_equal) {
      return $this;
    }
    return new self($this->_name, $value, $this->_expression);
  }

  public function hasEqual(): bool {
    return !$this->_equal->is_missing();
  }

  public function getEqual(): ?EqualToken {
    if ($this->_equal->is_missing()) {
      return null;
    }
    return TypeAssert::isInstanceOf(EqualToken::class, $this->_equal);
  }

  public function getEqualx(): EqualToken {
    return TypeAssert::isInstanceOf(EqualToken::class, $this->_equal);
  }

  public function getExpressionUNTYPED(): EditableSyntax {
    return $this->_expression;
  }

  public function withExpression(EditableSyntax $value): this {
    if ($value === $this->_expression) {
      return $this;
    }
    return new self($this->_name, $this->_equal, $value);
  }

  public function hasExpression(): bool {
    return !$this->_expression->is_missing();
  }

  public function getExpression(): EditableSyntax {
    return TypeAssert::isInstanceOf(EditableSyntax::class, $this->_expression);
  }
}