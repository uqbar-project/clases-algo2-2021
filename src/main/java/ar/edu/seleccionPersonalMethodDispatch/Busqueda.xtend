package ar.edu.seleccionPersonalMethodDispatch

import java.math.BigDecimal
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Busqueda {

	List<Postulante> postulantes = newArrayList
	BigDecimal remuneracion
	String sector
	String puesto

	def agregarPostulante(Postulante postulante) {
		postulantes.add(postulante)
	}

//	def postular(Postulante postulante) {
//		this.validarPostulacion(postulante)
//		this.agregarPostulante(postulante)
//	}
//	
//	def void validarPostulacion(Postulante postulante) {
//		// ok		
//	}
	
	def boolean estaPostulado(Postulante postulante) {
		postulantes.contains(postulante)
	}
	
	def void validarPersonalPlanta(Postulante postulante)
	def void validarPersonalContratado(Postulante postulante)
	def void validarPersonalExterno(Postulante postulante)
}

class BusquedaEspecial extends Busqueda {
	
	override validarPersonalPlanta(Postulante postulante) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override validarPersonalContratado(Postulante postulante) {
		if (postulante.cantidadPersonasACargo < 20) {
			throw new BusinessException("El postulante no tiene más de 20 personas a cargo")
		}
	}
	
	override validarPersonalExterno(Postulante postulante) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

//    PersonalContratado

//    Externo
//		if (!externo.trabajoEn(puesto)) {
//			throw new BusinessException("Para poder postularse debe haber trabajado anteriormente en el puesto de " + puesto)
//		}
	
	
//    Personal planta
//		if (remuneracion < empleado.sueldo) {
//			throw new BusinessException("La remuneración de la búsqueda debe superar el sueldo actual para postularse a una búsqueda especial")
//		}
//		if (empleado.cantidadPersonasACargo < 10) {
//			throw new BusinessException("Debe tener al menos 10 personas a cargo para postularse a una búsqueda especial")
//		}

}

class BusquedaExterna extends Busqueda {
	
	override validarPersonalPlanta(Postulante postulante) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override validarPersonalContratado(Postulante postulante) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override validarPersonalExterno(Postulante postulante) {
	}

// Personal Contratado
//		if (empleado.fechaAntiguedad > 1) {
//			throw new BusinessException("El postulante no tiene menos de un año de antigüedad")
//		}

// Personal planta
//		throw new BusinessException("Un empleado de planta no puede postularse a una búsqueda externa")

// Lo otro va bien
	
}

class BusquedaInterna extends Busqueda {

	override validarPersonalPlanta(Postulante postulante) {
	}
	
	override validarPersonalContratado(Postulante postulante) {
//		if (!sector.equals(postulante.sector)) {
//			throw new BusinessException(
//				"El postulante pertenece al sector " + postulante.sector + " y la búsqueda es para " + this.sector)
//		}
	}
	
	override validarPersonalExterno(Postulante postulante) {
		throw new BusinessException("No puede postularse a búsquedas internas")
	}
	
	//  PersonalContratado

	// Lo otro va bien	
}


