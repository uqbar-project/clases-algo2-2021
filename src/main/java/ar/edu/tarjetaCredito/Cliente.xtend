package ar.edu.tarjetaCredito

interface Cliente {

	def void comprar(int monto)
	def void pagarVencimiento(int monto)
	def boolean esMoroso()
	def int getSaldo()
	def void setSaldo(int saldo)
	def int getPuntos()
	def void sumarPuntosAcumulados(int puntos)
	
}
