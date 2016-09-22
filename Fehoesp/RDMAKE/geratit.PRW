#include "rwmake.ch"
User Function geratit()
SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,N_OPC,CPERG,SAIDA")
SetPrvt("C_BORDERO,_CNUMBORR,_ASTRU,C_ARQTMP,_ASTRU1,C_ARQTMP1")
SetPrvt("_ASTRU2,C_ARQTMP2,_ASTRU3,C_ARQTMP3,_ASTRU4,C_ARQTMP4")
SetPrvt("_DVENC,_DEMIS,_CPERIODO,_NREGISTROS,_NINCLUIDOS,_NSEQ")
SetPrvt("_NVALTOT,_CTEXTO,W,MES,AMES,")
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Geratit  ³ Autor ³ Luis Mattos Jr        ³ Data ³ 09/09/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Geração de titulos quitados                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs.:     ³ E' atualizado os arquivo SE1, SE5,                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_oldArea  := alias()
_oldOrder := indexord()
cTitulo   := "Titulos Quitados"
n_Opc := 0
cPerg    := "GERATIT"

Pergunte(cPerg,.T.)

@ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a geracao de titulos quitados"
@ 033,014 SAY "Conforme parametros selecionados."
@ 063,014 SAY "CONFIRME PARA INICIAR A GERACAO DOS TITULOS"

@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar()
@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)

ACTIVATE DIALOG oDlg1 CENTERED
Return


*************************
Static Function Iniciar()
Close(oDlg1)
Processa( {|| Gerar() })
Return
*************************
Static Function Gerar()
dbSelectArea("SA1")
dbsetorder(3)
IF !EMPTY(MV_PAR15)
	DBSEEK(XFILIAL()+MV_PAR15)
	CGCATE := MV_PAR15 
ELSE
	dbGotop()               
	CGCATE := "ZZZZZ "
ENDIF
ProcRegua(RecCount(),18,05)
_nRegistros := 0
_nIncluidos := 0
_cTitulo := "Gerando Titulos Quitados"
_nValTot := 0
Do While !Eof() .AND. SA1->A1_CGC<=CGCATE
	IncProc("Cliente: "+sa1->a1_cod+"-"+sa1->a1_nreduz)
	IF SA1->A1_INAT=="X"
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF 
   IF !EMPTY(MV_PAR08)
		if !SA1->A1_TPCADAS $MV_PAR08
			DBSELECTAREA("SA1")
			DBSKIP()
			LOOP
		ENDIF 
	ENDIF
	IF SA1->A1_DTCADAS<MV_PAR09 .OR. SA1->A1_DTCADAS>MV_PAR10
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF
	IF SA1->A1_DTinic<MV_PAR11 .OR. SA1->A1_DTinic>MV_PAR12
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF
   IF !EMPTY(MV_PAR13)
		if !SA1->A1_SITUAC $MV_PAR13
			DBSELECTAREA("SA1")
			DBSKIP()
			LOOP
		ENDIF 
	ENDIF
   IF !EMPTY(MV_PAR14)
		if !SA1->A1_SINDICA $MV_PAR14
			DBSELECTAREA("SA1")
			DBSKIP()
			LOOP
		ENDIF 
	ENDIF
	dbSelectArea("SE1") 
		NUMTIT :=GETSXENUM( "SE1","E1_NUM")
		RecLock("SE1",.T.)
		SE1->E1_FILIAL   := xFilial()
		SE1->E1_PREFIXO  := mv_par01
		SE1->E1_NUM      := NUMTIT
		SE1->E1_PARCELA  := MV_PAR02
		SE1->E1_TIPO     := "DP"
		SE1->E1_NATUREZ  := mv_par03
		SE1->E1_CLIENTE  := SA1->A1_COD
		SE1->E1_LOJA     := SA1->A1_LOJA
		SE1->E1_NOMCLI   := SA1->A1_NREDUZ
		SE1->E1_EMISSAO  := mv_par05
		SE1->E1_VENCTO   := mv_par05
		SE1->E1_VENCREA  := DataValida( mv_par05,.t.)
		SE1->E1_VALOR    := .01
		SE1->E1_EMIS1    := MV_PAR05
		SE1->E1_SITUACA  := "0"
		SE1->E1_SALDO    := 0
		SE1->E1_VLCRUZ   := .01
		SE1->E1_VALJUR   := 1
		SE1->E1_VENCORI  := mv_par05
		SE1->E1_MOEDA    := 1
		SE1->E1_HIST     := MV_PAR04
		SE1->E1_BAIXA    := MV_PAR06
		SE1->E1_DTCRED   := MV_PAR07
		SE1->E1_VALLIQ  := .01		
		//APOS BORDERO
		SE1->E1_PORTADO := "SIN"
		SE1->E1_AGEDEP  := "SIND"
		SE1->E1_CONTA   := "SIND"
		SE1->E1_MOVIMEN := MV_PAR06
		SE1->E1_ORIGEM  := "FINA040"
		SE1->E1_STATUS  := "B"
		SE1->E1_CGC     := SA1->A1_CGC
		SE1->E1_CODASSO := SA1->A1_CODASSO
		SE1->E1_CATEG1  := SA1->A1_CATEG1
		SE1->E1_ERSIN   := SA1->A1_ERSIN
		SE1->E1_BASE    := SA1->A1_BASE
		SE1->E1_SINDICA := SA1->A1_SINDICA 
		se1->e1_arqbco  := mv_par16
		_nIncluidos := _nIncluidos+1
		dbcommit()
		MsUnlock()
		DBSELECTAREA("SE5")
		RECLOCK("SE5",.F.)
		SE5->E5_FILIAL  := XFILIAL("se5")
		SE5->E5_DATA    := MV_PAR06
		SE5->E5_TIPO    := SE1->E1_TIPO
		SE5->E5_VALOR   := SE1->E1_VALOR
		SE5->E5_NATUREZ := MV_PAR03
		SE5->E5_BANCO   := SE1->E1_PORTADO
		SE5->E5_AGENCIA := SE1->E1_AGEDEP
		SE5->E5_CONTA   := SE1->E1_CONTA
		SE5->E5_RECPAG  := "R"
		SE5->E5_BENEF   := SA1->A1_NREDUZ
		SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
		SE5->E5_TIPODOC := "VL"
		SE5->E5_VLMOED2 := SE1->E1_VALOR
		SE5->E5_LA      := "N"
		SE5->E5_CLIFOR  := se1->e1_cliente
		SE5->E5_LOJA    := Se1->e1_LOJA
		SE5->E5_DTDIGIT := MV_PAR06
		SE5->E5_MOTBX   := "NOR"
		SE5->E5_SEQ     := "01"
		SE5->E5_PREFIXO := SE1->E1_PREFIXO
		SE5->E5_NUMERO  :=  Se1->e1_num
      SE5->E5_PARCELA := SE1->E1_PARCELA
		SE5->E5_DTDISPO := MV_PAR06     
		MsUnlock()
		_nregistros++
		confirmsx8()
	dbSelectArea("SA1")
	dbskip()
End

@ 96,42 TO 290,405 DIALOG oDlg1 TITLE "Termino da Geracao"
@ 8,10 TO 73,170
@ 23,22 SAY "Registros Gerados"
@ 23,95 GET _nRegistros PICTURE "@E 999,999" WHEN .F.
@ 77,078 BMPBUTTON TYPE 1 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED
dbSelectArea("SA1")
DbSetOrder(1)
dbSelectArea(_oldArea)
dbSetOrder(_oldOrder) // Atencao (UPDXFUN).
return
