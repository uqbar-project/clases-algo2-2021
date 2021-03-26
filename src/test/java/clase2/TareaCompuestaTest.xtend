package clase2

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

@DisplayName("Dado una tarea compuesta")
class TareaCompuestaTest {
	TareaCompuesta tareaCompuestaMuchasSubtareas
	
	@BeforeEach
	def void init() {
		// arrange
		tareaCompuestaMuchasSubtareas = new TareaCompuesta => [
			tiempo = 50
			agregarSubtarea(new TareaSimple)
			agregarSubtarea(new TareaSimple)
			agregarSubtarea(new TareaSimple)
		]
	}

	@DisplayName("Si tiene muchas subtareas tiene un costo extra por overhead")
	@Test
	def void tareaCompuestaMuchasSubtareasConCostoPorOverhead() {
		// act
		tareaCompuestaMuchasSubtareas.agregarSubtarea(new TareaSimple)

		// assert
		assertEquals(50, tareaCompuestaMuchasSubtareas.costoPorOverhead)
	} 

	@DisplayName("Si no tiene muchas subtareas, no tiene un costo extra por overhead")
	@Test
	def void tareaCompuestaPocasSubtareasSinCostoPorOverhead() {
		// assert
		assertEquals(0, tareaCompuestaMuchasSubtareas.costoPorOverhead)
	}

}