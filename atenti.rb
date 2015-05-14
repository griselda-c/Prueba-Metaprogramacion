class Atenti

  def compone proc1, proc2
    Proc.new do |x|
      proc2.call(proc1.call(x))
    end
  end

end

class TaxCalculator
  def initialize(name, &block)
    @name, @block = name, block
  end
  def getTax(amount)
    "#@name on #{amount} = #{ @block.call(amount) }"
  end
end
tc = TaxCalculator.new("Sales tax") { |amt| amt * 0.075 }
tc.getTax(100) #	»	"Sales tax on 100 = 7.5"
tc.getTax(250)	#»	"Sales tax on 250 = 18.75"

if __FILE__ == $0

  tc = TaxCalculator.new("Sales tax") { |amt| amt * 0.075 }
 puts tc.getTax(100) #	»	"Sales tax on 100 = 7.5"
  puts tc.getTax(250)	#»	"Sales tax on 250 = 18.75"


  def compone proc1, proc2
    Proc.new do |x|
      proc2.call(proc1.call(x))
    end
  end

  cuadrado = Proc.new do |x|
    x * x
  end

  doble = Proc.new do |x|
    x + x
  end

  dobleYCuadrado = compone doble, cuadrado
  cuadradoYDoble = compone cuadrado, doble

  puts dobleYCuadrado.call(5)
  puts cuadradoYDoble.call(5)

end

