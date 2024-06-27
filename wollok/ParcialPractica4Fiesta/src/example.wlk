/*para probar todo */

class Punteador{
	var property persona
	var property fiesta
	method puntajePersonaDisfraz(){
		return persona.puntajeDisfraz(fiesta)
	}
	method conformeConTraje(){
		return persona.puntajeDisfraz(fiesta)
	}
	method esUnBodrioLaFiesta(){
		return fiesta.esUnBodrio()
	}
}

class Intercambiador{
	var property persona1
	var property persona2
	var property personas=[persona1,persona2]
	var property fiesta
	method puedenIntercambiar(){
		return self.estanEnLaFiesta() &&
		self.hayAlgunDisconforme(personas) &&
		self.intercambiar()
	}
	method estaEnLaFiesta(p1){
		return fiesta.invitados().contains(p1)
	}
	method estanEnLaFiesta(){
		return personas.all({unaPersona=>unaPersona.estaEnLaFiesta(unaPersona)})
	}
	method hayAlgunDisconforme(listaPersonas){
		return listaPersonas.any({unaPersona=>not(unaPersona.conformeConTraje(fiesta))})
	}
	method intercambiar(){
		var persona1Aux=persona1
		var persona2Aux=persona2
		var persona1disfrazAux=persona1.disfraz()
		persona1Aux.disfraz(persona2.disfraz())
		persona2Aux.disfraz(persona1disfrazAux)
		return not(self.hayAlgunDisconforme([persona1Aux,persona2Aux]))
	}
} 

/*clases generales */

class Persona{
	var property disfraz
	var property tipoPersonalidad
	var property edad
	
	/* conforme */
	
	method conformeConTrajeDefault(fiesta){
		return self.puntajeDisfraz(fiesta)>10
	}
	method satisfecho(fiesta){
		return true
	}
	method conformeConTraje(fiesta){
		return self.conformeConTrajeDefault(fiesta) &&
		self.satisfecho(fiesta)
	}
	
	/*es sexy */
	
	method esSexy(){
		return tipoPersonalidad.esSexy(self)
	}
	
	/*puntaje*/
	
	method puntajeDisfraz(fiesta){
		return disfraz.puntaje(self,fiesta)
	}
}

class Fiesta{
	var property lugar
	var property fecha=new Date()
	var property invitados=[]
	
	/*es un bodrio */
	
	method esUnBodrio(){
		return invitados.all({unInvitado=>not(unInvitado.conformeConTraje(self))})
	}
	
	/*mejor disfraz */
	
	method mejorDisfraz(){
		const elMejor= invitados.max({unInvi=>unInvi.puntajeDisfraz(self)})
		return elMejor.disfraz()
	}
	
	method sePuedeAgregarInvitado(invitado){
		return invitado.disfraz()!=null &&
		not(invitados.contains(invitado))
	}
	
	method agregarInvitado(invitado){
		if(self.sePuedeAgregarInvitado(invitado)){
			invitados.add(invitado)
		}
	}
	
}

/*fiesta inolvidable */

class FiestaInolvidable inherits Fiesta{
		
	override method sePuedeAgregarInvitado(invitado){
		return super(invitado) && invitado.esSexy() &&
		invitado.ConformeConTraje(self)
		
	}
}

/* disfraz */

class Disfraz{
	var tiposDisfraz=[]
	var property fechaCompra=new Date()
	var nombre
	var property nivelGracia
	var property careta
	
	method hechoHace(numero){
		var hoy=new Date()
		return (hoy-fechaCompra)<numero
	}
	method tieneNombrePar(){
		return nombre.size().even()
	}
	method puntaje(persona,fiesta){
		return tiposDisfraz.sum({unTipo=>unTipo.puntaje(self,persona,fiesta,careta)})
	}
}
/*tipos de disfraces */
object gracioso{
	method puntaje(disfraz,persona,fiesta,careta){
			if(persona.edad()>50){
				return disfraz.nivelGracia()*3
			}else{
				return disfraz.nivelGracia()
			}	
		}
	}

object tobaras{
	method puntaje(disfraz,persona,fiesta,careta){
		if(fiesta.fecha()-disfraz.fechaCompra()>=2){
			return 5
		}else{
			return 3
		}
	}
}

object caretas{
	method puntaje(disfraz,persona,fiesta,careta){
		return careta.puntaje()
	}
}

object sexy{
	method puntaje(disfraz,persona,fiesta,careta){
		return persona.esSexy()
	}
}

/*tipos de personalidades */

object personalidadAlegre{
	method esSexy(persona){
		return false
	}
}

object personalidadTaciturna{
	method esSexy(persona){
		return persona.edad()<30
	}
}



/*la cambiante no la modelo, cambio la variable de la persona */

/*caretas */
object mickeyMouse{
	var property puntaje=8
}

object osoCarolina{
	var property puntaje=5
}

/*tipos de persona */

class PersonaCaprichosa inherits Persona{
	override method satisfecho(fiesta){
		return disfraz.tieneNombrePar()
	}
}

class PersonaPretenciosa inherits Persona{
	override method satisfecho(fiesta){
		return disfraz.hechoHace(30)
	}
}

class PersonaNumerologa inherits Persona{
	var puntajeExacto
	override method satisfecho(fiesta){
		return self.puntajeDisfraz(fiesta)==puntajeExacto
	}
}








