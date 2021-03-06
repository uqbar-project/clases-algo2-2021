package ar.edu.tarjetaCredito

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertThrows
import static org.junit.jupiter.api.Assertions.fail

@DisplayName("Dado un cliente que tiene únicamente safe shop como condición comercial")
class TestSafeShop{
	
	Cliente safeShop

	@BeforeEach
	def void init() {
		safeShop = new ClienteBuilder()
			.saldo(50)
			.safeShop(30)
			.build()
	}
	
	@Test
	@DisplayName("no debe poder comprar por más del valor permitido")
	def void testComprarSafeShopNoDebo() {
		assertThrows(BusinessException, [ safeShop.comprar(31) ])
	}

	@Test
	@DisplayName("al no poder comprar no debe aumentar el saldo")
	def void testComprarSafeShopFallidoNoAumentaSaldo() {
		try {
			safeShop.comprar(31)
			fail("El cliente gastatutti no debería comprar por 31")			
		} catch (BusinessException e) {
			assertEquals(50, safeShop.saldo)
		}
	}

	@Test
	@DisplayName("debe poder comprar hasta el valor límite")
	def void testComprarSafeShopPuedo() {
		safeShop.comprar(30)
		assertEquals(80, safeShop.saldo)
	}
	
}
