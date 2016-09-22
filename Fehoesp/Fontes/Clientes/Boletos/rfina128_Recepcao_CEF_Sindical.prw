#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
User Function RFINA128()     // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,_CLOTE,N_OPC,CPERG")
SetPrvt("C_BORDERO,_CARQ,_NTOTAL,_NTOTAL2,_ASTRU,C_ARQTMP")
SetPrvt("_DATAPROC,_CPERIODO,_CCGC,_DVENC,_NPREF,_NPARC")
SetPrvt("_LMOVIMENTA,")
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � RFINA28  � Autor � Luiz Mattos Duarte Jr � Data � 15/03/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorno de Contribuicoes Sindical (Cef)                    ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico SINDHOSP                                        ���
�������������������������������������������������������������������������Ĵ��
���Obs.:     � E' atualizado os arquivo SE1, SEA, SE5                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
_oldArea  := alias()
_oldOrder := indexord()
_cTitulo   := "Retorno de Contribuicoes - CEF"
_cLote:=""
n_Opc := 0
cPerg    := "FINA25"
Pergunte(cPerg,.T.)
C_BORDERO := ""
@ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a recepcao Bancaria das cobrancas "
@ 033,014 SAY "vindas pela CEF"
@ 063,014 SAY "CONFIRME PARA INICIAR A IMPORTACAO DE DADOS         "
@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar()// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==>    @ 110,138 BMPBUTTON TYPE 1 ACTION Execute(Iniciar)
@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED
Return
*************************
Static Function Iniciar()
Close(oDlg1)
Processa( {|| Receber() })
Return
*************************
Static Function Receber()
_cARQ := "\arquivos\retorno\"+MV_PAR01
If !File( allTrim( _cArq ))
	Help(" ",1,"ARRVAZ")
	Return
