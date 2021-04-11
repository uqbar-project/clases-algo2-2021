package clase2

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Tarea {
	int tiempo
	Complejidad complejidad = new ComplejidadMinima
	List<Impuesto> impuestos = newArrayList
	
	def asignarComplejidadMinima() {
		complejidad = new ComplejidadMinima
	}
	
	def asignarComplejidadMedia() {
		complejidad = new ComplejidadMedia
	}
	
	def asignarComplejidadMaxima() {
		complejidad = new ComplejidadMaxima
	}

	// template method	
	def double costo() {
		// primitiva 1        primitiva 2           primitiva 3
		costoComplejidad() + costoImpositivo() + costoPorOverhead()
	}
	
	def double costoComplejidad() {
		complejidad.costo(this)
	}
	
	def double costoPorOverhead() {0}
	
	def double costoImpositivo() {
		return this.impuestos.fold(0d, [ acum, impuesto | acum + impuesto.costoImpositivo(this) ])
	}
	
	def void agregarImpuesto(Impuesto impuesto) {
		this.impuestos.add(impuesto)
	}
	
}

abstract class Complejidad {
	def double costo(Tarea tarea) {
		tarea.tiempo * 25
	}
}

class ComplejidadMinima extends Complejidad {}
class ComplejidadMedia extends Complejidad {
	override costo(Tarea tarea) {
		super.costo(tarea) * 1.05
	}
}
class ComplejidadMaxima extends Complejidad {
	override costo(Tarea tarea) {
		super.costo(tarea) * 1.07 + (10 * Math.max(0, tarea.tiempo - 10))
	}
	
}

class TareaCompuesta extends Tarea {
	public val static MINIMO_MUCHAS_SUBTAREAS = 3
	public val static COEFICIENTE_AJUSTE_OVERHEAD = 0.04

	List<Tarea> subtareas = newArrayList
	
	def agregarSubtarea(Tarea tarea) {
		subtareas.add(tarea)
	}
	
	override costoPorOverhead() {
		if (tieneMuchasSubtareas()) costoComplejidad() * COEFICIENTE_AJUSTE_OVERHEAD else 0
	}
	
	def tieneMuchasSubtareas() {
		subtareas.length > MINIMO_MUCHAS_SUBTAREAS
	}
	
}

class TareaSimple extends Tarea {
	
	override costoPorOverhead() {
		0
	}
	
}
