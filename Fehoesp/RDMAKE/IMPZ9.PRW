#INCLUDE "RWMAKE.CH"
USER FUNCTION IMPSZ9()
USE ENT_2005 ALIAS TRB NEW SHARED
DBGOTOP()
DO WHILE !EOF()
	DBSELECTAREA("SZ9")
	RECLOCK("SZ9",.T.)
	SZ9->Z9_titulo := trb->guia
	sz9->z9_cgc    := trb->cnpj
	SZ9->Z9_VENCTO := CTOD("31/01/05")
	SZ9->Z9_PARCELA:= "05"
	MSUNLOCK()
	DBSELECTAREA("TRB")
	DBSKIP()
ENDDO 