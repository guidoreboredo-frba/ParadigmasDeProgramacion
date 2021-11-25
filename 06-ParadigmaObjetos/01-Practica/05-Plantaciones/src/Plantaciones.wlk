/* 
Module      :  Plantaciones
Description :  Practica de Parcial
Date        :  29.09.2021
Legajo      :  259.078-9
Name        :  Guido Reboredo 
Subject     :  PdeP K2054 - UTN FRBA
*/

/* TERRENOS */


class Terreno{
	var property plantas = []
	var property cantidadDePlantas = 0
		
	method costoDeMantenimiento()
	method esRico()
	
	method valorNetoDelTerreno(){
		return self.gananciaTotalDeCultivos() - self.costoDeMantenimiento()
	}
	
	method gananciaTotalDeCultivos(){
		return plantas.sum({unaPlanta => unaPlanta.gananciaGenerada()})
	}
	
	method tieneLugar() = plantas.size() < self.cantidadDePlantas()
	
	method plantar(unaPlanta){
		self.validarPlanta(unaPlanta)
		self.validarLugar()
		self.agregarPlantaACultivo(unaPlanta)
	}
	
	method agregarPlantaACultivo(unaPlanta){
		plantas.add(unaPlanta)
	}
	
	method validarLugar(){
		if(!self.tieneLugar())
			throw new NoHayLugarException(message = "NO_HAY_LUGAR")
		  
	}
	method validarPlanta(unaPlanta){
		if( !unaPlanta.puedeCrecerEn(self) )
		 throw new NoSePuedePlantar(message = "NO_SE_PUEDE_PLANTAR")
	}
}

class CampoAbierto inherits Terreno{
	var property tamanio
	var property mineral
	var property riqueza
	
	override method costoDeMantenimiento() = 500 * tamanio
	override method cantidadDePlantas() = 4 * tamanio

	override method esRico() = riqueza > 100
}

class Invernadero inherits Terreno{
	var property dispositivoElectronico
	
	override method costoDeMantenimiento() = 50000 + dispositivoElectronico.costo()
	override method esRico(){
		return dispositivoElectronico.enriqueseLaTierra() || self.validarCapacidadDeCultivos()	 
	}
	
	method validarCapacidadDeCultivos() = plantas.size() < (cantidadDePlantas/2)
}

class TerrazaAgricola inherits Terreno{
	var property niveles = #{}

	
	override method cantidadDePlantas() = niveles.sum({unNivel => unNivel.cantidadDePlantas()})
	override method costoDeMantenimiento() = niveles.sum({unNivel => unNivel.costoDeMantenimiento()})
	override method esRico() = niveles.all({unNivel => unNivel.esRico()})
	
	override method agregarPlantaACultivo(unaPlanta){
		self.ultimoNivelLibre().plantar(unaPlanta)
	}
	
	method ultimoNivelLibre(){
		return niveles.filter({nivel=> nivel.tieneLugar()}).max({unNivel => unNivel.nivel()})
	}
	
	method agregarNivel(altura) = niveles.add(new Nivel(nivel= altura, tamanio=100,mineral="hierro", riqueza= 150))
	
}

class Nivel inherits CampoAbierto{

	var property nivel
	
	override method costoDeMantenimiento(){
		if(nivel > 1000)
			return super() * 1.5
		else if(nivel >= 100 && nivel <= 1000)
			return super()*1.3
		else
			return super()*0.8
	}
/* 
	method cantidadDePlantas(){
		return campoAbierto.cantidadDePlantas()
	}
	
	method esRico() = nivel > 500 || campoAbierto.esRico()
	
	method tieneLugar(){
		return campoAbierto.tieneLugar()
	}
	
	method plantar(unaPlanta){
		campoAbierto.plantar(unaPlanta)
	} */
}

/* DISPOSITIVOS ELECTRONICOS */

object reguladorNutricional{
	
	method costo(invernadero) = 200 * invernadero.cantidadDePlantas()
	
	method enriqueseLaTierra() = true
	
}

object humidificador{

	var property humedad = 30
	
	method costo(invernadero){
	  if(humedad <= 30)
		return 1000
	  else 
	  	return 4500
	}
	
	method enriqueseLaTierra() = humedad.between(20,40)

}

object panelSolar{
	var property cantidadDePaneles = 1
	
	method costo(invernadero) = (-5000) * cantidadDePaneles
	
	method enriqueseLaTierra() = false
}

/* CULTIVOS */

object papa{
	method puedeCrecerEn(terreno) = true
	method ingresosGenerados() = 700
}

object algodon{
	method puedeCrecerEn(terreno) = terreno.esRico()
	method ingresosGenerados() = 500
}

class ArbolFrutal{
	
	var property anios 
	var property precioFruta
	
	method puedeCrecerEn(terreno) = terreno.esAlAireLibre()
	method ingresosGenerados(){
		if(self.esJoven())
			return 0
		else
			return precioFruta + self.frutasPorAnio()
	}
	method esJoven() = anios <= 3
	
	method frutasPorAnio() = 30 + (anios * 5)
	
}

object palmeraTropical inherits ArbolFrutal(anios = 5, precioFruta = 100){

	override method esJoven() = anios <= 5
	override method puedeCrecerEn(terreno) = super(terreno) && terreno.esRico()
	override method frutasPorAnio() = super() * 2
	
}

/* EXCEPCIONES */

class NoHayLugarException inherits DomainException{}
class NoSePuedePlantar    inherits DomainException{}