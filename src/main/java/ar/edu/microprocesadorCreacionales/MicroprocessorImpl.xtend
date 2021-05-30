package ar.edu.microprocesadorCreacionales

import java.util.ArrayList
import java.util.List

class MicroprocessorImpl implements Microprocessor {
	
	byte acumuladorA
	byte acumuladorB
	int programCounter
	List<Byte> datos
	boolean programStarted = false
	ProgramIterator programIterator
	
	new() {
		this.reset()
	}
	
	/** Manejo del estado del Microprocessor */
	override getAAcumulator() {
		acumuladorA
	}
	
	override setAAcumulator(byte value) {
		acumuladorA = value
	}
	
	override getBAcumulator() {
		acumuladorB
	}
	
	override setBAcumulator(byte value) {
		acumuladorB = value
	}
	
	override getPC() {
		programCounter as byte
	}
	
	override advancePC() {
		programCounter = programCounter + 1
	}
	
	override reset() {
		programCounter = 0 as byte
		acumuladorA = 0 as byte
		acumuladorB = 0 as byte
		datos = new ArrayList<Byte>(1024) 
		for (int i : 0..1023) {
			datos.add(0 as byte)
		}
	}
	
	override getData(int addr) {
		datos.get(addr)
	}
	
	override setData(int addr, byte value) {
		datos.set(addr, value)
	}
	
	override copyFrom(Microprocessor micro) {
		acumuladorA = micro.AAcumulator
		acumuladorB = micro.BAcumulator
		programCounter = micro.PC
		programCounter = programCounter - 1
		for (int i : 0..1023) {
			val data = micro.getData(i)
			this.setData(i, data)
		}
	}
	
	override clone() {
		try {
			return super.clone as Microprocessor
		} catch (CloneNotSupportedException e) {
			throw new SystemException(e)
		}
	}
	
	override setInput(byte channel, byte value) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override setPC(int value) {
		throw new UnsupportedOperationException("Use advancePC() instead")
	}

	override loadProgram(List<Byte> program) {
		if (this.programStarted) throw new SystemException("Ya hay un programa en ejecución")
		this.reset()
		this.programIterator = new ProgramIterator(program)
	}
	
	override start() {
		programStarted = true
	}

	override stop() {
		programStarted = false
	}

	override step() {
		if (!programStarted) throw new SystemException("El programa no está iniciado")
		if (!programIterator.hasNext()) throw new SystemException("No hay más instrucciones para ejecutar")
		val proximaInstruccion = programIterator.next()
		proximaInstruccion.execute(this)
	}
	
	override run() {
		this.start()
		while (programIterator.hasNext()) {
			this.step()
		}
		this.stop()
	}

}


abstract class Instruccion implements Cloneable {
	Microprocessor microBefore
	
	def void execute(Microprocessor micro) {
		microBefore = micro.clone
		this.doExecute(micro)
		micro.advancePC
	}
	
	def void undo(Microprocessor micro) {
		micro.copyFrom(microBefore)
	}
	
	def void doExecute(Microprocessor microprocessor)
	
	def copy() {
		this.clone as Instruccion
	}
	
	def prepare(ProgramIterator programIterator) {}
}

class NOP extends Instruccion {
	
	override doExecute(Microprocessor microprocessor) {
	}
	
}

class LODV extends Instruccion {
	byte value
	
	new(int originalValue) {
		value = originalValue as byte
	}
	
	override doExecute(Microprocessor micro) {
		micro.AAcumulator = value
	}
	
	override prepare(ProgramIterator programIterator) {
		value = programIterator.nextValue()
	}
}

class SWAP extends Instruccion {
	override doExecute(Microprocessor micro) {
		val buffer = micro.AAcumulator
		micro.AAcumulator = micro.BAcumulator
		micro.BAcumulator = buffer
	}
}

class ADD extends Instruccion {
	override doExecute(Microprocessor micro) {
		micro.AAcumulator = (micro.AAcumulator + micro.BAcumulator) as byte
		micro.BAcumulator = 0 as byte
	}
}

