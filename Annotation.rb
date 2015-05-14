# Annotations module, enable in base class with “extend Annotations”
module Annotations
  # NOTE: See end of article for a link to download this code
  # along with a simple unit test. Also included are methods for
  # annotating classes.

  # Annotate the next method defined
  def annotate_method(annotation_name, value)
    _annotation_storage(:@_annotated_next_method)[annotation_name] = value
  end
  # Get a method annotation
  def annotation_get(method_name, annotation_name)
    m = self.instance_variable_get(:@_annotated_methods)
    (m == nil) ? nil : m[method_name][annotation_name]
  end
  private
  # Magic method to make this work
  def method_added(method_name)
    a = self.instance_variable_get(:@_annotated_next_method)
    if a != nil
      _annotation_storage(:@_annotated_methods,{})[method_name] = a
      self.instance_variable_set(:@_annotated_next_method, nil)
    end
    super
  end
  # Store data in the class variable
  def _annotation_storage(name, default = nil)
    a = self.instance_variable_get(name)
    if a == nil
      a = Hash.new(default)
      self.instance_variable_set(name, a)
    end
    a
  end
end
