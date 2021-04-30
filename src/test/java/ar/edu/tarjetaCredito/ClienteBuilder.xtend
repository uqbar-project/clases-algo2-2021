package ar.edu.tarjetaCredito

class ClienteBuilder {
	
	Cliente cliente = new ClientePosta()
	
	def saldo(int valor) {
		cliente.saldo = valor
		return this
	}
	
	def safeShop(int montoMaximoSafeShop) {
		cliente = new SafeShop(montoMaximoSafeShop, cliente)
		return this
	}

	def conPromocion() {
		cliente = new Promocion(cliente)
		return this
	}
	
	def build() {
		if (cliente.saldo <= 0) {
			throw new BusinessException("El cliente no puede tener un saldo <= 0")
		}
		return cliente
	}
	
}