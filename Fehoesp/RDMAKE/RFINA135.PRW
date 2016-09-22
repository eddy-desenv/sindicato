#include "rwmake.ch"

User Function RFINA135()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RFINA135 ³ Autor ³        Nava           ³ Data ³ 15/01/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envio de Contribuicoes Asociativa E Confederativa  (ITAU)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP - Carteira 112                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs.:     ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
LOCAL aArea 	:= GetArea()
LOCAL cTitulo  := "Envio da Cobranca Associativa para o Itau"
LOCAL nOpc     := 0
LOCAL oDlg
LOCAL cNumBord := Strzero( Val( GETMV("MV_NUMBORR") ) + 1, 6 )

PRIVATE cPerg    := "FINA35"
PRIVATE _nRegistros := 0, _nIncluidos := 0, c_bordero   := "", _cTitulo := cTitulo

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                                       ³
³ mv_par01   // Mes para envio                                               ³
³ bbbbbbbbbb02   // ano para envio                                               ³
³ mv_par03   // Data de vencimento                                           ³
³ ;;mv_par04   // Sequencia       															  ³
³ MV_PAR04   // arquivo de saida := "H:\BCOREAL\ASSOC"+strzero(MES,2)+".txt" ³
³ MV_PAR05   // Sindicato de Hospitais
³ MV_PAR06   // Natureza              
³ MV_PAR07   // codigo do Banco                                              ³
³ MV_PAR08   // codigo da agencia                                            ³
³ MV_PAR09   // codigo da conta                                              ³
³ MV_PAR10   // codigo da subconta                                           ³
³ MV_PAR11   // Mensagem Linha 01                                            ³
³ MV_PAR12   // Mensagem Linha 02                                            ³
³ MV_PAR13   // Mensagem Linha 03                                            ³
³ MV_PAR14   // Mensagem Linha 04                                            ³
³ MV_PAR15   // Mensagem Linha 05                                            ³
³ MV_PAR16   // Da Data Inicio Sind. ?                                      ³
³ MV_PAR17   // Da Data Final  Sind. ?                                      ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Pergunte(cPerg,.T.)

@ 096,042 TO 375,505 DIALOG oDlg TITLE cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a geracao de Arquivo para cobranca da "
@ 033,014 SAY "Contribuicao Associativa E Confederativa no ITAU"
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

Processa( {|| Gerar(cNumBord) })

Return

/*=========================*/
   Static Function Gerar(cNumBord)
/*=========================*/

