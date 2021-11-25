/* 
Module      :  Practica Objetos - Compania telefonica
Description :  https://docs.google.com/document/d/1nVLdccfRxa-1mYPtnj2hSlc45UrEn9kljvLZuYGcAnQ/edit
Date        :  21.11.2021
Grupo       :  Grupo 6 
Name        :  Guido Reboredo
Subject     :  PdeP K2054 - UTN FRBA
*/

class Linea{
	var property numero
	var property packs = #{}
	var property consumos = #{}
	
	
	method consumosDelPeriodo(inicio, fin){
		return consumos.filter({unConsumo => unConsumo.consumidoEntre(inicio, fin)})
	}
	
	method totalDeConsumoPorPeriodo(inicio, fin){
		return self.consumosDelPeriodo(inicio,fin).sum({consumo => consumo.costo()})
	}
	
	method promedioDeConsumosEnPeriodo(inicio, fin){
		return self.totalDeConsumoPorPeriodo(inicio,fin) /  self.consumosDelPeriodo(inicio,fin).size()
	}

	method TotalDelMes(){
		return self.totalDeConsumoPorPeriodo(new Date(), new Date().minusMonth(1)) 
	}
	
	method consumirMegas(cantidad){
	 
	}
	
	method consumirSegundos(cantidadSegundos){	
	
	}
	
	/* PACKS */
	method agregarPack(pack){
		packs.add(pack)
	}
	
}


class Consumo{
	var property fecha = new Date()
	var property segundos = 0
	var property megas = 0
	
	
	method consumidoEntre(inicio, fin) = fecha.between(inicio, fin)
	
	method consumeInternet() = megas > 0
	method consumeLlamada() = segundos > 0
	
}


class ConsumoLlamada inherits Consumo{
	
	override method megas() = 0
	
	method segundosExcedidos(){
		return (segundos-30).max(0)
	}
	
	method costo(){
			return pdepfoni.costoFijo() + self.segundosExcedidos() * pdepfoni.costoSegundo()
	}

}


class ConsumoInternet inherits Consumo{
	
	override method segundos() = 0
		
	method costo(){
		return megas * pdepfoni.costoMegas()
	}
	
}


object pdepfoni{
	var property costoSegundo = 0.05
	var property costoFijo = 1
	var property costoMegas = 0.10
}


class Pack{

	var property vencimiento = ilimitado
	
	method puedeSatisfacer(consumo){
		return !vencimiento.vencido(consumo.fecha())
	}
}

class CreditoDisponible inherits Pack{
	
	var property creditoDisponible
	
	override method puedeSatisfacer(consumo){
		return super(consumo) && consumo.costo() < creditoDisponible
	}
}

class MegasInternet inherits Pack{
	var property megasDisponibles
	
	override method puedeSatisfacer(consumo){
		return super(consumo) && consumo.megas() < megasDisponibles && consumo.consumeInternet()
	}
}

class LlamadasGratis inherits Pack{
	override method puedeSatisfacer(consumo){
		return super(consumo) && consumo.consumeLlamada()
	}
}

class InternetIlimitadoLosFindes inherits Pack{
	override method puedeSatisfacer(consumo){
		return super(consumo) && consumo.fecha().isWeekendDay()	&& consumo.consumeInternet()
	}
}


object ilimitado{
	
	method vencido(fecha) = false
}

class Vencimiento{
	var property fechaVencimiento
	
	method vencido(fecha) = fechaVencimiento < fecha
}


