package ar.edu.tioCosa

import java.time.LocalDate
import java.util.List

class Vito {
	
	// SINGLETON
	private static Vito instance
	
	private new() {}
	
	public static def getInstance() {
		if (instance === null) instance = new Vito()
		instance
	}
	//
	
	List<Banda> bandas
	List<Tarea> tareas
	double montoRecaudado
		
	def void sumarRecaudacion(double monto) {
		montoRecaudado += monto
	}
	
	def pagar(int monto) {
		montoRecaudado -= monto
	}
	
	def agregarTarea(Tarea tarea) {
		this.tareas.add(tarea)
	}
	
	def void asignarTareas(LocalDate fecha) {
		tareasPendientes(fecha).forEach [ tarea |
			val banda = bandas.findFirst [ puedeRealizar(tarea) ]
			tarea.asignar(banda)
		]
	}
	
	def tareasPendientes(LocalDate fecha) {
		tareas.filter [ estaPendientePara(fecha) ]
	}
	
//	def tareasSinAsignar(LocalDate fecha) {
//		tareas.filter [ estaSinAsignar(fecha) ]
//	}

	def void realizarTareas(LocalDate fecha) {
		tareasPendientes(fecha).forEach [ realizar ]
	}
	
}