LOCAL aStru := {}
LOCAL cVencim 		:= strzero(day(mv_par03),2)+strzero(month(mv_par03),2)+strzero(val(substr(str(year(mv_par03),4),3,2)),2)
LOCAL cEmissao 	:= strzero(day(dDataBase),2)+strzero(month(dDataBase),2)+strzero(val(substr(str(year(dDataBase),4),3,2)),2)
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
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ARQUIVO REMESSA	REGISTRO HEADER	TAMANHO DO REGISTRO = 400 Bytes                          		³
//³                                                                                        				³
//³NOME DO CAMPO			SIGNIFICADO	POSIÇÃO   	PICTURE	CONTEÚDO                               		³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DE  REGISTRO		IDENTIFICAÇÃO DO REGISTRO HEADER			 	001   001	9(01)		0        		³
//³OPERAÇÃO 				TIPO DE OPERAÇÃO - REMESSA						002   002	9(01) 	1        		³
//³LITERAL DE REMESSA	IDENTIFICAÇÃO POR EXTENSO DO MOVIMENTO 	003   009	X(07) 	REMESSA  		³
//³CÓDIGO DO SERVIÇO 	IDENTIFICAÇÃO DO TIPO DE SERVIÇO				010   011	9(02) 	01       		³
//³LITERAL DE SERVIÇO 	IDENTIFICAÇÃO POR EXTENSO DO SERVIÇO		012   026	X(15) 	COBRANCA 		³
//³AGÊNCIA					AGÊNCIA MANTENEDORA DA CONTA					027   030	9(04)	            		³
//³ZEROS						COMPLEMENTO DE REGISTRO							031   032	9(02)		"00"     		³
//³CONTA						NÚMERO DA CONTA CORRENTE DA EMPRESA			033   037	9(05)	            		³
//³DAC						DÍGITO DE AUTO CONFERÊNCIA AG/CONTA 		038   038	9(01)	            		³
//³BRANCOS 					COMPLEMENTO DO REGISTRO 						039   046	X(08)  	         		³
//³NOME DA EMPRESA 		NOME POR EXTENSO DA "EMPRESA MÃE" 			047   076	X(30)  	         		³
//³CÓDIGO DO BANCO 		Nº DO BANCO NA CÂMARA DE COMPENSAÇÃO		077   079	9(03)  	341      		³
//³NOME DO BANCO			NOME POR EXTENSO DO BANCO COBRADOR 			080   094	X(15) 	BANCO ITAU SA  ³
//³DATA DE GERAÇÃO		DATA DE GERAÇÃO DO ARQUIVO 					095   100	9(06)		DDMMAA         ³
//³BRANCOS 					COMPLEMENTO DO REGISTRO							101   394	X(294)	               ³
//³NÚMERO SEQÜENCIAL 	NÚMERO SEQÜENCIAL DO REGISTRO NO ARQUIVO 	395   400	9(06) 	000001         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
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

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ARQUIVO REMESSA		REGISTRO DETALHER	TAMANHO DO REGISTRO = 400 Bytes                        		³
//³                                                                                        				³
//³NOME DO CAMPO			SIGNIFICADO	POSIÇÃO   	PICTURE	CONTEÚDO                               		³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DE  REGISTRO		IDENTIFICAÇÃO DO REGISTRO HEADER			 	001   001	9(01)		0        		³
//³CÓDIGO DE LAYOUT 		IDENTIFICAÇÃO DO LAYOUT PARA O REGISTRO 	002   002 	9(01)		1        		³
//³AGÊNCIA					AGÊNCIA MANTENEDORA DA CONTA					003   006	9(04)	        				³
//³ZEROS						COMPLEMENTO DE REGISTRO							007   008	9(02)		"00"        	³
//³CONTA						NÚMERO DA CONTA CORRENTE DA EMPRESA			009   013	9(05)	   					³
//³DAC						DÍGITO DE AUTO CONFERÊNCIA AG/CONTA 		014   014	9(01)	        				³
//³Nº DA CARTEIRA			Nº DA CARTEIRA NO BANCO							015   017	9(03)	        				³
//³NOSSO NÚMERO			IDENTIFICAÇÃO DO TÍTULO NO BANCO				018   025	9(08)	        				³
//³DAC						DAC DO NOSSO NÚMERO								026   026	9(01)		NOTA 23        ³
//³CÓDIGO DA MOEDA 		INDICA SE O VALOR EM REAL OU EM MOEDA 		027   027	9(01)		0 = R$ 1 = VAR ³
//³LITERAL DE MOEDA  	IDENTIF. DA MOEDA A SER IMPRESSA 			028   031	X(04)		NOTA 24        ³
//³VALOR DO TÍTULO		VALOR DO TÍTULO									032   044 	9(11)(2)	(*)        		³
//³SEU NÚMERO				NÚMERO DO DOCUMENTO NA EMPRESA 				045   054 	X(10)		NOTA 18        ³
//³VENCIMENTO 				DATA DE VENCIMENTO DO TÍTULO					055   060 	9(06)		DDMMAA        	³
//³ESPÉCIE 					ESPÉCIE DO TÍTULO 								061   062	X(02)		NOTA 10        ³
//³ACEITE  					IDENTIFICAÇÃO DE TÍTULO ACEITO OU NÃO 		063   063	X(01)		A=SIM ³N=NÃO   ³
//³DATA DE EMISSÃO 		DATA DE EMISSÃO DO TÍTULO						064   069	9(06)		DDMMAA        	³
//³CÓD. DE INSCRIÇÃO		IDENTIFICAÇÃO DE INSCRIÇÃO DO SACADO		070   071	9(02)		01=CPF 02=CNPJ ³
//³Nº DE INSCRIÇÃO		NÚMERO DE INSCRIÇÃO DO SACADO 				072   086	9(15)		CPF OU CNPJ    ³
//³NOME 						NOME DO SACADO										087   116	X(30)	        				³
//³BRANCOS 					COMPLEMENTO DO REGISTRO							117   125	X(09)	        				³
//³LOGRADOURO 				RUA, NÚMERO E COMPLEMENTO DO SACADO			126   165 	X(40)	        				³
//³BAIRRO 					BAIRRO DO SACADO 									166   177	X(12)	        				³
//³CEP 						CÓDIGO DE ENDEREÇAMENTO POSTAL DO SACADO	178   185	9(08)	        				³
//³CIDADE					CIDADE DO SACADO									186   200	X(15)	        				³
//³ESTADO					ESTADO DO SACADO									201   202	X(02)	        				³
//³SACADOR/AVALISTA		NOME DO SACADOR/AVALISTA 						203   232	X(30)	        				³
//³BRANCOS					COMPLEMENTO DE REGISTRO							233   236	X(04)	        				³
//³LOCAL DE PGTO 1		LOCAL PARA PAGAMENTO DO TÍTULO - LINHA 1	237   291	X(55)		NOTA 25        ³
//³LOCAL DE PGTO 2 		LOCAL PARA PAGAMENTO DO TÍTULO - LINHA 2 	292   346	X(55)		NOTA 25        ³
//³CÓD. DE INSCRIÇÃO.	TIPO DE INSCRIÇÃO DO SACADOR/AVALISTA		347   348 	9(02)		01=CPF 02=CNPJ ³
//³Nº DE INSCRIÇÃO		NÚMERO DE INSCRIÇÃO DO SACADOR/AVALISTA	349   363	9(15)	        				³
//³BRANCOS 					COMPLEMENTO DO REGISTRO							364   394	X(31)	        				³
//³NÚM. SEQÜENCIAL 		NÚMERO SEQÜENCIAL DO REGISTRO NO ARQUIVO 	395   400	9(06)	        				³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
AADD( aStru, { "COD_REGIST"  , "C" , 001 , 0 } ) // 6
AADD( aStru, { "COD_LAYOUT"  , "C" , 001 , 0 } ) // 1
AADD( aStru, { "AG_CEDENTE"  , "C" , 004 , 0 } )
AADD( aStru, { "ZERO_1"      , "C" , 002 , 0 } ) // 00
AADD( aStru, { "CT_CEDENTE"  , "C" , 005 , 0 } )
AADD( aStru, { "DAC_AGCONT"  , "C" , 001 , 0 } )
AADD( aStru, { "NUM_CARTEI"  , "C" , 003 , 0 } ) // 173
AADD( aStru, { "NOSSO_NUM"   , "C" , 008 , 0 } ) // 00000000
AADD( aStru, { "DAC_NOSSON"  , "C" , 001 , 0 } )
AADD( aStru, { "COD_MOEDA"   , "C" , 001 , 0 } ) // 0
AADD( aStru, { "LIT_MOEDA"   , "C" , 004 , 0 } ) // 
AADD( aStru, { "VLR_TITULO"  , "C" , 013 , 0 } )
AADD( aStru, { "SEU_NUM"     , "C" , 010 , 0 } ) // 00000000
AADD( aStru, { "DATA_VENC"   , "C" , 006 , 0 } )
AADD( aStru, { "ESPECIE"     , "C" , 002 , 0 } ) // 01 
AADD( aStru, { "ACEITE"      , "C" , 001 , 0 } ) // "N"
AADD( aStru, { "DATA_EMISS"  , "C" , 006 , 0 } )
AADD( aStru, { "COD_INSCRI"  , "C" , 002 , 0 } ) // 02
AADD( aStru, { "CGC_SACADO"  , "C" , 015 , 0 } )
AADD( aStru, { "NOME_SACAD"  , "C" , 030 , 0 } )
AADD( aStru, { "BRANCO2"     , "C" , 009 , 0 } )
AADD( aStru, { "END_SACADO"  , "C" , 040 , 0 } )
AADD( aStru, { "BAIRRO_SAC"  , "C" , 012 , 0 } )
AADD( aStru, { "CEP_SACADO"  , "C" , 008 , 0 } )
AADD( aStru, { "CIDADE_SAC"  , "C" , 015 , 0 } )
AADD( aStru, { "ESTADO_SAC"  , "C" , 002 , 0 } )
AADD( aStru, { "SACADOR"     , "C" , 030 , 0 } )
AADD( aStru, { "BRANCO1"     , "C" , 004 , 0 } )
AADD( aStru, { "LOCAL_1"     , "C" , 055 , 0 } )
AADD( aStru, { "LOCAL_2"     , "C" , 055 , 0 } )
AADD( aStru, { "CPF_OU_CGC"  , "C" , 002 , 0 } ) // 02
AADD( aStru, { "CGC_SINDHO"  , "C" , 015 , 0 } )
AADD( aStru, { "BRANCO3"     , "C" , 031 , 0 } )
AADD( aStru, { "NUM_SEQUEN"  , "C" , 006 , 0 } )

