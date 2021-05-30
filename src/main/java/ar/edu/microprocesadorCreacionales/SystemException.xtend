package ar.edu.microprocesadorCreacionales

class SystemException extends RuntimeException {
	new(String message) { super(message) }
	new(Exception cause) { super(cause) }
}