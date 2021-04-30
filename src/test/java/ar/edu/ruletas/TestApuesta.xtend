package ar.edu.ruletas

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import static org.mockito.Mockito.*

@DisplayName("Tests de apuesta")
class TestApuesta {

	Apuesta apuestaGanadora
	Apuesta apuestaPerdedora
	Casino casino
	MailSender mockedMailSender

	@BeforeEach
	def void init() {
		// arrange
		apuestaPerdedora = new Apuesta() => [
			numeroApostado = 2
			casillaCorreo = "looser@roulette.com"
		]
		apuestaGanadora = new Apuesta() => [
			numeroApostado = 5
			casillaCorreo = "winner@roulette.com"
		]
		mockedMailSender = mock(MailSender)
		casino = new Casino() => [
			ruleta = StubRuletaHelper.stubRuletaMockito(5)
			mailSender = mockedMailSender
//			ruleta = new StubRuleta(5)
			apostar(apuestaGanadora)
			apostar(apuestaPerdedora)
		]
	}

	@Test
	@DisplayName("cuando el apostador acierta la apuesta es ganadora")
	def void apuestaGanadora() {
		// act
		casino.realizarRondaApuestasRuleta()
		
		// assert
		verify(mockedMailSender, times(1)).sendMail(new Mail("winner@roulette.com", "Ganaste!"))
		verify(mockedMailSender, never).sendMail(new Mail("looser@roulette.com", "Ganaste!"))
	}

}
