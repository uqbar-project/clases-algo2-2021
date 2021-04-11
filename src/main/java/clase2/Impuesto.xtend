package clase2

import org.eclipse.xtend.lib.annotations.Data

@Data
class Impuesto {
	double porcentaje
	
	private new(double porcentaje) {
		this.porcentaje = porcentaje
	}
	
	// Multiton
	static Impuesto impuestoA = new Impuesto(0.03)
	static Impuesto impuestoB = new Impuesto(0.05)
		
	static def ImpuestoA() { impuestoA }
	static def ImpuestoB() { impuestoB }
	
	def costoImpositivo(Tarea tarea) {
		tarea.costoComplejidad * porcentaje
	}
	
}

