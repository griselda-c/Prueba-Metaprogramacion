class Join

  def initialize()
    @metodos_observados = Array.new
  end


  def get_metodos_de(clase) #clase puede ser una lista de clases o subclases o solo una clase
    if clase.respond_to?("each")
    @metodos_observados = clase.map{|klass| klass.instance_methods(false)}.inject{|a,b| a+b }
    else
      @metodos_observados = clase.instance_methods(false)
    end
  end

  def get_subClases_de(clase)
      ObjectSpace.each_object(Class).select { |k| k.send(:<,clase) }
  end

  #get_metodos_que "empiecen con", "esten en un conjunto", "que se llame"
  def metodos_con(letras,*clase) #  puede ser metodos de una clase, una lista de clases, o una lista de metodos
    if not clase.none? # si no hay parametros busca en los metodos_observados
       self.get_metodos_de(clase) # aca los setea en @metodos_observados
    end
    @metodos_observados.select{|metodo| metodo[0..letras.size].include? letras}
  end

  def cant_de_parametros(metodo)
    #clase.method(metodo).arity
    metodo.arity
  end

end

class Point

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

  def hola_Camion
    "hola soy un Camion"
  end

  def hola_mundo

  end

end


if __FILE__ == $0

  join = Join.new
  puts join.get_subClases_de(Animal).inspect
  puts join.get_metodos_de(join.get_subClases_de(Animal)).inspect
  puts join.get_metodos_de(Camion).inspect
  #join.cant_de_parametros(:hola_mundo)
 puts

  puts "-----------------------------"

  join.get_subClases_de(Animal)
  join_animal = join.metodos_con("hola").inspect
  #join_camion = Join.new.get_metodos_de(Camion) #[:hola_Camion]
  #union = join_animal | join_camion #o

  #interseccion = join_animal & join_camion
  nombre = Join.new.metodos_con("hola")
  #puts "union entre animal y camion (O)" +union.inspect
  #puts "interseccion entre animal y camion (and) esta en los dos" +interseccion.inspect
  #puts (interseccion & nombre).inspect

  puts join_animal
  #Join new()


end