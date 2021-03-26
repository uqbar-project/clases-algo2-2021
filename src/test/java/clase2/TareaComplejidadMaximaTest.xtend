package clase2

import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach

@DisplayName("Dada una tarea de complejidad maxima")
class TareaComplejidadMaximaTest {
	Tarea tareaComplejidadMaxima
	
	@BeforeEach
	def void init() {
		// arrange
		tareaComplejidadMaxima = new TareaSimple => [
			asignarComplejidadMaxima
			tiempo = 60
		]
	}

	@Test
	@DisplayName("el costo de una tarea de muchos días lleva un adicional")
	def void testCostoTareaMuchosDiasComplejidadMaxima() {
		// assert
		assertEquals(2105, tareaComplejidadMaxima.costo)
	}
	
	@Test
	@DisplayName("el costo de una tarea de pocos días lleva solo el porcentaje extra")
	def void testCostoTareaPocosDiasComplejidadMaxima() {
		// act
		tareaComplejidadMaxima.tiempo = 5
		// assert
		assertEquals(133.75, tareaComplejidadMaxima.costo)
	}
}