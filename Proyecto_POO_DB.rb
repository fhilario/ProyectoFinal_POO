require "test/unit"

class Departamento
	attr_accessor :numero, :bloque, :descripcion, :dni
	def initialize (numero,bloque,descripcion, dni)
		@numero = numero
		@bloque = bloque
		@descripcion = descripcion
		@dni = dni
	end

	def muestraDatos
		"Numero y Bloque: #{numero} #{bloque}  - DNI: #{dni}"
	end
    def dameNumero
		"#{numero}"
	end
end

class Propietario 
	attr_accessor :dni , :nombre, :apellido, :genero
	def initialize (dni , nombre, apellido, genero)
		@dni = dni
		@nombre = nombre
		@apellido  = apellido
		@genero = genero 
	end
	def muestraDatos
		"Nombres: #{nombre} #{apellido}  - DNI: #{dni} - Genero:  #{genero}"
	end
	def dameDNI
		"#{dni}"
	end
end

class Persona
	attr_accessor :dni, :nombresCompletos, :genero, :tipo, :dniPropietario 
	def initialize (dni, nombresCompletos, genero, tipo, dniPropietario)
		@dni = dni
		@nombresCompletos = nombresCompletos
		@genero = genero
		@tipo = tipo
		@dniPropietario = dniPropietario
	end

	def muestraDatos
		"Nombre Completos: #{nombresCompletos}  - DNI: #{dni} - Genero: #{genero} - Tipo: #{tipo} - DNI Propietario: #{dniPropietario}"
	end
    def dameDNI
		"#{dni}"
	end
end

class Familiares < Persona
	attr_accessor :parentesco
	def initialize (dni, nombresCompletos, genero, tipo, dniPropietario, parentesco)
		super(dni, nombresCompletos, genero, tipo, dniPropietario)
		@parentesco = parentesco
	end
	def muestraDatos
		"Nombre Completos: #{nombresCompletos}  - DNI: #{dni} - Genero #{genero} - DNI Propietario #{dniPropietario} - Parentesco #{parentesco}"
	end
	def dameDNI
		"#{dni}"
	end
end

class Visitas < Persona
	attr_accessor :fechaVisita, :estado
	def initialize (dni, nombresCompletos, genero, tipo, dniPropietario, fechaVisita, estado)
		super(dni, nombresCompletos, genero, tipo, dniPropietario)
		@fechaVisita = fechaVisita
		@estado = estado
	end
	def muestraDatos
		"Nombre Completos: #{nombresCompletos}  - DNI: #{dni} - Genero #{genero} - DNI Propietaio #{dniPropietario} - Fecha Visita #{fechaVisita} - Estado #{estado}"
	end
	def dameDNI
		"#{dni}"
	end
end

class Administrador
	attr_accessor :arregloDepartamento, :arregloPropietario, :arregloPersona
	def initialize
		@arregloDepartamento = []
		@arregloPropietario = []
		@arregloPersona = []
	end

	def validarDepartamento(departamento)
		for p in arregloDepartamento
			if p.numero == departamento.numero and p.bloque == departamento.bloque
				return true
			end
		end
		return false
	end		

	def registrarDepartamento(departamento)
		flag = validarDepartamento(departamento)
		if flag == true
			return "No se pudo registrar. El departamento ya existe"
		else
			arregloDepartamento.push(departamento)
			return "Departamento registrado con exito"
		end
	end

	def registrarPropietario(propietario)
		arregloPropietario.push(propietario)
		return "Propietario registrado con exito"
	end

	def registrarPersona(persona)
		arregloPersona.push(persona)
		return "Persona registrado con exito"
	end

	def buscarPropietario(dni)
		for p in arregloPropietario
			if p.dni == dni 
				return p
			end
		end
		return nil
	end

	def buscarPersona(dni)
		for p in arregloPersona
			if p.dni == dni 
				return p
			end
		end
		return nil
	end

	def buscarDepartamento(numero)
		for p in arregloDepartamento
			if p.dameNumero == numero 
				return p
			end
		end
		return nil
	end

	def obtenerDepartamento()
		temp = []
		for depa in arregloDepartamento
				temp.push(depa)
		end
		return temp
	end

	def obtenerPropietario()
		temp = []
		for pro in arregloPropietario
				temp.push(pro)
		end
		return temp
	end

	def obtenerPersona(dniPropietario, tipo)
		temp = []
		for per in arregloPersona
			if per.dniPropietario == dniPropietario and per.tipo == tipo
				temp.push(per)
			end
		end
		return temp
	end
end

class Factoria
  def self.dameObjeto(tipo, *arg)
     case tipo
     when "Familiares"
          return Familiares.new(arg[0], arg[1], arg[2], arg[3],arg[4], arg[5])
     when "Visitas"
         return Visitas.new(arg[0], arg[1], arg[2], arg[3],arg[4], arg[5], arg[6])
     when "Propietario"
         return Propietario.new(arg[0], arg[1], arg[2], arg[3])
     when "Departamento"
         return Departamento.new(arg[0], arg[1], arg[2], arg[3])
     end
  end  
