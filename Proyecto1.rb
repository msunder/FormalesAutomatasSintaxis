require 'gtk3'
#inicio automata
#inicio lista enlazada errores
class Nodoe
	attr_accessor :siguientee, :ne, :le, :existe
	def initialize()
		self.ne = 0
		self.le = 0
	end
	def set_nerror(ner)
		self.ne = ner 
	end 
	def set_lerror(ler)
		self.le = ler
	end
	def set_nextnodoe(nodoes)
		self.siguientee = nodoes 
	end 

end
class Lista_errores
	attr_accessor :ie, :nodot , :fe, :nnodose, :nlin, :nerro
	def initialize()
		self.ie = Nodoe.new()
		self.nnodose = 0
	end
	def add_error(nerr, lerr)
		self.nerro = nerr
		self.nlin = lerr
		if (nnodose == 0)
			self.ie.set_nerror(self.nerro)
			self.ie.set_lerror(self.nlin)
			self.nnodose += 1 
		else
			
			
			temp = Nodoe.new()
			temp.set_nerror(self.nerro)
			temp.set_lerror(self.nlin)
			self.nnodose += 1
			if (self.nnodose == 2)
				self.fe = temp
				self.ie.set_nextnodoe(fe)
			else
				self.fe.set_nextnodoe(temp)
				self.fe = temp
			end
			
		end 
	end
	def recorrer()
		if(self.nnodose > 0)
			x = 0
			temp = i
			while (x < self.nnodose)

				puts temp.palabra + " | "+ temp.numero.to_s
				temp = temp.siguiente
				x += 1 
			end
		end 
	end

end 
#fin lista enlazada errores
#inicio lista enlazada identificadores
class Nodo
	attr_accessor :siguiente, :palabra, :numero, :existe
	def initialize()
		self.numero = 0
		self.palabra =""
	end
	def set_palabra(pal)
		self.palabra = pal 
		self.numero = 1
	end 
	def inc_palabra()
		self.numero += 1
	end
	def set_nextnodo(nodos)
		self.siguiente = nodos 
	end 

end
class Lista_identificador
	attr_accessor :i, :nodot , :f, :nnodos, :existe, :palabrae
	def initialize()
		self.i = Nodo.new()
		self.nnodos = 0
	end
	def buscar()
		x = 0
		self.nodot = i 
		while (x < self.nnodos)
			if (nodot.palabra == palabrae)
				self.existe = true
				self.nodot.inc_palabra
				x=self.nnodos
			else
				self.nodot = self.nodot.siguiente
			end
			x+=1
		end
	end
	def rec_palabra(pala)
		self.existe = false
		self.palabrae = pala
		if (nnodos == 0)
			self.i.set_palabra(self.palabrae)
			self.nnodos += 1 
		else
			self.buscar()
			if(self.existe == false)
				temp = Nodo.new()
				temp.set_palabra(self.palabrae)
				self.nnodos += 1
				if (self.nnodos == 2)
					self.f = temp
					self.i.set_nextnodo(f)
				else
					self.f.set_nextnodo(temp)
					self.f = temp
				end
			end
		end 
	end
	def recorrer()
		if(self.nnodos > 0)
			x = 0
			temp = i
			while (x < self.nnodos)

				puts temp.palabra + " | "+ temp.numero.to_s
				temp = temp.siguiente
				x += 1 
			end
		end 
	end

