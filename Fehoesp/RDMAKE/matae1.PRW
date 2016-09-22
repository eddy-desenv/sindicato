#include "rwmake.ch"
user function matae1()
PERGUNTE("MATAE1",.T.)
use &MV_PAR01 alias jr new shared
dbselectarea("jr")
dbgotop()
xnumtit := 0
do while !eof()
	DBSELECTAREA("SE1")
	DBSETORDER(1)
	numtit := subs(jr->titulo,1,3)+subs(jr->titulo,5,6)+subs(jr->titulo,12,1)
	dbseek(xfilial()+numtit)
	if found()
		RECLOCK("SE1",.F.)
		DBDELETE()
		MSUNLOCK()
		xnumtit++
	endif
	dbselectarea("JR")
	DBSKIP()
ENDDO
ALERT(XNUMTIT)
If MsgYesNo("Confirma a exclusao dos titutos?", "Exlusao de Titulos")
	DBSELECTAREA("JR")
	DBGOTOP
	do while !eof()
		DBSELECTAREA("SE1")
		DBSETORDER(1)
		numtit := subs(jr->titulo,1,3)+subs(jr->titulo,5,6)+subs(jr->titulo,12,1)
		dbseek(xfilial()+numtit)
		if found()
			RECLOCK("SE1",.F.)
			DBDELETE()
			MSUNLOCK()
			xnumtit++
		endif
		dbselectarea("JR")
		DBSKIP()
	ENDDO
ENDIF
DBSELECTAREA("JR")
DBCLOSEAREA("JR")
	
