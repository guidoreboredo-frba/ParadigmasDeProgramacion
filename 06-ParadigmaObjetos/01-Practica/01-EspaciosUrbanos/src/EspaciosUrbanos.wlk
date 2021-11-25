/* 
Module      :  Practica Objetos - Espacios Urbanos
Description :  https://docs.google.com/document/d/1-4QWIlWteY94dDN3K045-gmsQXm2pAxoSa6cK9ZSsZI/edit#
Date        :  21.11.2021
Grupo       :  Grupo 6 
Name        :  Guido Reboredo
Subject     :  PdeP K2054 - UTN FRBA
*/


/* ESPACIOS URBANOS */

class EspacioUrbano {
	var property valuacion
	var property superficie
	var property nombre
	var property vallado
	var property trabajos = #{}
	
	
	method esGrande(){
		return self.cumpleCondicionGrande() && superficie > 50
	}
	
	method aumentarValuacion(cantidad){
		valuacion += cantidad
	}
	
	method esEspacioVerde()=false
	
	method esEspacioLimpiable()=false
	
	method registrarTrabajo(unTrabajo){
		trabajos.add(unTrabajo)
	}
	
	method cumpleCondicionGrande()
	
	method esDeUsoIntensivo(){
		return self.cantidadTrabajosHeavy() > 5
	}
	
	method trabajosRealizadosHeavy(){
		return trabajos.filter({unTrabajo => unTrabajo.esHeavy()})
	}
	method cantidadTrabajosHeavy(){
		return self.trabajosRealizadosHeavy().size()
	}

}

class Plaza inherits EspacioUrbano{
	var property esparcimiento
	var property canchas
	
	override method cumpleCondicionGrande() = canchas > 2
	
	override method esEspacioVerde() = canchas == 0
	
	override method esEspacioLimpiable() = true
	
}

class Plazoleta inherits EspacioUrbano{
	var property homenaje
	
	override method cumpleCondicionGrande() = homenaje=="San Martin" && vallado
	
}

class Anfiteatro inherits EspacioUrbano{
	var property capacidad
	var property escenario
	
	override method cumpleCondicionGrande() = capacidad > 500
	
	override method esEspacioLimpiable() = self.esGrande()
	
}

class Multiespacio inherits EspacioUrbano{
	var property espaciosUrbanos = new Set()
	
	override method cumpleCondicionGrande() = espaciosUrbanos.all({unEspacio => unEspacio.cumpleCondicionGrande()})
	
	override method esEspacioVerde() = espaciosUrbanos.size() > 3
}

/* PERSONAS */

class Persona{
	var property nombre
	var property profesion
	var property valorHora = 100
	
	method trabajar(unEspacioUrbano){
		profesion.realizarTrabajo(unEspacioUrbano,self)
	}
	
	method realizoTrabajoHeavy(trabajo){
		profesion.trabajoHeavy(trabajo)
	}
	
}

/* TRABAJOS */

class Profesion{
	
	method validarEspacio(unEspacioUrbano)
	
	method modificarEspacio(unEspacioUrbano)
	
	method duracion(unEspacioUrbano)
	
	method realizarTrabajo(unEspacioUrbano, unTrabajador){
		self.puedeTrabajarEn(unEspacioUrbano)
		self.modificarEspacio(unEspacioUrbano)
		self.registrarTrabajo(unEspacioUrbano, unTrabajador)
	}
	
	method puedeTrabajarEn(unEspacioUrbano){
		if(!self.validarEspacio(unEspacioUrbano)){
			throw new EspacioInvalido(message = "ESPACIO_INVALIDO")
		}
	}
	
	method costoTrabajo(unEspacioUrbano, unTrabajador){
		return self.duracion(unEspacioUrbano) * unTrabajador.valorHora()
	}
	
	method registrarTrabajo(unEspacioUrbano, unTrabajador){
		unEspacioUrbano.registrarTrabajo(self.trabajoRealizado(unEspacioUrbano, unTrabajador))
	}
	
	method trabajoRealizado(unEspacioUrbano, unTrabajador){
		return new Trabajo(trabajador = unTrabajador, duracion = self.duracion(unEspacioUrbano), costo = self.costoTrabajo(unEspacioUrbano, unTrabajador))
	}
	
	method trabajoHeavy(trabajo){
		return trabajo.costo() > 10000
	}
	
}

object cerrajero inherits Profesion{
	
	override method validarEspacio(unEspacioUrbano) = !unEspacioUrbano.vallado()
	
	override method modificarEspacio(unEspacioUrbano){
		  unEspacioUrbano.vallado(true)	
	}
    
    override method duracion(unEspacioUrbano){
    	if(unEspacioUrbano.esGrande())
    		return 5
    	else
    	    return 3
    	
    }
    
    override method trabajoHeavy(trabajo){
    	return super(trabajo) && trabajo.duracion()>5
    }
}

object jardinero inherits Profesion{
	
	
	override method validarEspacio(unEspacioUrbano) = unEspacioUrbano.esEspacioVerde()
	
	override method modificarEspacio(unEspacioUrbano){
		  unEspacioUrbano.aumentarValuacion(unEspacioUrbano.valuacion()*0.1)
	}
    
    override method duracion(unEspacioUrbano){
	 	return unEspacioUrbano.superficie()/10
    	
    }
	
	override method costoTrabajo(unEspacioUrbano, unTrabajador) = 2500

}

object encargado inherits Profesion{
	
	override method validarEspacio(unEspacioUrbano) = unEspacioUrbano.esEspacioLimpiable()
	
	override method modificarEspacio(unEspacioUrbano){
		unEspacioUrbano.aumentarValuacion(5000)
	}	

	override method duracion(unEspacioUrbano) = 8

}


class Trabajo{
	var property fecha = new Date()
	var property trabajador
	var property duracion
	var property costo
	
	method esHeavy(){
		return trabajador.realizoTrabajoHeavy(self)
	}
	
}



class EspacioInvalido inherits DomainException{}