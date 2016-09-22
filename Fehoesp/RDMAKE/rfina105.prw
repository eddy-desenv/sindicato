#include "rwmake.ch"
User Function RFINA105()
SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,N_OPC,CPERG,SAIDA")
SetPrvt("_ASTRU,C_ARQTMP,_ASTRU1,C_ARQTMP1,_ASTRU2,C_ARQTMP2")
SetPrvt("_ASTRU3,C_ARQTMP3,_DVENC,_DEMIS,_NREGISTROS,_NINCLUIDOS")
SetPrvt("_NSEQ,_NVALTOT,_NNUMSEQ,_CTEXTO,W,")
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RFINA05  ³ Autor ³ Andreia dos Santos    ³ Data ³ 26/03/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envio de Contribuicoes Confederativas                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±³          ³ H:\BCOREAL\CONFMM99.txt (arquivo para envio)               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs.:     ³ E' atualizado os arquivo SE1, SEA,                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_oldArea  := alias()
_oldOrder := indexord()
_cTitulo   := "Cobranca Confederativa"
n_Opc := 0
cPerg    := "FINA05"
_nRegistros  := 0
_nIncluidos  := 0
C_BORDERO    := ""

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                                       ³
³ mv_par01   // ano para envio   N2                                          ³
³ mv_par02   // Parcela          C1                                          ³
³ mv_par03   // Data de vencimento                                           ³
³ // mv_par04   // Data de Emissao                                           ³
³ // mv_par05   // Sequencia                                                 ³
³ MV_PAR04   // arquivo de saida := "H:\BCOREAL\ASSOC"+strzero(MES,2)+".txt" ³
³ MV_PAR05   // Codigo do Banco                                              ³
³ MV_PAR06   // codigo da agencia                                            ³
³ MV_PAR07   // Codigo da conta                                              ³
³ MV_PAR08   // codigo da subconta                                           ³
³ MV_PAR09   // destinatario - Entidades, Escritorios , Reenvio, 	     		  ³
³            //                Reenvio Entidades, Reenvio Escritorios 	     ³
³ MV_PAR10   // Data de Cadastro Ate                                         ³
³ MV_PAR11   // Codigo Sindicato                                             ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Pergunte(cPerg,.T.)
@ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a geracao de Arquivo para cobranca da "
@ 033,014 SAY "Contribuicao Confederativa "
@ 063,014 SAY "CONFIRME PARA INICIAR A GERACAO DE DADOS         "
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

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ,¿
//³Fixada a pergunta MV_PAR04 como data de Emissao, para evitar erro de digitacao com a data de vencimento.³
//³                                                                                                        ³
//³Nava - 28/05/07                                                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ,Ù
ENDDOC*/
  // Data de Emissao 															  ³

