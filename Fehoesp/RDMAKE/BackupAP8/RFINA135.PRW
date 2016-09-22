#include "rwmake.ch"

User Function RFINA135()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RFINA135 ³ Autor ³        Nava           ³ Data ³ 16/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envio de Contribuicoes associativas/Confed. (ITAU)         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs.:     ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
LOCAL aArea 	:= GetArea()
LOCAL cTitulo  := "Envio da Cobranca Associativa/Confed. para o Itau"
LOCAL nOpc     := 0
LOCAL cPerg    := "FIN134"
LOCAL oDlg
LOCAL cNumBord := Strzero( Val( GETMV("MV_NUMBORR") ) + 1, 6 )
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                                       ³
³ mv_par01   // Mes para envio                                               ³
³ mv_par02   // ano para envio                                               ³
³ mv_par03   // Data de vencimento                                           ³
³ mv_par04   // Data de Emissao                                              ³
³ mv_par05   // Sequencia                                                    ³
³ mv_par06   // arquivo de saida := "H:\BCOREAL\ASSOC"+strzero(MES,2)+".txt" ³
³ mv_par07   // Codigo Sindicato                                             ³
³ mv_par08   // codigo do Banco                                              ³
³ mv_par09   // codigo da agencia                                            ³
³ mv_par10   // codigo da conta                                              ³
³ mv_par11   // codigo da subconta                                           ³
³ mv_par12   // Mensagem Linha 01                                            ³
³ mv_par13   // Mensagem Linha 02                                            ³
³ mv_par14   // Mensagem Linha 03                                            ³
³ mv_par15   // Mensagem Linha 04                                            ³
³ mv_par16   // Mensagem Linha 05                                            ³
³ mv_par17   // Hist Assoc Preenchido ?                                      ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Pergunte(cPerg,.T.)

@ 096,042 TO 375,505 DIALOG oDlg TITLE cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a geracao de Arquivo para cobranca da "
@ 033,014 SAY "Contribuicao Associativa no ITAU"
@ 043,014 SAY "BORDERO : " + cNumBord
@ 063,014 SAY "CONFIRME PARA INICIAR A GERACAO DO ARQUIVO "

@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar( oDlg, cNumBord )
@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg)

ACTIVATE DIALOG oDlg CENTERED

RestArea( aArea )

Return


/*===============================*/
  Static Function Iniciar( oDlg, cNumBord )
/*===============================*/

Close(oDlg)
mv_par04 := dDataBase 
Processa( {|| Gerar(cNumBord) })

Return

/*=========================*/
   Static Function Gerar(cNumBord)
/*=========================*/

LOCAL aStru := {}
LOCAL cVencim 		:= strzero(day(mv_par03),2)+strzero(month(mv_par03),2)+strzero(val(substr(str(year(mv_par03),4),3,2)),2)
LOCAL dEmissao 	:= strzero(day(mv_par04),2)+strzero(month(mv_par04),2)+strzero(val(substr(str(year(mv_par04),4),3,2)),2)
LOCAL nRegistros 	:= 0
LOCAL nIncluidos 	:= 0
LOCAL cTitulo 		:= "Gerando Arquivo Bancario - Associativa - ITAU"
LOCAL nSeq 			:= "000002"
LOCAL nValTot 		:= 0
LOCAL cNumborr 	:= val( getMV("MV_NUMBORR")) +1
LOCAL cPeriodo 	:= substr( cVencim, 5, 2 ) + substr( cVencim, 3, 2 )

PRIVATE cArqTmp1
PRIVATE cArqTmp2
PRIVATE cArqTmp3
PRIVATE cArqTmp4

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ,¿
//³Fixada a pergunta MV_PAR04 como data de Emissao, para evitar erro de digitacao com a data de vencimento.³
//³                                                                                                        ³
//³Nava - 28/05/07                                                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ,Ù
ENDDOC*/
  // Data de Emissao 															  ³

