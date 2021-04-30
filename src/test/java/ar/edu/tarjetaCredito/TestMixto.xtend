package ar.edu.tarjetaCredito

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertThrows

@DisplayName("Dado un cliente que tiene tanto safe shop como promoción como condiciones comerciales")
class TestMixto {
	
	Cliente mixto

	@BeforeEach
	def void init() {
		new ClientePosta()
		mixto = new ClienteBuilder()
			.saldo(50)
			.safeShop(80)
			.conPromocion()
			.build()
	}
	
	@Test
	@DisplayName("Al comprar por arriba del límite de promoción y por debajo del safe shop, acumula puntos y la compra funciona ok")
	def void testComprarAcumulandoPuntosParaMixto() {
		mixto.comprar(60)
		assertEquals(110, mixto.saldo)
		assertEquals(15, mixto.puntos)
	}
	
	@Test
	@DisplayName("Al comprar por arriba del límite de safe shop, la compra se cancela y no acumula puntos")
	def void testComprarSobrepasandoMaximoSafeShopParaMixto() {
		assertThrows(BusinessException, [ mixto.comprar(110) ])
		assertEquals(0, mixto.puntos)
		assertEquals(50, mixto.saldo)
	}

}