_aStru := {}	//REGISTRO HEADER
AADD( _aStru, { "COD_REGIST"  , "C" , 001 , 0 } )
AADD( _aStru, { "CONSTANTE"   , "C" , 025 , 0 } )
AADD( _aStru, { "ZERO"        , "C" , 001 , 0 } )
AADD( _aStru, { "AGE_CEDENT"  , "C" , 004 , 0 } )
AADD( _aStru, { "ZERO2"       , "C" , 001 , 0 } )
AADD( _aStru, { "CTA_CEDENT" , "C" , 007 , 0 } )
AADD( _aStru, { "VAGO"        , "C" , 007 , 0 } )
AADD( _aStru, { "NOME_CEDEN" , "C" , 030 , 0 } )
AADD( _aStru, { "IDENT_BANC" , "C" , 003 , 0 } )
AADD( _aStru, { "NOME_BANCO"  , "C" , 015 , 0 } )
AADD( _aStru, { "DATA_PROCE"  , "C" , 006 , 0 } )
AADD( _aStru, { "CONSTANTE2"  , "C" , 008 , 0 } )
AADD( _aStru, { "VAGO2"       , "C" , 282 , 0 } )
AADD( _aStru, { "SEQUEN_MOV" , "C" , 004 , 0 } )
AADD( _aStru, { "NUM_SEQUEN"  , "C" , 006 , 0 } )
c_ArqTmp := CriaTrab(_aStru,.t.)
dbUseArea(.t.,,c_ArqTmp,"HEAD")
dbSelectArea("HEAD")
_aStru1 := {}  //REGISTRO TRAILLER
AADD( _aStru1, { "COD_REGIS"  , "C" , 001 , 0 } )
AADD( _aStru1, { "QUANT_REG"  , "C" , 006 , 0 } )
AADD( _aStru1, { "VLR_TOTAL"  , "C" , 013 , 0 } )
AADD( _aStru1, { "VAGO"       , "C" , 374 , 0 } )
AADD( _aStru1, { "NUM_SEQUEN" , "C" , 006 , 0 } )
c_ArqTmp1 := CriaTrab(_aStru1,.t.)
dbUseArea(.t.,,c_ArqTmp1,"TRAI")
dbSelectArea("TRAI")
_aStru2 := {}
AADD( _aStru2, { "COD_REGIST"  , "C" , 001 , 0 } )
AADD( _aStru2, { "COD_INSCRI"  , "C" , 002 , 0 } )
AADD( _aStru2, { "CGC_SDHOSP"  , "C" , 014 , 0 } )
AADD( _aStru2, { "ZERO_1"      , "C" , 001 , 0 } )
AADD( _aStru2, { "AG_CEDENTE"  , "C" , 004 , 0 } )
AADD( _aStru2, { "ZERO_2"      , "C" , 001 , 0 } )
AADD( _aStru2, { "CT_CEDENTE"  , "C" , 007 , 0 } )
AADD( _aStru2, { "VAGO_1"      , "C" , 032 , 0 } )
AADD( _aStru2, { "ZERO_3"      , "C" , 002 , 0 } )
AADD( _aStru2, { "NUMTIT_BAN"  , "C" , 013 , 0 } )
AADD( _aStru2, { "VAGO_2"      , "C" , 031 , 0 } )
AADD( _aStru2, { "COD_OCORRE"  , "C" , 002 , 0 } )
AADD( _aStru2, { "VAGO_3"      , "C" , 010 , 0 } )
AADD( _aStru2, { "DATA_VENC"   , "C" , 006 , 0 } )
AADD( _aStru2, { "VLR_TITULO"  , "C" , 013 , 0 } )
AADD( _aStru2, { "IDENT_BANC"  , "C" , 003 , 0 } )
AADD( _aStru2, { "VAGO_4"      , "C" , 005 , 0 } )
AADD( _aStru2, { "ESP_TITULO"  , "C" , 002 , 0 } )
AADD( _aStru2, { "VAGO_5"      , "C" , 001 , 0 } )
AADD( _aStru2, { "DATA_EMISS"  , "C" , 006 , 0 } )
AADD( _aStru2, { "VAGO_6"      , "C" , 004 , 0 } )
AADD( _aStru2, { "JUROS_MORA"  , "C" , 013 , 0 } )
AADD( _aStru2, { "DATA_DESCO"  , "C" , 006 , 0 } )
AADD( _aStru2, { "VLR_DESCON"  , "C" , 013 , 0 } )
AADD( _aStru2, { "VLR_IOC"     , "C" , 013 , 0 } )
AADD( _aStru2, { "VLR_ABATIM"  , "C" , 013 , 0 } )
AADD( _aStru2, { "CPF_OU_CGC"  , "C" , 002 , 0 } )
AADD( _aStru2, { "CGC_SACADO"  , "C" , 014 , 0 } )
AADD( _aStru2, { "NOME_SACAD"  , "C" , 040 , 0 } )
AADD( _aStru2, { "END_SACADO"  , "C" , 040 , 0 } )
AADD( _aStru2, { "BAIRRO_SAC"  , "C" , 012 , 0 } )
AADD( _aStru2, { "CEP_SACADO"  , "C" , 008 , 0 } )
AADD( _aStru2, { "CIDADE_SAC"  , "C" , 015 , 0 } )
AADD( _aStru2, { "ESTADO_SAC"  , "C" , 002 , 0 } )
AADD( _aStru2, { "SACADOR"     , "C" , 040 , 0 } )
AADD( _aStru2, { "VAGO_7"      , "C" , 001 , 0 } )
AADD( _aStru2, { "VLR_MOEDA"   , "C" , 001 , 0 } )
AADD( _aStru2, { "TIPO_MOEDA"  , "C" , 001 , 0 } )
AADD( _aStru2, { "NUM_SEQUEN"  , "C" , 006 , 0 } )
c_ArqTmp2 := CriaTrab(_aStru2,.t.)
dbUseArea(.t.,,c_ArqTmp2,"DETA")
dbSelectArea("DETA")
_aStru3 := {}  //ARQUIVO FINAL
AADD( _aStru3, { "REGISTRO"  , "C" , 400 , 0 } )
c_ArqTmp3 := CriaTrab(_aStru3,.t.)
dbUseArea(.t.,,c_ArqTmp3,"REGI")
dbSelectArea("REGI")
_DVenc := strzero(day(mv_par03),2)+strzero(month(mv_par03),2)+strzero(val(substr(str(year(mv_par03),4),3,2)),2)
_Demis := strzero(day(dDataBase),2)+strzero(month(dDataBase),2)+strzero(val(substr(str(year(dDataBase),4),3,2)),2)
dbSelectArea("HEAD")  //GERANDO REGISTRO HEADER
RecLock("HEAD",.T.)
HEAD->COD_REGIST  := "0"
HEAD->CONSTANTE   := "1REMESSA01COBRANCA"
HEAD->ZERO        := "0"
HEAD->AGE_CEDENT  := MV_PAR06 //"1874"
HEAD->ZERO2       := "0"
HEAD->CTA_CEDENT  := MV_PAR07 // "7713319"
HEAD->NOME_CEDEN  := "SINDHOSP-SIND.HOSPITAIS EST SP"
HEAD->IDENT_BANC  := MV_PAR05 //"356"
HEAD->NOME_BANCO  := "BANCO REAL S.A."
HEAD->DATA_PROCE  := _Demis
HEAD->CONSTANTE2  := "01600BPI"
HEAD->SEQUEN_MOV  := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" ) //strzero(val(MV_PAR05),4)
HEAD->NUM_SEQUEN  := "000001"
DBCOMMIT()
MsUnLock()
dbSelectArea("SA1")
if (MV_PAR09 == 2 .or. MV_PAR09 == 4 )
	DBSETORDER(1)
	DBGOTOP()
	ProcRegua(RecCount(),22,05)
	DO WHILE !EOF()
	IncProc("Cliente: "+sa1->a1_cod+"-"+sa1->a1_nreduz)
		DbSelectArea("SZC")
		DbSetorder(2)
		if ! ( dbseek( xFilial() + SA1->A1_ESCCONT ) )
			DBSELECTAREA("SA1")
			reclock("SA1",.F.)
			SA1->A1_ESCCONT := ""
			MSUNLOCK()
		ENDIF
		DBSELECTAREA("SA1")
		DBSKIP()
	ENDDO
	DbOrderNickName('7')  && Ordena arq. por CNPJ escrit. contabil // Atencao (UPDXFUN).
	dbseek(xfilial()+"0",.t.)