endif
_nTotal:= 0
_nTotal2:= 0
_aStru := {}
AADD( _aStru, { "CAMPO"       , "C" , 240 , 0 } )
AADD( _aStru, { "obs"         , "C" ,  40 , 0 } )
c_ArqTmp := CriaTrab(_aStru,.t.)
dbUseArea(.t.,,c_ArqTmp,"TMP")
dbSelectArea("TMP")
Append From &(alltrim(_cArq)) SDF
dbGotop()
ProcRegua(RecCount(),22,05)
DO WHILE !EOF()     
	IF SUBS(TMP->CAMPO,1,8)="10400000"
		if subs(tmp->campo,62,8)=="00000973"
			XSINDICA := "02"
		ELSEif subs(tmp->campo,62,8)=="00000989"
			XSINDICA := "03"
		ELSEif subs(tmp->campo,62,8)=="00000974"
			XSINDICA := "04"
		ELSEif subs(tmp->campo,62,8)=="00000986"
			XSINDICA := "05"
		ELSEif subs(tmp->campo,62,8)=="00000990"
			XSINDICA := "06"
		ELSE
			XSINDICA := "01"
		ENDIF
	ENDIF			
	IF !SUBS(TMP->CAMPO,14,1) $ "T"
		IF !SUBS(TMP->CAMPO,14,1) $ "U"
			RECLOCK("TMP",.F.)
			DBDELETE()
			MSUNLOCK()
		ENDIF
		DBSELECTAREA("TMP")
		DBSKIP()
		LOOP
	ENDIF
	IncProc("Boleto Num.: "+sUbs(tmp->campo,137,12))
	dbSelectArea("SA1")
	dbSetOrder(3)
	dbseek( xFilial()+ substr(TMP->CAMPO,137,12) )
	DATAVENC := STOD(SUBS(TMP->CAMPO,78,4)+subs(TMP->CAMPO,76,02)+subs(TMP->CAMPO,74,02))
	ANOVENC  := SUBS(TMP->CAMPO,80,2)
	CONFED   := sUbs(tmp->campo,137,12)
	XCGC     := substr(TMP->CAMPO,137,12)
	NUMLINHA := TMP->(RECNO())
	IF SUBS(SA1->A1_CGC,1,12)==XCGC
	//	DBSELECTAREA("SE1")
	//	DBSETORDER(1)
	//	dbseek( xFilial()+ANOVENC+"S"+SA1->A1_COD)
   	ACHOU := .F.
		DBSELECTAREA("SE1")
		dbOrderNickName('18')  // DBSETORDER(18) // Alterado (UPDXFUN).
		dbseek( xFilial()+sUbs(tmp->campo,137,12))
		IF FOUND()
			DO WHILE SUBS(SE1->E1_CONFED,1,12)==sUbs(tmp->campo,137,12) .AND. !EOF()
			DBSELECTAREA("TMP")
			RECLOCK("TMP",.F.)
			if upper(ALLTRIM(SE1->E1_ARQBCO)) == SUBS(upper(ALLTRIM(MV_PAR01)),1,12) .AND. SE1->E1_LINARQ  == NUMLINHA
				tmp->obs := "arq. ja baixado"
				msunlock()
				DBSKIP()
				ACHOU := .T.
				EXIT
			
				/*
				else
				if upper(ALLTRIM(SE1->E1_ARQBCO)) == upper(ALLTRIM(MV_PAR01)) .AND. SE1->E1_LINARQ  <> NUMLINHA
				tmp->obs := "Duplicidade no arq."
				else
				tmp->obs := "Tiulo ja existe"
				endif*/
			endif
			DBSELECTAREA("SE1")
			DBSKIP()
	     	ENDDO
			IF ACHOU
				LOOP
			ENDIF
		ENDIF
	ELSE
		DBSELECTAREA("SE1")
		dbOrderNickName('18')  // DBSETORDER(18) // Alterado (UPDXFUN).
		dbseek( xFilial()+sUbs(tmp->campo,137,12))
		PULA := .F.
		DO WHILE !EOF() .AND. SUBS(SE1->E1_CONFED,1,12) == sUbs(tmp->campo,137,12)
			IF SE1->E1_PREFIXO == ANOVENC+"S"
				PULA := .T.
				IF upper(ALLTRIM(SE1->E1_ARQBCO)) == SUBS(upper(ALLTRIM(MV_PAR01)),1,12) .AND. SE1->E1_LINARQ   == NUMLINHA
					MESMOARQ := .T.
				ELSE
					MESMOARQ := .F.
				ENDIF
			ENDIF
			DBSKIP()
		ENDDO
		IF PULA
			DBSELECTAREA("TMP")
			RECLOCK("TMP",.F.)
			if mesmoarq
				tmp->obs := "arq. ja baixado"
				MSUNLOCK()
				DBSKIP()
				LOOP
				/*
				eLSE
				if mesmoarq .AND. SE1->E1_LINARQ  <> NUMLINHA
				tmp->obs := "Duplicidade no arq."
				else
				TMP->OBS := "Tiulo ja existe"
				ENDIF*/
			ENDIF
		ENDIF
	ENDIF
	DBSELECTAREA("TMP")
	DBSKIP()
	VALTIT   := val( substr(TMP->CAMPO,78,15) )/100
	VALCRED  := VAL( substr(TMP->CAMPO,93,15) )/100
	valjur   := VAL( substr(TMP->CAMPO,18,15) )/100
	dTPAG    := STOD(SUBS(TMP->CAMPO,142,4)+subs(TMP->CAMPO,140,02)+subs(TMP->CAMPO,138,02))
	dTCRED   := STOD(SUBS(TMP->CAMPO,150,4)+subs(TMP->CAMPO,148,02)+subs(TMP->CAMPO,146,02))
	IF SUBS(SA1->A1_CGC,1,12)==XCGC
		RecLock("SE1",.T.)
		SE1->E1_FILIAL   := xFilial()
		SE1->E1_PREFIXO  := ANOVENC+"S"
		SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
		SE1->E1_PARCELA  := ""
		SE1->E1_TIPO     := "DP"
		SE1->E1_NATUREZ  := "003"
		SE1->E1_CLIENTE  := SA1->A1_COD
		SE1->E1_SINDICA  := SA1->A1_SINDICA
		SE1->E1_CODASSO  := SA1->A1_CODASSO
		SE1->E1_CGC      := SA1->A1_CGC
		SE1->E1_CATEG1   := SA1->A1_CATEG1
		SE1->E1_ERSIN    := SA1->A1_ERSIN
		SE1->E1_BASE     := SA1->A1_BASE
		SE1->E1_LOJA     := SA1->A1_LOJA
		SE1->E1_NOMCLI   := SA1->A1_NOME
		SE1->E1_EMISSAO  := DATAVENC-30
		SE1->E1_MOVIMEN  := DTPAG
		SE1->E1_EMIS1    := DTpAG
		SE1->E1_VENCTO   := DATAVENC
		SE1->E1_VENCREA  := DataValida(DATAVENC)
		SE1->E1_VENCORI  := DATAVENC
		SE1->E1_HIST     := "Ref.Contr. Sindical de "+ ANOVENC
		SE1->E1_VALOR    := VALTIT-valjur
		SE1->E1_SALDO    := 0
		SE1->E1_VLCRUZ   := VALTIT-valjur
		SE1->E1_JUROS    := valjur
		SE1->E1_MOEDA    := 1
		SE1->E1_ARQBCO   := upper(MV_PAR01)
		SE1->E1_LINARQ  := NUMLINHA
		se1->e1_dtcred   := DTCRED
		//APOS BORDERO
		SE1->E1_PORTADO := "104"
		//		SE1->E1_AGEDEP := "0249"
		SE1->E1_AGEDEP := "0242"
		//		SE1->E1_CONTA   :="050.010-0"
		SE1->E1_CONTA   :="000.724-3"
		SE1->E1_SITUACA := "1"
		SE1->E1_OCORREN := "01"
		SE1->E1_ORIGEM  := "RFINA28"
		SE1->E1_STATUS  := "B"
		//SE1->E1_JUROS   := VALJUROS
		SE1->E1_VALLIQ  := VALTIT
		SE1->E1_BAIXA   := DTPAG
		SE1->E1_OK      := CHR(69)+CHR(120)
		SE1->E1_CONFED  := CONFED
		SE1->E1_VALCRED := VALCRED
		_nTotal:= _nTotal + SE1->E1_VALLIQ

		MSUNLOCK()
		CONFIRMSX8()
	ELSE

		RecLock("SE1",.T.)

		SE1->E1_FILIAL   := xFilial()
		SE1->E1_PREFIXO  := anovenc+"S"
		SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
		SE1->E1_PARCELA  := ""
		SE1->E1_TIPO     := "DP"
		SE1->E1_NATUREZ  := "003"
		SE1->E1_CLIENTE  := "999999"
		SE1->E1_SINDICA  := XSINDICA
		SE1->E1_CODASSO  := ""
		SE1->E1_CGC      := "" //substr(TMP->CAMPO,70,12)
		SE1->E1_EMISSAO  := DATAVENC-30
		SE1->E1_MOVIMEN  := DTPAG
		SE1->E1_EMIS1    := DTPAG
		SE1->E1_VENCTO   := DATAVENC
		SE1->E1_VENCREA  := DataValida( DATAVENC)
		SE1->E1_VENCORI  := DATAVENC
		SE1->E1_HIST     := "Ref.Contr. Sindical de "+ ANOVENC
		SE1->E1_VALOR    := VALTIT-valjur
		SE1->E1_SALDO    := 0
		SE1->E1_VLCRUZ   := VALTIT-valjur
		SE1->E1_VALJUR   := 0
		SE1->E1_MOEDA    := 1
		//APOS BORDERO
		SE1->E1_PORTADO := "104"
		//		SE1->E1_AGEDEP := "0249"
		SE1->E1_AGEDEP := "0242"
		//		SE1->E1_CONTA   :="050.010-0"
		SE1->E1_CONTA   :="000.724-3"
		SE1->E1_SITUACA := "1"
		SE1->E1_OCORREN := "01"
		SE1->E1_ORIGEM  := "RFINA28"
		SE1->E1_STATUS  := "B"
		SE1->E1_JUROS   := valjur
		SE1->E1_VALLIQ  := VALTIT
		SE1->E1_BAIXA   := DTPAG
		SE1->E1_OK      := CHR(69)+CHR(120)
		SE1->E1_CONFED  := CONFED
		SE1->E1_ARQBCO   := upper(MV_PAR01)
		SE1->E1_LINARQ  := NUMLINHA
		se1->e1_dtcred   := DTCRED
		SE1->E1_VALCRED := VALCRED
		_nTotal:= _nTotal + SE1->E1_VALLIQ     && Total de pagtos assist.

		MSUNLOCK()
		CONFIRMSX8()
	endif
	dbselectArea("SE5")
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial()
	SE5->E5_DATA    := dtpag
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := valcred
	SE5->E5_NATUREZ := "003"
	SE5->E5_BANCO   := "104"
	//	SE5->E5_AGENCIA := "0249"
	SE5->E5_AGENCIA := "0242"
	//	SE5->E5_CONTA   :="050.010-0"
	SE5->E5_CONTA   :="000.724-3"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
	SE5->E5_TIPODOC := "VL"
	SE5->E5_VLMOED2 := valcred
	SE5->E5_LA      := "N"
	SE5->E5_CLIFOR  := se1->e1_cliente
	SE5->E5_LOJA    := Se1->e1_LOJA
	SE5->E5_DTDIGIT := dDATABASE
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := SE1->E1_PREFIXO
	SE5->E5_NUMERO  :=  Se1->e1_num
	//          SE5->E5_PARCELA := _nPARC
	SE5->E5_DTDISPO := _DATAPROC
	MsUnlock()
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial()
	SE5->E5_DATA    := dtpag
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := VALTIT-valcred
	SE5->E5_NATUREZ := "003"
	SE5->E5_BANCO   := "REP"
	SE5->E5_AGENCIA := "REPAS"
	SE5->E5_CONTA   := "REPASSE"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
	SE5->E5_TIPODOC := "VL"
	SE5->E5_VLMOED2 := VALTIT-valcred
	SE5->E5_LA      := "N"
	SE5->E5_CLIFOR  := se1->e1_cliente
	SE5->E5_LOJA    := Se1->e1_LOJA
	SE5->E5_DTDIGIT := dDATABASE
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := SE1->E1_PREFIXO
	SE5->E5_NUMERO  :=  Se1->e1_num
	//          SE5->E5_PARCELA := _nPARC
	SE5->E5_DTDISPO := _DATAPROC
	MsUnlock()
	dbSelectArea("TMP")
	RECLOCK("TMP",.F.)
	DBDELETE()
	MSUNLOCK()
	dbskip()
