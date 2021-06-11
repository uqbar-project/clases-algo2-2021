package ar.edu.seleccionPersonal

import ar.edu.seleccionPersonalMethodDispatch.BusinessException
import ar.edu.seleccionPersonalMethodDispatch.BusquedaExterna
import ar.edu.seleccionPersonalMethodDispatch.BusquedaInterna
import ar.edu.seleccionPersonalMethodDispatch.Externo
import ar.edu.seleccionPersonalMethodDispatch.Postulante
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertThrows
import static org.junit.jupiter.api.Assertions.assertTrue

class TestBusqueda {
	
	@Test
	@DisplayName("Un externo puede postularse a una búsqueda externa")
	def void unExternoPuedePostularseAUnaBusquedaExterna() {
		// Arrange
		val Postulante externo = new Externo()
		val busquedaExterna = new BusquedaExterna()
		
		// Act
		externo.postularA(busquedaExterna)
		
		// Assert
		assertTrue(busquedaExterna.estaPostulado(externo))
	}
	
	@Test
	@DisplayName("Un externo no puede postularse a una búsqueda interna")
	def void unExternoNoPuedePostularseAUnaBusquedaInterna() {
		// Arrange
		val Postulante externo = new Externo()
		val busquedaInterna = new BusquedaInterna()
		
		// Act
		assertThrows(BusinessException, [ externo.postularA(busquedaInterna) ])
	}
}