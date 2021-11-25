/* 
Module      :  Practica Objetos - Danger Zone
Description :  https://docs.google.com/document/d/e/2PACX-1vRFhr0lXZkZoovSdMhpqNr45HMn6NsuRTsQBJXVCDReAqqcvaOtskwIJCV9K7vIbWAXHlF2gFjaQwD9/pub
Date        :  21.11.2021
Grupo       :  Grupo 6 
Name        :  Guido Reboredo
Subject     :  PdeP K2054 - UTN FRBA
*/


/* Empleados */

class Empleado{
	var property habilidades = []
	var property salud = 100
	var property puesto
	
	
	method incapacitado() = salud < puesto.saludCritica()
	
	method puedeUsar(habilidad) = !self.incapacitado() && self.poseeHabilidad(habilidad)
	
	method poseeHabilidad(habilidad) = habilidades.contains(habilidad)

}

object espia {
	method saludCritica() = 15
}

class Oficinista{
	var property estrellas
	
	method saludCritica() = 40 - 5 * estrellas
}

class Jefe inherits Empleado{
	
	var property subordinados = #{}
	
	method agregarSubordinado(empleado){
		subordinados.add(empleado)
	}
	
	override method puedeUsar(habilidad){
		return super(habilidad) or subordinados.any({empleado => empleado.puedeUsar(habilidad)})
	}
}

class Equipo{
	var property empleados = new Set()
	
	method unMiembroPosee(habilidad){
		return empleados.any({empleado => empleado.puedeUsar(habilidad)})
	}	
	
	method validarHabilidades(unaMision){
		return unaMision.habilidades().all({habilidad => self.unMiembroPosee(habilidad)})
	}
	
}

class Mision{
	var property nombre
	var property habilidades = []
	var property peligrosidad


}