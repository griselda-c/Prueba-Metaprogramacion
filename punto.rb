class Punto
  def initialize(x,y)
    @x= x
    @y=y
  end

  def shift_left(how_long)
    @x= @x + how_long
    puts "soy el viejo"
    @x
  end
end


class Advice
  attr_accessor :code
#alias http://rubytutorial.wikidot.com/metodos
  def apply_to(clase,selector)
    adv= self
    #advice guarda el metodo viejo
    clase.send(:alias_method,:advice, selector)

    #redefino el selector pasado por parametro
    clase.send(:define_method,selector)do |argument|
      #llamo al proc
      adv.code.call(self,clase,selector,argument)
      #llamo al metodo viejo
      self.advice(argument)
      end
  end


end

interceptor = Advice.new
interceptor.code = Proc.new do |obj,clase,selector,*arg|
  puts "soy un aspecto que paso por la #{clase} y el metodo #{selector}"

end

interceptor.apply_to(Punto,:shift_left)

puntito = Punto.new(3,4)



puts puntito.shift_left(6)

