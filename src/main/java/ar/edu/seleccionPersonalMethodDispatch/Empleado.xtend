package ar.edu.seleccionPersonalMethodDispatch

import java.math.BigDecimal
import java.time.LocalDate
import java.time.temporal.ChronoUnit
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

abstract class Postulante {

	def void postularA(Busqueda busqueda) {
		this.validarBusqueda(busqueda)
		busqueda.agregarPostulante(this)
	}
	
	def void validarBusqueda(Busqueda busqueda)
	
	def int cantidadPersonasACargo() { 0 }

}

@Accessors
abstract class Empleado extends Postulante {
	String sector
	LocalDate fechaIngreso
	List<Empleado> personasACargo

	new() {
		personasACargo = new ArrayList<Empleado>
		fechaIngreso = LocalDate.now
	}

	def void agregarPersonaACargo(Empleado empleado) {
		personasACargo.add(empleado)
	}

	def getFechaAntiguedad(LocalDate dia) {
		ChronoUnit.YEARS.between(fechaIngreso, dia)
	}

	def getFechaAntiguedad() {
		LocalDate.now().fechaAntiguedad
	}

	override cantidadPersonasACargo() {
		personasACargo.size
	}

}

@Accessors
class PersonalPlanta extends Empleado {

	Cargo cargo

	def sueldo() {
		cargo.sueldo
	}
	
	override validarBusqueda(Busqueda busqueda) {
		busqueda.validarPersonalPlanta(this)
	}

	
}

class PersonalContratado extends Empleado {
	@Accessors BigDecimal sueldo
	
	override validarBusqueda(Busqueda busqueda) {
		busqueda.validarPersonalContratado(this)
	}
}

class Externo extends Postulante {
	List<Cargo> cargosAnteriores = newArrayList

	def void trabajarDe(Cargo cargo) {
		cargosAnteriores.add(cargo)
	}

	def trabajoEn(String puesto) {
		puestosAnteriores.contains(puesto)
	}

	def puestosAnteriores() {
		cargosAnteriores.map[descripcion]
	}

	override validarBusqueda(Busqueda busqueda) {
		busqueda.validarPersonalExterno(this)
	}
	
}


class ToastMessage {
	val ERROR = 1
	
	def void mostrarMensaje(String mensaje) {
		mostrarMensaje(mensaje, ERROR, 5000)
	}
	
	def void mostrarMensaje(String mensaje, int TipoMensaje, int milisegundosAEsperar) {
//		...
	}
}
