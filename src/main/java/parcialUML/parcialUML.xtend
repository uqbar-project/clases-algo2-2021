package parcialUML

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

class Turista {
	List<Destino> destinosDeseados = newArrayList
	List<Destino> destinosVisitados = newArrayList
	TipoTurista tipoTurista
	int felicidad = 100
	
	def void cumplirSuenio() {
		val destino = tipoTurista.elegirDestino(this.destinosDeseados)
		destino.visitar(this)
		destinosVisitados.add(destino)
		destinosDeseados.remove(destino)
	}
	
	def void subirFelicidad(int cantidad) {
		felicidad = felicidad + cantidad
	}
}

interface TipoTurista {
	def Destino elegirDestino(List<Destino> destinos)
}

class TuristaAnsioso implements TipoTurista {
	
	override elegirDestino(List<Destino> destinos) {
		destinos.head
	}
	
}

class TuristaAmbicioso implements TipoTurista {
	
	override elegirDestino(List<Destino> destinos) {
		destinos.maxBy [ calificacion ]
	}
	
}

interface Destino {
	def void visitar(Turista turista)
	def int getCalificacion()
}

class DestinoTuristico implements Destino {
	@Accessors int calificacion
	int cantidadVisitas
	
	override visitar(Turista turista) {
		cantidadVisitas = cantidadVisitas + 1
		turista.subirFelicidad(calificacion * 3)
	}
	
}

class ComboDestinos implements Destino {
	List<Destino> destinos = newArrayList
	
	override visitar(Turista turista) {
		destinos.forEach [ destino | destino.visitar(turista) ]
	}
	
	override getCalificacion() {
		destinos.fold(0, [acum, destino | acum + destino.calificacion ])
	}
	
}