else
	Dbsetorder(1) // Atencao (UPDXFUN).
	dbGotop()
EndIf
ProcRegua(RecCount(),22,05)
_nRegistros := 0
_nIncluidos := 0
_cTitulo := "Gerando Arquivo Bancario - Confederativa"
_nseq := "000002"
_nValTot := 0
Do While !Eof()

	DBSELECTAREA("SA1")
	IncProc(_cTitulo)
	IF LEN(ALLTRIM(SA1->A1_CEP))<> 8
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF
	if !empty(mv_par12)
		IF !SA1->A1_TPCADAS$MV_PAR12
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
		ENDIF
	ENDIF			
	if !empty(MV_PAR10) .and. sa1->a1_dtcadas > MV_PAR10
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	endif	

	If ! EMPTY( MV_PAR11) .AND. SA1->A1_SINDICA <> MV_PAR11
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	If !EMPTY(SA1->A1_INAT)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	If SA1->A1_FILANT == "X"      && Envio para Todos (Geral)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	If SA1->A1_FOLCENT == "S"      && Envio para Todos (Geral)

		/*BEGINDOC
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄP¿
		//³Exclusao de emissao para as empresas que possuam folha centralizada.³
		//³Campo A1_FOLCENT ="S"                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄPÙ
		ENDDOC*/

		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	IF VAL(SA1->A1_CATEG1) >= 12000
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	DbSelectArea("SZC")
	DbSetorder(2)
	if ! ( dbseek( xFilial() + SA1->A1_ESCCONT ) )
		DBSELECTAREA("SA1")
		reclock("SA1",.F.)
		SA1->A1_ESCCONT := ""
		MSUNLOCK()
	ENDIF
	If (MV_PAR09 == 1 .or. MV_PAR09 == 3 ) .and. len(alltrim(SA1->A1_ESCCONT))>0 	&& Envio para Todos (Geral)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	if (MV_PAR09 == 2 .or. MV_PAR09 == 4 )
		if len(alltrim(SA1->A1_ESCCONT))==0
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	EndIf
	IF MV_PAR02 == "1"
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
/*
		if dbseek( xFilial()+strzero(mv_par01,2)+" "+SA1->A1_COD+mv_par02+"DP") .or.;
			dbseek( xFilial()+strzero(mv_par01,2)+"E"+SA1->A1_COD+mv_par02+"DP") .or.;
			dbseek( xFilial()+strzero(mv_par01,2)+"A"+SA1->A1_COD+mv_par02+"DP")
*/
		if MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" "+mv_par02+"DP") .or.;
			MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E"+mv_par02+"DP") .or.;
			MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A"+mv_par02+"DP")
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	ELSEIF MV_PAR02== "2"
		IF MV_PAR09 == 1 .OR.MV_PAR09 == 2
			dbSelectArea("SE1")
			dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).

			if MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" "+mv_par02+"DP") .or.;
				MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E"+mv_par02+"DP") .or.;
				MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A"+mv_par02+"DP")
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		ENDIF
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+" "+SA1->A1_COD+"1"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" 1DP")
		IF FOUND()
			IF ALLTRIM(SE1->E1_NATUREZ)== "0301"
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+"E"+SA1->A1_COD+"1"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E1DP")
		IF FOUND()
			IF ALLTRIM(SE1->E1_NATUREZ)== "0301"
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+"A"+SA1->A1_COD+"1"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A1DP")
		IF FOUND()
			IF ALLTRIM(SE1->E1_NATUREZ)== "0301"
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+" "+SA1->A1_COD+"2"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" 2DP")
		IF FOUND()
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+"E"+SA1->A1_COD+"2"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E2DP")
		IF FOUND()
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
//		dbseek( xFilial()+strzero(mv_par01,2)+"A"+SA1->A1_COD+"2"+"DP")
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A2DP")
		IF FOUND()
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	endif
	dbSelectArea("SE1")
	dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).

