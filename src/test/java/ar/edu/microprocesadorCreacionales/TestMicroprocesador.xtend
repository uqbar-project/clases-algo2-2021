package ar.edu.microprocesadorCreacionales

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

@DisplayName("Dado un microprocesador")
class TestMicroprocesador {
	
	Microprocessor micro

	@BeforeEach
	def void setUp() {
		micro = new MicroprocessorImpl
	}
	
	@Test
	def void sumar8y5() {
		// arrange
		micro.loadProgram(
			new ProgramBuilder()
				.LODV(8)
				.SWAP
				.LODV(5)
				.ADD
				.build
		)

		// act
		micro.run()
		
		// assert
		assertEquals(13, micro.AAcumulator)
		assertEquals(0, micro.BAcumulator)
		assertEquals(4, micro.PC)
	}
}