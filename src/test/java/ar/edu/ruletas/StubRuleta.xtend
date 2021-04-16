package ar.edu.ruletas

import static org.mockito.Mockito.*

class StubRuleta implements IRuleta {
	
	int numeroGanador
	
	new(int numeroGanador) {
		this.numeroGanador = numeroGanador
	}
	
	override elegirNumero() {}
	
	override apuestaGanadora(Apuesta apuesta) {
		apuesta.numeroApostado === this.numeroGanador
	}
	
}

class StubRuletaHelper {
	
	def static IRuleta stubRuletaMockito(int numeroGanador) {
		val ruleta = mock(IRuleta)
		
		doNothing.when(ruleta).elegirNumero()
		
		doAnswer [ invocation |
			val apuesta = invocation.arguments.head as Apuesta
			println("numero ganador " + numeroGanador)
			return apuesta.numeroApostado === numeroGanador
		].when(ruleta).apuestaGanadora(any(Apuesta))
		
		ruleta
	}
}