// Alterado a pedidio do Nilton - 05/09/07
//	if (SA1->A1_CATLEIT $"66/67/68/70/71/72" .AND. ALLTRIM(SA1->A1_SITUAC)=="AS")
	IF  SA1->A1_NATUREZ = "1000" .AND. ALLTRIM(SA1->A1_SITUAC)=="AS"
// 	if !(dbseek( xFilial()+strzero(mv_par01,2)+" "+SA1->A1_COD+mv_par02+"DP")) .and.;
// 		!(dbseek( xFilial()+strzero(mv_par01,2)+"E"+SA1->A1_COD+mv_par02+"DP")) .and.;
// 		!(dbseek( xFilial()+strzero(mv_par01,2)+"A"+SA1->A1_COD+mv_par02+"DP"))
		if ! MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" "+mv_par02+"DP") .and.;
			! MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E"+mv_par02+"DP") .and.;
			! MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A"+mv_par02+"DP")

			RecLock("SE1",.T.)

			SE1->E1_FILIAL   := xFilial()
			SE1->E1_PREFIXO  := strzero(MV_PAR01,2)
			SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
			SE1->E1_PARCELA  := mv_par02
			SE1->E1_TIPO     := "DP"
			SE1->E1_NATUREZ  := "002"
			SE1->E1_CLIENTE  := SA1->A1_COD
			SE1->E1_CODASSO  := SA1->A1_CODASSO
			SE1->E1_CGC	     := SA1->A1_CGC
			SE1->E1_CATEG1   := SA1->A1_CATEG1
			SE1->E1_ERSIN	  := SA1->A1_ERSIN
			SE1->E1_BASE	  := SA1->A1_BASE
			SE1->E1_LOJA     := SA1->A1_LOJA
			SE1->E1_NOMCLI   := SA1->A1_NOME
			SE1->E1_EMISSAO  := date()
			SE1->E1_MOVIMEN  := date()
			SE1->E1_EMIS1    := date()
			SE1->E1_VENCTO   := mv_par03
			SE1->E1_VENCREA  := DataValida( mv_par03 )
			SE1->E1_VENCORI  := mv_par03
			SE1->E1_HIST     := "Isento Contr. "+ substr( dtos( mv_par03 ),5,2)+"/"+substr(dtos(mv_par03),3,2)
			SE1->E1_VALOR    := 0
			SE1->E1_SALDO    := 0
			SE1->E1_VLCRUZ   := 0
			SE1->E1_VALJUR   := 0
			SE1->E1_MOEDA    := 1
			SE1->E1_PORTADO  := MV_PAR05 //"356"
			SE1->E1_AGEDEP   := MV_PAR06 //"1874"
			SE1->E1_CONTA    := MV_PAR07 //"7713319"
			SE1->E1_SITUACA  := "1"
			SE1->E1_OCORREN  := "01"
			SE1->E1_ORIGEM  := "RFINA05"
			SE1->E1_STATUS  := "B"
			SE1->E1_JUROS   := 0
			SE1->E1_VALLIQ  := 0
			SE1->E1_BAIXA   := mv_par03
			SE1->E1_OK      := CHR(69)+CHR (120)
			SE1->E1_CONFED  := "Isento"

			MSUNLOCK()
			CONFIRMSX8()
			
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	endif
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	RecLock("DETA",.T.)
	DETA->COD_REGIST := "1"
	DETA->COD_INSCRI := "02"
	DETA->CGC_SDHOSP := "47436373000173"
	DETA->ZERO_1     := "0"
	DETA->AG_CEDENTE := MV_PAR06 //"1874"
	DETA->ZERO_2     := "0"
	DETA->CT_CEDENTE := MV_PAR07 //"7713319"
	DETA->ZERO_3     := "00"
	//NOSSO NUMERO
	if MV_PAR09 == 1
		DETA->NUMTIT_BAN := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" )+"000"+_nseq
	elseif MV_PAR09 == 2
		dbSelectArea("SZC")
		Dbsetorder(2)
		dbseek( xFilial() + SA1->A1_ESCCONT )
		DETA->NUMTIT_BAN := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" )+SZC->ZC_CODIGO + SUBSTR(_nseq,2,5)
	elseif MV_PAR09 == 3
		DETA->NUMTIT_BAN := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" )+"200"+_nseq
	elseif MV_PAR09 == 4
		dbSelectArea("SZC")
		Dbsetorder(2)
		dbseek( xFilial() + SA1->A1_ESCCONT )
		DETA->NUMTIT_BAN := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" )+SZC->ZC_CODIGO + SUBSTR(_nseq,2,5)
	endif
	DETA->COD_OCORRE := "01"
	DETA->DATA_VENC  := _DVenc
	DETA->VLR_TITULO := "0000000000000"
	DETA->IDENT_BANC := MV_PAR05 // "356"
	DETA->ESP_TITULO := "01"
	DETA->DATA_EMISS := _Demis
	DETA->JUROS_MORA := "0000000000000"
	DETA->DATA_DESCO := "000000"
	DETA->VLR_DESCON := "0000000000000"
	DETA->VLR_IOC    := "0000000000000"
	DETA->VLR_ABATIM := "0000000000000"
	DETA->CPF_OU_CGC := "02"
	DETA->CGC_SACADO := SA1->A1_CGC
	Ver_Ascii()
	DETA->SACADOR    := "SINDICATO DOS HOSPITAIS DO EST.SAO PAULO"
	DETA->VLR_MOEDA  := "7"
	DETA->TIPO_MOEDA := "7"
	dbSelectArea("SZ9")
	Reclock("SZ9",.T.)	
	SZ9->Z9_FILIAL := xFilial("SZ9")
	if MV_PAR09 == 1
		SZ9->Z9_TITULO := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" )+"000"+_nseq
	elseif MV_PAR09 == 2
		SZ9->Z9_TITULO := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" )+SZC->ZC_CODIGO + SUBSTR(_nseq,2,5)
	elseif MV_PAR09 == 3
		SZ9->Z9_TITULO := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" )+"200"+_nseq
	elseif MV_PAR09 == 4
		SZ9->Z9_TITULO := IIF( SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) ), STRZERO(VAL(SX5->X5_DESCSPA),4), "0000" )+SZC->ZC_CODIGO + SUBSTR(_nseq,2,5)
	endif
	SZ9->Z9_CGC    := SA1->A1_CGC
	SZ9->Z9_VENCTO := mv_par03
	IF !EMPTY(SA1->A1_ESCCONT)
		SZ9->Z9_PARCELA:= strzero(mv_par01,2)+"E"+MV_PAR02   && PP AA
	ELSE
		SZ9->Z9_PARCELA:= strzero(mv_par01,2)+" "+MV_PAR02   && PP AA
	ENDIF
	msUnlock()
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	DETA->NUM_SEQUEN := _nseq     //Sequencia
	msUnlock()
	_nNumSeq := val( _nseq )
	_nNumSeq := _nNumSeq + 1
	_nseq := strzero( _nNumSeq,6 )
	_nRegistros := _nRegistros + 1
	dbSelectArea("SA1")
	dbskip()
