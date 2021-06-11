package ar.edu.tioCosa

import java.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.Data

// COMMAND
@Accessors
abstract class Tarea {
	Persona personaInvolucrada
	LocalDate fecha = LocalDate.now
	boolean cumplida = false
	Banda banda
	List<TareaRealizadaObserver> tareaRealizadaObservers = newArrayList 

	def void realizar() {
		doRealizar()
		cumplida = true
		tareaRealizadaObservers.forEach [ tareaRealizada(this) ]
	}
	
	def void doRealizar()
	
	def estaPendientePara(LocalDate unaFecha) {
		!cumplida && (fecha.month == unaFecha.month && fecha.year == unaFecha.year)
	}
	
	def void asignar(Banda banda) { this.banda = banda }
	
	def int dineroAGanar() { 0 }
	
	def int monto()
	
	def String mensajeClave() { "" }
	
}

abstract class TareaIngreso extends Tarea {
	override doRealizar() {
		banda.sumarRecaudacion(montoARecaudar)
	}
	
	override dineroAGanar() { banda.montoParaLaBanda(montoARecaudar).intValue }
	
	override monto() { montoARecaudar.intValue }
	
	def double montoARecaudar()
}

@Accessors
class CobrarDinero extends TareaIngreso {
	int dineroACobrar
	
	override montoARecaudar() {
		dineroACobrar
	}
	
	override doRealizar() {
		super.doRealizar()
		personaInvolucrada.bajarDeuda(dineroACobrar)
	}
	
}

class RecolectarDinero extends TareaIngreso {
	public static val PORCENTAJE_COMISION_RECOLECCION = 0.1

	override montoARecaudar() {
		PORCENTAJE_COMISION_RECOLECCION * personaInvolucrada.ventasObtenidas
	}
	
	override mensajeClave() { "La puerca está en la pocilga" }
}

class AbrirDeposito extends Tarea {
	public static val VALOR_METRO_CUADRADO = 100
	
	Deposito deposito
	
	override doRealizar() {
		Vito.instance.pagar(monto)
	}
	
	override monto() { VALOR_METRO_CUADRADO * deposito.superficie }
}

class PrestarDinero extends Tarea {
	int montoAPrestar
	int cantidadCuotas = 4
	
	override doRealizar() {
		Vito.instance.pagar(montoAPrestar)
		personaInvolucrada.sumarDeuda(montoADevolver)
		crearCuotas
	}
	
	def crearCuotas() {
		(1..cantidadCuotas).forEach [ i |
			Vito.instance.agregarTarea(
				new CobrarDinero => [
					personaInvolucrada = this.personaInvolucrada
					fecha = this.fecha.plusMonths(i)
					dineroACobrar = this.valorCuota
				]
			)
		]
	}
	
	def valorCuota() {
		this.montoADevolver / cantidadCuotas
	}
	
	def montoADevolver() { montoAPrestar * 2 }
	
	override monto() {
		montoAPrestar
	}
	
}


@Accessors
class Deposito {
	int superficie
}

interface TareaRealizadaObserver {
	def void tareaRealizada(Tarea tarea)
}

class WhatsAppObserver implements TareaRealizadaObserver {
	// número de vito => como atributo
	// mensaje clave de la tarea => tarea
	// monto => tarea
	// crear una notificación ????
	String numero = "0 3 0 3 4 5 6"
	WhatsAppSender whatsAppSender
	
	override tareaRealizada(Tarea tarea) {
		whatsAppSender.send(new WhatsAppNotification(numero, tarea.mensajeClave + "- " + tarea.monto))
	}
	
}

interface WhatsAppSender {
	def void send(WhatsAppNotification notification)
}

@Data
class WhatsAppNotification {
	String destinatario
	String mensaje
}