enddo
//totcad()
dbSelectArea("TMP")
dbCloseArea()
If File(c_ArqTmp+".DBF")
	Ferase(c_ArqTmp+".DBF")
EndIf
dbSelectArea("SA1")
dbSetOrder(1)
dbSelectArea("SE1")
dbSetOrder(1)
dbselectArea("SI2")
dbsetorder(1)
dbSelectArea(_oldArea)
dbSetOrder(_oldOrder) // Atencao (UPDXFUN).
Return(nil)

************************
static Function TOTCAD()
SetPrvt("_CALIAS,CBCONT,CBTXT,WNREL,CDESC1,CDESC2")
SetPrvt("CDESC3,CSTRING,TAMANHO,TIPO,LIMITE,TITULO")
SetPrvt("CABEC2,CABEC1,ARETURN,NOMEPROG,NLASTKEY,CPERG")
SetPrvt("M_PAG,LI,_AESTR,C_ARQIMP,CARQIND,CINDSA1")
SetPrvt("NLINHA,")
_cAlias := alias()
cbcont := 0
cbtxt := ""
wnrel := ""
cDesc1 := "Este programa ir� gerar as criticas da Baixa da Sindical."
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "P"
tipo := 15
limite := 220
Titulo := "Criticas da Baixa da Sindical"
cabec2 := ""
cabec1 := "CGC            Vencto         Observacao"
aReturn := { "Zebrado", 1,"Administracao", 4, 2, 1, "",1 }
nomeprog := "RFINA28"
nLastkey := 0
cPerg := "FINA25"
m_pag := 1
li := 80
wnrel := "RFINA28"
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)
if nLastkey == 27
	return
