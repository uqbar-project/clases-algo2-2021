package clase2

import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import static org.junit.jupiter.api.Assertions.assertEquals

@DisplayName("Dada una tarea de complejidad mínima")
class TareaComplejidadMinimaTest {
	
	@Test
	@DisplayName("el costo se hace en base al cálculo por defecto")
	def void testCostoTareaComplejidadMinima() {
		// arrange
		val tareaComplejidadMinima = new Tarea => [
			asignarComplejidadMinima
			tiempo = 60
		]
		
		// assert
		assertEquals(1500, tareaComplejidadMinima.costo)
	} 
}

@DisplayName("Dada una tarea de complejidad media")
class TareaComplejidadMediaTest {
	
	@Test
	@DisplayName("el costo se hace en base al cálculo por defecto más un adicional")
	def void testCostoTareaComplejidadMedia() {
		// arrange
		val tareaComplejidadMedia = new Tarea => [
			asignarComplejidadMedia
			tiempo = 60
		]
		
		// assert
		assertEquals(1575, tareaComplejidadMedia.costo)
	} 
}