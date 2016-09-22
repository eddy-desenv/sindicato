#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
User Function RFINA128()     // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,_CLOTE,N_OPC,CPERG")
SetPrvt("C_BORDERO,_CARQ,_NTOTAL,_NTOTAL2,_ASTRU,C_ARQTMP")
SetPrvt("_DATAPROC,_CPERIODO,_CCGC,_DVENC,_NPREF,_NPARC")
SetPrvt("_LMOVIMENTA,")
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RFINA28  ³ Autor ³ Luiz Mattos Duarte Jr ³ Data ³ 15/03/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorno de Contribuicoes Sindical (Cef)                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs.:     ³ E' atualizado os arquivo SE1, SEA, SE5                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
_aStrurel := {}  //REGISTRO relatorio
AADD( _aStrurel, { "SINDICATO"  , "C" , 002 , 0 } )
AADD( _aStrurel, { "NATUREZA"   , "C" , 009 , 0 } )
AADD( _aStrurel, { "xDATA"       , "D" , 008 , 0 } )
AADD( _aStrurel, { "CNPJ"    	, "C" , 014 , 0 } )
AADD( _aStrurel, { "NOME"       , "C" , 040 , 0 } )
AADD( _aStrurel, { "VENCIMENTO" , "D" , 008 , 0 } )
AADD( _aStrurel, { "numban"     , "C" , 013 , 0 } )
AADD( _aStrurel, { "PREFIXO"    , "C" , 003 , 0 } )
AADD( _aStrurel, { "NUMTIT"     , "C" , 006 , 0 } )
AADD( _aStrurel, { "VALOR"      , "N" , 011 , 2 } )
AADD( _aStrurel, { "VLRRECEB"   , "N" , 011 , 2 } )
AADD( _aStrurel, { "VLRcred "   , "N" , 011 , 2 } )
AADD( _aStrurel, { "SITUACAO"   , "C" , 002 , 0 } )
AADD( _aStrurel, { "ARQUIVO"    , "C" , 012 , 0 } )
AADD( _aStrurel, { "HISTORICO"  , "C" , 030 , 0 } )
c_ArqREL := CriaTrab(_aStruREL,.t.)
dbUseArea(.t.,,c_ArqREL,"REL")
INDE ON SINDICATO+natureza+dtos(xdata) TO &C_ARQREL 

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
	XPREFIXO := ANOVENC+"S"
	dbselectarea("SZ9")
	DBSETORDER(1)
	DBSEEK(XFILIAL()+CONFED)
	DO WHILE !EOF() .AND. SUBS(SZ9->Z9_TITULO,1,12)==CONFED
		IF SZ9->Z9_VALOR<>VALTIT-valjur                   
			DBSKIP()			
		ELSE
			XPREFIXO:=SUBS(SZ9->Z9_ANO,3,2)+"S"   
			EXIT
		ENDIF

	ENDDO		
	DBSELECTAREA("SE1")
	IF SUBS(SA1->A1_CGC,1,12)==XCGC
		RecLock("SE1",.T.)
		SE1->E1_FILIAL   := xFilial()
		SE1->E1_PREFIXO  := XPREFIXO
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
							dbselectarea("rel")
					reclock("rel",.t.)
					rel->SINDICATO := se1->e1_sindica
					rel->NATUREZA  := se1->e1_naturez
					rel->xDATA      := se1->e1_dtcred
					rel->CNPJ      := sa1->a1_cgc
					rel->NOME      := sa1->a1_nome
					rel->VENCIMENTO:= se1->e1_vencto
					rel->numban    := se1->e1_confed
					rel->PREFIXO   := se1->e1_prefixo
					rel->NUMTIT    := se1->e1_num
					rel->VALOR     := se1->e1_valor
					rel->VLRRECEB  := se1->e1_valliq
					rel->VLRcred   := se1->e1_valcred
					rel->SITUACAO  := sa1->a1_situac
					rel->ARQUIVO   := se1->e1_arqbco
					rel->HISTORICO := se1->e1_hist
					msunlock()					

	ELSE

		RecLock("SE1",.T.)

		SE1->E1_FILIAL   := xFilial()
		SE1->E1_PREFIXO  := XPREFIXO
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
					dbselectarea("rel")
					reclock("rel",.t.)
					rel->SINDICATO := se1->e1_sindica
					rel->NATUREZA  := se1->e1_naturez
					rel->xDATA      := se1->e1_dtcred
					rel->CNPJ      := sa1->a1_cgc
					rel->NOME      := sa1->a1_nome
					rel->VENCIMENTO:= se1->e1_vencto
					rel->numban    := se1->e1_confed
					rel->PREFIXO   := se1->e1_prefixo
					rel->NUMTIT    := se1->e1_num
					rel->VALOR     := se1->e1_valor
					rel->VLRRECEB  := se1->e1_valliq
					rel->VLRcred   := se1->e1_valcred
					rel->SITUACAO  := sa1->a1_situac
					rel->ARQUIVO   := se1->e1_arqbco
					rel->HISTORICO := se1->e1_hist
					msunlock()					

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
imprelbx()
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
cDesc1 := "Este programa irá gerar as criticas da Baixa da Sindical."
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


