package clase2

import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import static org.junit.jupiter.api.Assertions.assertEquals

@DisplayName("Dado una tarea simple")
class TareaSimpleTest {
	
	@Test
	@DisplayName("no tiene costo por overhead")
	def void tareaSimpleCostoPorOverhead() {
		// arrange
		val tareaSimple = new TareaSimple => [
			tiempo = 10
		]
		
		// assert
		assertEquals(0, tareaSimple.costoPorOverhead)
	}
}