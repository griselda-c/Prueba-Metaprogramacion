class Persona

  def nombre(nombre)
    puts nombre
  end
end


define_method("saludo") do |argument|
  "hola #{argument}"
end

Persona.send(:alias_method,:nombre, :saludo)
p = Persona.new
puts p.nombre("carolina")