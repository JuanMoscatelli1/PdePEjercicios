// Las mensajerias

object chasqui{
	
	var property mensajesEnviados=0
	
	method incrementarMensajes(){
		mensajesEnviados++
	}
	
	method puedeEnviar(mensaje){
		return mensaje.size()<50
	}
	
	method costoMensaje(mensaje){
		return 2*mensaje.size()
	}
}

object sherpa{
	
	var costoMensaje=60
	var property mensajesEnviados=0
	
	method incrementarMensajes(){
		mensajesEnviados++
	}
	
	method puedeEnviar(mensaje){
		return mensaje.size().even()
	}
	
	method costoMensaje(mensaje){
		return costoMensaje
	}
	
	
}

object messich{
	
	var multiplicador=10
	var property mensajesEnviados=0
	
	method incrementarMensajes(){
		mensajesEnviados++
	}
	
	method puedeEnviar(mensaje){
		return not(mensaje.startsWith("a"))
	}
	
	method costoMensaje(mensaje){
		return	(mensaje.words().size())*multiplicador
	}
	
}

object pali{
	
	var property mensajesEnviados=0
	
	method incrementarMensajes(){
		mensajesEnviados++
	}
	
	method puedeEnviar(mensaje){
		var mensajeSinEspacios=mensaje.replace(" ","")
		return mensajeSinEspacios==mensajeSinEspacios.reverse()
	}
	
	method costoMensaje(mensaje){
		var costoMensajeParcial = 4*mensaje.size()
		return costoMensajeParcial.min(80)
	}
	
}

object pichca{
	
	var property mensajesEnviados=0
	var valoresAzar=[3,4,5,6,7]
	
	method incrementarMensajes(){
		mensajesEnviados++
	}
	
	method puedeEnviar(mensaje){
		return (mensaje.words().size())>3
	}
	
	method costoMensaje(mensaje){
		return (mensaje.size())*(valoresAzar.anyOne())
	}
	
}

// Mensajer@ Estandar

class MensajeroEstandar{
	
	var sector
	var property mensajesEnviados=0
	
	method incrementarMensajes(){
		mensajesEnviados++
	}
	
	method puedeEnviar(mensaje){
		return mensaje.size()>=20
	}
	
	method costoMensaje(mensaje){
		const cantidadPalabras = (mensaje.split(" ").size())
		return  calculadorDeCostoPorSector.calcularCosto(cantidadPalabras,sector)
		 
	}
	
}

object enviosRapidos{
	var property cobra=20
}
object enviosEstandares{
	var property cobra=15
}
object enviosVIP{
	var property cobra=30
}
object calculadorDeCostoPorSector{
	method calcularCosto(cantidadPalabras,sector){
		return cantidadPalabras*sector.cobra()
	}
}

// Agencia de mensajeria

object agenciaDeMensajeria{
	
	var property mensajeros=[chasqui,sherpa,messich,pali]
	var property mensajerosReceptores=[]
	var property mensajesRecibidos=[]
	var property dineroAPagar=0
	method aQuienPedirle(mensaje){
		const mensajerosPosibles=mensajeros.filter({unMensajero=>unMensajero.puedeEnviar(mensaje)})
		return mensajerosPosibles.min({unMensajero=>unMensajero.costoMensaje(mensaje)})
		
	}
	
	method mensajeVacio(mensaje){
		return mensaje.size() ==0
	}
	
	method recibirMensaje(mensaje){
		if(self.mensajeVacio(mensaje)){
			self.error("No se puede recibir el mensaje")
		}
		if(mensajeros.filter({unMensajero=>unMensajero.puedeEnviar(mensaje)})==[]){
			self.error("Nadie puede enviar este mensaje")
		}
		const mensajeroReceptor=self.aQuienPedirle(mensaje)
		mensajerosReceptores.add(mensajeroReceptor)
		mensajesRecibidos.add(mensaje)
		dineroAPagar+=mensajeroReceptor.costoMensaje(mensaje)
		mensajeroReceptor.incrementarMensajes()
	}
	
	/*aca los mensajes largos van a ser los totales menos los cortos */
	method gananciaNeta(){
		var mensajesCortos=mensajesRecibidos.filter({unMensaje=>unMensaje.size()<30})
		var mensajesLargos=mensajesRecibidos.filter({unMensaje=>unMensaje.size()>30})
		return 500*mensajesCortos.size()+900*mensajesLargos.size()-self.dineroAPagar()
	}
	
	method chasquiQuilla(){
		return mensajeros.max({unMensajero=>unMensajero.mensajesEnviados()})
	}
	
}