end 
#fin lista enlazada identificadores
#inicio analizador de sintaxis 
class Analizador
	attr_accessor :sumas, :linea, :lineal, :caracter, :ultima_palabra, :palabra, :error, :nlinea, :nlinea_error, :ultimochar
	attr_accessor :cantidad, :nerror, :listapalabras, :otros, :errorprincipal, :lerrores, :otros1
	def initialize()
		self.nlinea = 0
		self.lerrores = Lista_errores.new()
		self.cantidad=Array.new(28)
		self.otros =["entero","decimal","booleano","cadena","si","sino","mientras","hacer","verdadero","falso","+","-","*","/","%","=","==","<",">",">=","<=","(",")","{","}",34.chr("UTF-8"),";","numeros"]
		self.otros1 =["Palabra Reservada","Palabra Reservada","Palabra Reservada","Palabra Reservada","Palabra Reservada","Palabra Reservada","Palabra Reservada","Palabra Reservada","Palabra Reservada","Palabra Reservada","Operador","Operador","Operador","Operador","Operador","Operador","Operador","Operador","Operador","Operador","Operador","Signos","Signos","Signos","Signos","Signos","Signos","numerico","Identificador"]
		x=0
		self.listapalabras = Lista_identificador.new()
		while(x<28)
			cantidad[x]=0
			x+=1
		end
		self.errorprincipal = false
		self.sumas = 0
		self.lineal = 0
		self.error = false
		self.palabra = ""
		self.ultimochar = ""
		
	end
	def reiniciar()
		self.cantidad=Array.new(28)
		self.otros =["entero","decimal","booleano","cadena","si","sino","mientras","hacer","verdadero","falso","+","-","*","/","%","=","==","<",">",">=","<=","(",")","{","}",34.chr("UTF-8"),";","numeros"]
		x=0
		self.listapalabras = Lista_identificador.new()
		while(x<28)
			cantidad[x]=0
			x+=1
		end

		self.sumas = 0
		self.lineal = 0
		self.error = false
		self.palabra = ""
	end 
	def aumentar
		self.sumas = self.sumas + 1
	end
	def mostrar_datos
		if(error == false)
			x = 0
		while(x < 28)
			puts self.otros[x] + self.cantidad[x].to_s
			x += 1

		end
		self.listapalabras.recorrer()
		end
	end
	#diferenciar un palabra de un numero
	def discriminacion()
		if(self.palabra[0]=="1"||self.palabra[0]=="2"||self.palabra[0]=="3"||self.palabra[0]=="4"||self.palabra[0]=="5"||self.palabra[0]=="6"||self.palabra[0]=="7"||self.palabra[0]=="8"||self.palabra[0]=="9"||self.palabra[0]=="0")
			self.cantidad[27] += 1
		else
			case self.palabra
			when "entero"
				self.cantidad[0]+=1
			when "decimal"
				self.cantidad[1]+=1
			when "booleano"
				self.cantidad[2]+=1
			when "cadena"
				self.cantidad[3]+=1
			when "si"
				self.cantidad[4]+=1
			when "sino"
				self.cantidad[5]+=1
			when "mientras"
				self.cantidad[6]+=1
			when "hacer"
				self.cantidad[7]+=1
			when "verdadero"
				self.cantidad[8]+=1
			when "falso"
				self.cantidad[9] +=1 
			else

				self.listapalabras.rec_palabra(self.palabra)
			end
		end
		self.palabra = ""
	end
	def analizarLinea(lin)
		self.linea = lin
		self.lineal = self.linea.length
		self.palabra = ""
		self.ultimochar =  ""
		contador = 0
		self.nlinea +=1
		while (contador < self.lineal)
			self.caracter = self.linea[contador]
			case caracter
			#Inicio Letras
			when "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
				if (self.palabra.length == 0)
					self.palabra = self.caracter
					if (ultimochar != "")
						self.ultimochar = ""
					end
				else
					if(self.palabra[0]=="1"||self.palabra[0]=="2"||self.palabra[0]=="3"||self.palabra[0]=="4"||self.palabra[0]=="5"||self.palabra[0]=="6"||self.palabra[0]=="7"||self.palabra[0]=="8"||self.palabra[0]=="9"||self.palabra[0]=="0" )
						self.error = true 
						self.nerror = 1
					else
						self.palabra = palabra + caracter
					end

				end
				
			#inicio Digitos
			when "1", "2", "3", "4", "5", "6", "7","8", "9", "0"
				if(palabra.length == 0)
					if (ultimochar != "")
						self.ultimochar = ""
					end
					self.palabra = caracter
				else
					self.palabra = palabra + caracter
				end
				
			#inicio operadores 

			when "+"
				if(palabra.length == 0)
					self.cantidad[10] += 1  
				else
					self.cantidad[10] += 1  
					self.discriminacion()
				end
			when "-"
				if(palabra.length == 0)
					self.cantidad[11] += 1  
				else
					self.cantidad[11] += 1  
					self.discriminacion()
				end
			when "*"
				if(palabra.length == 0)
					self.cantidad[12] += 1  
				else
					self.cantidad[12] += 1  
					self.discriminacion()
				end
			when "/"
			if(palabra.length == 0)
					self.cantidad[13] += 1  
				else
					self.discriminacion()
					self.cantidad[13] += 1  
				end		
			when "%"
				if(palabra.length == 0)
					self.cantidad[14] += 1  
				else
					self.discriminacion()
					self.cantidad[14] += 1 
				end
			when "="
				if(palabra.length == 0)
					if (ultimochar.length == 0)
						self.cantidad[15] += 1
						self.ultimochar = "="
					else
						if (self.ultimochar == "=")
							self.cantidad[15] -= 1
							self.cantidad[16] +=1
							self.ultimochar = ""
						else
							if(self.ultimochar == "<")
								self.cantidad[17] -= 1
								self.cantidad[20] +=1
								self.ultimochar = ""
							else
								if (self.ultimochar == ">")
									self.cantidad[18] -= 1
									self.cantidad[19] +=1
									self.ultimochar = ""
								end
							end
						end
					end

				else
					self.discriminacion()
					self.cantidad[15] += 1
					ultimochar = "="
				end
			when "<"
				if(palabra.length == 0)
					if(self.ultimochar == "=")
						self.error =true
						self.nerror = 2
					else
						self.cantidad[17] += 1
						self.ultimochar = "<"
					end
					
				else 
					self.discriminacion()
					self.cantidad[17] += 1
					self.ultimochar = "<"
				end
			when ">"
				if(palabra.length == 0)
					if(self.ultimochar == "=")
						self.error =true
						self.nerror = 2
					else
						self.cantidad[18] += 1
						self.ultimochar = ">"
					end
				else 
					self.discriminacion()
					self.cantidad[18] += 1
					self.ultimochar = ">"
				end
			when ")"
				if(palabra.length == 0)
					self.cantidad[21] += 1  
				else
					self.discriminacion()
					self.cantidad[21] += 1  
				end
			when "("
				if(palabra.length == 0)
					self.cantidad[22] += 1  
				else
					self.discriminacion()
					self.cantidad[22] += 1  
				end
			when "{"
				if(palabra.length == 0)
					self.cantidad[23] += 1  
				else
					self.discriminacion()
					self.cantidad[23] += 1  
				end
			when "}"
				if(palabra.length == 0)
					self.cantidad[24] += 1  
				else
					self.discriminacion()
					self.cantidad[24] += 1  
				end
			when 34.chr("UTF-8")
				if(palabra.length == 0)
					self.cantidad[25] += 1  
				else
					self.discriminacion()
					self.cantidad[25] += 1  
				end
			when ";"
				if(palabra.length == 0)
					self.cantidad[26] += 1  
				else
					self.discriminacion()
					self.cantidad[26] += 1  
				end
			when " "
				if(palabra.length != 0)
					if (ultimochar != "")
						self.ultimochar = ""
					end
					self.discriminacion()
				end
			when "\n"

			else 
				self.error =true
				self.nerror = 3
			end
			
			contador = contador + 1
			
		end
		if(palabra.length != 0 )
			self.discriminacion()
		end
		if self.error == true 
				self.error = false
				self.errorprincipal = true
				self.lerrores.add_error(self.nerror, self.nlinea)
		end
		
		

	end
