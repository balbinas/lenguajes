# Lenguajes de Programacion
# Tarea 2 - Problema 2 - Implementacion en Python
# 9 de Febrero 2016
# Balbina Santana   A00812215
# Fabian Montemayor A001280156
# Manuel Sanudo     A001192241

import sys

# Matriz de transiciones
# [renglon, columna] = [estado, transicion]
# Estados > 99 son finales (ACEPTORES)
# Caso especial: Estado 110 = ERROR

#       0    1    2    3    4    5    6
#       esp  fin  var   num  op  err
MT = [[ 0, 100,   2,   3,   4,    5], # edo - esp
      [ 0, 1,   1,   2,   3,    5], # edo - fin
      [ 0, 100,  2, 103, 105,  110], # edo - var
      [ 0, 103, 110,   2, 110,  110], # edo - num
      [ 0, 100,   1,   2, 110,  115], # edo - op 
      [ 0, 110, 110, 110, 110, 110]] # edo - error

# Filtro de caracteres: regresa el numero de columna de la matriz de transiciones
# de acuerdo al caracter dado
def filtro(c):
    
    if c == ' ': # operadores
        return 0

    elif c == '$' or c == '(' or c == ')' or c == '.' or c == '\\': # fin de entrada
        return 1

    elif c == 'u' or c == 'v' or c == 'w' or c == 'x' or c == 'y' or c == 'z': # u-z
       return 2

    elif c == '0' or c == '1' or c == '2' or \
       c == '3' or c == '4' or c == '5' or \
       c == '6' or c == '7' or c == '8' or c == '9': # 0-9
        return 3

    elif c == '+' or c == '-' or c == '*' or c == '/': # operadores
        return 4

    else: # caracter raro
        return 5

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

        elif edo == 102:    # Token 102 - variable
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( VARIABLE ) " + lexema
            return 'variable'

        elif edo == 103:    # Token 103 - numero
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( NUMERO ) " + lexema
            return 'numero'

        elif edo == 105:    # Token 105 - operador
            lexema = lexema[:-1] # elimina el delimitador
            print "   ( OPERADOR ) " + lexema
            return 'operador'

        elif edo == 110:    # Token 110 - Error Lexico
            lexema = lexema[:-1] # elimina el delimitador
            leer = False
            return 'errorScan'

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
    if token == 'variable' or token == 'numero':
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

