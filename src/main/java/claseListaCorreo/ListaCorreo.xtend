package claseListaCorreo

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ListaCorreo {
	MailSender mailSender
	List<Usuario> usuarios = newArrayList
	ModoSuscripcion modoSuscripcion = new ModoSuscripcionAbierta()
	TipoEnvio tipoEnvio = new EnvioAbierto()
		
	// Suscripción
	def suscribirALista(Usuario usuario) {
		modoSuscripcion.suscribir(usuario, this)
	}

	def envioMensaje(Mensaje mensaje) {
		tipoEnvio.validarMensaje(mensaje, this)
		usuarios.forEach [ usuario | 
			mailSender.mandarMail(new Mail(mensaje.mailEmisor, usuario.mailPrincipal, mensaje.asunto, mensaje.contenido))
		]
	}
	
	def contieneUsuario(Usuario usuario) {
		this.usuarios.contains(usuario)
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