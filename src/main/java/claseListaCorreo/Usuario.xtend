package claseListaCorreo

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario {
	String mailPrincipal
	List<String> mailsAlternativos = newArrayList
	
	
}
