package clase1

import org.eclipse.xtend.lib.annotations.Accessors

class Cliente {
	protected int deuda = 0
	
	def puedeCobrarSiniestro() {
		!esMoroso
	}
	
	def esMoroso() {
		deuda > 0
	}
	
	def endeudarse(int monto) {
		deuda = deuda + monto
	}
}

@Accessors
class Flota extends Cliente {
	public static val MAXIMO_FLOTA_MUCHOS_AUTOS = 10000
	public static val MAXIMO_FLOTA_POCOS_AUTOS = 5000

	int autos
	
	override puedeCobrarSiniestro() {
		deuda <= maximoPermitido
	}
	
	def maximoPermitido() {
		if (autos <= 5) MAXIMO_FLOTA_POCOS_AUTOS else MAXIMO_FLOTA_MUCHOS_AUTOS
	}
	
}