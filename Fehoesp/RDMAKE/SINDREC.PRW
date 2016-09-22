#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
User Function SINDREC()     // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
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
@ 033,014 SAY "vindas pe*la CEF"
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
USE \SINDICAL ALIAS TMP NEW SHARED
dbSelectArea("TMP")
dbGotop()
ProcRegua(RecCount(),22,05)
DO WHILE !EOF()     
	XSINDICA := TMP->SINDICATO  
	IF XSINDICA=="02"
		XXCONTA := "00000973-4"
	ELSEIF 	XSINDICA == "03"
		XXCONTA := "00000989-0"
	ELSEIF 	XSINDICA == "04"
		XXCONTA := "00000974-2"
	ELSEIF 	XSINDICA == "05"
		XXCONTA := "00000986-6"
	ELSEIF 	XSINDICA == "06"
		XXCONTA := "00000990-4"
    ENDIF
	IncProc("Boleto Num.: "+tmp->BOLETO)
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbseek( xFilial()+ TMP->CODIGO           )
	DATAVENC := TMP->DATAVENCTO
	ANOVENC  := SUBS(TMP->TITULO,1,2)
	CONFED   := sUbs(tmp->BOLETO,1,12)
	XCGC     := TMP->CNPJ
	
	NUMLINHA := TMP->(RECNO())
	IF SA1->A1_CGC==XCGC
	//	DBSELECTAREA("SE1")
	//	DBSETORDER(1)
	//	dbseek( xFilial()+ANOVENC+"S"+SA1->A1_COD)
   		ACHOU := .F.
		DBSELECTAREA("SE1")
		dbOrderNickName('18')  // DBSETORDER(18) // Alterado (UPDXFUN).
		dbseek( xFilial()+sUbs(tmp->BOLETO,1,12))
		IF FOUND()
//			ALERT (TMP->BOLETO+" ja encontrado")
		ENDIF
	ELSE
		ALERT (TMP->BOLETO+" cgc n encontrado")
	ENDIF
	DBSELECTAREA("TMP")
	VALTIT   := tmp->valortit-tmp->juros
	XVALCRED  := tmp->valcred
	valjur   := tmp->juros
	dTPAG    :=  ctod("21/07/12")
	xdTCRED   := ctod("21/07/12")
	XPREFIXO := subs(tmp->titulo,1,3)
	DBSELECTAREA("SE1")
	IF SA1->A1_CGC==XCGC
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
		SE1->E1_EMISSAO  := tmp->emissao
		SE1->E1_MOVIMEN  := DTPAG
		SE1->E1_EMIS1    := tmp->emissao
		SE1->E1_VENCTO   := tmp->datavencto
		SE1->E1_VENCREA  := tmp->vencreA
		SE1->E1_VENCORI  := tmp->datavencto
		SE1->E1_HIST     := TMP->HIST_PAGTO
		SE1->E1_VALOR    := VALTIT
		SE1->E1_SALDO    := 0
		SE1->E1_VLCRUZ   := VALTIT
		SE1->E1_JUROS    := VALJUR       
		SE1->E1_MOEDA    := 1
		SE1->E1_ARQBCO   := "SINDICAL"
		SE1->E1_LINARQ   := TMP->(RECNo())
		se1->e1_dtcred   := xDTCRED
		//APOS BORDERO
		SE1->E1_PORTADO := "104"
		//		SE1->E1_AGEDEP := "0249"
		SE1->E1_AGEDEP := "0242"
		//		SE1->E1_CONTA   :="050.010-0"
		SE1->E1_CONTA   := XXCONTA
		SE1->E1_SITUACA := "1"
		SE1->E1_OCORREN := "01"
		SE1->E1_ORIGEM  := "SINDICAL"
		SE1->E1_STATUS  := "B"
		//SE1->E1_JUROS   := VALJUROS
		SE1->E1_VALLIQ  := VALTIT+VALJUR
		SE1->E1_BAIXA   := DTPAG
		SE1->E1_OK      := CHR(69)+CHR(120)
		SE1->E1_CONFED  := CONFED
		SE1->E1_VALCRED := XVALCRED
