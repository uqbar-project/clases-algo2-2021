package ar.edu.tarjetaCredito

import org.eclipse.xtend.lib.annotations.Accessors

class ClientePosta implements Cliente {
	@Accessors int saldo = 0
	int puntosAcumulados = 0
	
	/**
	 * METODOS DE NEGOCIO
	 */
	override comprar(int monto) {
		saldo = saldo + monto
	}

	override pagarVencimiento(int monto) {
		saldo = saldo - monto
	}

	override esMoroso() {
		saldo > 0
	}

	override getPuntos() {
		puntosAcumulados
	}
	
	override getSaldo() {
		saldo
	}
	
	override sumarPuntosAcumulados(int puntos) {
		puntosAcumulados = puntosAcumulados + puntos
	}

}

abstract class ClienteConCondicionComercial implements Cliente {
	@Accessors(PUBLIC_GETTER) Cliente cliente
	
	new(Cliente cliente) {
		this.cliente = cliente	
	}

	override pagarVencimiento(int monto) { cliente.pagarVencimiento(monto) }
	override esMoroso() { cliente.esMoroso }
	override getSaldo() { cliente.saldo }
	override getPuntos() { cliente.puntos }
	override sumarPuntosAcumulados(int puntos) {
		cliente.sumarPuntosAcumulados(puntos)
	}
	override setSaldo(int saldo) {
		cliente.saldo = saldo
	}
}

class SafeShop extends ClienteConCondicionComercial {
	int montoMaximoSafeShop

	new(int montoMaximoSafeShop, Cliente cliente) {
		super(cliente)
		this.montoMaximoSafeShop = montoMaximoSafeShop
	}

	override comprar(int monto) {
		if (monto > montoMaximoSafeShop) {
			throw new BusinessException("El monto excede el máximo permitido")
		}
		cliente.comprar(monto)
	}

}

class Promocion extends ClienteConCondicionComercial {
	static int MONTO_MINIMO = 50
	static int PUNTOS_PROMOCION = 15
	
	new(Cliente cliente) {
		super(cliente)
	}

	override comprar(int monto) {
		cliente.comprar(monto)
		if (monto > MONTO_MINIMO) {
			cliente.sumarPuntosAcumulados(PUNTOS_PROMOCION)
		}
	}

}
