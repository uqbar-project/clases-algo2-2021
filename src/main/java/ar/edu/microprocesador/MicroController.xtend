package ar.edu.microprocesador

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

interface Microcontroller extends Cloneable {
  	/*** programacion: carga y ejecuta un conjunto de instrucciones en memoria */
  	def void run(List<Instruccion> program)
  	/*** Getters y setters de acumuladores A y B */
  	def byte getAAcumulator()
  	def void setAAcumulator(byte value)
  	def byte getBAcumulator()
  	def void setBAcumulator(byte value)
  	/*** Manejo de program counter */
  	def void advancePC() // Avanza el program counter una instrucción
  	def byte getPC()
  	def void reset()     // Inicializa el microcontrolador
  	/*** Manejo de dirección de memoria de datos: getter y setter */
  	def byte getData(int addr)
  	def void setData(int addr, byte value)
  	def Microcontroller copy()
  	def void copyFrom(Microcontroller other)
}

class MicrocontrollerImpl implements Microcontroller {
	
	byte acumuladorA
	byte acumuladorB
	int programCounter
	List<Byte> datos

	new() {
		this.reset
	}
	
	override run(List<Instruccion> program) {
		program.forEach [ instruccion | instruccion.execute(this) ] 
	}
	
	/** Manejo del estado del microcontroller */
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
		datos.get(addr) as byte
	}
	
	override setData(int addr, byte value) {
		datos.set(addr, value)
	}
	
	override copy() {
		this.clone() as Microcontroller
	}
	
	override copyFrom(Microcontroller other) {
		this.AAcumulator = other.AAcumulator
		this.BAcumulator = other.BAcumulator
		for (i : 0..1023) {
			val data = other.getData(i)
			this.setData(i, data)
		} 
		this.programCounter = other.PC
	}
	
}

abstract class Instruccion {
	Microcontroller microBefore
	
	def void execute(Microcontroller micro) {
		microBefore = micro.copy
		this.doExecute(micro)
		micro.advancePC
	}
	
	def void undo(Microcontroller micro) {
		micro.copyFrom(microBefore)
	}
	
	def void doExecute(Microcontroller microcontroller)
	
}

class NOP extends Instruccion {
	
	override doExecute(Microcontroller microcontroller) {
	}
	
}

class LODV extends Instruccion {
	byte value
	
	new(int originalValue) {
		value = originalValue as byte
	}
	
	override doExecute(Microcontroller micro) {
		micro.AAcumulator = value
	}
}

class SWAP extends Instruccion {
	override doExecute(Microcontroller micro) {
		val buffer = micro.AAcumulator
		micro.AAcumulator = micro.BAcumulator
		micro.BAcumulator = buffer
	}
}

class ADD extends Instruccion {
	override doExecute(Microcontroller micro) {
		micro.AAcumulator = (micro.AAcumulator + micro.BAcumulator) as byte
		micro.BAcumulator = 0 as byte
	}
}

abstract class InstruccionMultiple extends Instruccion {
	@Accessors(PUBLIC_GETTER) List<Instruccion> instrucciones
	
	new(List<Instruccion> instrucciones) {
		this.instrucciones = instrucciones
	}
	
	override doExecute(Microcontroller micro) {
		micro.run(instrucciones)
	}

	protected def boolean notZero(Microcontroller micro) {
		micro.AAcumulator != 0
	}
	
}

class IFNZ extends InstruccionMultiple {
	new(List<Instruccion> instrucciones) {
		super(instrucciones)
	}

	override doExecute(Microcontroller micro) {
		if (notZero(micro)) {
			super.doExecute(micro)
		}
	}
	
	
}


class WHNZ extends InstruccionMultiple {
	
	new(List<Instruccion> instrucciones) {
		super(instrucciones)
	}

	override doExecute(Microcontroller micro) {
		while (notZero(micro)) {
			super.doExecute(micro)
		}
	}
	
}