//		_nTotal:= _nTotal + SE1->E1_VALLIQ

		MSUNLOCK()
		CONFIRMSX8()
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
		SE1->E1_CGC      := TMP->CNPJ
		SE1->E1_EMISSAO  := tmp->emissao
		SE1->E1_MOVIMEN  := DTPAG
		SE1->E1_EMIS1    := tmp->emissao
		SE1->E1_VENCTO   := tmp->datavencto
		SE1->E1_VENCREA  := tmp->vencreA
		SE1->E1_VENCORI  := tmp->datavencto
		SE1->E1_HIST     := TMP->HIST_PAGTO
		SE1->E1_VALOR    := VALTIT
		SE1->E1_SALDO    := 0
		SE1->E1_VLCRUZ   := VALTIT
		SE1->E1_JUROS    := VALJUR
		SE1->E1_MOEDA    := 1
		SE1->E1_ARQBCO   := "SINDICAL"
		SE1->E1_LINARQ  := TMP->(RECNO())
		se1->e1_dtcred   := xDTCRED
		//APOS BORDERO
		SE1->E1_PORTADO := "104"
		//		SE1->E1_AGEDEP := "0249"
		SE1->E1_AGEDEP := "0242"
		//		SE1->E1_CONTA   :="050.010-0"
		SE1->E1_CONTA   := XXCONTA
		SE1->E1_SITUACA := "1"
		SE1->E1_OCORREN := "01"
		SE1->E1_ORIGEM  := "SINDICAL"
		SE1->E1_STATUS  := "B"
		//SE1->E1_JUROS   := VALJUROS
		SE1->E1_VALLIQ  := VALTIT+VALJUR
		SE1->E1_BAIXA   := DTPAG
		SE1->E1_OK      := CHR(69)+CHR(120)
		SE1->E1_CONFED  := CONFED
		SE1->E1_VALCRED := XVALCRED
//		_nTotal:= _nTotal + SE1->E1_VALLIQ
		MSUNLOCK()
		CONFIRMSX8()

	endif

	dbselectArea("SE5")
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial()
	SE5->E5_DATA    := dtpag
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := Xvalcred
	SE5->E5_NATUREZ := "003"
	SE5->E5_BANCO   := "104"
	//	SE5->E5_AGENCIA := "0249"
	SE5->E5_AGENCIA := "0242"
	//	SE5->E5_CONTA   :="050.010-0"
	SE5->E5_CONTA   :=XXCONTA
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
	SE5->E5_TIPODOC := "VL"
	SE5->E5_VLMOED2 := Xvalcred
	SE5->E5_LA      := "N"
	SE5->E5_CLIFOR  := se1->e1_cliente
	SE5->E5_LOJA    := Se1->e1_LOJA
	SE5->E5_DTDIGIT := dDATABASE
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := SE1->E1_PREFIXO
	SE5->E5_NUMERO  :=  Se1->e1_num
	//          SE5->E5_PARCELA := _nPARC
	SE5->E5_DTDISPO := dtpag
	MsUnlock()
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial()
	SE5->E5_DATA    := dtpag
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := tmp->valbaixa-Xvalcred
	SE5->E5_NATUREZ := "003"
	SE5->E5_BANCO   := "REP"
	SE5->E5_AGENCIA := "REPAS"
	SE5->E5_CONTA   := "REPASSE"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
	SE5->E5_TIPODOC := "VL"
	SE5->E5_VLMOED2 := tmp->valbaixa-Xvalcred
	SE5->E5_LA      := "N"
	SE5->E5_CLIFOR  := se1->e1_cliente
	SE5->E5_LOJA    := Se1->e1_LOJA
	SE5->E5_DTDIGIT := dDATABASE
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := SE1->E1_PREFIXO
	SE5->E5_NUMERO  :=  Se1->e1_num
	//          SE5->E5_PARCELA := _nPARC
	SE5->E5_DTDISPO := dtpag
	MsUnlock()
	dbSelectArea("TMP")
	RECLOCK("TMP",.F.)
	DBDELETE()
	MSUNLOCK()
		dbSelectArea("TMP")
	dbskip()
enddo
//totcad()
dbSelectArea("TMP")
dbCloseArea()
dbSelectArea("SA1")
dbSetOrder(1)
dbSelectArea("SE1")
dbSetOrder(1)
dbselectArea("SI2")
dbsetorder(1)
dbSelectArea(_oldArea)
dbSetOrder(_oldOrder) // Atencao (UPDXFUN).
Return(nil)
          