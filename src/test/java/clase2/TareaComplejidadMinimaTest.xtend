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
		val tareaComplejidadMinima = new TareaSimple => [
			asignarComplejidadMinima
			tiempo = 60
		]
		
		// assert
		assertEquals(1500, tareaComplejidadMinima.costo)
	} 
}