Static Function IMPRELBX()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ RELBXS   ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 12.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao relatorio de BAIXAS                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
SetPrvt("_CALIAS,CBCONT,CBTXT,WNREL,CDESC1,CDESC2")
SetPrvt("CDESC3,CSTRING,TAMANHO,TIPO,LIMITE,TITULO")
SetPrvt("CABEC2,CABEC1,ARETURN,NOMEPROG,NLASTKEY,CPERG")
SetPrvt("M_PAG,LI,_AESTR,C_ARQIMP,CARQIND,CINDSA1")
SetPrvt("NLINHA,")
_cAlias := alias()
cbcont := 0
cbtxt := ""
wnrel := ""
cDesc1 := "Este programa irá imprimir a relacao de baixas"
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Relacao de Baixas"
cabec2 := ""
cabec1 := ""
aReturn := { "Zebrado", 1,"Administracao", 4, 2, 1, "",1 }
nomeprog := cPerg                                                                                                
nLastkey := 0
m_pag := 1
li := 80
wnrel :=  cPerg
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)

if nLastkey == 27
    return
endif
SetDefault(aReturn,cString)
if nLastkey == 27
   return
endif
    RptStatus({|| impRELX() },titulo)
    return



Static function ImpRELX()
cDesc1 := "Este programa irá imprimir a relacao de baixas"
cDesc2 := ""
cDesc3 := ""
String := "SE1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Relação de Baixas"
cabec2 := ""
CABEC1 := "Sind. Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Baixa  Vlr. Recebido Situacao No.Bancário   Arquivo "
li := 80
dbselectarea("rel")
dbgotop()
SetRegua(RecCount())
VALTIT := VALPG := QTDPG := 0

	CABEC1 := "Sind. Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Cred.  Vlr.  Credito Sit. No.Bancário    Arquivo             Historico"
	//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99,999,999.99 zz       x
	//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19
	xDATA := rel->xdata
	CPODATA := "REL->xDATA"
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
//li+= 2
VALTIT1:= VALPG1  := 	QTDPG1  := 0
VALTIT2:= VALPG2  := 	QTDPG2 := 0
VALTIT3:= VALPG3  := 	QTDPG3  := 0
VALTIT4:= VALPG4  := 	QTDPG4  := 0
VALTIT5:= VALPG5  := 	QTDPG5  := 0
VALTIT6:= VALPG6  := 	QTDPG6  := 0
while !eof()
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	XNATUREZA := REL->NATuREZA
	NATVALTIT := NATVALPG := NATQTDPG := 0
	DBSELECTAREA("SED")
	DBSETORDER(1)
	DBSEEK(XFILIAL()+REL->NATUREZA)
	@ LI,000 PSAY "NATUREZA: "+alLTRIM(REL->NATUREZA)+" "+SED->ED_DESCRIC
	LI+= 2
	dbselectarea("rel")
	DO WHILE !EOF() .AND. REL->NATUREZA == XNATUREZA
		datVALTIT := datVALPG := DATQTDPG := 0
		INCREGUA()
		if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		endif
			CABEC1 := "Sind. Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Cred.  Vlr.  Credito Situacao No.Bancário"
			//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99,999,999.99 zz       x
			//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
			//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        5
			
			XDATA := rel->xdata
			CPODATA := "rel->xdata"
			@ LI,000 PSAY "DATA: "+DTOC(rel->xdata)
		
		LI+= 2
		dbselectarea("rel")
		DO WHILE !EOF() .AND. &CPODATA == XDATA
			if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
			endif
