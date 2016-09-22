USER FUNCTION DUMMY()

Processa({||U_AtuSE1()}, "", "Atualizando Sindicatos, aguarde...")
RETURN

DBSELECTAREA("sa1")

DBGOTOP()

DO WHIL .NOT.EOF()

	IF A1_INAT = " "
		RecLock("SA1", .F. )
		REPL A1_SINDICA WITH POSICIONE("SZR", 2, XFILIAL("SZR")+A1_MUN, "ZR_SINDICA")
	   MSUNLOCK()
   ENDIF
	DBSKip()
ENDDO

User Function AtuSE1()

LOCAL aArea 	:= GetArea()
LOCAL aAreaSE1 := SE1->( GetArea() )
LOCAL cSindica

DBSELECTAREA("SE1")
DBGOTOP()

ProcRegua(SE1->(Recno()))
DO WHIL .NOT.EOF()

	IncProc()
	cSindica := POSICIONE("SA1", 1, XFILIAL("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA, "A1_SINDICA")

	IF cSindica <> SE1->E1_SINDICA.AND.cSindica <> " "
		RecLock("SE1", .F. )
		REPL E1_SINDICA WITH cSindica
	   MSUNLOCK()
   ENDIF
   
	SE1->( DBSKip() )

ENDDO

RestArea( aAreaSE1 )
RestArea( aArea )
RETURN