cArqTmp3 := CriaTrab( aStru, .T.)
dbUseArea(.t.,, cArqTmp3,"DETA")
dbSelectArea("DETA")

aStru := {}  //ARQUIVO FINAL
AADD( aStru, { "REGISTRO"  , "C" , 400 , 0 } )
cArqTmp4 := CriaTrab( aStru,.t.)
dbUseArea(.t.,,cArqTmp4,"REGI")
dbSelectArea("REGI")

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ARQUIVO REMESSA		REGISTRO DETALHER	TAMANHO DO REGISTRO = 400 Bytes                        		³
//³                                                                                        				³
//³NOME DO CAMPO			SIGNIFICADO	POSIÇÃO   	PICTURE	CONTEÚDO                               		³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ TIPO DE  REGISTRO		IDENTIFICAÇÃO DO REGISTRO HEADER			 	001   001	9(01)		6        	³
//³ CÓDIGO DE LAYOUT 		IDENTIFICAÇÃO DO LAYOUT PARA O REGISTRO 	002   002 	9(01)		2        	³
//³ LINHA 1						CONTEÚDO DA 1ª LINHA 							003   071	X(69)	NOTA 26     	³
//³ LINHA 2 					CONTEÚDO DA 2ª LINHA 							072   140	X(69)	NOTA 26     	³
//³ LINHA 3						CONTEÚDO DA 3ª LINHA 							141   209	X(69)	NOTA 26     	³
//³ LINHA 4 					CONTEÚDO DA 4ª LINHA 							210   278	X(69)	NOTA 26     	³
//³ LINHA 5						CONTEÚDO DA 5ª LINHA 							279   347	X(69)	NOTA 26     	³
//³ BRANCOS 					COMPLEMENTO DO REGISTRO							364   394	X(47)	        			³
//³ NÚM. SEQÜENCIAL 		NÚMERO SEQÜENCIAL DO REGISTRO NO ARQUIVO 		395   400	9(06)	        			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aStru := {}
AADD( aStru, { "COD_REGIST"  	, "C" , 001 , 0 } ) // 6
AADD( aStru, { "COD_LAYOUT" 	, "C" , 001 , 0 } ) // 2
AADD( aStru, { "LINHA_1" 	   , "C" , 069 , 0 } )
AADD( aStru, { "LINHA_2" 		, "C" , 069 , 0 } )
AADD( aStru, { "LINHA_3"	 	, "C" , 069 , 0 } )
AADD( aStru, { "LINHA_4"	 	, "C" , 069 , 0 } )
AADD( aStru, { "LINHA_5"	 	, "C" , 069 , 0 } )
AADD( aStru, { "BRANCO"    	, "C" , 047 , 0 } )
AADD( aStru, { "NUM_SEQUEN" 	, "C" , 006 , 0 } )
ENDDOC*/

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

	// Rodrigo - Desabilitado porque todas as naturezas jah sao 1.000
