package clase1

import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import static org.junit.jupiter.api.Assertions.assertFalse
import static org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach

@DisplayName("Dado un cliente de flota con muchos autos")
class TestClienteFlotaMuchosAutos {

	Flota flotaConMuchosAutos

	@BeforeEach
	def void init() {
		flotaConMuchosAutos = new Flota => [
			autos = 6
		]
	}

	@Test
	@DisplayName("si está muy endeudado => no puede cobrar el siniestro")
	def void clienteMuyEndeudadoNoPuedeCobrarSiniestro() {
		// Arrange / Act
		flotaConMuchosAutos.endeudarse(Flota.MAXIMO_FLOTA_MUCHOS_AUTOS + 1)

		// Assert
		assertFalse(flotaConMuchosAutos.puedeCobrarSiniestro,
			"Una flota con muchos autos y mucha deuda no deberia poder cobrar el siniestro")
	}

	@Test
	@DisplayName("si no está muy endeudado => puede cobrar el siniestro")
	def void clienteNoMuyEndeudadoPuedeCobrarSiniestro() {
		// Arrange / Act
		flotaConMuchosAutos.endeudarse(Flota.MAXIMO_FLOTA_MUCHOS_AUTOS)

		// Assert
		assertTrue(flotaConMuchosAutos.puedeCobrarSiniestro,
			"Una flota con muchos autos y no mucha deuda deberia poder cobrar el siniestro")
	}
}
