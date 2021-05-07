package claseListaCorreo

import org.eclipse.xtend.lib.annotations.Data

@Data
class Mensaje {
	Usuario emisor
	String asunto
	String contenido
	
	def mailEmisor() {
		emisor.mailPrincipal
	}
}