/*
	if sa1->a1_catleit $"66/67/68/70/71/72"
		reclock("sa1",.f.)
		sa1->a1_naturez:="1000"
		msunlock()
	endif
*/
	If ! EMPTY( MV_PAR05) .AND. SA1->A1_SINDICA <> MV_PAR05
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	If !EMPTY(SA1->A1_INAT)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	if alltrim(SA1->A1_NATUREZ)<>Rtrim( MV_PAR06 )   && Associativa + Confederativa
		dbSelectArea("SA1")
		dbskip()
		Loop
	EndIf

	IF !EMPTY(MV_PAR16) .AND. SA1->A1_INISIND < MV_PAR16
		dbskip()
		Loop
	EndIf
	
	IF !EMPTY(MV_PAR17) .AND. SA1->A1_INISIND > MV_PAR17
		dbskip()
		Loop
	EndIf

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
		dbSelectArea("SA1")
		dbskip()
		Loop
	Endif
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	RecLock("DETA",.T.)

	DETA->COD_REGIST := "6"
	DETA->COD_LAYOUT := "1"
	DETA->AG_CEDENTE := Rtrim( MV_PAR08 )
	DETA->ZERO_1     := "00"
	DETA->CT_CEDENTE := Rtrim( MV_PAR09 )
	DETA->DAC_AGCONT := STR( MODULO10( AllTrim( MV_PAR08 ) + AllTrim( MV_PAR09 ) ), 1 )
	DETA->NUM_CARTEI := "173"
	DETA->NOSSO_NUM  := strzero(MV_PAR02,2)+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)
	DETA->DAC_NOSSON := STR( MODULO10( AllTrim( MV_PAR08 ) + AllTrim( MV_PAR09 ) + DETA->NUM_CARTEI + DETA->NOSSO_NUM  ), 1 )
	DETA->COD_MOEDA := "0"
	DETA->VLR_TITULO := strzero(val( TABELA("90",SA1->A1_CATLEIT) )*100,13)
	DETA->SEU_NUM    := strzero(MV_PAR02,2)+"0"+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)+"0000"
	DETA->DATA_VENC  := cVencim
	DETA->ESPECIE    := "01"
	DETA->ACEITE     := "N"
	DETA->DATA_EMISS := cEmissao
	DETA->COD_INSCRI := "02"
	DETA->CGC_SACADO := SA1->A1_CGC
	DETA->NOME_SACAD := NoAccent( SA1->A1_NOME   )
	DETA->END_SACADO := NoAccent( SA1->A1_END    )
	DETA->BAIRRO_SAC := NoAccent( SA1->A1_BAIRRO )
	DETA->CEP_SACADO := NoAccent( SA1->A1_CEP    )
	DETA->CIDADE_SAC := NoAccent( SA1->A1_MUN    )
	DETA->ESTADO_SAC := NoAccent( SA1->A1_EST    )
	DETA->SACADOR    := "SINDICATO DOS HOSPITAIS DO EST.SAO PAULO"
	DETA->LOCAL_1    := "ATE O VCTO.,  PAGUE PREFERENCIALMENTE NO ITAU"
	DETA->LOCAL_2    := "APOS O VENCIMENTO, PAGUE SOMENTE NO ITAU"
	DETA->CPF_OU_CGC := "02"
	DETA->CGC_SINDHO := "47436373000173"
	DETA->NUM_SEQUEN := nSeq     //Sequencia

	MsUnlock()

	nSeq					:= strzero( ( VAL( nSeq ) + 1 ), 6 )

	dbSelectArea("MSG")  //GERANDO REGISTRO MENSAGEM
	RecLock("MSG",.T.)