endif
SetDefault(aReturn,cString)
if nLastkey == 27
	return
endif
RptStatus({|| impREL() },titulo)
return
**********
Static function ImpREL()
LI := 80
ntotdupl := ntotexist := 0
titdupl := titexist := 0
DBSELECTAREA("TMP")
DBGOTOP()
DO WHILE !EOF()
	IF !SUBS(TMP->CAMPO,14,1) $ "T"
		DBSKIP()
		LOOP
	ENDIF
	IF 	ALLTRIM(tmp->obs)== "arq. ja baixado" .OR. EMPTY(TMP->OBS)
		DBSKIP()
		LOOP
	ENDIF
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		nLinha := prow() + 1
	endif

	@ li,000 PSAY substr(TMP->CAMPO,137,12)
	@ LI,015 PSAY STOD(SUBS(TMP->CAMPO,78,4)+subs(TMP->CAMPO,76,02)+subs(TMP->CAMPO,74,02))
	@ li,030 psay TMP->OBS
	XOBS := aLLTRIM(tmp->obs)
	dbskip()
	IF Xobs == "Duplicidade no arq."
		NTOTDUPL += 	VAL( substr(TMP->CAMPO,93,15) )/100
		titdupl ++
	elseIF 	Xobs == "Tiulo ja existe"
		NTOTEXIST += 	VAL( substr(TMP->CAMPO,93,15) )/100
		titexist ++
	ENDIF
	LI++
	dbskip()
enddo
LI++
@ LI,000 PSAY "Total Duplicidade: "
@ li,050 psay ntotdupl picture "@e 99,999,999.99"
@ li,070 psay titdupl picture "@e 999,999"
LI++
@ LI,000 PSAY "Total ja Existente: "
@ li,050 psay ntotexist picture "@e 99,999,999.99"
@ li,070 psay titexist picture "@e 999,999"
li++
set device to screen
if aReturn[5] == 1
	set printer to
	dbcommit()
	ourspool(wnrel)
endif
MS_FLUSH()
return