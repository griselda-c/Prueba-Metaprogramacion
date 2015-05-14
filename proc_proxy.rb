class ProcProxy

  instance_methods.each { |m| undef_method(m) unless m.to_s =~ /^__|respond_to\?|method_missing/ }

  def initialize(object, position = 1)
    @object, @position = object, position
  end

  def to_proc
    raise "Please specify a method to be called on the object" unless @delegation
    Proc.new { |*values| @object.__send__(*@delegation[:args].dup.insert(@position, *values), &@delegation[:block]) }
  end

  def method_missing(*args, &block)
    @delegation = { :args => args, :block => block }
    self
  end

end

class Symbol
  def to_proc
    Proc.new { |obj, *args| obj.send(self, *args) }
  end
end

puts [1, 2, 3].map(&:to_s)
puts [3, 4, 5].inject(&:*)


a_proc = Proc.new {|a, *b| b.collect {|i| i*a }}
a_proc.call(9, 1, 2, 3)   #=> [9, 18, 27]
