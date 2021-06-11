package ar.edu.tioCosa

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Persona {
	int deuda = 0
	int ventasObtenidas = 0
	
	def void sumarDeuda(int monto) {
		deuda += monto
	}
	
	def void bajarDeuda(int monto) {
		deuda -= monto
	}
}