Enddo

// Adiciona 1 ao SX!

// Adiciona 1 ao SX5 da tabela GR - Responsavel pelos contadores de todas as geracoes

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ</Owú.ú.¿
//³	01    	<Title lang="pt">Geraçäo Assoc.</Title>         ³
//³				<Function>RFINA104</Function>                    ³

//³	02			<Title lang="pt">Geraçäo Conf.real</Title>      ³
//³				<Function>RFINA105</Function>                   ³

//³	03			<Title lang="pt">Geraçäo Conf.bradesco</Title>  ³
//³				<Function>RFINA127</Function>                   ³

//³	04			<Title lang="pt">Geraçäo Conf.cef</Title>       ³
//³				<Function>RFINA137</Function>                   ³

//³	05			<Title lang="pt">Geraçäo Itau - Cart.173</Title>³
//³				<Function>RFINA135</Function>                   ³

//³	06			<Title lang="pt">Geraçäo Assist.</Title>        ³
//³				<Function>RFINA108</Function>                   ³

//³	07			<Title lang="pt">Geraçäo Assoc/Conf</Title>     ³
//³				<Function>RFINATST</Function>                   ³

//³	08			<Title lang="pt">Geraçäo Sindical</Title>       ³
//³				<Function>RFINA124</Function>                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ</OwÙ
ENDDOC*/


