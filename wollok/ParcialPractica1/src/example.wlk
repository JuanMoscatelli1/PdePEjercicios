class Linea{
	var numero = 1
	var packs = []
	var consumos = []
	var tipoLinea = lineaDefault
	var deuda = 0
	method agregarConsumo(consumo){
		consumos.add(consumo)
	}
	method agregarPack(pack){
		packs.add(pack)
	}
	method consumoTotal(lista){
		return lista.sum({unConsumo=>unConsumo.costoConsumo()})
	}
	method cantidadConsumos(lista){
		return lista.size()
	}
	
	method consumosEntre(fecha1,fecha2){
		const consumosDias = consumos.filter({consumo=>consumo.consumidoEntre(fecha1,fecha2)})
		return consumosDias
	}
	
	method calcularPromedio(lista){
		
		return self.consumoTotal(lista)/self.cantidadConsumos(lista)
	}
	
	method calcularPromedioEntreDias(fecha1,fecha2){
		const consumosDias = self.consumosEntre(fecha1,fecha2)
		return self.calcularPromedio(consumosDias)
	}
	
	method consumoTotal30(){
		const fecha = new Date()
		const consumosDias = self.consumosEntre(fecha,fecha.plusDays(30))
		return self.consumoTotal(consumosDias)
	}
	
	method puedeHacerConsumo(consumo){
		return packs.any({unPack=>unPack.consumoCubre()})
	}
	
	method consumirLinea(consumo){
		const packsPosibles= packs.filter({unPack=>unPack.consumoCubre()})
		if(packsPosibles==[]){
			var costoDelConsumo = consumo.costoConsumo()
			tipoLinea.manejarError(self,costoDelConsumo)
		}
		const packSeleccionado= packsPosibles.last()
		packSeleccionado.consumir(consumo.cantidad())
		consumos.agregarConsumo(consumo)		
	}
	
	method limpieza(){
		packs.removeAllSuchThat({unPack=>not(unPack.fechaVigente()) || unPack.cantidad()<=0})
	}
	method aumentarDeuda(costo){
		deuda+=costo
	}		
}

object lineaDefault{
	method manejarError(linea,deuda){
		self.error("Ningun pack puede consumirlo")
	}
}

object lineaBlack{
	method manejarError(linea,costoDelConsumo){
		linea.aumentarDeuda(costoDelConsumo)
	}
}

object lineaPlatinum{
	method manejarError(linea,costo){
		
	}
}

class Consumo {
	var fecha = new Date()
	var property cantidad
	
	method consumidoEntre(fecha1,fecha2){
		return fecha.between(fecha1,fecha2)
	}
	
	method cubreInternet(pack)=false
	method cubreLlamadas(pack)=false
}

class ConsumoLlamada inherits Consumo{
	
	
	method costoConsumo(){
		return 1 + ((cantidad-30).max(0))*0.05
	}
	
	override method cubreLlamadas(pack){
		return pack.puedeCubrir(cantidad)
	}
}

class ConsumoInternet inherits Consumo{
	
	
	method costoConsumo(){
		return cantidad*0.1
	}
	
	override method cubreInternet(pack){
		return pack.puedeCubrir(cantidad)
	}
}

class Pack{
	var fecha = new Date()
	
	var cantidad
	
	
	method consumir(numero){
		cantidad-=numero
	}

	method puedeSatisfacer(consumo){
		return self.fechaVigente() && self.consumoCubre(consumo)
	}
	method consumoCubre(consumo)
	
	method fechaVigente(){
		const fechaHoy = new Date()
		return fechaHoy < fecha
	}
}

class PackMBLibres inherits Pack{
	
	
	method puedeCubrir(megas){
		return cantidad>megas
	}
	
	override method consumoCubre(consumo){
		consumo.cubreInternet(self)
	}
}

class PackCredito inherits Pack{

	
	override method consumoCubre(consumo){
		return cantidad > consumo.costoConsumo()
	}
}

class PackMBLibreMasMas inherits PackMBLibres{
	override method puedeCubrir(megas){
		if(cantidad<megas){
			return megas<=0.1
		}else
		return super(megas)
	}
}














