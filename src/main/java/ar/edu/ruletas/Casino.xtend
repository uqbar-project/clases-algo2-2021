package ar.edu.ruletas

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.Data

@Accessors
class Casino {
	IRuleta ruleta = new Ruleta
	List<Apuesta> apuestas = newArrayList
	MailSender mailSender
	
	def apostar(Apuesta apuesta) {
		apuestas.add(apuesta)
	}

	def void realizarRondaApuestasRuleta() {
		ruleta.elegirNumero()
		
		apuestas
			.filter [ apuesta | this.ruleta.apuestaGanadora(apuesta) ]
			.forEach [ apuesta | this.mailSender.sendMail(new Mail(apuesta.casillaCorreo, "Ganaste!"))]
	}
}

@Data
class Mail {
	String to
	String subject
}

interface MailSender {
	def void sendMail(Mail mail)
}