aStru := {}  //REGISTRO HEADER
AADD( aStru, { "COD_REGIST"  , "C" , 001 , 0 } )
AADD( aStru, { "CONSTANTE"   , "C" , 025 , 0 } )
AADD( aStru, { "AGE_CEDENT"  , "C" , 004 , 0 } )
AADD( aStru, { "ZERO"        , "C" , 002 , 0 } )
AADD( aStru, { "CTA_CEDENT"  , "C" , 005 , 0 } )
AADD( aStru, { "DAC"         , "C" , 001 , 0 } )
AADD( aStru, { "BRANCO1"     , "C" , 008 , 0 } )
AADD( aStru, { "NOME_CEDEN"  , "C" , 030 , 0 } )
AADD( aStru, { "IDENT_BANC"  , "C" , 003 , 0 } )
AADD( aStru, { "NOME_BANCO"  , "C" , 015 , 0 } )
AADD( aStru, { "DATA_PROCE"  , "C" , 006 , 0 } )
AADD( aStru, { "BRANCO2"     , "C" , 294 , 0 } )
AADD( aStru, { "NUM_SEQUEN"  , "C" , 006 , 0 } )

cArqTmp1 := CriaTrab( aStru,.t.)
DBUSEAREA(.T.,, cArqTmp1, "HEAD")
dbSelectArea("HEAD")

aStru := {}  //REGISTRO TRAILLER
AADD( aStru, { "COD_REGIS"  , "C" , 001 , 0 } )
AADD( aStru, { "BRANCO"     , "C" , 393 , 0 } )
AADD( aStru, { "NUM_SEQUEN" , "C" , 006 , 0 } )

cArqTmp2 := CriaTrab( aStru,.t.)
dbUseArea(.t.,, cArqTmp2, "TRAI")

dbSelectArea("TRAI")
aStru := {} // REGISTRO DETALHE

AADD( aStru, { "COD_REGIST"  , "C" , 001 , 0 } )
AADD( aStru, { "COD_INSCRI"  , "C" , 002 , 0 } )
AADD( aStru, { "CGC_SDHOSP"  , "C" , 014 , 0 } )
AADD( aStru, { "AG_CEDENTE"  , "C" , 004 , 0 } )
AADD( aStru, { "ZERO_1"      , "C" , 002 , 0 } )
AADD( aStru, { "CT_CEDENTE"  , "C" , 005 , 0 } )
AADD( aStru, { "DAC"         , "C" , 001 , 0 } )
AADD( aStru, { "BRANCO1"     , "C" , 004 , 0 } )
AADD( aStru, { "INSTR_ALEG"  , "C" , 004 , 0 } ) //0000
AADD( aStru, { "NUMTIT_BAN"  , "C" , 025 , 0 } )
AADD( aStru, { "NOSSO_NUM"   , "C" , 008 , 0 } ) // 00000000
AADD( aStru, { "QTDE_MOEDA"  , "C" , 013 , 0 } ) // 000
AADD( aStru, { "NUM_CARTEI"  , "C" , 003 , 0 } ) // 112
AADD( aStru, { "VAGO"        , "C" , 021 , 0 } )
AADD( aStru, { "CARTEIRA"    , "C" , 001 , 0 } ) // "I"
AADD( aStru, { "COD_OCORRE"  , "C" , 002 , 0 } ) // 01
AADD( aStru, { "NUM_DOC"     , "C" , 010 , 0 } ) // 01
AADD( aStru, { "DATA_VENC"   , "C" , 006 , 0 } )
AADD( aStru, { "VLR_TITULO"  , "C" , 013 , 0 } )
AADD( aStru, { "IDENT_BANC"  , "C" , 003 , 0 } ) // 341
AADD( aStru, { "AGEN_COBR"   , "C" , 005 , 0 } ) // 00000
AADD( aStru, { "ESPECIE"     , "C" , 002 , 0 } ) // 01 
AADD( aStru, { "ACEITE"      , "C" , 001 , 0 } ) // "N"
AADD( aStru, { "DATA_EMISS"  , "C" , 006 , 0 } )
AADD( aStru, { "INSTRUCAO1"  , "C" , 002 , 0 } )
AADD( aStru, { "INSTRUCAO2"  , "C" , 002 , 0 } )
AADD( aStru, { "JUROS_MORA"  , "C" , 013 , 0 } )
AADD( aStru, { "DATA_DESCO"  , "C" , 006 , 0 } )
AADD( aStru, { "VLR_DESCON"  , "C" , 013 , 0 } )
AADD( aStru, { "VLR_IOF"     , "C" , 013 , 0 } )
AADD( aStru, { "VLR_ABATIM"  , "C" , 013 , 0 } )
AADD( aStru, { "CPF_OU_CGC"  , "C" , 002 , 0 } ) // 02
AADD( aStru, { "CGC_SACADO"  , "C" , 014 , 0 } )
AADD( aStru, { "NOME_SACAD"  , "C" , 030 , 0 } )
AADD( aStru, { "BRANCO2"     , "C" , 010 , 0 } )
AADD( aStru, { "END_SACADO"  , "C" , 040 , 0 } )
AADD( aStru, { "BAIRRO_SAC"  , "C" , 012 , 0 } )
AADD( aStru, { "CEP_SACADO"  , "C" , 008 , 0 } )
AADD( aStru, { "CIDADE_SAC"  , "C" , 015 , 0 } )
AADD( aStru, { "ESTADO_SAC"  , "C" , 002 , 0 } )
AADD( aStru, { "SACADOR"     , "C" , 030 , 0 } )
AADD( aStru, { "BRANCO3"     , "C" , 004 , 0 } )
AADD( aStru, { "DATA_MORA"   , "C" , 006 , 0 } ) // Vencimento
AADD( aStru, { "PRAZO_MORA"  , "C" , 002 , 0 } ) // 05
AADD( aStru, { "BRANCO4"     , "C" , 001 , 0 } )
AADD( aStru, { "NUM_SEQUEN"  , "C" , 006 , 0 } )

