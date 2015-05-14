class EspacioObjetos

  @metodos_observados = []

  def get_clases(lista,metodo)
    @metodos_observados = lista.each { |clase| get_clase(clase,metodo)}
  end

  #aca quiero pasar por parametro el simbolo == o < para las subclases
  def get_clase(clase,metodo)
     ObjectSpace.each_object(Class).select { |k| k.send(metodo,clase) }
  end

  #get_metodos_de una clase o subclase

  def get_metodos_de(clase,metodo) #metodo puede  ser :== o :<
   lista = get_clase(clase,metodo) #puede devolver una clase o una lista de subclases
    lista.map{|klass| klass.instance_methods(false)}.inject{|a,b| a+b }
  end


  #get_metodos_que "empiecen con", "esten en un conjunto", "que se llame"
  def get_metodos_que_empiecen(letras,lista)
    #lista = get_all_methods
    lista.select{|metodo| metodo[0..letras.size].include? letras}
  end

  def get_all_methods(clase)
    #ObjectSpace.each_object(Class).map{|k| k.instance_methods(false)}
     #@observados.map{|k| k.instance_methods(false)}.inject{|a,b| a + b}
    if clase.respond_to?("each")
      clase.map{|k| k.instance_methods(false)}.inject{|a,b| a + b}
    else
      clase.instance_methods(false)
    end
  end

  def cant_de_parametros(metodo)
    #clase.method(metodo).arity
    #clase.new.method(metodo).arity
    method(metodo).owner.instance_eval.arity
  end

  def Or (proc1, proc2)
    proc1 + proc2
  end




end


class PointCut
  def initialize(name, &block)
    @name, @block = name, block
    @join_point = EspacioObjetos.new
  end

  def getMetodos(bloque)
    "#@name = #{ @block.call(bloque) }"
  end

  def Or proc1, proc2
    proc1 + proc2
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

  def hola_Camion
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
 # puts espacio.get_clase(Animal,:<).inspect
  puts "++++++++++++++++++++++++++++++++++++++"

  #metodos de la clase Animal
  #puts espacio.get_metodos_de(Animal,:==).inspect

  #metodos de las subclases de animal
  #puts espacio.get_metodos_de(Animal,:<).inspect
  puts "++++++++++++++++++++++++++++++++++++++"
  #todos los metodos de todas las clases
 # puts espacio.get_all_methods.inspect
puts "---------------------------------------"
  #puts espacio.get_metodos_que_empiecen("hola_mundo").inspect

  puts "---------------------------------------"

  #puts espacio.cant_de_parametros(Mono,:hola_mundo)
  #puts espacio.getMetodosDe(Mono).inspect

 puts  espacio.get_metodos_que_empiecen("hola",(espacio.send(:get_metodos_de,Mono,:==) + espacio.send(:get_metodos_de,Camion,:==) ))

#pointcut.new metodos_de_(Punto,:==) o metodos_de_(Rectangulo,:==), and empiecen_con_("set"), and tengan_parametro_(1)
  #arg1

  #

#  puts espacio.Or(espacio.(:get_metodo_de,Mono,:==), espacio.(:get_metodo_de,Camion,:==)).inspect

  cuadrado = Proc.new do |x,y|
    lista = espacio.get_clase(x,y) #puede devolver una clase o una lista de subclases
    lista.map{|klass| klass.instance_methods(false)}.inject{|a,b| a+b }
  end

  set = Proc.new do |letras,lista|
    lista.select{|metodo| metodo[0..letras.size].include? letras}
    end

 puts "2222" + espacio.Or(set.call("hol",cuadrado.call(Animal,:==)),set.call("h",cuadrado.call(Camion,:==))).inspect

  puts espacio.get_all_methods(espacio.get_clase(Animal,:==)).select{|m|method(m).owner}



end