package claseListaCorreo

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ListaCorreo {
	package List<Usuario> usuarios = newArrayList
	ModoSuscripcion modoSuscripcion = new ModoSuscripcionAbierta()
	TipoEnvio tipoEnvio = new EnvioAbierto()
	List<PostObserver> postObservers = newArrayList
		
	// Suscripción
	def suscribirALista(Usuario usuario) {
		modoSuscripcion.suscribir(usuario, this)
	}

	def envioMensaje(Mensaje mensaje) {
		tipoEnvio.validarMensaje(mensaje, this)
		postObservers.forEach [ postObserver | postObserver.postRecibido(this, mensaje) ]
	}
	
	def agregarObserver(PostObserver observer) {
		postObservers.add(observer)
	}
	
	// =================================================================================
	// extension method - agregado para la clase
	def getMailsDestino(Mensaje mensaje) {
		usuarios.filter [ usuario | usuario !== mensaje.emisor ].map [ mailPrincipal ]
	}
	// =================================================================================
	
	def contieneUsuario(Usuario usuario) {
		this.usuarios.contains(usuario)
	}
	
}

interface PostObserver {
	def void postRecibido(ListaCorreo lista, Mensaje mensaje)
}

class MailObserverMuchosMails implements PostObserver {
	MailSender mailSender
	
	override postRecibido(ListaCorreo lista, Mensaje mensaje) {
		lista.getMailsDestino(mensaje).forEach [ mailAEnviar |
			val mail = new Mail(mensaje.mailEmisor, mailAEnviar, mensaje.asunto, mensaje.contenido) 
			mailSender.mandarMail(mail)
		]
	}

}

class MailObserverUnSoloMail implements PostObserver {
	MailSender mailSender
	
	override postRecibido(ListaCorreo lista, Mensaje mensaje) {
		val mail = new Mail(mensaje.mailEmisor, lista.getMailsDestino(mensaje).join(", "), mensaje.asunto, mensaje.contenido)
		mailSender.mandarMail(mail)
	}
}

class MalasPalabrasObserver implements PostObserver {
	static List<String> MALAS_PALABRAS = #["hambre", "guerra", "racismo", "sexismo"]
	List<Usuario> usuariosChanchitos = newArrayList
	
	override postRecibido(ListaCorreo lista, Mensaje mensaje) {
		if (MALAS_PALABRAS.exists [ malaPalabra | mensaje.contiene(malaPalabra) ]) {
			usuariosChanchitos.add(mensaje.emisor)
		}
	}
	
}

interface ModoSuscripcion {
	def void suscribir(Usuario usuario, ListaCorreo lista)
}

class ModoSuscripcionAbierta implements ModoSuscripcion {
	override suscribir(Usuario usuario, ListaCorreo lista) {
		lista.usuarios.add(usuario)
	}
}

class ModoSuscripcionCerrada implements ModoSuscripcion {
	List<Usuario> usuariosPendientes = newArrayList

	def agregarUsuarioPendiente(Usuario usuario) {
		usuariosPendientes.add(usuario)
	}
	
	def eliminarUsuarioPendiente(Usuario usuario) {
		usuariosPendientes.remove(usuario)
	}

	def aceptarUsuario(Usuario usuario, ListaCorreo lista) {
		this.eliminarUsuarioPendiente(usuario)
		lista.usuarios.add(usuario)
	}
	
	override suscribir(Usuario usuario, ListaCorreo lista) {
		this.agregarUsuarioPendiente(usuario)
	}
}

interface TipoEnvio {
	def void validarMensaje(Mensaje mensaje, ListaCorreo lista)
}

class EnvioAbierto implements TipoEnvio {
	
	override validarMensaje(Mensaje mensaje, ListaCorreo lista) {
		// Null Object Pattern
	}
	
}

class EnvioRestringido implements TipoEnvio {
	
	override validarMensaje(Mensaje mensaje, ListaCorreo lista) {
		if (!(lista.contieneUsuario(mensaje.emisor))) {
			throw new RuntimeException("No puede enviar un mensaje porque no pertenece a la lista")
		}
	}
	
}

class ElQueUsaElBoton {
	def void main() {
		val miBotoncito = new Button
		miBotoncito.agregarListener(new Aceptar)
		miBotoncito.agregarListener(new Cancelar)
		miBotoncito.agregarListener([ | println("Chau! Me hicieron click!!")])
	}
}

// User Interface
class Button {
	List<ButtonListener> listeners = newArrayList
	def agregarListener(ButtonListener listener) {
		listeners.add(listener)
	}
	def resize() {}
	def render() {}
	def label() {}
	def void onClick() {
		listeners.forEach [ clicked ]
	}
}

interface ButtonListener {
	def void clicked()
}

// Comportamiento de la vista => no hay cuestiones gráficas
class Aceptar implements ButtonListener {
	override clicked() {
		// mis cosas
	}
}

class Cancelar implements ButtonListener {
	override clicked() {
		// otras cosas
	}
}




