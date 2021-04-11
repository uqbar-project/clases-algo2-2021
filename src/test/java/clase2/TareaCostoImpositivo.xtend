package clase2

import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals

@DisplayName("Dada una tarea")
class TareaCostoImpositivo {
	
	Tarea tarea = new TareaSimple() => [
		tiempo = 100
	]
	
	@DisplayName("si no tiene impuestos, su costo impositivo es 0")
	@Test
	def void tareaSinCostoImpositivo() {
		assertEquals(0, tarea.costoImpositivo) 
	}
	
	@DisplayName("si tiene impuestos, tendrá su costo impositivo > 0")
	@Test
	def void tareaConCostoImpositivo() {
		val impuestoA = Impuesto.ImpuestoA
		tarea.agregarImpuesto(impuestoA)
		tarea.agregarImpuesto(Impuesto.ImpuestoB)
		assertEquals(200, tarea.costoImpositivo) 
	}
}