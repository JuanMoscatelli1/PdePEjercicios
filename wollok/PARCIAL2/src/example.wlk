/*jugadores */

class Jugador{
	var nombre
	var fechaNacimiento = new Date()
	var puntajeBase=1
	var property nivelEnergia=1
	var velocidad=1
	var property lesionado=false
	
	method edad(){
		const hoy = new Date()
		return (hoy - fechaNacimiento)/365
	}
	method puntosHabilidad()
	
	method puntajeTotal(){
		return self.puntosHabilidad()+puntajeBase
	}
	
	/*entrenar */
	
	method lesionar(tiempo,metros){
		if(self.puntosHabilidad()<100 || tiempo>120){
			lesionado=true
		}
	}
	
	method entrenarConDT(tiempo,metros){
		self.lesionar(tiempo,metros) 
		self.entrenar(tiempo,metros)
	}
	
	method entrenar(tiempo,metros)
	
	method noEstaLesionado(){
		return not(lesionado)
	}
	
	/*relajacion*/
	
	method aumentarEnergia(cantidad){
		nivelEnergia+=cantidad
	}
	
	method multiplicarVelocidad(porcentaje){
		velocidad+=velocidad*porcentaje
	}
	
	method curarLesion(){
		lesionado=false
	}
	
	method tomarBebida(bebida){
		bebida.hidratarJugador(self)
	}
}

class Correcaminos inherits Jugador{
	override method puntosHabilidad(){
		return 3*velocidad
	}
	
	override method entrenar(tiempo,metros){
		if(metros>6000){
			velocidad+=1
		}
	}
}

class Pared inherits Jugador{
	var nivelDureza=1
	
	override method puntosHabilidad(){
		return (velocidad+nivelDureza+nivelEnergia)/3
	}
	
	method aumentarDureza(cantidad){
		nivelDureza+=cantidad
	}
	
	override method entrenar(tiempo,metros){
		if(nivelDureza<150){
			self.aumentarDureza(50)
		} else{
			self.aumentarDureza(25)
		}
	}
	
}

class Mago inherits Jugador{
	var cantidadAcrobacias=1
	override method puntosHabilidad(){
		return (cantidadAcrobacias*20)
	}
	
	override method entrenar(tiempo,metros){
		if(tiempo>60){
			cantidadAcrobacias=cantidadAcrobacias/2
		}else{
			cantidadAcrobacias+=tiempo/10
		}
	}
}

/*dt */

class DT{
	var tipoDT
	var puntajeMinimo=1
	var tiempoEntrenar=1
	var metrosEntrenar=1
	var tipoBebida=tipoBebidaComun
	var litrosDeBebida=1
	method aceptaJugador(jugador){
		return tipoDT.aceptaJugador(jugador,self)
	}
	
	/*entrenar jugadores */
	
	method entrenarEquipo(jugadores){
		jugadores.forEach({unJugador=>unJugador.entrenarConDT()})
	}
	
	
	
	/*relajacion */
	
	method darDeBeberAJugadores(jugadores,bebida){
		jugadores.forEach({unJugador=>unJugador.tomarBebida(bebida)})
	}
	
	method recuperarFuerzas(jugadores){
		const jugadoresLesionados = jugadores.filter({unJugador=>unJugador.lesionado()})
		const jugadoresNoLesionados= jugadores.filter({unJugador=>unJugador.noEstaLesionado()})
		const bebidaRecuperadora1=tipoBebidaReparadora.crearBebida(litrosDeBebida)
		const bebidaTipo1=tipoBebida.crearBebida(litrosDeBebida)
		self.darDeBeberAJugadores(jugadoresLesionados,bebidaRecuperadora1)
		self.darDeBeberAJugadores(jugadoresNoLesionados,bebidaTipo1)
	}
}

object carusista{
	method aceptaJugador(jugador,dt){
		return true
	}
}

object bilardista{
	method aceptaJugador(jugador,dt){
		return jugador.edad()>23 && 
		jugador.puntajeTotal()>dt.puntajeMinimo()
	}
}

object scalonista{
	method aceptaJugador(jugador,dt){
		return jugador.nivelEnergia()>100 &&
		jugador.nivelEnergia()>jugador.puntajeHabilidad()
	}
}

/*equipos */

class Equipo{
	var titulares=[]
	var suplentes=[]
	var dt
	
	method agregarJugador(jugador){
		if(not(jugador.lesionado())){
			titulares.add(jugador)
		}
	}
	
	method habilidadesTotales(jugadores){
		return jugadores.sum({unJugador=>unJugador.puntajeTotal()})
	}
	
	method jugadoresCombinados(){
		return titulares.addAll(suplentes)
	}
	
	method edadTotal(jugadores){
		return jugadores.sum({unJugador=>unJugador.edad()})
	}
	
	method cantidadJugadores(jugadores){
		return jugadores.size()
	}
	
	method habilidadApta(){
		return self.habilidadesTotales(titulares)>2*self.habilidadesTotales(suplentes)
	}
	
	method edadApta(){
		const todosLosJugadores=self.jugadoresCombinados()
		return (self.edadTotal(todosLosJugadores)/self.cantidadJugadores(todosLosJugadores))>26
	}
	
	method tienePotencial(){
		return self.habilidadApta() || self.edadApta()
	}
	
	/*entrenar al equipo */
	
	method entrenarEquipo(){
		dt.entrenarEquipo(self.jugadoresCombinados())
	}
	
	method equipoApto(){
		const jugadoresAptos=  self.jugadoresCombinados().filter({unJugador=>unJugador.noEstaLesionado()})
		return jugadoresAptos.size()>=11
	}
	
	/*relajacion */
	
	method recuperarFuerzas(){
		dt.recuperarFuerzas(self.jugadoresCombinados())
	}
}

const equipo1=new Equipo(titulares=[sofi,marcos,ale],dt=dtluli)

const equipo2=new Equipo(titulares=[maria],dt=dtmartin)

/*jugadores y dts con nombre */

const sofi = new Correcaminos(nombre="sofi")
const marcos = new Pared(nombre="marcos")
const ale = new Mago(nombre="ale")
const dtluli=new DT(tipoDT=bilardista)

const maria=new Correcaminos(nombre="maria")
const dtmartin=new DT(tipoDT=carusista)


/* bebidas */

class Bebida{
	var cantidadDeLiquido
	method hidratarSegunTipo(jugador){
		
	}
	method hidratarJugador(jugador){
		jugador.aumentarEnergia(2*cantidadDeLiquido)
		self.hidratarSegunTipo(jugador)
	}
}

class BebidaComun inherits Bebida{
	 
}

class BebidaEnergizante inherits Bebida{
	
	var porcentajeVelocidad=0.1
	override method hidratarSegunTipo(jugador){
		jugador.multiplicarVelocidad(porcentajeVelocidad)
	}
}

class BebidaReparadora inherits Bebida{
	
	override method hidratarSegunTipo(jugador){
		jugador.curarLesion()
	}
}

object tipoBebidaReparadora{
	method crearBebida(cantidad){
		return new BebidaReparadora(cantidadDeLiquido=cantidad)
	}
}

object tipoBebidaComun{
	method crearBebida(cantidad){
		return new BebidaComun(cantidadDeLiquido=cantidad)
	}
}

object tipoBebidaEnergizante{
	method crearBebida(cantidad){
		return new BebidaEnergizante(cantidadDeLiquido=cantidad)
	}
}