/*	dbselectarea("szc")
			dbsetorder(2)
			dbseek(xfilial("SZC")+TRB->A1_ESCCONT)
			dbSelectArea("TMP")
			RECLOCK("TMP",.T.)
			TMP->CODIGO    := TRB->A1_COD
			TMP->NOME      := TRB->A1_NOME
			TMP->ENDERECO  := trb->a1_end
			TMP->BAIRRO    := trb->a1_bairro
			tmp->CEP       := trb->a1_cep
			TMP->CIDADE    := TRB->A1_MUN
			TMP->UF        := TRB->A1_EST
			tmp->cnpj      := trb->A1_CGC
			TMP->DTCADAS   := STOD(TRB->A1_DTCADAS)
			TMP->DTASSOC   := STOD(TRB->A1_DTINASS)
			TMP->TELEFONE  := TRB->A1_TEL
			TMP->CODASSO   := TRB->A1_CODASSO
			TMP->SITUACAO  := TRB->A1_SITUAC
			TMP->ERSIN     := TRB->A1_ERSIN
			TMP->CATEGORIA := TRB->A1_CATEG1 
			TMP->NATUREZA  := alltrim(TRB->e1_naturez)
			TMP->TITULO    := TRB->E1_PREFIXO+"-"+TRB->E1_NUM+"-"+TRB->E1_PARCELA
			TMP->VALORTIT  := TRB->E1_VALOR+trb->e1_juros
			TMP->DATAVENCTO:= STOD(TRB->E1_VENCTO)
			IF mv_par12 == 1
				TMP->DATAPAGTO := STOD(TRB->E1_BAIXA)
			ELSE
				TMP->DATAPAGTO := STOD(TRB->E1_DTCRED)
			ENDIF
			IF ALLTRIM(TRB->E1_NATUREZ) == "003"
				TMP->VALORREC  := (TRB->E1_VALOR)*.6+TRB->E1_JUROS
			else
				TMP->VALORREC  := TRB->E1_VALLIQ
			endif
			TMP->HISTORICO := TRB->E1_HIST
			TMP->NUMBCO    := TRB->E1_CONFED
			TMP->BASE      := TRB->A1_BASE
			TMP->INATIVO   := TRB->A1_INAT
			TMP->DTABERT   := stod(TRB->A1_DTabert)
			TMP->DTINASS   := STOD(TRB->A1_DTINASS)
			TMP->DTFIMASS  := STOD(TRB->A1_DTFIMAS)
			TMP->VALASSOC  := TRB->A1_VALASSO      
			TMP->FOLHA     := trb->A1_FOLHA
			TMP->CAPITAL   := trb->A1_CAPITAL
			TMP->CAPCENT   := trb->a1_capcent
			TMP->FOLHA_CENT:= trb->a1_folcent
			TMP->LEITOS    := trb->a1_leitos
			TMP->FUNCION   := trb->A1_NUMFUN
			TMP->ESCR_CONT := trb->A1_ESCCONT
			TMP->FILANT    := trb->A1_FILANT
			TMP->HISTORICO := trb->A1_HIST
			TMP->HISTORICO2:= trb->A1_HIST2
			TMP->HISTASS   := trb->A1_HISTASS
			TMP->EMISSAO   := STOD(trb->e1_emissao)
			TMP->VENCREA   := stod(trb->e1_vencrea)
			TMP->JUROS     := trb->e1_juros 
			TMP->VALBAIXA  := trb->e1_valliq
			TMP->BOLETO    := trb->e1_confed 
			TMP->ARQBCO    := trb->e1_arqbco
			TMP->VALCRED   := trb->e1_valcred
			TMP->DTCRED    := STOD(trb->e1_dtcred)
			TMP->NOMEESCR  := SZC->ZC_NOMESC
			TMP->ENDESCR   := SZC->ZC_END
			TMP->CEPESCR   := SZC->ZC_CEP
			TMP->BAIRESCR  := SZC->ZC_BAIRRO
			TMP->MUNESCR   := SZC->ZC_MUN
			TMP->ESTESCR   := SZC->ZC_EST
			TMP->FONEESCR  := SZC->ZC_FONE
			TMP->HIST_PAGTO:= TRB->E1_HIST
			TMP->SINDICATO := TRB->E1_SINDICA                           
			TMP->TPCADASTRO:= TRB->A1_TPCADAS
			msunlock()*/
			@ LI,000 PSAY rel->sindicato 
			@ LI,006 PSAY rel->NOME
			@ LI,057 PSAY rel->cnpj   PICTURE "@R 99.999.999/9999-99"
			@ LI,076 PSAY rel->natureza  
			@ LI,087 PSAY rel->PREFIXO+"-"+rel->numtit//-"+TRB->E1_PARCELA
			@ LI,101 PSAY rel->vencimento
			@ LI,110 PSAY rel->VLRreceb PICTURE "@E 99,999,999.99"
			@ LI,125 PSAY rel->xdata
			IF ALLTRIM(rel->NATUREZa) == "003"
				@ LI,135 PSAY rel->Vlrcred PICTURE "@E 99,999,999.99"
				DATVALPG  += rel->Vlrcred
			  if rel->sindicato == "01"
			  	VALTIT1+=rel->VLRRECEB
			  	 VALPG1 += 	REL->VLRCRED
			  	  QTDPG1  ++ 
			   elseif rel->sindicato == "02"
			  	VALTIT2+=REL->VLRRECEB
			  		 VALPG2 += 	REL->VLRCRED
			  	  QTDPG2  ++ 
			   elseif rel->sindicato == "03"
			  	VALTIT3+=REL->VLRRECEB
  				  	 VALPG3 += 	REL->VLRCRED
			  	 			  	 QTDPG3  ++ 
			   elseif rel->sindicato == "04"
			  	VALTIT4+=REL->VLRRECEB
			  	 VALPG4 += 	REL->VLRCRED
			  	 QTDPG4  ++ 
			   elseif rel->sindicato == "05"
			  	VALTIT5+=REL->VLrRECEB
			  	 VALPG5 += 	REL->VLRCRED
			  	 QTDPG5  ++ 
			   elseif rel->sindicato == "06"
			  	VALTIT6+=REL->VLRRECEB
			  	 VALPG6 += 	REL->VLRCRED
			  	 QTDPG6  ++ 
			   ENDIF
			else
				JRVALORREC:= REL->VLRrecEB
				IF ALLTRIM(REL->NATuREZA) $ "002/0301" .AND. REL->SINDICATO<>"01"
					JRVALORREC := REL->vlrCRED
				ENDIF
				@ LI,135 PSAY JRVALORREC PICTURE "@E 99,999,999.99"
				DATVALPG  += REL->VLRcred
 			  if rel->sindicato == "01"
			  	VALTIT1+=REL->VLRreceb
			  	 VALPG1 += 	REL->VLRcred
			  	 QTDPG1  ++ 
			   elseif rel->sindicato == "02"
			  	VALTIT2+=REL->VLRreceb
			  	 VALPG2 += 	REL->VLRcred
			  	 QTDPG2  ++ 
			   elseif rel->sindicato == "03"
			  	VALTIT3+=REL->VLRreceb
			  	 VALPG3 += 	REL->VLRcred
			  	 QTDPG3  ++ 
			   elseif rel->sindicato == "04"
			  	VALTIT4+=REL->VLRreceb
			  	 VALPG4 += 	REL->VLRcred
			  	 QTDPG4  ++ 
			   elseif rel->sindicato == "05"
			  	VALTIT5+=REL->VLRreceb
			  	 VALPG5 += 	REL->VLRcred
			  	 QTDPG5  ++ 
			   elseif rel->sindicato == "06"
			  	VALTIT6+=REL->VLRreceb
			  		  	 VALPG6 += 	REL->VLRcred
			  	 QTDPG6  ++ 
			   ENDIF

				ENDIF
			@ LI,149 PSAY rel->situacao
			@ li,154 psay rel->numban
			@ li,169 psay rel->arquivo// MUDAR O SITUACAO PARA SIT  E AUMENTAR E1_HIST