cArqTmp3 := CriaTrab( aStru, .T.)
dbUseArea(.t.,, cArqTmp3,"DETA")
dbSelectArea("DETA")

aStru := {}  //ARQUIVO FINAL
AADD( aStru, { "REGISTRO"  , "C" , 400 , 0 } )
cArqTmp4 := CriaTrab( aStru,.t.)
dbUseArea(.t.,,cArqTmp4,"REGI")
dbSelectArea("REGI")

aStru := {}
AADD( aStru, { "CODIGO" 		, "C" , 001 , 0 } )
AADD( aStru, { "FLASH"  		, "C" , 003 , 0 } )
AADD( aStru, { "LINHA_1" 	   , "C" , 002 , 0 } )
AADD( aStru, { "MENSAGEM_1" 	, "C" , 100 , 0 } )
AADD( aStru, { "BRANCO_1"   	, "C" , 028 , 0 } )
AADD( aStru, { "LINHA_2" 		, "C" , 002 , 0 } )
AADD( aStru, { "MENSAGEM_2" 	, "C" , 100 , 0 } )
AADD( aStru, { "BRANCO_2"   	, "C" , 028 , 0 } )
AADD( aStru, { "LINHA_3"	 	, "C" , 002 , 0 } )
AADD( aStru, { "MENSAGEM_3" 	, "C" , 100 , 0 } )
AADD( aStru, { "BRANCO_3"    	, "C" , 028 , 0 } )
AADD( aStru, { "NUM_SEQUEN" 	, "C" , 006 , 0 } )

cArqTmp5 := CriaTrab( aStru,.t.)
dbUseArea(.t.,,cArqTmp5,"MSG")

dbSelectArea("SA1")
dbsetorder(3)
dbGotop()
ProcRegua(RecCount(),18,05)

