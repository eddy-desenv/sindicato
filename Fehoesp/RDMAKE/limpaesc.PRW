#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
User Function limpaesc()
SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,N_OPC,_CARQCONTRIB,_CARQASSOCIA")
SetPrvt("_NINCLUIDOS,_NALTERADOS,_NINCONSIST,_CARQUIVO,_NCOD,ANOC")
SetPrvt("_CTEXTO,W,")
_oldArea  := alias()
_oldOrder := indexord()

_cTitulo  := "Checagem Escritorio Contabil"
n_Opc := 0
   @ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
   @ 008,010 TO 100,222
   @ 023,014 SAY "Este programa fara a validacao dos "
   @ 033,014 SAY "Escritorios contabeis no cad. cliente."

   @ 110,168 BMPBUTTON TYPE 1 ACTION Iniciar()// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==>    @ 110,138 BMPBUTTON TYPE 1 ACTION Execute(Iniciar)
   @ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
   ACTIVATE DIALOG oDlg1 CENTERED
Return
*************************
Static Function Iniciar()
Close(oDlg1)
Processa( {|| processa() })
Return

**************************
Static Function processa()
DBSELECTAREA("SA1")
dbgotop()
num := 0
do while !eof()
	if empty(sa1->a1_esccont)
		dbskip()
		loop
	endif
	dbselectarea("szc")
	dbsetorder(2)
	dbseek(xfilial()+sa1->a1_esccont)
	if !found()
		reclock("sa1",.f.)
		sa1->a1_esccont:=""
		msunlock()
		NUM++
	endif
	dbselectarea("sa1")
	dbskip()
enddo

ALERT("Checagem terminada. Limpos:"+alltrim(str(num)))
dbSelectArea("SA1")
Return