IF SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "02" ) )
   RecLock( "SX5", .F. )
   SX5->X5_DESCSPA := Strzero( ( Val( SX5->X5_DESCSPA ) + 1 ), 4 )
   MsUnLock() 
ENDIF   

//ATUALIZA-SE O SEE
dbSelectArea("SEE")
if dbseek( xFilial()+MV_PAR05+MV_PAR06+MV_PAR07+MV_PAR08 )
	RecLock("SEE",.F.)
	SEE->EE_ULTDSK := strzero(val(SEE->EE_ULTDSK)+1,6)
	//    SEE->EE_FAXATU := strzero(val(SEE->EE_FAXATU)+1,10)
	dbcommit()
	MsUnlock()
endif
dbSelectArea("TRAI")  //GERANDO REGISTRO TRAILLER
RecLock("TRAI",.T.)
TRAI->COD_REGIS := "9"
TRAI->QUANT_REG := Strzero( _nRegistros,6 )
TRAI->VLR_TOTAL := "0000000000000"
TRAI->NUM_SEQUEN := _nseq
dbcommit()
MsUnlock()
dbSelectArea("HEAD")
COPY TO HEAD.txt SDF
dbSelectArea("DETA")
COPY TO DETA.TXT SDF
dbSelectArea("TRAI")
COPY TO TRAI.TXT SDF
dbSelectArea("REGI")
Append From HEAD.TXT SDF
Append From DETA.TXT SDF
Append From TRAI.TXT SDF
ARQ := "\arquivos\confederativa\"+MV_PAR04
COPY TO &ARQ SDF

TOTCAD()