Do While !Eof()
	IncProc("Cliente: "+sa1->a1_cod+"-"+sa1->a1_nreduz)
	IF LEN(ALLTRIM(SA1->A1_CEP))<> 8
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF

	dbSelectArea("SA1")

	If ! EMPTY( MV_PAR07) .AND. SA1->A1_SINDICA <> MV_PAR07
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	If !EMPTY(SA1->A1_INAT)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	if ALLTRIM(SA1->A1_NATUREZ)<>"1000"
		dbskip()
		Loop
	EndIf

	IF ( MV_PAR17 == 1.AND.  EMPTY( SA1->A1_HISTASS ) ) .OR. ;
		( MV_PAR17 == 2.AND.! EMPTY( SA1->A1_HISTASS ) )
		DBSKIP()
		LOOP
	ENDIF

	If empty(SA1->A1_CODASSO)
		dbskip()
		Loop
	Endif
	if SA1->A1_SITUAC <> "AS" .and. SA1->A1_SITUAC <> "SS"
		dbskip()
		Loop
	Endif
	If !empty(SA1->A1_DTFIMAS)
		dbskip()
		Loop
	Endif
	if val(SA1->A1_CATLEIT) <= 0
		dbskip()
		Loop
	Endif
	if val( TABELA("90",SA1->A1_CATLEIT) ) <= 0
		dbskip()
		Loop
	Endif

	dbSelectArea("SE1")
	dbsetorder(1)
	IF dbseek(xFilial("SE1")+strzero(MV_PAR02,2)+" "+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4))
		/*========================
		RecLock("SE1",.F.)
		DBDELETE()
		MSUNLOCK()
		//========================*/
		dbSelectArea("SA1")
		dbskip()
		Loop
	Endif
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	RecLock("DETA",.T.)

	DETA->COD_REGIST := "1"
	DETA->COD_INSCRI := "04"
	DETA->CGC_SDHOSP := "47436373000173"
	DETA->AG_CEDENTE := mv_par09
	DETA->ZERO_1     := "00"
	DETA->CT_CEDENTE := mv_par10
	DETA->DAC	     := STR( MODULO10( AllTrim( mv_par09 ) + AllTrim( mv_par10 ) ), 1 )
	DETA->INSTR_ALEG := "    "
	DETA->NUMTIT_BAN := strzero(MV_PAR02,2)+"0"+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)+"0000"
	DETA->NOSSO_NUM  := strzero(MV_PAR02,2)+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)
	DETA->QTDE_MOEDA := "0000000000000"
	DETA->NUM_CARTEI := "112"
	DETA->CARTEIRA   := "I"
	DETA->COD_OCORRE := "01"
	DETA->NUM_DOC    := strzero(MV_PAR02,2)+"0"+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)+"0"
	DETA->DATA_VENC  := cVencim
	DETA->VLR_TITULO := strzero(val( TABELA("90",SA1->A1_CATLEIT) )*100,13)
	DETA->IDENT_BANC := mv_par08 //"356" - Nava
	DETA->AGEN_COBR  := "00000"
	DETA->ESPECIE    := "01"
	DETA->ACEITE     := "N"
	DETA->DATA_EMISS := dEmissao
	DETA->JUROS_MORA := "0000000000000"
	DETA->DATA_DESCO := "      "
	DETA->VLR_DESCON := "0000000000000"
	DETA->VLR_IOF    := "0000000000000"
	DETA->VLR_ABATIM := "0000000000000"
	DETA->CPF_OU_CGC := "02"
	DETA->CGC_SACADO := SA1->A1_CGC

	DETA->NOME_SACAD := NoAccent( SA1->A1_NOME   )
	DETA->END_SACADO := NoAccent( SA1->A1_END    )
	DETA->BAIRRO_SAC := NoAccent( SA1->A1_BAIRRO )
	DETA->CEP_SACADO := NoAccent( SA1->A1_CEP    )
	DETA->CIDADE_SAC := NoAccent( SA1->A1_MUN    )
	DETA->ESTADO_SAC := NoAccent( SA1->A1_EST    )

	DETA->SACADOR    := "SINDICATO DOS HOSPITAIS DO EST.SAO PAULO"
	DETA->DATA_MORA  := cVencim
	DETA->PRAZO_MORA := "05" // ver
	DETA->NUM_SEQUEN := nSeq     //Sequencia

	MsUnlock()

	nSeq					:= strzero( ( VAL( nSeq ) + 1 ), 6 )

	dbSelectArea("MSG")  //GERANDO REGISTRO MENSAGEM
	RecLock("MSG",.T.)
	MSG->CODIGO 	 := "7"
	MSG->FLASH		 := "L6L"
	MSG->LINHA_1	 := "01"
	MSG->MENSAGEM_1 := SPACE( 7 ) + PADR( NoAccent( SA1->A1_NOME   ), 60 ) + ;
						     PADR( strzero(MV_PAR02,2)+"0"+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)+"0", 17 ) + ;
						     cVencim
	MSG->LINHA_2	 := "04"
	MSG->MENSAGEM_2 := NoAccent( MV_PAR12 )
	MSG->LINHA_3	 := "06"
	MSG->MENSAGEM_3 := NoAccent( MV_PAR13 )

	MSG->NUM_SEQUEN := nSeq     //Sequencia
	MsUnlock()

	nSeq					:= strzero( ( VAL( nSeq ) + 1 ), 6 )

	RecLock("MSG",.T.)
	MSG->CODIGO 	 := "7"
	MSG->FLASH		 := "L6L"
	MSG->LINHA_1	 := "08"
	MSG->MENSAGEM_1 := NoAccent( MV_PAR14 )
	MSG->LINHA_2	 := "10"
	MSG->MENSAGEM_2 := NoAccent( MV_PAR15 )
	MSG->LINHA_3	 := "12"
	MSG->MENSAGEM_3 := NoAccent( MV_PAR16 )
	MSG->NUM_SEQUEN := nSeq     //Sequencia
	MsUnlock()

	nValTot 				+= val( TABELA("90",SA1->A1_CATLEIT) )
	nRegistros 			+= 1
	nSeq					:= strzero( ( VAL( nSeq ) + 1 ), 6 )

	dbSelectArea("SE1")  //GERANDO Contas a receber
	IF ! dbseek(xFilial()+strzero(MV_PAR02,2)+" "+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4))
		RecLock("SE1",.T.)         

		SE1->E1_FILIAL   := xFilial("SE1")
		SE1->E1_PREFIXO  := strzero(MV_PAR02,2)+" "
		SE1->E1_NUM      := strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)
		SE1->E1_PARCELA  := ""
		SE1->E1_TIPO     := "DP"
		SE1->E1_NATUREZ  := "001"  //VER
		SE1->E1_CLIENTE  := SA1->A1_COD
		SE1->E1_LOJA     := SA1->A1_LOJA
		SE1->E1_NOMCLI   := SA1->A1_NREDUZ
		SE1->E1_EMISSAO  := mv_par04
		SE1->E1_VENCTO   := mv_par03
		SE1->E1_VENCREA  := DataValida( mv_par03,.t.)
		SE1->E1_VALOR    := val( TABELA("90",SA1->A1_CATLEIT) )
		SE1->E1_EMIS1    := mv_par04
		SE1->E1_SITUACA  := "0"
		SE1->E1_SALDO    := val( TABELA("90",SA1->A1_CATLEIT) )
		SE1->E1_VLCRUZ   := val( TABELA("90",SA1->A1_CATLEIT) )
		SE1->E1_VALJUR   := 1
		SE1->E1_VENCORI  := mv_par03
		SE1->E1_MOEDA    := 1
		SE1->E1_HIST     := "Ref.Contr.Assoc. de "+strzero(mv_par01,2)+"/"+strzero(mv_par02,2)
		//APOS BORDERO
		SE1->E1_PORTADO := mv_par08
		SE1->E1_AGEDEP  := mv_par09
		SE1->E1_CONTA   := mv_par10
		SE1->E1_NUMBOR  := strzero(cNumborr,6)  //NUMERO DO BORDERO
		SE1->E1_DATABOR := DDatabase //DATA DO BORDERO
		SE1->E1_MOVIMEN := DDatabase
		SE1->E1_SITUACA := "1"
		SE1->E1_OCORREN := "01"
		SE1->E1_ORIGEM  := "FINA040"
		SE1->E1_STATUS  := "A"
		SE1->E1_OK      := CHR(56)+CHR (121)
		SE1->E1_CGC     := SA1->A1_CGC
		SE1->E1_CODASSO := SA1->A1_CODASSO
		SE1->E1_CATEG1  := SA1->A1_CATEG1
		SE1->E1_ERSIN   := SA1->A1_ERSIN
		SE1->E1_BASE    := SA1->A1_BASE
		SE1->E1_SINDICA := SA1->A1_SINDICA

		//APOS GERACAO
		//    SE1->E1_NUMBCO := //NOSSO NUMERO
		nIncluidos 		 += 1
		MsUnlock()

		//ATUALIZA-SE O SEA
		dbSelectArea("SEA")  //GERANDO Contas a receber
		RecLock("SEA",.T.)
		SEA->EA_FILIAL  := xFilial("SEA")
		SEA->EA_PREFIXO := strzero(MV_PAR02,2)+" "
		SEA->EA_PARCELA := ""
		SEA->EA_NUM     := strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)
		SEA->EA_PORTADO := mv_par08 //"356" - Nava
		SEA->EA_AGEDEP  := mv_par09 // "1874" - Nava
		SEA->EA_NUMCON  := mv_par10 // "7710534" - Nava
		SEA->EA_NUMBOR  := strzero( cNumborr, 6)
		SEA->EA_DATABOR :=  dDatabase
		SEA->EA_TIPO    := "DP"
		SEA->EA_CART    := "R"
		SEA->EA_SITUACA := "1"
		//APOS GERAR ARQUIVO
		SEA->EA_TRANSF := "S"
		MsUnlock()

		RecLock("SA1",.F.)
		SA1->A1_MCOMPRA := SA1->A1_MCOMPRA +val( TABELA("90",SA1->A1_CATLEIT) )
		SA1->A1_SALDUP  := SA1->A1_SALDUP +val( TABELA("90",SA1->A1_CATLEIT) )
		SA1->A1_PRICOM  := if(empty(SA1->A1_PRICOM),mv_par04,SA1->A1_PRICOM)
		SA1->A1_ULTCOM  := mv_par04
		dbcommit()
		MsUnlock()
	ENDIF
	dbSelectArea("SA1")
	dbskip()
