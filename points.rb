

class Points

  def relay(array, data_type)
    array.map {|s| s.send("to_#{data_type}") }
  end

end

class SetInStone
  #empty class
end

class Perro
  attr_accessor :velocidad
end

class Auto
  attr_accessor :velocidad
end


class Doctor
  ["rhinoplasty", "checkup", "interpretive_dance","correr"].each do |action|
    define_method("perform_#{action}") do |argument|
      "performing #{action} on #{argument}"
    end
  end

end

class Monk
  attr_accessor :state

  [:failure, :error, :success].each do |method|
    define_method method do
      self.state = method
    end
  end

  def monk(arg1, arg2)
    "Monks"
  end

end

class Class
  def def_each(*method_names, &block)
    method_names.each do |method_name|
      define_method method_name do
        instance_exec method_name, &block
      end
    end
  end

  #ejemplo de proc y bloques

  def profile descripcionDeBloque, &bloque
    inicioHora = Time.now

    bloque.call

    duracion = Time.now - inicioHora

    puts descripcionDeBloque+':  '+duracion.to_s+' segundos'
  end



  profile '25000 duplicaciones' do
    numero = 1

    25000.times do
      numero = numero + numero
    end

    puts numero.to_s.length.to_s+' digitos'  #  El numero de digitos en este numero ENORME.
  end

  profile 'contar hasta un millon' do
    numero = 0

    1000000.times do
      numero = numero + 1
    end
  end
end
class Monastery
  def monks(arg1, arg2)
    "Monks" + arg1 + arg2
  end
end

class Join
  [Perro ,Auto].each do |action|
    code = proc { puts self }
    nombre = action.instance_eval(&code)
    define_method("join #{nombre}") do |proc|
      proc.call
    end
  end
end

if __FILE__ == $0

  doctor = Doctor.new
  puts doctor.perform_rhinoplasty("nose")
  puts doctor.perform_checkup("throat")
  puts doctor.perform_interpretive_dance("in da club")
  puts doctor.perform_correr("al parque")

  monk = Monk.new
 puts   monk.method(:error)

  #Ejemplo de proc
  toast = Proc.new do
    puts 'Aplausos!!'
  end
  toast.call


  mo = Monastery.new.method(:monks)

  puts "Receiver --"
  p mo.receiver

  puts

  puts "Owner --"
  p mo.owner

  joinPerro = Proc.new do
    puts "Soy el join del perro"
  end

  join = Join.new
  join.join(joinPerro)

  code = proc { puts self }
  pe = Perro.instance_eval(&code)



end

