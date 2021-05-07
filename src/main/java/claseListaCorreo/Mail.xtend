package claseListaCorreo

import org.eclipse.xtend.lib.annotations.Data

@Data
class Mail {
	String from
	String to
	String subject
	String text
}