EndDO

/* Contabilizar CTB
dbselectArea("SI2")
dbsetorder(3)
dbseek( xFilial() + dtos(mv_par04) + "7500" )
if _nvalTot > 0 .and. eof()
	recLock("SI2",.T.)
	SI2->I2_FILIAL := "01"
	SI2->I2_NUM    := "7500001"
	SI2->I2_LINHA  := "01"
	SI2->I2_DATA   := mv_par03
	SI2->I2_DC     := "X"
	SI2->I2_MOEDAS := "SNNNN"
	SI2->I2_VALOR  := _nvalTot
	SI2->I2_DTVENC := mv_par03
	SI2->I2_ROTINA := "RFINA04"
	SI2->I2_PERIODO:= _cPeriodo
	SI2->I2_ORIGEM := "L.GER P/RFINA04"
	SI2->I2_FILORIG:= "01"
	SI2->I2_DEBITO := "1123010001"
	SI2->I2_CREDITO:= "3111040001"
	SI2->I2_HIST   := "PROVISAO REFERENTE AO MES " + strzero(mv_par01) + "/" + strzero(mv_par02)
	MsUnlock()
endif
*/

DbSelectArea("SX6")
dbseek(xfilial()+"MV_NUMBORR")
if !eof()
	reclock("SX6",.F.)
	SX6->X6_CONTEUD :=  strzero( cNumborr, 6)
	MSunlock()