end

class Vista
   def mostrarMensaje(resultado)
   	  puts resultado
   end
   def imprimirListado(arregloObjeto)
   	  for ar in arregloObjeto
   	  	 puts ar.muestraDatos
   	  end
   end
   def mostrarObjeto(objeto)
   	puts "Resultado de Busqueda..."
   	if objeto!=nil
      puts objeto.muestraDatos
    else
      puts "No encontrado!!!"
    end
   end
end

class Controlador
   attr_accessor :vista, :administrador
   def initialize(vista, administrador)
   	 @vista = vista
   	 @administrador = administrador
   end
   def registra(tipo, *arg)
      objeto = Factoria.dameObjeto(tipo, *arg)
      if tipo == "Familiares"
      resultado = administrador.registrarPersona(objeto)
      elsif tipo == "Visitas"
      resultado = administrador.registrarPersona(objeto)
      elsif tipo == "Propietario"
      resultado = administrador.registrarPropietario(objeto)
      elsif tipo == "Departamento"
      resultado = administrador.registrarDepartamento(objeto)			
      end
      vista.mostrarMensaje(resultado)
   end

   def obtenerDepartamento()
   	   puts "Lista de departamentos"
   	   arregloDepartamentoDNI = administrador.obtenerDepartamento()
   	   vista.imprimirListado(arregloDepartamentoDNI)
   	   puts "-------------------"
   end
   def buscarDepartamento(numero)
   	   departamento = administrador.buscarDepartamento(numero)
   	   vista.mostrarObjeto(departamento)
   end

   def buscarDepartamentoTest(numero)
   	   departamento = administrador.buscarDepartamento(numero)
   	   return departamento
   end

   def obtenerPropietario()
   	   puts "Lista de propietarios "
   	   arregloPropietarioDNI = administrador.obtenerPropietario()
   	   vista.imprimirListado(arregloPropietarioDNI)
   	   puts "-------------------"
   end
   def buscarPropietario(dni)
   	   propietario = administrador.buscarPropietario(dni)
   	   vista.mostrarObjeto(propietario)
   end

    def obtenerPersona(dniPropietario, tipo)
    	if tipo == "Visitas"
    		puts "Lista vistitantes de acuerdo al dni propietario : #{dniPropietario} "
   	    	arregloPersonaDNI = administrador.obtenerPersona(dniPropietario, tipo)
    	elsif tipo == "Familiares"
    		puts "Lista Familiares de acuerdo al dni propietario : #{dniPropietario} "
   	    	arregloPersonaDNI = administrador.obtenerPersona(dniPropietario, tipo)
    	end
   	   
   	   vista.imprimirListado(arregloPersonaDNI)
   	   puts "-------------------"
   end
   def buscarPersona(dni)
   	   arregloPersonaDNI = administrador.buscarPersona(dni)
   	   vista.mostrarObjeto(arregloPersonaDNI)
   end
end

class TestGlobal < Test::Unit::TestCase
	
	def setup
		@admin = Administrador.new()
		@vista = Vista.new
		@controlador = Controlador.new(@vista, @admin)
		#Registro Departamento
		@controlador.registra("Departamento","703","B05","Departamento con 3 habitaciones","71589688")
		@controlador.registra("Departamento","705","B05","Departamento con 3 habitaciones","10469856")
		@controlador.registra("Departamento","702","B05","Departamento con 2 habitaciones","16263736")
		#Registro Propietario
		@controlador.registra("Propietario","71589688","Diego Alonso" ,"Bueno Pastor","Masculino")
		@controlador.registra("Propietario","10469856","Flor Maria" ,"Hilario Ramirez","Femenino")
        @controlador.registra("Propietario","16263736","Juan" ,"Perez Perez","Masculino")
		#Registro Persona
        @controlador.registra("Visitas","27439386","Euler Tuesta Bardales" ,"Masculino", "Visitas", "71589688", "05/12/2019", "Por venir")
		@controlador.registra("Familiares","24654789","Elena Ramirez","Femenino","Familiares", "71589688", "Suegra")
        @controlador.registra("Familiares","34567434","Juan Carlos Hilario Ramirez","Masculino","Familiares","10469856","Hermano")
	end

	def testListar
		#Lista departamento
		@controlador.obtenerDepartamento()
		#Lista Propietarios
     	@controlador.obtenerPropietario()
     	#Lista de Personas(Visitas o Familiares) de acuerdo al DNI Propietario
     	@controlador.obtenerPersona("10469856", "Familiares")
	end

	def testBuscar
		#Obtener Departamento por Numero
        @controlador.buscarDepartamento("703")
        #Obtener Propietario por DNI
        @controlador.buscarPropietario("71589688")
        #Obtener Persona(Visitas o Familiares) por DNI 
        @controlador.buscarPersona("34567434")
	end

	def test_validar_datos

    numero = "703"
    bloque = "B05"

    result = @controlador.buscarDepartamentoTest(numero)
    assert_equal numero, result.numero
    assert_equal bloque, result.bloque

    end

end



