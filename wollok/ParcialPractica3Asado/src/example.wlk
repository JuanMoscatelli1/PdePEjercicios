class Persona{
	var property elementos=[]
	var tipoPersona=normal
	var property posicion="0@0"
	var tipoComensal=vegetariano
	var bandejasIngeridas=[]
	
	method cantidadComidas(){
		return bandejasIngeridas.size()
	}
	
	method cambiarPosicion(_posicion){
		posicion=_posicion
	}
	
	method pedirElemento(persona2){
		persona2.pasarElementosAOtro(self)
	}
	
	method agregarElementos(elementosNuevos){
		elementos.addAll(elementosNuevos)
	}
	
	method deletearElementos(elementosNuevos){
		elementos.removeAllSuchThat({unElemento=>elementosNuevos.contains(unElemento)})
	}
	
	method pasarElementosAOtro(persona2){
		const elementosNuevos=tipoPersona.pasarElementos()
		persona2.agregarElementos(elementosNuevos)
		self.deletearElementos(elementosNuevos)
	}
	
	method comeBandeja(bandeja){
		return tipoComensal.comeBandeja(bandeja,self)
	}
	
	method ingerirBandeja(bandeja){
		if(self.comeBandeja(bandeja)){
			bandejasIngeridas.add(bandeja)
		}
	}
	
	method pipon(){
		return bandejasIngeridas.any({unaBandeja=>unaBandeja.esPesada()})
	}
	
	method feliz(){
		return bandejasIngeridas.size()>1
	}
	
	method comioCarne(){
		return bandejasIngeridas.any({unaBandeja=>unaBandeja.esCarne()})
	}
	
	method cantElem(){
		return elementos.size()
	}
}


object sordo{
	
	method pasarElementos(elemento,elSelf,persona2){
		return [persona2.first()]
	}
}

object todosLosElem{
	
	method pasarElementos(elemento,elSelf,persona2){
		return [persona2.elementos()]
	}
}

object switch{
	
	method pasarElementos(elemento,elSelf,persona2){
		const posicionAnterior=persona2.posicion()
		persona2.cambiarPosicion(elSelf.posicion())
		elSelf.cambiarPosicion(posicionAnterior)
		return []
	}
}

object normal{
	
	method pasarElementos(elemento,elSelf,persona2){
		if(persona2.elementos().contains(elemento)){
			return [elemento]
		}else{
			return []
		}
	}
}
/* comensales */

class Bandeja{
	var property calorias
	var property esCarne
	method esPesada(){
		return calorias>500
	}
}

object vegetariano{
	method comeBandeja(bandeja,persona){
		return bandeja.esCarne()
	}
}

object dietetico{
	method comeBandeja(bandeja,persona){
		return bandeja.calorias()<oms.caloriasOms()
	}
}

object alternado{
	method comeBandeja(bandeja,persona){
		return persona.cantidadComidas().even()
	}
}

object combo{
	method comeBandeja(bandeja,persona){
		return vegetariano.comeBandeja(bandeja,persona) &&
		dietetico.comeBandeja(bandeja,persona) &&
		alternado.comeBandeja(bandeja,persona)
	}
}

object oms{
	var property caloriasOms=500
}

object osky inherits Persona{
	
}

object moni inherits Persona{
	override method feliz(){
		return super() && self.posicion() == "1@1"	
	}
}

object facu inherits Persona{
	override method feliz(){
		return super() && self.comioCarne()
	}
}	
	
object vero inherits Persona{
	override method feliz(){
		return super() && self.cantElem()<=3
	}
}	
	
	
	
	
	
	
	
	
	