endif

//ATUALIZA-SE O SEE
dbSelectArea("SEE")  //GERANDO Contas a receber
if dbseek( xFilial("SEE")+MV_PAR08+MV_PAR09+MV_PAR10+MV_PAR11 )
	RecLock("SEE",.F.)
	SEE->EE_ULTDSK := strzero(val(SEE->EE_ULTDSK)+1,6)
	MsUnlock()
Endif

IF VAL( nSeq ) > 2

	dbSelectArea("HEAD")  //GERANDO REGISTRO HEADER
	RecLock("HEAD",.T.)
	
	HEAD->COD_REGIST  := "0"
	HEAD->CONSTANTE   := "1REMESSA01COBRANCA"
	HEAD->AGE_CEDENT  := mv_par09
	HEAD->ZERO        := "00"
	HEAD->CTA_CEDENT  := mv_par10
	HEAD->DAC         := STR( MODULO10( AllTrim( mv_par09 ) + AllTrim( mv_par10 ) ), 1 )
	HEAD->NOME_CEDEN  := "SINDHOSP-SIND.HOSPITAIS EST SP"
	HEAD->IDENT_BANC  := mv_par08
	HEAD->NOME_BANCO  := "BANCO ITAU SA"
	HEAD->DATA_PROCE  := dEmissao
	HEAD->NUM_SEQUEN  := "000001"
	
	MsUnLock()
	COPY TO HEAD.txt SDF

	dbSelectArea("TRAI")  //GERANDO REGISTRO TRAILLER
	RecLock("TRAI",.T.)
	TRAI->COD_REGIS := "9"
	TRAI->NUM_SEQUEN := strzero(val( nSeq), 6 ) //INCREMENTA()
	MsUnlock()
	COPY TO TRAI.TXT SDF

	dbSelectArea("REGI")	    // Gera Trailler
	Append From HEAD.TXT SDF

	dbSelectArea("DETA")
	DbGotop()
	dbSelectArea("MSG")
	DbGotop()

	Do While !(DETA->(eof()))
		dbSelectArea("DETA")
		COPY NEXT 1 TO DETA.TXT SDF
		dbSelectArea("MSG")
		COPY NEXT 2 TO MSG.TXT SDF
		dbSelectArea("REGI")	  // Gera Detalhes e Mensagem
		Append From DETA.TXT SDF
		Append From MSG.TXT SDF
	EndDo
	
	Append From TRAI.TXT SDF
	ARQ := "\arquivos\associativa\"+MV_PAR06
	COPY TO &arq SDF	    // Copia arq. definitivo
	