end
#fin automata
class Visual
	attr_accessor :seleccionar, :builder1, :rutaf, :textov1, :textov2, :tex, :auto,  :errornod, :idennod, :lerrores
	def initialize()
		self.lerrores =  [" ","La sintaxis de identificador"," La sintaxis de operador/comparador (=<, =>) ", " El caracter no esta incluido en el lenguaje"]
		self.auto = Analizador.new()
		self.builder1 = Gtk::Builder.new
		self.builder1.add_from_file('interfaz.glade')
		#builder.connect_signals{|handler| method(handler)}
		self.builder1.connect_signals do |handler|
			begin
				method(handler) 
			rescue
			end
		end
		self.seleccionar = builder1.get_object('selector')
		
		self.tex = builder1.get_object('holatu')

		seleccionar.show()
	end
	
	def abrirar(object)

		self.tex = builder1.get_object('ventde')
		self.textov1 = builder1.get_object('despli')
		self.textov2 = builder1.get_object('resu')
		self.tex.show()
		self.textov1.show()
		self.textov2.show()
		self.rutaf = seleccionar.filename
		File.open(rutaf, 'r') do |fichero1|
			while linea = fichero1.gets
				self.auto.analizarLinea(linea)
				textov1.buffer.insert_at_cursor(linea)
			end
		end

		textotemp = ""
		if(self.auto.errorprincipal == true)
			errornod = self.auto.lerrores.ie
			x = self.auto.lerrores.nnodose
			y = 0
			while (y<x)
				textotemp = " Error numero: " + errornod.ne.to_s + " en la linea numero: " + errornod.le.to_s + "\n"
				
				textov2.buffer.insert_at_cursor(textotemp)
				
				textov2.buffer.insert_at_cursor(self.lerrores[errornod.ne.to_i]+"\n")
				
				errornod = errornod.siguientee
				y += 1
			end
		else
			x=0
			idennod = self.auto.listapalabras.i
			while(x<28)

				textotemp = self.auto.otros[x] + " ------> " + self.auto.cantidad[x].to_s+ " ------> "+self.auto.otros1[x]+"\n" 
				textov2.buffer.insert_at_cursor(textotemp)
				x += 1
			end
			x = self.auto.listapalabras.nnodos
			y = 0
			while (y<x)
				textotemp = idennod.palabra + " ------> " + idennod.numero.to_s+" ------> "+self.auto.otros1[28]+"\n"
				textov2.buffer.insert_at_cursor(textotemp)
				idennod = idennod.siguiente
				y += 1
			end
		end
		seleccionar.hide()
		
	end
	
end
	def clickseleccionar(object)
		hola = Visual.new()
	end
	def on_main_window_destroy(object)
		Gtk.main_quit()
	end
	

	builder = Gtk::Builder.new
	builder.add_from_file('interfaz.glade')
	#builder.connect_signals{|handler| method(handler)}
	builder.connect_signals do |handler|
		begin
			method(handler) 
		rescue
		end
	end

	window1 = builder.get_object('ventanaPrincipal')
	window1.show()
	

	Gtk.main