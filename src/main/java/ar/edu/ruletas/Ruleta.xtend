package ar.edu.ruletas

import org.eclipse.xtend.lib.annotations.Accessors

interface IRuleta {
	def void elegirNumero()
	def boolean apuestaGanadora(Apuesta apuesta)
}

@Accessors
class Ruleta implements IRuleta {
	int numeroGanador

	override void elegirNumero() {
		this.numeroGanador = (Math.random * 36).intValue
		println("ruleta eligió " + this.numeroGanador)
	}

	override boolean apuestaGanadora(Apuesta apuesta) {
		this.numeroGanador.intValue === apuesta.numeroApostado
	}
}
