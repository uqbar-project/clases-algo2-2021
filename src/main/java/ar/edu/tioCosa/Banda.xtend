package ar.edu.tioCosa

import java.math.BigDecimal
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Banda {
	static val PORCENTAJE_COMISION_BANDA = 0.2
	
	double montoRecaudado
	List<Integrante> integrantes = newArrayList
	Integrante lider
	
	def sumarRecaudacion(double monto) {
		val montoParaBanda = montoParaLaBanda(monto)
		montoRecaudado += montoParaBanda
		val montoParaVito = monto - montoParaBanda
		Vito.instance.sumarRecaudacion(montoParaVito)
	}
	
	def montoParaLaBanda(double monto) {
		PORCENTAJE_COMISION_BANDA * monto
	}

	def puedeRealizar(Tarea tarea) {
		!estaEnBancarrota && puedeHacer(tarea)
	}
	
	def boolean puedeHacer(Tarea tarea)
	
	def estaEnBancarrota() {
		montoRecaudado === 0
	}
	
	def void agregarIntegrante(Integrante integrante) {
		integrantes.add(integrante)
	}
	
	def void eliminarIntegrante(Integrante integrante) {
		integrantes.remove(integrante)
	}
}

class BandaForajida extends Banda {
	
	override puedeHacer(Tarea tarea) {
		integrantes.exists [ quiereHacer(tarea) ]
	}
	
}

class BandaTipica extends Banda {
	
	override puedeHacer(Tarea tarea) {
		lider.quiereHacer(tarea)
	}
	
}


class Integrante {
	Personalidad personalidad
	
	def quiereHacer(Tarea tarea) { personalidad.quiereHacer(tarea) }
}

interface Personalidad {
	def boolean quiereHacer(Tarea tarea)
}

class AltoPerfil implements Personalidad {
	override quiereHacer(Tarea tarea) {
		tarea.dineroAGanar() >= 1000
	}
}

class Culposo implements Personalidad {
	override quiereHacer(Tarea tarea) {
		tarea.personaInvolucrada.ventasObtenidas > 5000
	}
}

class Alternante implements Personalidad {
	
	Personalidad personalidadMesPar = new Culposo()
	Personalidad personalidadMesImpar = new AltoPerfil()
	
	override quiereHacer(Tarea tarea) {
		personalidad(tarea).quiereHacer(tarea)
	}
	
	def Personalidad personalidad(Tarea tarea) {
		if (mesPar(tarea)) personalidadMesPar else personalidadMesImpar
	}
	
	def boolean mesPar(Tarea tarea) {
		tarea.fecha.monthValue % 2 === 0
	}
	
}

class Combinada implements Personalidad {
	List<Personalidad> personalidades
	
	override quiereHacer(Tarea tarea) {
		personalidades.forall [ quiereHacer(tarea) ]
	}
}
