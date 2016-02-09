# Lenguajes de Programacion
# Tarea 2 - Problema 2 - Implementacion en Python
# 9 de Febrero 2016
# Balbina Santana   A00812215
# Fabian Montemayor A0
# Manuel Sañudo     A0

# Se tomaron de base los programas scanner y parser del Dr. Santiago Conant

# Implementacion de un scanner mediante la codificacion de un Autmata
# Finito Determinista como una Matriz de Transiciones
# Autor: Dr. Santiago Conant, Agosto 2014

# Implementación de un parser
# Reconoce expresiones mediante la gramática:
# <prog>::= <exp><prog> | $
# <exp>::= <átomo> | <lista>
# <átomo>::= símbolo | número | booleano | string
# <lista>::= ( <elemento> )
# <elemento>::= {<exp>}
#
# Autor: Dr. Santiago Conant, Agosto 2014

import sys

# Matriz de transiciones: codificacion del AFD
# [renglon, columna] = [estado, transicion]
# Estados > 99 son finales (ACEPTORES)
# Caso especial: Estado 110 = ERROR

#       0    1    2    3    4   5     6     7   8    9   10
#       esp  \n   (    "   a-z  0-9  #t#f   ;   $  raro   )
MT = [[   0,   0, 111,   1,   5,   3,   4,   6, 100,   7, 112 ], # edo 0 - inicial
      [   1, 110, 110,   2,   1,   1, 110, 110,   1,   7, 110 ], # edo 1 - inicio string
      [ 101, 101, 101, 110, 110, 110, 110, 110, 101,   7, 101 ], # edo 2 - termino string
      [ 102, 102, 102, 110, 110,   3, 110, 110, 102,   7, 102 ], # edo 3 - numero
      [ 103, 103, 103, 110, 110, 110, 110, 110, 103,   7, 103 ], # edo 4 - booleano
      [ 104, 104, 104, 110,   5, 110, 110, 110, 104,   7, 104 ], # edo 5 - simbolo
      [   6, 105,   6,   6,   6,   6,   6,   6, 105,   6, 105 ], # edo 6 - comentario
      [ 110, 110, 110, 110, 110, 110, 110, 110, 110,   7, 110 ]] # edo 7 - error


# Filtro de caracteres: regresa el numero de columna de la matriz de transiciones
# de acuerdo al caracter dado
def filtro(c):
    """Regresa el numero de columna asociado al tipo de caracter dado(c)"""
    
    if c == ' ': # espacio blanco
        return 0

    elif ord(c) == 10 or ord(c) == 13: # salto de linea
        return 1

    elif c == '(': # abrir parentesis
        return 2

    elif c == ')': # cerrar parentesis
        return 10

    elif c == '"': # comillas
        return 3

    elif c == 'a' or c == 'b' or c == 'c' or c == 'd' or c == 'e' or \
      c == 'f' or c == 'g' or c == 'h' or c == 'i' or c == 'j' or \
      c == 'k' or c == 'l' or c == 'm' or c == 'n' or c == 'o' or \
      c == 'p' or c == 'q' or c == 'r' or c == 's' or c == 't' or \
      c == 'u' or c == 'v' or c == 'w' or c == 'x' or c == 'y' or c == 'z': # a-z
       return 4

    elif c == '0' or c == '1' or c == '2' or \
       c == '3' or c == '4' or c == '5' or \
       c == '6' or c == '7' or c == '8' or c == '9': # 0-9
        return 5

    elif c == '#t' or c == '#f': # verdadero o falso
        return 6;

    elif c == ';': # comentario
        return 7

    elif c == '$': # fin de entrada
        return 8

    else: # caracter raro
        return 9

# Funcion principal scanner: implementa el analisis lexico
def scanner():
    """Implementa un analizador lexico: lee los caracteres de la entrada estandar"""
    edo = 0 # numero de estado en el automata
    lexema = ""
    leer = True # indica si se requiere leer un caracter de la entrada estandar
    while (True):
        while edo < 100:    # mientras el estado no sea ACEPTOR ni ERROR
            if leer: c = sys.stdin.read(1)
            else: leer = True
            edo = MT[edo][filtro(c)]
            if edo != 0: lexema += c

        if edo == 100:      # Token 100 - $ - termina analisis
            lexema = lexema[:-1] # elimina el delimitador
            leer = False
            print "   ( FIN ) " + lexema
            return 'fin';

        elif edo == 101:    # Token 101 - string
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( STRING ) " + lexema
            return 'string'

        elif edo == 102:    # Token 102 - numero
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( NUMERO ) " + lexema
            return 'numero'

        elif edo == 103:    # Token 103 - booleano
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( BOOLEANO ) " + lexema
            return 'booleano'

        elif edo == 104:    # Token 104 - simbolo
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( SIMBOLO ) " + lexema
            return 'simbolo'

        elif edo == 105:    # Token 105 - comentario
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( COMENTARIO ) " + lexema
            return 'comentario'

        elif edo == 110:    # Token 110 - Error Lexico
            lexema = lexema[:-1] # elimina el delimitador
            leer = False
            return 'errorScan'

        elif edo == 111:    # Token 111 - parentesis izquierdo
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( PARENTESIS IZQ ) "
            return 'izq'

        elif edo == 112:    # Token 112 - parentesis derecho
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( PARENTESIS DER ) "
            return 'der'

        lexema = ""
        edo = 0


# Empata y obtiene el siguiente token
def match(tokenesperado):
    global token
    if token == tokenesperado:
        token = scanner()
    else:
        token = 'errorPars'


# Funcion principal parser: implementa el analisis sintactico
def prog():
    print "[PROG]"
    global token
    token = scanner()
    if token != 'fin':
        exp()
        prog()

#Funcion no terminal (atomo o lista)
def exp():
    print "[EXP]"
    global token
    if token == 'simbolo' or token == 'numero' or \
      token == 'booleano' or token == 'string':
        match(token)
        atomo()
    else:
        lista()

#Funcion no terminal (atomo)
def atomo():
    print "[ATOMO]"

#Funcion no terminal (lista)
def lista():
    print "[LISTA]"
    global token
    if token == 'izq':
        match(token)
        elemento()
        if token == 'der':
            match(token)

#Funcion no terminal (elemento de lista)
def elemento():
    print "[ELEMENTO]"
    exp()


#Inicializacion del programa
global token
token = scanner()
if token != 'errorScan':
    prog()
    if token == 'fin':
        print ">>ENTRADA CORRECTA<<"
    elif token == 'errorPars':
        print ">>ERROR SINTACTICO<<"
else:
    print ">>ERROR LEXICO<<"

