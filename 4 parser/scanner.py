# -*- coding: utf-8 -*-

# Implementaci�n de un scanner mediante la codificaci�n de un Aut�mata
# Finito Determinista como una Matr�z de Transiciones
# Autor: Dr. Santiago Conant, Agosto 2014 (modificado en Agosto 2015)

import sys

# tokens
INT = 100 # N�mero entero
FLT = 101 # N�mero de punto flotante
OPB = 102 # Operador binario
LRP = 103 # Delimitador: par�ntesis izquierdo
RRP = 104 # Delimitador: par�ntesis derecho
END = 105 # Fin de la entrada
ERR = 200 # Error l�xico: palabra desconocida

# Matriz de transiciones: codificaci�n del AFD
# [rengl�n, columna] = [estado no final, transici�n]
# Estados > 99 son finales (ACEPTORES)
# Caso especial: Estado 200 = ERROR
#	   dig   op   (    )  raro  esp  .   $  vocal  ,
MT = [[  1, OPB, LRP, RRP,   4,   0, 4, END,   5, 300], # edo 0 - estado inicial
	  [  1, INT, INT, INT, INT, INT, 2, INT,   4, INT], # edo 1 - d�gitos enteros
	  [  3, ERR, ERR, ERR,   4, ERR, 4, ERR,   4, ERR], # edo 2 - primer decimal flotante
	  [  3, FLT, FLT, FLT, FLT, FLT, 4, FLT,   4, FLT], # edo 3 - decimales restantes flotante
	  [ERR, ERR, ERR, ERR,   4, ERR, 4, ERR,   4, ERR], # edo 4 - estado de error
	  [  5, 108, 108, 108,   4, 108, 4, ERR,   5, 108]] # edo 5 - vocal

# Filtro de caracteres: regresa el n�mero de columna de la matriz de transiciones
# de acuerdo al caracter dado
def filtro(c):
	"""Regresa el n�mero de columna asociado al tipo de caracter dado(c)"""
	if c == '0' or c == '1' or c == '2' or \
	   c == '3' or c == '4' or c == '5' or \
	   c == '6' or c == '7' or c == '8' or c == '9': # d�gitos
		return 0
	elif c == '+' or c == '-' or c == '*' or \
		 c == '/': # operadores
		return 1
	elif c == '(': # delimitador (
		return 2
	elif c == ')': # delimitador )
		return 3
	elif c == ' ' or ord(c) == 9 or ord(c) == 10 or ord(c) == 13: # blancos
		return 5
	elif c == '.': # punto
		return 6
	elif c == '$': # fin de entrada
		return 7
	elif c == 'A' or c == 'E' or c == 'I' or c == 'O' or c == 'U':
		return 8
	elif c == ',':
		return 9
	else: # caracter raro
		return 4

# Funci�n principal: implementa el an�lisis l�xico
def scanner():
	"""Implementa un analizador l�xico: lee los caracteres de la entrada est�ndar"""
	edo = 0 # n�mero de estado en el aut�mata
	lexema = "" # palabra que genera el token
	tokens = []
	leer = True # indica si se requiere leer un caracter de la entrada est�ndar
	while (True):
		while edo < 100:	# mientras el estado no sea ACEPTOR ni ERROR
			if leer: c = sys.stdin.read(1)
			else: leer = True
			edo = MT[edo][filtro(c)]
			if edo < 100 and edo != 0: lexema += c
		if edo == INT:	
			leer = False # ya se ley� el siguiente caracter
			print "Entero", lexema
		elif edo == FLT:
			leer = False # ya se ley� el siguiente caracter
			print "Flotante", lexema
		elif edo == OPB:
			lexema += c # el �ltimo caracter forma el lexema
			print "Operador", lexema
		elif edo == LRP:
			lexema += c # el �ltimo caracter forma el lexema
			print "Delimitador", lexema
		elif edo == RRP:
			lexema += c # el �ltimo caracter forma el lexema
			print "Delimitador", lexema
		elif edo == 108:
			lexema += c # el �ltimo caracter forma el lexema
			print "id", lexema
		elif edo == 300:
			lexema += c
			print "Delimitador", lexema
		elif edo == ERR:
			leer = False # el �ltimo caracter no es raro
			print "ERROR! palabra ilegal", lexema
		tokens.append(edo)
		if edo == END: return tokens
		lexema = ""
		edo = 0
			
		
	

