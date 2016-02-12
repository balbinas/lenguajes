# -*- coding: utf-8 -*-

# Implementación de un parser
# Reconoce expresiones mediante la gramática:
# EXP -> EXP op EXP | EXP -> (EXP) | cte
# la cual fué modificada para eliminar ambig¸edad a:
# EXP  -> cte EXP1
# EXP1 -> (EXP) EXP1 | op EXP EXP1 | vacío
# los elementos léxicos (delimitadores, constantes y operadores)
# son reconocidos por el scanner
#
# Autor: Dr. Santiago Conant, Agosto 2014 (modificado Agosto 2015)
# Co-Autores: Manuel Sañudo, Fabián Montemayor, Balbina Santana

import sys
import scanner

# Empata y obtiene el siguiente token
def match(tokenEsperado):
	global token
	if token[0] == tokenEsperado:
		token.pop(0)
	else:
		error("token equivocado")

# Función principal: implementa el análisis sintáctico
def parser():
	global token
	token = scanner.scanner() # inicializa con el primer token
#	print "inicio", token
	exp()
#	print "fin", token
	if token[0] == scanner.END:
		print "Expresion bien construida!!"
	else:
		error("expresion mal terminada")

# Módulo que reconoce expresiones
def exp():
	if token[0] == scanner.INT or token[0] == scanner.FLT or token[0] == scanner.VAR:
		match(token[0]) # reconoce Constantes/variables
		exp1()
	elif token[0] == scanner.LRP:
		match(token[0]) # reconoce Delimitador (
		exp()
		match(scanner.RRP)
		exp1()
	else:
		error("expresion mal iniciada")

# Módulo auxiliar para reconocimiento de expresiones
def exp1():
	if token[0] == 300:
		match(token[0])
		exp()
	elif token[0] == scanner.LRP:
		match(token[0]) # reconoce Delimitador (
		exp()
		match(scanner.RRP)
		exp1()
	elif token[0] == scanner.OPB:
		match(token[0]) # reconoce operador
		exp()
		exp1()

# Termina con un mensaje de error
def error(mensaje):
	print "ERROR:", mensaje, token
#	sys.exit(1)


