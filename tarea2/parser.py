# Implementaci�n de un parser
# Reconoce expresiones mediante la gram�tica:
# EXP -> EXP op EXP | EXP -> (EXP) | cte
# la cual fu� modificada para eliminar ambig�edad a:
# EXP  -> cte EXP1
# EXP1 -> (EXP) EXP1 | op EXP EXP1 | vac�o
#
# Autor: Dr. Santiago Conant, Agosto 2014

import sys

# Empata y obtiene el siguiente token
def match(tokenEsperado):
    global token
    if token == tokenEsperado:
        token = sys.stdin.read(1) # token = caracter
        sys.stdout.write(token)
    else:
        print "Error: se esperaba " + tokenEsperado
        sys.exit(1)

# Funci�n principal: implementa el an�lisis sint�ctico
def parser():
    global token 
    token = sys.stdin.read(1) # inicializa con el primer token
    sys.stdout.write(token)
    exp()
    if token == '\n':
        print "Expresi�n bien construida"
    else:
        print "\nExpresi�n mal construida"

# M�dulo que reconoce expresiones
def exp():
    global token
    if token == '0':
        match(token) # reconoce Constantes
        exp1()
    elif token == '(':
        match(token) # reconoce Delimitador (
        exp()
    else:
        print "\nError: se esperaba CTE o ("
        sys.exit(1)

# M�dulo auxiliar para reconocimiento de expresiones
def exp1():
    global token
    if token == '+':
        match(token) # reconoce operador
        exp()
        exp1()
    
        
