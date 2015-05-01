class EspacioObjetos

  @observados = []

  def get_clases(lista,metodo)
    @observados = lista.each { |clase| get_clase(clase,metodo)}
  end

  #aca quiero pasar por parametro el simbolo == o < para las subclases
  def get_clase(clase,metodo)
     @observados =  ObjectSpace.each_object(Class).select { |k| k.send(metodo,clase) }
  end

  #get_metodos_de una clase o subclase
  def get_metodos_de(clase,metodo)
    lista = get_clase(clase,metodo)
    lista.map{|klass| klass.instance_methods(false)}.inject{|a,b| a+b }
  end

  #get_metodos_que "empiecen con", "esten en un conjunto", "que se llame"
  def get_metodos_que_empiecen(letras)
    lista = get_all_methods
    lista.select{|metodo| metodo[0..letras.size].include? letras}
  end

  def get_all_methods()
    #ObjectSpace.each_object(Class).map{|k| k.instance_methods(false)}
     @observados.map{|k| k.instance_methods(false)}.inject{|a,b| a + b}
  end


end

class Animal
  def correr
    "estoy corriendo"
  end

end

class Mono < Animal

  def hola_mundo
    "hola soy un mono"
  end

  def decir_adios
    puts "adios"
  end

end

class Gato <Animal

end

class Camion

  def hola_mundo
    "hola soy un Camion"
  end

end

if __FILE__ == $0
=begin
puts  ObjectSpace.each_object(Class).select { |k| k == Mono }
  mono = Mono.new
 mono.class == Mono
#puts espacio.getMetodosDe(Mono)
 puts  Mono.instance_methods(false).inspect
puts Mono.send(:==,mono.class)
puts ([1,2,3] + [4,5,6]).inspect
=end
  espacio = EspacioObjetos.new
  # subclases de Animal
  puts espacio.get_clase(Animal,:<).inspect
  puts "++++++++++++++++++++++++++++++++++++++"

  #metodos de la clase Animal
  puts espacio.get_metodos_de(Animal,:==).inspect

  #metodos de las subclases de animal
  puts espacio.get_metodos_de(Animal,:<).inspect
  puts "++++++++++++++++++++++++++++++++++++++"
  #todos los metodos de todas las clases
  puts espacio.get_all_methods.inspect
puts "---------------------------------------"
  puts espacio.get_metodos_que_empiecen("hola_mundo").inspect


end