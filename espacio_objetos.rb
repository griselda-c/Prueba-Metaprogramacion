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
    lista.map{|klass| klass.instance_methods(false)}
  end

  #get_metodos_que "empiecen con", "esten en un conjunto", "que se llame"
  def get_metodos_que_empiecen(letras)

  end

  def get_all_methods()
    #ObjectSpace.each_object(Class).map{|k| k.instance_methods(false)}
     @observados.map{|k| k.instance_methods(false)}.inject{|a,b| a + b}
  end



  #que quiero hacer?
  #que getMetodos devuelva los metodos de una clase o de una subclase

end

class Animal

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
puts  ObjectSpace.each_object(Class).select { |k| k == Mono }
  mono = Mono.new
 mono.class == Mono

  espacio = EspacioObjetos.new

  #puts espacio.getMetodosDe(Mono)
 puts  Mono.instance_methods(false).inspect

 puts Mono.send(:==,mono.class)

  puts espacio.get_clase(Animal,:<).inspect

 puts ([1,2,3] + [4,5,6]).inspect
puts "++++++++++++++++++++++++++++++++++++++"
  puts espacio.get_metodos_de(Animal,:<).inspect

  set = :set_algo

 puts set[0..2].include? "set"

  puts espacio.get_all_methods.inspect

end