//			@ li,186 psay trb->e1_sindica
			@ li,189 psay rel->HISTorico
			LI++
			DATVALTIT += rel->vlrreceb
			DATQTDPG ++
			dbselectarea("rel")
			DBSKIP()
		ENDDO
		li++
		@ LI,000 PSAY "Total da Data: "+DTOC(xDATA)
		@ LI,060 PSAY "Qtde.Titulos:"
		@ li,074 psay datqtdpg picture "@e 999,999"
		@ LI,110 PSAY datvaltit PICTURE "@E 99,999,999.99"
		@ LI,135 PSAY datvalpg  PICTURE "@E 99,999,999.99"
		natVALTIT += dATVALTIT
		natVALPG  += dATVALPG
		NATQTDPG += DATQTDPG
		LI+=2
	ENDDO
	li++
	@ LI,000 PSAY "Total da Natureza: "
	@ LI,060 PSAY "Qtde.Titulos:"
	@ li,074 psay natqtdpg picture "@e 999,999"
	@ LI,110 PSAY natvaltit PICTURE "@E 99,999,999.99"
	@ LI,135 PSAY natvalpg  PICTURE "@E 99,999,999.99"
	VALTIT += NATVALTIT
	VALPG  += NATVALPG
	QTDPG  += NATQTDPG
	li+= 2
