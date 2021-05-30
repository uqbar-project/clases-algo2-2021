package ar.edu.microprocesadorCreacionales

import java.util.Iterator
import java.util.List
import java.util.Map

class ProgramIterator implements Iterator<Instruccion> {
	
	List<Byte> program
	int index = 0
	
	new(List<Byte> program) {
		this.program = program
	}
	
	override hasNext() {
		index < program.size
	}
	
	override next() {
		val instructionCode = nextValue()
		InstruccionFactory.getInstruccion(instructionCode, this)
	}
	
	def Byte nextValue() {
		program.get(index++)
	}
	
}

class InstruccionFactory {
	static Map<Integer, (ProgramIterator) => Instruccion> instrucciones = #{
		9 -> [ ProgramIterator programIterator |
			val value = programIterator.nextValue
			new LODV(value)
		],
		5 -> [ ProgramIterator programIterator | new SWAP ],
		2 -> [ ProgramIterator programIterator | new ADD ]
	}
	
	def static getInstruccion(int instructionCode, ProgramIterator programIterator) {
		instrucciones.get(instructionCode).apply(programIterator)
	}
	
	private new(){}
}

