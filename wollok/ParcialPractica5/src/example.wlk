/*isla */

class Isla{
	var property pajaros=[]
	
	/*fuerzas */
	
	method fuertes(){
		return pajaros.filter({unPajaro=>unPajaro.fuerza()>50})
	}
	
	method fuerzaTotal(){
		const pajarosFuertes=self.fuertes()
		return pajarosFuertes.sum({unPajaro=>unPajaro.fuerza()})
	}
	
	/*punto 2 (isla siniestra) */
	
	method sesionDeManejo(){
		pajaros.forEach({unPajaro=>unPajaro.tranquilizar()})
	}
	
	method invasionDeCerdos(cantCerdos){
		var cont=cantCerdos/100
		pajaros.forEach({unPajaro=>cont.times({i=>unPajaro.enrage()})})	
	}
	
	method fiestaSorpresa(homenajeados){
		var homenajeadosEnIsla=homenajeados.filter({unPajaro=>pajaros.contains(unPajaro)})
		if(homenajeadosEnIsla==[]){
			self.error("No fueron a su propia fiesta")
		}
		homenajeadosEnIsla.forEach({unPajaro=>unPajaro.enrage()})
	}
	
	method serieDeEventos(cantCerdos,homenajeados){
		self.sesionDeManejo()
		self.invasionDeCerdos(cantCerdos)
		self.fiestaSorpresa(homenajeados)
	}
	
	/*invadir isla cerdo */
	
	method invadirIslaCerdo(islaCerdo){
		if(pajaros.first().puedeDerribar(islaCerdo.defensas().first())){
			islaCerdo.defensas().remove(islaCerdo.defensas().first())
		}else{
			pajaros.remove(pajaros.first())
		}
		if(pajaros!=[] && islaCerdo.defensas()!=[] ){
			self.invadirIslaCerdo(islaCerdo)	
		}
		if(pajaros==[]){
			return "Mision fallida"
		}else{
			return "Se han recuperado los huevos :D"
		}
		
	}
	
}

/*pajaros */

class Pajaro{
	var ira=10
	method fuerza(){
		return ira*2
	}
	method enrage(){
		ira=ira*2
	}
	method tranquilizar(){
		ira-=5
	}
	
	method puedeDerribar(obstaculo){
		return self.fuerza()>obstaculo.resistencia()
	}
}

class PajaroRencoroso inherits Pajaro{
	var cantEnojo=1
	override method fuerza(){
		return ira*10*cantEnojo
	}
}

object red inherits PajaroRencoroso(ira=15){
	
}

object bomb inherits Pajaro(ira=20){
	var tope = 9000
	override method fuerza(){
		return (ira*2).min(tope)
	}
}

object chuck inherits Pajaro{
	var velocidad = 500
	override method fuerza(){
		if(velocidad<80){
			return 150
		}else{
			return (velocidad-80)*5
		}
	}
	override method enrage(){
		super()
		velocidad=velocidad*2
	}
	override method tranquilizar(){
		
	}
}

object terence inherits PajaroRencoroso{
	var multiplicador=1.5
	override method fuerza(){
		return super()*multiplicador
	}
}

object matilda inherits Pajaro{
	var huevos=[]
	override method fuerza(){
		return super() + huevos.sum({unHuevo=>unHuevo.fuerza()})
	}
	override method enrage(){
		const huevoNuevo=new Huevo(peso=2)
		huevos.add(huevoNuevo)
	}
}

/*huevos */

class Huevo{
	var peso
	method fuerza(){
		return peso
	}
}

/* guerra porcina */

class IslaCerdo{
	var property defensas=[]
	
}

class Pared{
	var tipoPared
	var ancho
	method resistencia(){
		return tipoPared.resistencia(ancho)
	}
}

object paredVidrio{
	method resistencia(anchoPared){
		return anchoPared*10
	}
}

object paredMadera{
	method resistencia(anchoPared){
		return anchoPared*25
	}
}

object paredPiedra{
	method resistencia(anchoPared){
		return anchoPared*50
	}
}

class CerdoObrero{
	method resistencia(){
		return 50
	}
}

class CerdoArmado{
	var pertenencia
	method resistencia(){
		return 10*pertenencia.resistencia()
	}
}

class Escudo{
	var property resistencia
}

class Casco{
	var property resistencia
}






