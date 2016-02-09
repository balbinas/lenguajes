# Implementacion de un scanner mediante la codificacion de un Autmata
# Finito Determinista como una Matriz de Transiciones
# Autor: Dr. Santiago Conant, Agosto 2014

import sys

# Matriz de transiciones: codificacion del AFD
# [renglon, columna] = [estado, transicion]
# Estados > 99 son finales (ACEPTORES)
# Caso especial: Estado 200 = ERROR
#      dig   op   (    )  raro  esp  .   $
#MT = [[  1, 102, 105, 106,   4,   0, 4, 107], # edo 0 - estado inicial
#      [  1, 100, 100, 100, 100, 100, 2, 100], # edo 1 - digitos enteros
#      [  3, 200, 200, 200,   4, 200, 4, 200], # edo 2 - primer decimal flotante
#      [  3, 101, 101, 101, 101, 101, 4, 101], # edo 3 - decimales restantes flotante
#      [200, 200, 200, 200,   4, 200, 4, 200]] # edo 4 - estado de error

#       esp  \n   ( )   "   a-z  0-9  #t#f   ;   $  raro
MT2 = [[   0,   0,   0,   1,   5,   3,   4,   6, 100,   7 ], # edo 0 - inicial
      [   1, 110, 110,   2,   1,   1, 110, 110,   1,   7 ], # edo 1 - inicio string
      [ 101, 101, 101, 110, 110, 110, 110, 110, 101,   7 ], # edo 2 - termino string
      [ 102, 102, 102, 110, 110,   3, 110, 110, 102,   7 ], # edo 3 - numero
      [ 103, 103, 103, 110, 110, 110, 110, 110, 103,   7 ], # edo 4 - booleano
      [ 104, 104, 104, 110,   5, 110, 110, 110, 104,   7 ], # edo 5 - simbolo
      [   6, 105,   6,   6,   6,   6,   6,   6, 105,   6 ], # edo 6 - comentario
      [ 110, 110, 110, 110, 110, 110, 110, 110, 110,   7 ]] # edo 7 - error

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

    elif c == '(': # abrir o cerrar parentesis
        return 2

    elif c == ')':
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

    elif c == '#t' or c == '#f':
        return 6;

    elif c == ';': # comentario
        return 7

    elif c == '$': # fin de entrada
        return 8

    else: # caracter raro
        return 9

# Funcion principal: implementa el analisis lexico
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

        if edo == 100:      # Token 100 - $
            lexema = lexema[:-1] # elimina el delimitador
            leer = False
            print "fin del programa " + lexema
            return 0;

        elif edo == 101:    # Token 101 - string
            lexema = lexema[:-1] # elimina el delimitador
            #leer = False
            print "String: " + lexema
            return 'string'

        elif edo == 102:    # Token 102 - numero
            #lexema = lexema[:-1] # elimina el delimitador
            print "Numero: " + lexema
            #return 'numero'

        elif edo == 103:    # Token 105
            lexema = lexema[:-1] # elimina el delimitador
            print "Booleano: " + lexema
            return 'booleano'

        elif edo == 104:    # Token 106
            lexema = lexema[:-1] # elimina el delimitador
            print "Simbolo: " + lexema
            #return 'simbolo'

        elif edo == 105:    # Termina analisis
            lexema = lexema[:-1] # elimina el delimitador
            print "Comentario: " + lexema
            return 'comentario'
            #return 0

        elif edo == 110:    # ERROR
            lexema = lexema[:-1] # el ultimo caracter no es raro
            leer = False
            print "ERROR! palabra ilegal " + lexema
            return 'error'

        elif edo == 111:
            lexema = lexema[:-1]
            print "parentesis izq" + lexema
            #return 'izq'

        elif edo == 112:
            lexema = lexema[:-1]
            print "parentesis der" + lexema
            #return 'der'

        lexema = ""
        edo = 0

scanner()