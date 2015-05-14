class Example

  post_only
  def method1
  end
  # Method name style blends in too much.

  post_only
  def method2
  end
  # Well that’s one way to make it different.

  post_only; def method3
  end
  # Ugly ; symbol, and the ‘def’ is too far right to read easily.
  # Plus it’s too long if the annotation takes arguments.

  _PostOnly
  def method4
  end
  # Looks different to normal syntax, has a trailing _ to distinguish.
end