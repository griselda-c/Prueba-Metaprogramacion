class Square
  def area
    @side * @side
  end

  def nombre(nombre)
    nombre
  end

  def initialize(side)
    @side = side
  end
end

class Pato
  def comer
    "comer"
  end

  def nuevo(method)
    puts "soy un aspecto"
    method.call
  end

  def otro_nombre(nombre)
    puts nombre
  end

  def full_name(nombre)
    puts nombre
    "hhhhhhhhhhhhhhhhhhhgggggggggggggg"
  end

  alias_method :otro_nombre, :full_name



end

area_un = Square.instance_method(:area)

s = Square.new(12)
p = Pato.new
area = area_un.bind(s)
puts p.nuevo(area)


define_method("saludo") do |argument|
  "hola #{argument}"
end

Pato.send(:alias_method,:otro_nombre, :saludo)

puts p.otro_nombre("carolina")




#puts area.class


#area.call   #=> 144