enddo
IF LI <> 80
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	IF QTDPG1 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 01:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg1 picture "@e 999,999"
	   @ LI,110 PSAY valtit1 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg1  PICTURE "@E 99,999,999.99"
		li++
	endif
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif

	IF QTDPG2 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 02:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg2 picture "@e 999,999"
	   @ LI,110 PSAY valtit2 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg2  PICTURE "@E 99,999,999.99"
		li++
	endif                             
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	
	IF QTDPG3 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 03:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg3 picture "@e 999,999"
	   @ LI,110 PSAY valtit3 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg3  PICTURE "@E 99,999,999.99"
	LI++
	endif
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif

	IF QTDPG4 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 04:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg4 picture "@e 999,999"
	   @ LI,110 PSAY valtit4 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg4  PICTURE "@E 99,999,999.99"
		LI++
	endif   
		if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
                        
	
	IF QTDPG5 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 05:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg5 picture "@e 999,999"
	   @ LI,110 PSAY valtit5 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg5  PICTURE "@E 99,999,999.99"
		LI++
	endif
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif

	IF QTDPG6 <> 0
		@ LI,000 PSAY "Total Geral Sindicato 06:"
		@ LI,060 PSAY "Qtde.Titulos:"
   	@ li,074 psay qtdpg6 picture "@e 999,999"
	   @ LI,110 PSAY valtit6 PICTURE "@E 99,999,999.99"
	   @ LI,135 PSAY valpg6  PICTURE "@E 99,999,999.99"
		LI++
	endif
	li++
	@ LI,000 PSAY "Total Geral:"
	@ LI,060 PSAY "Qtde.Titulos:"
	@ li,074 psay qtdpg picture "@e 999,999"
	@ LI,110 PSAY valtit PICTURE "@E 99,999,999.99"
	@ LI,135 PSAY valpg  PICTURE "@E 99,999,999.99"
	li++
ENDIF    


if LI <> 80
	roda(cbcont,cbtxt,tamanho)
endif
DBSELECTAREA("rel")
DBCLOSEAREA("rel")
set device to screen
if aReturn[5] == 1
	set printer to
	dbcommit()
	ourspool(wnrel)
endif
MS_FLUSH()
//dbselectarea(_cAlias)
return