ENDIF

@ 96,42 TO 290,405 DIALOG oDlg TITLE "Termino da Geracao"
@ 8,10 TO 73,170
@ 23,22 SAY "Registros Gerados"
@ 23,95 GET nRegistros PICTURE "@E 999,999" WHEN .F.
@ 38,22 SAY "Registros Incluidos"
@ 38,95 GET nIncluidos PICTURE "@E 999,999" WHEN .F.
@ 53,22 SAY "Numero do Bordero "
@ 53,95 GET cNumBord  PICTURE "@E 999999" WHEN .F.
@ 77,078 BMPBUTTON TYPE 1 ACTION Close(oDlg)
ACTIVATE DIALOG oDlg CENTERED

HEAD->( DbCloseArea() )
MSG->( DbCloseArea() )
TRAI->( DbCloseArea() )
DETA->( DbCloseArea() )
REGI->( DbCloseArea() )

FOR nI := 1 TO 5

   cArqTmp := "cArqTmp" + Str( nI, 1 )
	IF FILE( &cArqTmp  + ".DBF")
	 	Ferase( &cArqTmp  + ".DBF")
	EndIf

Next nI

If File("HEAD.TXT")
  	Ferase("HEAD.TXT")
EndIf
If File("DETA.TXT")
  	Ferase("DETA.TXT")
