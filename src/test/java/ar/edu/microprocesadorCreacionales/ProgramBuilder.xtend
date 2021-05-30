package ar.edu.microprocesadorCreacionales

import java.util.List

class ProgramBuilder {
	List<Byte> program = newArrayList
	
	def LODV(int value) {
		program.add(9 as byte)
		program.add(value as byte)
		this
	}
	
	def SWAP() {
		program.add(5 as byte)
		this
	}
	
	def ADD() {
		program.add(2 as byte)
		this
	}
	
	def build() {
		if (program.isEmpty) {
			throw new RuntimeException("El programa no puede estar vacío")
		}
		program
	}

}