@ 96,42 TO 290,405 DIALOG oDlg1 TITLE "Termino da Geracao"
@ 8,10 TO 68,170
@ 23,22 SAY "Registros Gerados"
@ 23,95 GET _nRegistros PICTURE "@E 999,999" WHEN .F.
@ 77,078 BMPBUTTON TYPE 1 ACTION Close(oDlg1)

ACTIVATE DIALOG oDlg1 CENTERED
dbSelectArea("HEAD")
dbCloseArea()
If File(c_ArqTmp+".DBF")
	Ferase(c_ArqTmp+".DBF")
EndIf
dbSelectArea("TRAI")
dbCloseArea()
If File(c_ArqTmp1+".DBF")
	Ferase(c_ArqTmp1+".DBF")
EndIf
dbSelectArea("DETA")
dbCloseArea()
If File(c_ArqTmp2+".DBF")
	Ferase(c_ArqTmp2+".DBF")
EndIf
If File("HEAD.TXT")
	Ferase("HEAD.TXT")
EndIf
If File("DETA.TXT")
	Ferase("DETA.TXT")
EndIf
If File("TRAI.TXT")
	Ferase("TRAI.TXT")
EndIf
dbSelectArea("REGI")
dbCloseArea()
If File(c_ArqTmp3+".DBF")
	Ferase(c_ArqTmp3+".DBF")
EndIf
dbSelectArea("SA1")
dbSetOrder(1)
dbSelectArea("SE1")
dbSetOrder(1)
dbSelectArea(_oldArea)
dbSetOrder(_oldOrder) // Atencao (UPDXFUN).
return
*************************
Static FUNCTION Ver_Ascii()
_cTexto := SA1->A1_NOME
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->NOME_SACAD := _cTexto
if MV_PAR09 == 1 .or. MV_PAR09 == 3
	_cTexto := SA1->A1_END
else
	_cTexto := SZC->ZC_END
endif
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->END_SACADO := _cTexto
if MV_PAR09 == 1 .or. MV_PAR09 == 3
	_cTexto := SA1->A1_CEP
else
	_cTexto := SZC->ZC_CEP
endif
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->CEP_SACADO := _cTexto
if MV_PAR09 == 1 .or. MV_PAR09 == 3
	_cTexto := SA1->A1_MUN
else
	_cTexto := SZC->ZC_MUN
endif
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->CIDADE_SAC := _cTexto
_cTexto := "SP"
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->ESTADO_SAC := _cTexto
if MV_PAR09 == 1 .or. MV_PAR09 == 3
	_cTexto := SA1->A1_BAIRRO
else
	_cTexto := SZC->ZC_BAIRRO
endif
for w := 1 to len(_cTexto)
	if !(substr(_cTexto,w,1) >= "0" .and. substr(_cTexto,w,1) <= "Z") .and. ;
		!(substr(_cTexto,w,1) >= "a" .and. substr(_cTexto,w,1) <= "z") .and. ;
		!substr(_cTexto,w,1) == " "
		_cTexto := strtran(_cTexto,substr(_cTexto,w,1)," ")
	endif
next w
DETA->BAIRRO_SAC := _cTexto
return

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
cDesc1 := "Este programa irá gerar o resumo da geração da contribuição."
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "P"
tipo := 15
limite := 220
Titulo := _cTitulo
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
    RptStatus({|| impREL() },titulo)
    return

**********
Static function ImpREL()
LI := 80
if Li >= 60
    cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
    nLinha := prow() + 1
endif
@ li+ 1,000 PSAY "Registros gerados: "
@ li+ 1,030 psay 	_nRegistros picture "@e 999999"
@ li+ 2,000 PSAY "Registros incluidos: "
@ li+ 2,030 psay 	_nIncluidos picture "@e 999999"
@ li+ 3,000 psay 	"Numero do Bordero "
@ li+ 3,030 psay 	C_BORDERO  PICTURE "@E 999999" 
@ li+ 4,000 psay 	"Numero Sequencial: "
@ li+ 4,030 psay 	VAL( SX5->X5_DESCSPA )-1 PICTURE "@E 999999" 
set device to screen
if aReturn[5] == 1
   set printer to
   dbcommit()
   ourspool(wnrel)
endif
MS_FLUSH()
return