EndIf
If File("MSG.TXT")
//  	Ferase("MSG.TXT")
EndIf
If File("TRAI.TXT")
  	Ferase("TRAI.TXT")
EndIf

dbSelectArea("SA1")
dbSetOrder(1)

return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao    ³ MODULO10()  ³ Autor ³ Flavio Novaes    ³ Data ³ 03/02/2005 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao ³ Impressao de Boleto Bancario do Banco Itau com Codigo de   ³±±
±±³           ³ Barras, Linha Digitavel e Nosso Numero.                    ³±±
±±³           ³ Baseado no Fonte TBOL001 de 01/08/2002 de Raimundo Pereira.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ FINANCEIRO                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC FUNCTION Modulo10(cData)
LOCAL L,D,P := 0
LOCAL B     := .F.
L := Len(cData)
B := .T.
D := 0
WHILE L > 0
	P := VAL(SUBSTR(cData, L, 1))
	IF (B)
		P := P * 2
		IF P > 9
			P := P - 9
		ENDIF
	ENDIF
	D := D + P
	L := L - 1
	B := !B
ENDDO
D := 10 - (Mod(D,10))
IF D = 10
	D := 0
ENDIF
RETURN(D)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NoAccent  ºAutor  ³       Nava         º Data ³  03/Nov/07  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para transformar texto acentuado em NAO acentuado    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Generico                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

STATIC Function NoAccent( cText )

cText := STRTRAN( cText, CHR(198 ), "a" )
cText := STRTRAN( cText, CHR(228 ), "o" )
cText := STRTRAN( cText, CHR(160 ), "a" )
cText := STRTRAN( cText, CHR(130 ), "e" )
cText := STRTRAN( cText, CHR(161 ), "i" )
cText := STRTRAN( cText, CHR(162 ), "o" )
cText := STRTRAN( cText, CHR(163 ), "u" )
cText := STRTRAN( cText, CHR(133 ), "a" )
cText := STRTRAN( cText, CHR(138 ), "e" )
cText := STRTRAN( cText, CHR(141 ), "i" )
cText := STRTRAN( cText, CHR(149 ), "o" )
cText := STRTRAN( cText, CHR(151 ), "u" )
cText := STRTRAN( cText, CHR(131 ), "a" )
cText := STRTRAN( cText, CHR(136 ), "e" )
cText := STRTRAN( cText, CHR(140 ), "i" )
cText := STRTRAN( cText, CHR(147 ), "o" )
cText := STRTRAN( cText, CHR(150 ), "u" )
cText := STRTRAN( cText, CHR(199 ), "A" )
cText := STRTRAN( cText, CHR(229 ), "O" )
cText := STRTRAN( cText, CHR(181 ), "A" )
cText := STRTRAN( cText, CHR(144 ), "E" )
cText := STRTRAN( cText, CHR(214 ), "I" )
cText := STRTRAN( cText, CHR(224 ), "O" )
cText := STRTRAN( cText, CHR(233 ), "U" )
cText := STRTRAN( cText, CHR(183 ), "A" )
cText := STRTRAN( cText, CHR(212 ), "E" )
cText := STRTRAN( cText, CHR(222 ), "I" )
cText := STRTRAN( cText, CHR(227 ), "O" )
cText := STRTRAN( cText, CHR(235 ), "U" )
cText := STRTRAN( cText, CHR(182 ), "A" )
cText := STRTRAN( cText, CHR(210 ), "E" )
cText := STRTRAN( cText, CHR(215 ), "I" )
cText := STRTRAN( cText, CHR(226 ), "O" )
cText := STRTRAN( cText, CHR(128 ), "C" )
cText := STRTRAN( cText, CHR(135 ), "c" )

Return cText
