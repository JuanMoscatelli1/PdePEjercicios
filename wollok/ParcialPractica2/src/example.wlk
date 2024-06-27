class Expedicion{
	var lugaresAInvadir=[]
	var vikingos=[]
	
	method cantidadVikingos(){
		return vikingos.size()
	}
	
	method valeLaPena(){
		return lugaresAInvadir.all({unLugar=>unLugar.valeLaPena(self.cantidadVikingos())})
	}
	
	method subirVikingo(vikingo){
		if(vikingo.puedeIr()){
			vikingos.add(vikingo)
		}else{
			self.error("No puede ir :(")
		}
	}
	
	method invadirTodo(){
		lugaresAInvadir.forEach({unLugar=>unLugar.serInvadida(self.cantidadVikingos())})
		var botinTotal=lugaresAInvadir.sum({unLugar=>unLugar.botin()})
		vikingos.forEach({unVikingo=>unVikingo.aumentarOro(botinTotal/self.cantidadVikingos())})
	}
}

class Ciudad{
	var defensoresDerrotados
	var factorRiqueza
	method botin(){
		return defensoresDerrotados*factorRiqueza
	}
	method valeLaPena(cant){
		return self.botin()*3>=cant
	}
	method serInvadida(cant){
		defensoresDerrotados+=cant
	}
}

class Aldea{
	var crucifijos
	var comitiva
	method botin(){
		return crucifijos
	}
	method valeLaPena(cant){
		return self.botin()>15
	}
	method serInvadida(cant){
		crucifijos = 0
	}
}

class AldeaAmurallada inherits Aldea{
	override method valeLaPena(cant){
		return super(cant) && cant>comitiva
	}
}

class CastaSocial{
	method estaApto(vik){
		return true
	}
}

object jarl inherits CastaSocial{
	override method estaApto(vik){
		return vik.armas()==0
	}
	method ascender(vikingo){
		vikingo.aumentarRiquezas()
		vikingo.cambiarCasta(karl)
	}
}

object karl inherits CastaSocial{
	method ascender(vikingo){
		vikingo.cambiarCasta(thrall)
	}
}

object thrall inherits CastaSocial{
	method ascender(vikingo){
	
	}
}

class Vikingo{
	var castaSocial
	var property armas
	var oro
	method esProductivo()
	method aumentarOro(cantOro){
		oro += cantOro
	}
	method puedeIr(){
		return self.esProductivo() && castaSocial.estaApto(self)
		
	}
	method cambiarCasta(castaNueva){
		castaSocial = castaNueva
	}
	method ascender(){
		castaSocial.ascender(self)
	}
}

class Soldado inherits Vikingo{
	var bajas
	method aumentarRiquezas(){
		armas+=10
	}
	override method esProductivo(){
		return bajas>20 && armas
	}
}

class Granjero inherits Vikingo{
	var hijos
	var hectareas
	method aumentarRiquezas(){
		hijos+=2
		hectareas+=2
	}
	override method esProductivo(){
		return 2*hectareas>=hijos
	}
}

/* 5)
 Se pueden agregar sin cambiar nada por el polimorfismo
  entre estos lugares y la expedicion los utiliza como iguales
 */