/*
	MSG->COD_REGIST := "6"
	MSG->COD_LAYOUT := "2"
	MSG->LINHA_1	 := NoAccent( MV_PAR11 )
	MSG->LINHA_2	 := NoAccent( MV_PAR )
	MSG->LINHA_3	 := NoAccent( MV_PAR13 )
	MSG->LINHA_4	 := NoAccent( MV_PAR14 )
	MSG->LINHA_5	 := NoAccent( MV_PAR15 )
	MSG->NUM_SEQUEN := nSeq     //Sequencia
	MsUnlock()
*/

	MSG->CODIGO 	 := "7"
	MSG->FLASH		 := "L6L"
	MSG->LINHA_1	 := "01"
	MSG->MENSAGEM_1 := SPACE( 7 ) + PADR( NoAccent( SA1->A1_NOME   ), 60 ) + ;
						     PADR( strzero(MV_PAR02,2)+"0"+strzero(MV_PAR01,2)+substr(SA1->A1_CODASSO,3,4)+"0", 17 ) + ;
						     cVencim
	MSG->LINHA_2	 := "04"
	MSG->MENSAGEM_2 := NoAccent( MV_PAR11 )
	MSG->LINHA_3	 := "06"
	MSG->MENSAGEM_3 := NoAccent( MV_PAR12 )

	MSG->NUM_SEQUEN := nSeq     //Sequencia
	MsUnlock()

	nSeq					:= strzero( ( VAL( nSeq ) + 1 ), 6 )

	RecLock("MSG",.T.)
	MSG->CODIGO 	 := "7"
	MSG->FLASH		 := "L6L"
	MSG->LINHA_1	 := "08"
	MSG->MENSAGEM_1 := NoAccent( MV_PAR13 )
	MSG->LINHA_2	 := "10"
	MSG->MENSAGEM_2 := NoAccent( MV_PAR14 )
	MSG->LINHA_3	 := "12"
	MSG->MENSAGEM_3 := NoAccent( MV_PAR15 )
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
		SE1->E1_NATUREZ  := RTRIM( MV_PAR06 ) //VERIFICAR
		SE1->E1_CLIENTE  := SA1->A1_COD
		SE1->E1_LOJA     := SA1->A1_LOJA
		SE1->E1_NOMCLI   := SA1->A1_NREDUZ
		SE1->E1_EMISSAO  := dDataBase
		SE1->E1_VENCTO   := mv_par03
		SE1->E1_VENCREA  := DataValida( mv_par03,.t.)
		SE1->E1_VALOR    := val( TABELA("90",SA1->A1_CATLEIT) )
		SE1->E1_EMIS1    := dDataBase
		SE1->E1_SITUACA  := "0"
		SE1->E1_SALDO    := val( TABELA("90",SA1->A1_CATLEIT) )
		SE1->E1_VLCRUZ   := val( TABELA("90",SA1->A1_CATLEIT) )
		SE1->E1_VALJUR   := 1
		SE1->E1_VENCORI  := mv_par03
		SE1->E1_MOEDA    := 1
		SE1->E1_HIST     := "Ref.Contr.Assoc. de "+strzero(mv_par01,2)+"/"+strzero(mv_par02,2)
		//APOS BORDERO
		SE1->E1_PORTADO := Rtrim( MV_PAR07 )//"356"
		SE1->E1_AGEDEP  := Rtrim( MV_PAR08 )//"1874"
		SE1->E1_CONTA   := Rtrim( MV_PAR09 )//"5005542"
		SE1->E1_NUMBOR  := strzero(cNumborr,6)  //NUMERO DO BORDERO
		SE1->E1_DATABOR := DDatabase //DATA DO BORDERO
		SE1->E1_MOVIMEN := DDatabase
		SE1->E1_SITUACA := "1"
		SE1->E1_OCORREN := "01"
		SE1->E1_ORIGEM  := "RFINA135"
		SE1->E1_STATUS  := "A"
		SE1->E1_OK      := CHR(56)+CHR (121)
		SE1->E1_CGC     := SA1->A1_CGC
		SE1->E1_CODASSO := SA1->A1_CODASSO
		SE1->E1_CATEG1  := SA1->A1_CATEG1
		SE1->E1_ERSIN   := SA1->A1_ERSIN
		SE1->E1_BASE    := SA1->A1_BASE
		SE1->E1_SINDICA := '01' //SA1->A1_SINDICA

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
		SEA->EA_PORTADO := MV_PAR07 //"356" - Nava
		SEA->EA_AGEDEP  := MV_PAR08 // "1874" - Nava
		SEA->EA_NUMCON  := MV_PAR09 // "7710534" - Nava
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
		SA1->A1_PRICOM  := if(empty(SA1->A1_PRICOM),dDataBase,SA1->A1_PRICOM)
		SA1->A1_ULTCOM  := dDataBase
		dbcommit()
		MsUnlock()
	ENDIF
	dbSelectArea("SA1")
	dbskip()
