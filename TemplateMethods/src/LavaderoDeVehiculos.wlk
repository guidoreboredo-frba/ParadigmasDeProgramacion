/* Lavadero de Vehiculos */

class Vehiculo{
	var property nivelSuciedad = 0
	
	
}

class lavArtesanal{
	
}

class Paloma {
	
	var property peso
	
	
	method ensuciar(vehiculo){
		
		var cantEnsucia = peso * 0.3
		vehiculo.incrementarNivelSuciedad( cantEnsucia )
		peso -= cantEnsucia
		
		
	}
	
	
}

class Gaviota {

	var property cantPescado
	
	
	method ensuciar(vehiculo){
		vehiculo.incrementarNivelSuciedad( cantPescado * 3 )
	}
	
}

class Ave {
	
	var cantEnsucia
	
	method ensuciar(vehiculo){
		vehiculo.incrementarNivelSuciedad(cantEnsucia)
	}
	
}

class Bandada{
	formacion
	
}