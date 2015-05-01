class EspacioObjetos

  def get_clases(lista)
    lista.each { |clase| get_clase(clase)}
  end

  def get_clase(clase)
      ObjectSpace.each_object(Class).select { |k| k == clase }
  end

end

class Animal

end

class Mono < Animal

  def hola_mundo
    "hola soy un mono"
  end

end

class Camion

  def hola_mundo
    "hola soy un Camion"
  end

end

if __FILE__ == $0
puts  ObjectSpace.each_object(Class).select { |k| k == Mono }
  mono = Mono.new
 mono.class == Mono

  espacio = EspacioObjetos.new
  puts espacio.get_clases([Mono,Animal])

end