EndDO

/* Contabilizar CTB
dbselectArea("SI2")
dbsetorder(3)
dbseek( xFilial() + dtos(dDataBase) + "7500" )
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
if dbseek( xFilial("SEE")+MV_PAR07+MV_PAR08+MV_PAR09+MV_PAR10 )
	RecLock("SEE",.F.)
	SEE->EE_ULTDSK := strzero(val(SEE->EE_ULTDSK)+1,6)
	MsUnlock()
Endif

IF VAL( nSeq ) > 2

	dbSelectArea("HEAD")  //GERANDO REGISTRO HEADER
	RecLock("HEAD",.T.)
	
	HEAD->COD_REGIST  := "0"
	HEAD->CONSTANTE   := "1REMESSA01COBRANCA"
	HEAD->AGE_CEDENT  := Rtrim( MV_PAR08 )
	HEAD->ZERO        := "00"
	HEAD->CTA_CEDENT  := Rtrim( MV_PAR09 )
	HEAD->DAC         := STR( MODULO10( AllTrim( MV_PAR08 ) + AllTrim( MV_PAR09 ) ), 1 )
	HEAD->NOME_CEDEN  := "SINDHOSP-SIND.HOSPITAIS EST SP"
	HEAD->IDENT_BANC  := Rtrim( MV_PAR07 )
	HEAD->NOME_BANCO  := "BANCO ITAU SA"
	HEAD->DATA_PROCE  := cEmissao
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
	ARQ := "\arquivos\associativa\"+AllTrim( MV_PAR04 )
	COPY TO &arq SDF	    // Copia arq. definitivo
	
ENDIF

_nRegistros := nRegistros
 _nIncluidos := nIncluidos
c_bordero   := cNumBord

SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "05" ) )
TOTCAD()

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


IF SX5->( DbSeek( xFilial( "SX5" ) + "GR" + "05" ) )
   RecLock( "SX5", .F. )
   SX5->X5_DESCSPA := Strzero( ( Val( SX5->X5_DESCSPA ) + 1 ), 4 )
   MsUnLock() 
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
  	Ferase("MSG.TXT")
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
