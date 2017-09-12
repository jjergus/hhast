<?hh
/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<cbd91cb0647b121117295914c82614ff>>
 */
namespace Facebook\HHAST;
use type Facebook\TypeAssert\TypeAssert;

final class TypeConstant extends EditableSyntax {

  private EditableSyntax $_left_type;
  private EditableSyntax $_separator;
  private EditableSyntax $_right_type;

  public function __construct(
    EditableSyntax $left_type,
    EditableSyntax $separator,
    EditableSyntax $right_type,
  ) {
    parent::__construct('type_constant');
    $this->_left_type = $left_type;
    $this->_separator = $separator;
    $this->_right_type = $right_type;
  }

  public static function from_json(
    array<string, mixed> $json,
    int $position,
    string $source,
  ): this {
    $left_type = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['type_constant_left_type'],
      $position,
      $source,
    );
    $position += $left_type->width();
    $separator = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['type_constant_separator'],
      $position,
      $source,
    );
    $position += $separator->width();
    $right_type = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['type_constant_right_type'],
      $position,
      $source,
    );
    $position += $right_type->width();
    return new self($left_type, $separator, $right_type);
  }

  public function children(): KeyedTraversable<string, EditableSyntax> {
    yield 'left_type' => $this->_left_type;
    yield 'separator' => $this->_separator;
    yield 'right_type' => $this->_right_type;
  }

  public function rewrite_children(
    self::TRewriter $rewriter,
    ?Traversable<EditableSyntax> $parents = null,
  ): this {
    $parents = $parents === null ? vec[] : vec($parents);
    $parents[] = $this;
    $left_type = $this->_left_type->rewrite($rewriter, $parents);
    $separator = $this->_separator->rewrite($rewriter, $parents);
    $right_type = $this->_right_type->rewrite($rewriter, $parents);
    if (
      $left_type === $this->_left_type &&
      $separator === $this->_separator &&
      $right_type === $this->_right_type
    ) {
      return $this;
    }
    return new self($left_type, $separator, $right_type);
  }

  public function getLeftTypeUNTYPED(): EditableSyntax {
    return $this->_left_type;
  }

  public function withLeftType(EditableSyntax $value): this {
    if ($value === $this->_left_type) {
      return $this;
    }
    return new self($value, $this->_separator, $this->_right_type);
  }

  public function hasLeftType(): bool {
    return !$this->_left_type->is_missing();
  }

  public function getLeftType(): EditableSyntax {
    return TypeAssert::isInstanceOf(EditableSyntax::class, $this->_left_type);
  }

  public function getSeparatorUNTYPED(): EditableSyntax {
    return $this->_separator;
  }

  public function withSeparator(EditableSyntax $value): this {
    if ($value === $this->_separator) {
      return $this;
    }
    return new self($this->_left_type, $value, $this->_right_type);
  }

  public function hasSeparator(): bool {
    return !$this->_separator->is_missing();
  }

  public function getSeparator(): ColonColonToken {
    return TypeAssert::isInstanceOf(ColonColonToken::class, $this->_separator);
  }

  public function getRightTypeUNTYPED(): EditableSyntax {
    return $this->_right_type;
  }

  public function withRightType(EditableSyntax $value): this {
    if ($value === $this->_right_type) {
      return $this;
    }
    return new self($this->_left_type, $this->_separator, $value);
  }

  public function hasRightType(): bool {
    return !$this->_right_type->is_missing();
  }

  public function getRightType(): NameToken {
    return TypeAssert::isInstanceOf(NameToken::class, $this->_right_type);
  }
}