object tom {

	var energia = 20
	var posicion = 30
	
	method energia(cantidad){
		energia = cantidad
	}
	
	method getEnergia() = energia
	
	method posicion() = posicion
	
	method velocidad() = 5 + energia/10
	
	method puedeAtraparA(algo) = self.velocidad() > algo.velocidad()
	
	method tomCorreA(algo) {
		energia -= 0.5 * self.velocidad() * self.distanciaA(algo)
		posicion = algo.posicion()
	}  
	
	method distanciaA(algo){
		return (posicion - algo.posicion()).abs()
	}


}

object jerry {
	
	var peso = 4
	var posicion = 34
	
	method posicion() = posicion
	
	method peso(cantidad){
		peso = cantidad
	}
	
	method velocidad() = 10-peso
	
}
