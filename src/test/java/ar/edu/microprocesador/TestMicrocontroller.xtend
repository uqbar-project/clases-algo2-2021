package ar.edu.microprocesador

import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

class TestMicrocontroller {

	// Arrange
	Microcontroller micro = new MicrocontrollerImpl
	
	@Test
	@DisplayName("Test del programa NOP")
	def void programNOP() {
		// Act
		val nop = new NOP
		micro.run(#[
			nop,
			nop,
			nop
		])
		
		// Assert
		assertEquals(3, micro.PC)
	}
	
	@Test
	@DisplayName("Test del programa que suma 10 + 22")
	def void programSuma() {
		// Act
		micro.run(#[
			new LODV(10),
			new SWAP,
			new LODV(22),
			new ADD
		])
		
		// Assert
		assertEquals(32, micro.AAcumulator)
		assertEquals(0, micro.BAcumulator)
		assertEquals(4, micro.PC)
	}	

	@Test
	@DisplayName("Test del undo")
	def void programUndo() {
		val swap = new SWAP
		
		// Act
		micro.run(#[
			new LODV(10),
			swap
		])
		
		// Assert
		assertEquals(0, micro.AAcumulator)
		assertEquals(10, micro.BAcumulator)
		assertEquals(2, micro.PC)
		
		// Ahora sí probamos el UNDO
		swap.undo(micro)
		
		// Assert
		assertEquals(10, micro.AAcumulator)
		assertEquals(0, micro.BAcumulator)
		assertEquals(1, micro.PC)
	}	

	@Test
	@DisplayName("Test del IFNZ")
	def void programIFNZ() {
		// Act
		micro.run(#[
			new LODV(10), // A => 10
			new SWAP,     // B => 10, A => 0
			new LODV(5),  // B => 10, A => 5
			new IFNZ(#[   // si A es distinto de 0
				new ADD,  // A => 15, B => 0
				new NOP   // PC => 6
			])	
		])
		
		// Assert
		assertEquals(15, micro.AAcumulator)
		assertEquals(0, micro.BAcumulator)
		assertEquals(6, micro.PC)
	}	


}