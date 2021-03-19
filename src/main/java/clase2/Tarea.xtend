package clase2

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Tarea {
	int tiempo
	Complejidad complejidad
	
	def asignarComplejidadMinima() {
		complejidad = Complejidad.MINIMA
	}
	
	def asignarComplejidadMedia() {
		complejidad = Complejidad.MEDIA
	}
	
	def double costo() {
		if (complejidad == Complejidad.MINIMA) {
			return costoBase()
		}
		if (complejidad == Complejidad.MEDIA) {
			return costoBase() * 1.05
		}
	}
	
	def int costoBase() {
		tiempo * 25
	}
	
}

enum Complejidad { MINIMA, MEDIA, MAXIMA }