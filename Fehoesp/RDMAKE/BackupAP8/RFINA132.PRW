#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

/*========================*/
  User Function RFINA132()        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
/*========================*/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RFINA132 ³ Autor ³        Nava           ³ Data ³ 14/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorno de Contribuicoes   (Banco Itau)                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs.:     ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

/* Associativa
agencia=> "1874/0409"
conta  => "7710534/6066347"
*/

/* Confederativa
agencia=> "1874/0409"
conta  => "7713319/1066389"
*/

/* Contributiva
agencia=> "1874/0409"
conta  => "1001714"
*/

/* Confederativa / Termos
agencia=> "1874/0409"
conta  => "6713328"
*/

/* Contratos Stas Casas - Natureza = 0327
agencia=> "1874/0409"
conta  => "9721760/0067611"
*/

#DEFINE cTitulo  "Retorno de Contribuicoes do Itau"

LOCAL aArea 	:= GetArea()
LOCAL nOpc     := 0
LOCAL cPerg    := "FIN132"
LOCAL oDlg

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                                       ³
³01       ¦ Sindicato                      C          2                      ³
³02       ¦ Natureza                       C         10                      ³
³03       ¦ Banco                          C          3                      ³
³04       ¦ Agencia                        C          4                      ³
³05       ¦ Conta                          C          7                      ³
³06       ¦ Arq. Bancario      ?           C         30                      ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

Pergunte(cPerg,.T.)

@ 096,042 TO 375,505 DIALOG oDlg TITLE cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a recepcao Bancaria "
@ 033,014 SAY "das cobrancas provindas do Banco ITAU  "

@ 063,014 SAY "CONFIRME PARA INICIAR A IMPORTACAO DE DADOS         "

@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar( oDlg )
@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg)

ACTIVATE DIALOG oDlg CENTERED

RestArea( aArea )

RETURN

/*=========================*/
  Static Function Iniciar( oDlg )
/*=========================*/

Close( oDlg )
Processa( {|| Receber() })

RETURN

/*=========================*/
  Static Function Receber()
/*=========================*/

LOCAL aStru 	:= {}
LOCAL cArqTmp

PRIVATE nTotal		:= 0	 // totalizador de registros
PRIVATE nTotal2	:= 0	 // totalizador de termos confed.
PRIVATE nTotal3	:= 0	 // totalizador avulsos confed.
PRIVATE nTotJur	:= 0	 // totalizador de juros recebidos (associativa)

PRIVATE cArq		:= "\arquivos\retorno\"+ AllTrim( MV_PAR06 )

IF !File( cArq )
	Help(" ",1,"ARRVAZ")
	RETURN
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criando estrutura para arquivo temporario                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

AADD( aStru, { "COD_REGIST"  , "C" , 001 , 0 } )
AADD( aStru, { "CAMPO"       , "C" , 400 , 0 } )

cArqTmp := CriaTrab( aStru, .T. )
DBUSEAREA(.T.,,cArqTmp,"TMP")
dbSelectArea("TMP")

APPEND FROM &cArq SDF
DBGOTOP()

ProcRegua(RECCOUNT(),22,05)

/*
ARQUIVO RETORNO		REGISTRO HEADER	TAMANHO DO REGISTRO = 400Bytes

NOME DO CAMPO			SIGNIFICADO													POSIÇÃO	PICTURE	CONTEÚDO
TIPO DE REGISTRO		IDENTIFICAÇÃO DO REGISTRO HEADER 					001   001	9(01)  	0
CÓDIGO DE RETORNO 	IDENTIFICAÇÃO DO ARQUIVO RETORNO  					002   002 	9(01) 	2
LITERAL DE RETORNO 	IDENTIFICAÇÃO. POR EXTENSO DO TIPO DE MOVIMENTO	003   009 	X(07)	RETORNO
CÓDIGO DO SERVIÇO 	IDENTIFICAÇÃO DO TIPO DE SERVIÇO						010   011	9(02)	01
LITERAL DE SERVIÇO 	IDENTIFICAÇÃO POR EXTENSO DO TIPO DE SERVIÇO		012   026 	X(15)	COBRANCA
AGÊNCIA					AGÊNCIA MANTENEDORA DA CONTA							027   030	9(04)	
ZEROS						COMPLEMENTO DE REGISTRO									031   032	9(02)	"00"
CONTA						NÚMERO DA CONTA CORRENTE DA EMPRESA					033   037	9(05)	
DAC						DÍGITO DE AUTO CONFERÊNCIA AG/CONTA EMPRESA		038   038	9(01)	
BRANCOS  				COMPLEMENTO DO REGISTRO									039   046	X(08)  	
NOME DA EMPRESA 		NOME POR EXTENSO DA "EMPRESA MÃE"  					047   076 	X(30) 	
CÓDIGO DO BANCO 		NÚMERO DO BANCO NA CÂMARA DE COMPENSAÇÃO  		077   079 	9(03)	341
NOME DO BANCO 			NOME POR EXTENSO DO BANCO COBRADOR  				080   094	X(15) 	BANCO ITAU  SA
DATA DE GERAÇÃO 		DATA DE GERAÇÃO DO ARQUIVO 							095   100	9(06) 	DDMMAA
DENSIDADE 				UNIDADE DA DENSIDADE 									101   105 	9(05) 	
UNIDADE DE DENSID. 	DENSIDADE DE GRAVAÇÃO DO ARQUIVO 					106   108	X(03) 	BPI
Nº SEQ. ARQUIVO RET.	NÚMERO SEQÜENCIAL DO ARQUIVO RETORNO 				109   113 	9(05) 	
DATA DE CRÉDITO		DATA DE CRÉDITO DOS LANÇAMENTOS						114   119	9(06)	DDMMAA
BRANCOS					COMPLEMENTO DO REGISTRO									120   394	X(275)	
NÚMERO SEQÜENCIAL		NÚMERO SEQÜENCIAL DO REGISTRO NO ARQUIVO 			395   400	9(06) 	000001

=================================================================================================
02RETORNO01COBRANCA       023700452206        SIND HOS C C S LAB PES ANAL C 341BANCO ITAU S.A.29110701600BPI00001301107                                                                                                                                                                                                                                                                                   000001
10247436373000173023700452206                                 80000000            109800000008             I06291107          80000000            000000000000000020003302436  000000000042000000000000000000000000000000000000000000000000000000000000000000000000000022000000000000000000000000000   30110700000000000000000000000                                                                    B1000002
9201341          000000000000000000000000000000          000000000000000000000000000000                                                  000000000000000000000000000000          000000000000000000000000000000000010000000100000000000200                                                                                                                                                                000003
=================================================================================================

ARQUIVO RETORNO	REGISTRO TRANSAÇÃO	TAMANHO DO REGISTRO = 400 Bytes

NOME DO CAMPO			SIGNIFICADO													POSIÇÃO	PICTURE	CONTEÚDO
TIPO DE REGISTRO		IDENTIFICAÇÃO DO REGISTRO TRANSAÇÃO 				001   001	9(01) 	1
CÓDIGO DE INSCRIÇÃO	IDENTIFICAÇÃO DO TIPO DE INSCRIÇÃO/EMPRESA		002   003	9(02)	01=CPF 02=CNPJ
NÚMERO DE INSCRIÇÃO	NÚMERO DE INSCRIÇÃO DA EMPRESA (CPF/CNPJ)   		004   017	9(14)	
AGÊNCIA					AGÊNCIA MANTENEDORA DA CONTA							018   021	9(04)	
ZEROS						COMPLEMENTO DE REGISTRO									022   023	9(02)	"00"
CONTA						NÚMERO DA CONTA CORRENTE DA EMPRESA					024   028	9(05)	
DAC						DÍGITO DE AUTO CONFERÊNCIA AG/CONTA EMPRESA		029   029	9(01)	
BRANCOS   				COMPLEMENTO DE REGISTRO									030   037 	X(08)	
USO DA EMPRESA 		IDENTIFICAÇÃO DO TÍTULO NA EMPRESA  				038   062	X(25)	NOTA 2
NOSSO NÚMERO 			IDENTIFICAÇÃO DO TÍTULO NO BANCO 					063   070 	9(08)	
BRANCOS 					COMPLEMENTO DO REGISTRO  								071   082	X(12)  	
CARTEIRA 				NUMERO DA CARTEIRA										083   085	9(03)  	NOTA 5
NOSSO NÚMERO			IDENTIFICAÇÃO DO TÍTULO NO BANCO 					086   093 	9(08)	NOTA 3
DAC NOSSO NÚMERO		DAC DO NOSSO NÚMERO										094   094 	9(01)	NOTA 3
BRANCOS 					COMPLEMENTO DO REGISTRO 								095   107	X(13) 	
CARTEIRA					CÓDIGO DA CARTEIRA 										108   108	X(01)  	NOTA 5
CÓD. DE OCORRÊNCIA 	IDENTIFICAÇÃO DA OCORRÊNCIA 							109   110	9(02)	NOTA 17
DATA DE OCORRÊNCIA 	DATA DE OCORRÊNCIA NO BANCO 							111   116	9(06)  	DDMMAA
Nº DO DOCUMENTO 		Nº DO DOCUMENTO DE COBRANÇA (DUPL, NP ETC)		117   126 	X(10)	NOTA 18
NOSSO NÚMERO 			CONFIRMAÇÃO DO NÚMERO DO TÍTULO NO BANCO 			127   134	9(08)	
BRANCOS 					COMPLEMENTO DO REGISTRO									135   146	X(12) 	
VENCIMENTO 				DATA DE VENCIMENTO DO TÍTULO 							147   152	9(06) 	DDMMAA
VALOR DO TÍTULO 		VALOR NOMINAL DO TÍTULO 								153   165	9(11)V9(2)	
CÓDIGO DO BANCO 		NÚMERO DO BANCO NA CÂMARA DE COMPENSAÇÃO 	166   168	9(03)	
AGÊNCIA COBRADORA 	AG. COBRADORA, AG. DE LIQUIDAÇÃO OU BAIXA	169   172 	9(04) 	NOTA 9
DAC AG. COBRADORA 	DAC DA AGÊNCIA COBRADORA 								173   173 	9(01) 	
ESPÉCIE 					ESPÉCIE DO TÍTULO 										174   175	9(02)	NOTA 10
TARIFA DE COBRANÇA	VALOR DA DESPESA DE COBRANÇA							176   188 	9(11)V9(2)	
BRANCOS 					COMPLEMENTO DO REGISTRO  								189   214	X(26) 	
VALOR DO IOF  			VALOR DO IOF A SER RECOLHIDO (NOTAS SEGURO)		215   227	9(11)V9(2)	
VALOR ABATIMENTO		VALOR DO ABATIMENTO CONCEDIDO 						228   240 	9(11)V((2)	NOTA 19
DESCONTOS 				VALOR DO DESCONTO CONCEDIDO 							241   253	9(11)V9(2)	NOTA 19
VALOR PRINCIPAL 		VALOR LANÇADO EM CONTA CORRENTE						254   266	9(11)V9(2)	
JUROS DE MORA/MULTA	VALOR DE MORA E MULTA PAGOS PELO SACADO			267   279 	9(11)V9(2)	
OUTROS CRÉDITOS		VALOR DE OUTROS CRÉDITOS								280  292	9(11)V9(2)	
BRANCOS					COMPLEMENTO DO REGISTRO									293   295	X(03)	
DATA CRÉDITO			DATA DE CRÉDITO DESTA LIQUIDAÇÃO						296   301	9(06)	DDMMAA
INSTR.CANCELADA		CÓDIGO DA INSTRUÇÃO CANCELADA							302   305	9(04)	NOTA 20
BRANCOS					COMPLEMENTO DE REGISTRO									306   324	X(19)	
NOME DO SACADO			NOME DO SACADO												325   354	X(30)	
BRANCOS					COMPLEMENTO DO REGISTRO									355   377	X(23)	
ERROS 					REGISTROS REJEITADOS OU ALEGAÇÃO DO SACADO		378   385	X(08)	NOTA 20
BRANCOS 					COMPLEMENTO DO REGISTRO									386   392	X(07)	
CÓD. DE LIQUIDAÇÃO	MEIO PELO QUAL O TÍTULO FOI LIQUIDADO				393   394	X(02)	NOTA 28
NÚMERO SEQÜENCIAL		NÚMERO SEQÜENCIAL DO REGISTRO NO ARQUIVO 			395   400	9(06)	

ARQUIVO RETORNO	REGISTRO TRAILER	TAMANHO DO REGISTRO = 400 Bytes

NOME DO CAMPO			SIGNIFICADO	POSIÇÃO										PICTURE	CONTEÚDO
TIPO DE REGISTRO		IDENTIFICAÇÃO DO REGISTRO TRAILER 					001   001	9(01) 	9
CÓDIGO DE RETORNO 	IDENTIFICAÇÃO DE ARQUIVO RETORNO 					002   002 	9(01) 	2
CÓDIGO DE SERVIÇO 	IDENTIFICAÇÃO DO TIPO DE SERVIÇO 					003   004	9(02)  	01
CÓDIGO DO BANCO 		IDENTIFICAÇÃO DO BANCO NA COMPENSAÇÃO 				005   007 	9(03)	341
BRANCOS 					COMPLEMENTO DE REGISTRO									008   017	X(10)	
QTDE. DE TÍTULOS 		QTDE. DE TÍTULOS EM COBR. SIMPLES					018   025	9(08)	NOTA 21
VALOR TOTAL  			VR TOTAL DOS TÍTULOS EM COBRANÇA SIMPLES			026   039 	9(12)V9(2)	NOTA 21
AVISO BANCÁRIO 		REFERÊNCIA DO AVISO BANCÁRIO 							040   047	X(08) 	NOTA 22
BRANCOS 					COMPLEMENTO DO REGISTRO 								048   057	X(10) 	
QTDE. DE TÍTULOS 		QTDE DE TÍTULOS EM COBRANÇA/VINCULADA				058   065 	9(08) 	NOTA 21
VALOR TOTAL 			VR TOTAL DOS TÍTULOS EM COBRANÇA/VINCULADA		066   079 	9(12)V9(2)	NOTA 21
AVISO BANCÁRIO 		REFERÊNCIA DO AVISO BANCÁRIO							080   087	X(08) 	NOTA 22
BRANCOS 					COMPLEMENTO DO REGISTRO 								088   177	X(90) 	
QTDE. DE TÍTULOS		QTDE. DE TÍTULOS EM COBR. DIRETA./ESCRITURAL		178   185 	9(08)  	NOTA 21
VALOR TOTAL 			VR TOTAL DOS TÍTULOS EM COBR. DIRETA/ESCRIT.		186   199	9(12)V9(2)	NOTA 21
AVISO BANCÁRIO 		REFERÊNCIA DO AVISO BANCÁRIO 							200   207 	X(08)	NOTA 22
CONTROLE DO ARQUIVO	NÚMERO SEQÜENCIAL DO ARQUIVO RETORNO 				208   212 	9(05) 	
QTDE DE DETALHES 		QUANTIDADE DE REGISTROS DE TRANSAÇÃO				213   220	9(08)	
VLR TOTAL INFORMADO	VALOR DOS TÍTULOS INFORMADOS NO ARQUIVO   		221   234	9(12)V9(2)	
BRANCOS 	COMPLEMENTO DO REGISTRO   												235   394	X(160) 	
NÚMERO SEQÜENCIAL 	NÚMERO SEQÜENCIAL DO REGISTRO NO ARQUIVO			395   400	9(06) 	

*/

IF TMP->COD_REGIST == "0"  //registro Header

	cConta 	:= Rtrim( substr( TMP->CAMPO,32,6 ) )

	IF cConta $ "452206/452222"  // COBRANCA ASSOCIATIVA/ASSOCIATIVA CONFEDERATIVA

		cPeriodo := "20"+substr(TMP->CAMPO,098,2) + substr(TMP->CAMPO,096,2)
		cMes		:= substr(TMP->CAMPO,096,2) + "/" + substr(TMP->CAMPO,098,2)
		cLote		:= "7000"

		//		3  4         5
		//		7890123456789012345678
		//		02RETORNO01COBRANCA       023700452206        SIND HOS C C S LAB PES ANAL C 341BANCO ITAU S.A.11120701600BPI00001121207                                                                                                                                                                                                                                                                                   000001
		//		10247436373000173023700452206                                 00000002            109000000022             I06101207          00000002            000000000000000050023704234  000000000042000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000   11120700000000000000000000000                                                                    B3000002
		//		10247436373000173023700452206                                 00000003            109000000030             I06101207          00000003            000000000000000050023704234  000000000042000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000   11120700000000000000000000000                                                                    B3000003
		//    10247436373000173023700452206        0701299990000            00000000            109000000006             I03111207070129999000000000            30120700000000048003410000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000         00000000000000000000000(TESTE) RODRIGO MOREIRA DOS SA                       14000000         000002
		//    9201341          000000000000000000000000000000          000000000000000000000000000000                                                  000000000000000000000000000000          000000000000000000000000000000000010000000100000000004800                                                                                                                                                                000003

		//		Numero do Titulo na Empresa - Posicao 38
		//		3  4         5
		//		7890123456789012345678
		//		0701299990000 		//             AA0MMCCCC0000
		//		AA		-> ano --> 46,2
		//		MM    -> mes --> 49,2
		//    CCCC	-> substr(SA1->A1_CODASSO,3,4) --> 51,4
		//    0000  -> 0000  -> 46,4
		
		DBSKIP()

		DO WHILE !EOF() .AND. TMP->COD_REGIST == "1"
			IncProc(cTitulo)

			dDataVenc	:= CTOD( SUBSTR(TMP->CAMPO,146,2)+"/"+SUBSTR(TMP->CAMPO,148,2)+"/"+SUBSTR(TMP->CAMPO,150,2))
			nValorTit	:= VAL(  SUBSTR(TMP->CAMPO,152,13) )/100
			dDataCred	:= CTOD( SUBSTR(TMP->CAMPO,295,2)+"/"+SUBSTR(TMP->CAMPO,297,2)+"/"+SUBSTR(TMP->CAMPO,299,2))
         nValCred		:= VAL(  SUBSTR(TMP->CAMPO,253,13) )/100
			nJurosMul 	:= VAL(  SUBSTR(TMP->CAMPO,266,13) )/100
			cCodAssoc   := STRZERO ( VAL ( SUBSTR ( TMP->CAMPO,42, 4 ) ) , 6 )
			cTipoBole   := SUBSTR( TMP->CAMPO, 046,4)
			cTipoOcor   := SUBSTR( TMP->CAMPO, 108,2)
			cPrefixo1   := SUBSTR( TMP->CAMPO, 037,2) + " "
			cE1Num      := SUBSTR( TMP->CAMPO, 040,6)
			cConfeder   := "70000" + SUBSTR( TMP->CAMPO, 062,8)
			nValorTit	:= VAL( SUBSTR(TMP->CAMPO,152,13) )/100
			nValorCred	:= VAL( SUBSTR(TMP->CAMPO,253,13) )/100
			nValorMJur	:= VAL( SUBSTR(TMP->CAMPO,266,13) )/100
			nSaldo		:= nValorTit - nValorCred
			dDataEmi    := CTOD("01"+ "/"+SUBSTR(TMP->CAMPO,112,2)+"/"+SUBSTR(TMP->CAMPO,114,2))
			dDataOcor	:= CTOD( SUBSTR(TMP->CAMPO,110,2)+"/"+SUBSTR(TMP->CAMPO,112,2)+"/"+SUBSTR(TMP->CAMPO,114,2))
			dDataMovi	:= CTOD("01"+ "/"+SUBSTR(TMP->CAMPO,148,2)+"/"+SUBSTR(TMP->CAMPO,150,2))			

// REAL  0010226000173200010226

			IF  cTipoOcor == "06" //LIQUIDACAO NORMAL
				IF cTipoBole == SPACE(4) //$ "0000" //"8000"   && Boleto Avulso
					Baixa_Avulso( cConfeder, nValorMJur, nValorCred, dDataOcor, nValorTit )
					dbSelectArea("TMP")
					dbskip()
					loop
				Endif
				if cTipoBole == "0000" //<> "8000"   && Boleto Via Remessa
					dbSelectArea("SA1")
					dbSetOrder(8)
					dbseek( xFilial("SA1") + cCodAssoc )
					if eof()
						dbSetOrder(8) // Atencao (UPDXFUN).
						dbSelectArea("TMP")
						dbskip()
						loop
					endif
					dbSelectArea("SE1")  //GERANDO Contas a receber
					dbSetOrder(1) //// E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
					if Dbseek( xFilial("SE1")+ cPrefixo1 + cE1Num + "E"+"DP")
						if SE1->E1_STATUS <> "B"
							Baixa_Promo()
						endif
						dbSelectArea("TMP")
						dbskip()
						loop
					EndIf
//					dbseek( xFilial()+substr( TMP->CAMPO,46,2)+" "+substr(TMP->CAMPO,49,6)+" "+"DP")
					Dbseek( xFilial("SE1")+ cPrefixo1 + cE1Num + " "+"DP")
					_nRecno:= recno()
					cPrefixo2 := " "
					if SE1->E1_STATUS == "B"
//						dbseek( xFilial()+substr( TMP->CAMPO,46,2)+" "+substr(TMP->CAMPO,49,6)+" "+"DP")
						Dbseek( xFilial("SE1")+ cPrefixo1 + cE1Num + " "+"DP")
						if eof()
							_cPrefixo2 := "D"
						else
							dbgoto( _nRecno )
						endif
					endif
					_lMovimenta := .T.
				ELSE
					DBSELECTAREA("SE1")
					dbordernickname("25")
					dbseek( xFilial("SE1")+ cConfeder )
				ENDIF

				IF EOF() .AND. cTipoBole <>"8000"
					RecLock("SE1",.T.)

					SE1->E1_FILIAL   	:= xFilial("SE1")
					SE1->E1_PREFIXO  	:= cPrefixo1 + cPrefixo2
					SE1->E1_NUM      	:= GETSXENUM("SE1","E1_NUM") //substr(TMP->CAMPO,49,6)
					SE1->E1_PARCELA  	:= ""
					SE1->E1_TIPO     	:= "DP"
					SE1->E1_NATUREZ  	:= RTRIM( MV_PAR02 )
					SE1->E1_CLIENTE  	:= SA1->A1_COD
					SE1->E1_SINDICA  	:= IIF( ! EMPTY( SA1->A1_SINDICA ), SA1->A1_SINDICA, MV_PAR01 )
					SE1->E1_CODASSO  	:= SA1->A1_CODASSO
					SE1->E1_CGC	 		:= SA1->A1_CGC
					SE1->E1_CATEG1	 	:= SA1->A1_CATEG1
					SE1->E1_ERSIN	 	:= SA1->A1_ERSIN
					SE1->E1_LOJA     	:= SA1->A1_LOJA
					SE1->E1_NOMCLI	 	:= SA1->A1_NOME
					SE1->E1_EMISSAO  	:= dDataEmi
					SE1->E1_VENCTO   	:= dDataVenc
					SE1->E1_VENCREA  	:= DataValida( dDataVenc, .T. )
					SE1->E1_VALOR    	:= nValorTit
					SE1->E1_DTCRED  	:= dDataCred
					SE1->E1_VALCRED  	:= nValorCred
					SE1->E1_EMIS1    	:= dDataEmi
					SE1->E1_SALDO    	:= IF( nSaldo <0, 0, nSaldo )
					SE1->E1_VLCRUZ   	:= nValorTit
					SE1->E1_VALJUR   	:= 1
					SE1->E1_VENCORI  	:= dDataVenc
					SE1->E1_MOEDA    	:= 1
					SE1->E1_HIST     	:= "Ref.Contr.Assoc. de "+DTOC( dDataMovi )

					//APOS BORDERO
					SE1->E1_PORTADO 	:= Rtrim( MV_PAR03 )
					SE1->E1_AGEDEP	 	:= Rtrim( MV_PAR04 ) // 1874
					SE1->E1_CONTA   	:= Rtrim( MV_PAR05 )//"7710534"
					SE1->E1_MOVIMEN 	:= dDataMovi
					SE1->E1_SITUACA 	:= "1"
					SE1->E1_OCORREN 	:= "01"
					SE1->E1_ORIGEM  	:= "FINA040"
					SE1->E1_STATUS  	:= "B"
					SE1->E1_JUROS	 	:= nValorMJur
					SE1->E1_VALLIQ	 	:= nValorCred
					SE1->E1_BAIXA   	:= dDataOcor
					SE1->E1_OK			:= CHR(69)+CHR (120)
					SE1->E1_ARQBCO  	:= MV_PAR06
					SE1->E1_CONFED		:= cConfeder

					nTotal				+= nValorCred
					nTotJur				+= nValorMJur
					MsUnlock()

				elseif SE1->E1_SALDO == 0
					_lMovimenta := .f.
				else

					DBSELECTAREA("SE1")
					Reclock( "SE1",.F.)

					SE1->E1_STATUS  := "B"

					IF SE1->E1_VALOR == 0
						SE1->E1_VALOR := nValorTit
					ENDIF

					SE1->E1_JUROS	 	:= nValorMJur
					SE1->E1_VALLIQ	 	:= nValorCred
					SE1->E1_BAIXA   	:= dDataOcor
					SE1->E1_SALDO    	:= IF( nSaldo <0, 0, nSaldo )
					SE1->E1_OK			:= CHR(69)+CHR (120)
					SE1->E1_ARQBCO  	:= MV_PAR06
					SE1->E1_CONFED		:= cConfeder
					SE1->E1_DTCRED  	:= dDataCred
					SE1->E1_VALCRED  	:= nValorCred
					nTotal				+= nValorCred
					MsUnlock()

				ENDIF
				DBSELECTAREA("SE5")

				IF nValorMJur > 0 .and. _lMovimenta

					RECLOCK("SE5",.T.)

					SE5->E5_FILIAL  := xFilial()
					SE5->E5_DATA    := dDataCred
					SE5->E5_TIPO    := "DP"
					SE5->E5_VALOR   := nValorTit
					SE5->E5_NATUREZ := RTRIM( MV_PAR02 )
					SE5->E5_BANCO   := Rtrim( MV_PAR03 )
					SE5->E5_AGENCIA := Rtrim( MV_PAR04 )//1874
					SE5->E5_CONTA   := Rtrim( MV_PAR05 )//"7710534"
					SE5->E5_RECPAG  := "R"
					SE5->E5_BENEF   := SA1->A1_NREDUZ
					SE5->E5_HISTOR  := "Juros s/Receb.Titulo"
					SE5->E5_TIPODOC := "JR"
					SE5->E5_VLMOED2 := nValorCred
					SE5->E5_LA      := "N"
					SE5->E5_NUMERO  := "1"
					SE5->E5_CLIFOR  := SA1->A1_COD
					SE5->E5_LOJA    := SA1->A1_LOJA
					SE5->E5_DTDIGIT := dDataCred
					SE5->E5_MOTBX   := "NOR"
					SE5->E5_SEQ     := "01"
					SE5->E5_PREFIXO := cPrefixo1 + cPrefixo2
					SE5->E5_NUMERO  := SE1->E1_NUM
					SE5->E5_DTDISPO := dDataCred
					MsUnlock()
				endif
				if _lMovimenta
					RECLOCK("SE5",.T.)

					SE5->E5_FILIAL  := xFilial()
					SE5->E5_DATA    := dDataCred
					SE5->E5_TIPO    := "DP"
					SE5->E5_VALOR   := nValorTit
					SE5->E5_NATUREZ := RTRIM( MV_PAR02 )
					SE5->E5_BANCO   := Rtrim( MV_PAR03 )
					SE5->E5_AGENCIA := Rtrim( MV_PAR04 )// 1874
					SE5->E5_CONTA   := Rtrim( MV_PAR05 )//"7710534"
					SE5->E5_RECPAG  := "R"
					SE5->E5_BENEF   := SA1->A1_NREDUZ
					SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
					SE5->E5_TIPODOC := "VL"
					SE5->E5_VLMOED2 := nValorCred
					SE5->E5_LA      := "N"
					SE5->E5_NUMERO  := "1"
					SE5->E5_CLIFOR  := SA1->A1_COD
					SE5->E5_LOJA    := SA1->A1_LOJA
					SE5->E5_DTDIGIT := dDataCred
					SE5->E5_MOTBX   := "NOR"
					SE5->E5_SEQ     := "01"
					SE5->E5_PREFIXO := cPrefixo1 + cPrefixo2
					SE5->E5_NUMERO  := SE1->E1_NUM
					SE5->E5_DTDISPO := dDataCred
					MsUnlock()
				endif
			endif
			dbSelectArea("TMP")
			dbskip()
		enddo
//	elseif substr( TMP->CAMPO,32,7) == "7713319" .or. substr( TMP->CAMPO,32,7) == "1001714" .or. substr( TMP->CAMPO,32,7) == "6713328" .or. substr( TMP->CAMPO,32,7) =="9721760" //Cobranca Confederativa/Assistencial
	ELSEIF cConta $ "9721760/7713319/1066389/1001714/6713328/0067611" //Cobranca Confederativa/Contributiva/Contratos

		cPeriodo := "20"+substr(TMP->CAMPO,098,2) + substr(TMP->CAMPO,096,2)
		cMes		:= substr(TMP->CAMPO,096,2) + "/" + substr(TMP->CAMPO,098,2)
		cLote	:= iif( cConta $ "7713319/1066389/6713328", "7000","9000")
		cLote	:= iif( cConta $ "9721760/0067611", "7100","9000")

		DBSKIP()

		DBSELECTAREA("TMP")		

		DO WHILE !EOF() .AND. TMP->COD_REGIST == "1"
			IncProc(cTitulo)

			dDataVenc	:= CTOD( SUBSTR(TMP->CAMPO,146,2)+"/"+SUBSTR(TMP->CAMPO,148,2)+"/"+SUBSTR(TMP->CAMPO,150,2))
			nValorTit	:= VAL(  SUBSTR(TMP->CAMPO,152,13) )/100
			dDataCred	:= CTOD( SUBSTR(TMP->CAMPO,295,2)+"/"+SUBSTR(TMP->CAMPO,297,2)+"/"+SUBSTR(TMP->CAMPO,299,2))
         nValCred		:= VAL(  SUBSTR(TMP->CAMPO,253,13) )/100
			nJurosMul 	:= VAL(  SUBSTR(TMP->CAMPO,266,13) )/100
			cCodAssoc   := STRZERO ( VAL ( SUBSTR ( TMP->CAMPO,51, 4 ) ) , 6 )
			cTipoBole   := SUBSTR( TMP->CAMPO, 046,4)
			cTipoOcor   := SUBSTR( TMP->CAMPO, 108,2)
			cPrefixo1   := SUBSTR( TMP->CAMPO, 046,2)
			cConfeder   := SUBSTR( TMP->CAMPO, 046,13)
			nValorTit	:= VAL( SUBSTR(TMP->CAMPO,152,13) )/100
			nValorCred	:= VAL( SUBSTR(TMP->CAMPO,253,13) )/100
			nValorMJur	:= VAL( SUBSTR(TMP->CAMPO,266,13) )/100
			nSaldo		:= nValorTit - nValorCred
			dDataEmi    := CTOD("01"+ "/"+SUBSTR(TMP->CAMPO,112,2)+"/"+SUBSTR(TMP->CAMPO,114,2))
			dDataOcor	:= CTOD( SUBSTR(TMP->CAMPO,110,2)+"/"+SUBSTR(TMP->CAMPO,112,2)+"/"+SUBSTR(TMP->CAMPO,114,2))

			if  cTipoOcor == "06" //LIQUIDACAO NORMAL
				_cCGC  := ""
				_dVENC := ctod("")
				_nPREF := ""
				_nPARC := ""
				dbSelectArea("SZ9")
				if dbseek( xFilial("SZ9") + cConfeder ) // Num_tit
					_cCGC  := SZ9->Z9_CGC
					_dVenc := SZ9->Z9_VENCTO
					_nPREF := SUBS(SZ9->Z9_PARCELA,1,3)
					_nPARC := substr( SZ9->Z9_PARCELA,4,1)
				else
					_cCGC   := "99"   && Boleto Avulso / Termo
				endif
				if empty( _cCGC )
					dbSelectArea("TMP")
					dbskip()
					loop
				endif
				if _cCGC <> "99"
					dbSelectArea("SA1")
					dbSetOrder(3)
					dbseek( xFilial()+ _cCGC )
					if eof()
						dbSetOrder(1) // Atencao (UPDXFUN).
						dbSelectArea("TMP")
						dbskip()
						loop
					endif
				endif
				dbSelectArea("SE1")  //GERANDO Contas a receber
				dbordernickname("25")
				dbseek( xFilial("SE1") + cConfeder )
				_lMovimenta:=.f.
				if eof() .and. _cCGC <> "99"    && Gera titulo se nao existe (Recepcao normal)
					_lMovimenta := .T.

					RecLock("SE1",.T.)
					SE1->E1_FILIAL   := xFilial()
					SE1->E1_PREFIXO  := _nPREF
					SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
					SE1->E1_PARCELA  := _nPARC
					SE1->E1_TIPO     := "DP"
//					SE1->E1_NATUREZ  := iif( val(_cConta) == 7713319 .or. val(_cConta) == 6713328 ,"002","009")
					SE1->E1_NATUREZ  := iif( cConta $ "7713319/1066389/6713328" ,"002","009")
//					if ( val(_cConta) == 9721760 )
					if ( cConta $ "9721760/0067611" )
						SE1->E1_NATUREZ  := "0327"
					EndIf
					SE1->E1_CLIENTE  	:= SA1->A1_COD
					SE1->E1_SINDICA  	:= IIF( ! EMPTY( SA1->A1_SINDICA ), SA1->A1_SINDICA, MV_PAR01 )
					SE1->E1_CODASSO  	:= SA1->A1_CODASSO
					SE1->E1_CGC	 		:= SA1->A1_CGC
					SE1->E1_CATEG1	 	:= SA1->A1_CATEG1
					SE1->E1_ERSIN	 	:= SA1->A1_ERSIN
					SE1->E1_LOJA     	:= SA1->A1_LOJA
					SE1->E1_NOMCLI	 	:= SA1->A1_NOME
					SE1->E1_EMISSAO  	:= dDataEmi
					SE1->E1_MOVIMEN  	:= dDataMovi
					SE1->E1_EMIS1    	:= dDataEmi
					SE1->E1_VENCTO   	:= _dVenc
					SE1->E1_VENCREA  	:= DataValida( _dVenc )
					SE1->E1_VENCORI  	:= _dVenc
					SE1->E1_HIST     	:= "Ref.Contr. de "+ DTOC( dDataMovi )
					SE1->E1_VALOR    	:= nValorTit
					SE1->E1_DTCRED  	:= dDataCred
					SE1->E1_VALCRED  	:= nValorCred
					SE1->E1_SALDO    	:= 0
					SE1->E1_VLCRUZ   	:= nValorTit
					SE1->E1_VALJUR   	:= 0
					SE1->E1_MOEDA    	:= 1
					//APOS BORDERO
					SE1->E1_PORTADO 	:= MV_PAR03 // "356"
					SE1->E1_AGEDEP  	:= MV_PAR04 // "0409" //1874
					SE1->E1_CONTA   	:= cConta
					SE1->E1_SITUACA 	:= "1"
					SE1->E1_OCORREN 	:= "01"
					SE1->E1_ORIGEM  	:= "RFINA132"
					SE1->E1_STATUS  	:= "B"
					SE1->E1_JUROS   	:= 0
					SE1->E1_VALLIQ  	:= nValorCred
					SE1->E1_BAIXA   	:= dDataOcor
					SE1->E1_OK      	:= CHR(69)+CHR (120)
					SE1->E1_CONFED		:= cConfeder
					SE1->E1_ARQBCO  	:= MV_PAR06

					nTotal				+= SE1->E1_VALLIQ

					MSUNLOCK()
					CONFIRMSX8()

				else
					_altconf:=.f.
					Do While alltrim(SE1->E1_CONFED)== cConfeder .AND. .NOT. EOF()
						tConta:=""	  && Verifica qual conta se refere a baixa
						if alltrim(substr(SE1->E1_PREFIXO,3,1))=="A" .or. substr(SE1->E1_PREFIXO,3,1)==" "
//							_tConta:="7713319"
							tConta:="1066389"
						endif
						if alltrim(substr(SE1->E1_PREFIXO,3,1))=="T"
							tConta:="6713328"
						endif
//						if (val(_cConta) == 9721760)   && Contratos
						if (cConta $ "9721760/0067611")   && Contratos
//							_tConta:="9721760"
							tConta:="0067611"
							_altconf:=.t.
						EndIf
						if val(cConta)==val(tConta)
							_altconf:=.t.
							exit
						endif
						dbskip()
					EndDo
					if _altconf
						Reclock( "SE1",.F.)	&& Altera titulo se existe (Boleto Avulso/Termo)
						SE1->E1_STATUS  := "B"
						SE1->E1_JUROS   := 0
						&& Coloca valor no titulo Confederativa
						if _cCGC=="99"
							SE1->E1_VALOR    := nValorTit
							SE1->E1_SALDO    := 0
							SE1->E1_VLCRUZ   := nValorTit
						endif
						IF SE1->E1_VALOR == 0
							SE1->E1_VALOR    := nValorTit
						ENDIF						
						SE1->E1_SALDO   := SE1->E1_SALDO-nValorTit
						SE1->E1_VALLIQ  := nValorTit
						SE1->E1_BAIXA   := dDataCred
						SE1->E1_OK      := CHR(69)+CHR (120)
						SE1->E1_PORTADO := MV_PAR03 // "356"
						SE1->E1_AGEDEP  := MV_PAR04 // "0409" //1874
						SE1->E1_CONTA   := tConta
						SE1->E1_SITUACA := "1"
						SE1->E1_OCORREN := "01"
						SE1->E1_ORIGEM  := "RFINA132"						
						SE1->E1_CONFED	:= cConfeder
						SE1->E1_ARQBCO  := MV_PAR06
						SE1->E1_DTCRED  	:= dDataCred
						SE1->E1_VALCRED  	:= nValorCred

						if tConta $ "7713319/1066389"
							nTotal += SE1->E1_VALLIQ     && Total de pagtos confed.
						EndIf
						if tConta=="6713328"
							nTotal2 += SE1->E1_VALLIQ    && Total de termos
						EndIf
						if tConta $ "9721760/0067611"
							nTotal3 += SE1->E1_VALLIQ    && Total de contratos Stas Casas
						EndIf
						MsUnlock()
						_lMovimenta:=.t.
					else
						_lMovimenta:=.f.
					endif
				endif
				dbselectArea("SE5")
				if _lMovimenta
					RECLOCK("SE5",.T.)

					SE5->E5_FILIAL  := xFilial("SE5")
					SE5->E5_DATA    := dDataCred
					SE5->E5_TIPO    := "DP"
					SE5->E5_VALOR   := nValorTit
//					SE5->E5_NATUREZ := iif( val(_cConta) == 7713319 .or. val(_cConta) == 6713328,"002","009")
					SE5->E5_NATUREZ := iif( cConta $ "7713319/1066389/6713328" ,"002","009")

//					if ( val(_cConta) == 9721760)
					if ( cConta $ "9721760/0067611" )
						SE5->E5_NATUREZ  := "0327"
					EndIf

					SE5->E5_BANCO   := MV_PAR03
					SE5->E5_AGENCIA := MV_PAR04 //"0409" //1874
					SE5->E5_CONTA   := MV_PAR05 //"6066347" //"7710534"
					SE5->E5_RECPAG  := "R"
					SE5->E5_BENEF   := SA1->A1_NREDUZ
					SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
					SE5->E5_TIPODOC := "VL"
					SE5->E5_VLMOED2 := nValorCred
					SE5->E5_LA      := "N"
					SE5->E5_CLIFOR  := SA1->A1_COD
					SE5->E5_LOJA    := SA1->A1_LOJA
					SE5->E5_DTDIGIT := dDataCred
					SE5->E5_MOTBX   := "NOR"
					SE5->E5_SEQ     := "01"
					SE5->E5_PREFIXO := _nPREF
					SE5->E5_NUMERO  :=  SA1->A1_COD
					SE5->E5_PARCELA := _nPARC
					SE5->E5_DTDISPO := dDataCred
					MsUnlock()

				endif
			endif
			dbSelectArea("TMP")
			dbskip()
		enddo
	endif

/* Falta contabilizar no CTB

	dbselectArea("SI2")
	dbsetorder(3)
	dbseek( xFilial() + dtos(dDataOco) + cLote )
	if _nTotal > 0 .and. eof()
		recLock("SI2",.T.)
		SI2->I2_FILIAL := "01"
		SI2->I2_NUM    := cLote + "001"
		SI2->I2_LINHA  := "01"
		SI2->I2_DATA   := dDataOco
		SI2->I2_DC     := "X"
		SI2->I2_MOEDAS := "SNNNN"
		SI2->I2_VALOR  := _nTotal
		SI2->I2_DTVENC := dDataOco
		SI2->I2_ROTINA := "RFINA12"
		SI2->I2_PERIODO:= cPeriodo
		SI2->I2_ORIGEM := "L.GER P/RFINA12"
		SI2->I2_FILORIG:= "01"
		if cLote == "8000"
			SI2->I2_DEBITO := "1112020001"
			SI2->I2_CREDITO:= "1123010001"
			SI2->I2_HIST	:= "RECEB. DE CONT. ASSOCIATIVA - " + cMes
			if _nTotJur > 0
				MsUnlock()
				recLock("SI2",.T.)
				SI2->I2_FILIAL := "01"                 && Juros recebidos
				SI2->I2_NUM    := cLote + "001"
				SI2->I2_LINHA  := "02"
				SI2->I2_DATA   := dDataOco
				SI2->I2_DC     := "X"
				SI2->I2_MOEDAS := "SNNNN"
				SI2->I2_VALOR  := _nTotJur
				SI2->I2_DTVENC := dDataOco
				SI2->I2_ROTINA := "RFINA12"
				SI2->I2_PERIODO:= cPeriodo
				SI2->I2_ORIGEM := "L.GER P/RFINA12"
				SI2->I2_FILORIG:= "01"
				SI2->I2_DEBITO := "1112020001"
				SI2->I2_CREDITO:= "3111040002"
				SI2->I2_HIST   := "RECEB. DE JUROS CONTR. ASSOC. - " + cMes
			endif
		elseif cLote == "7000"
			SI2->I2_DEBITO := "1112020006"
			SI2->I2_CREDITO:= "3111010001"
			SI2->I2_HIST	:= "RECEB. DE CONT. CONFEDERATIVA - " + cMes
		endif
		MsUnlock()
	endif
	dbselectArea("SI2")
	dbsetorder(3)
	dbseek( xFilial() + dtos(dDataOco) + "7010" )
	if _nTotal2 > 0 .and. eof()
		recLock("SI2",.T.)
		SI2->I2_FILIAL := "01"
		SI2->I2_NUM    := "7010" + "001"
		SI2->I2_LINHA  := "01"
		SI2->I2_DATA   := dDataOco
		SI2->I2_DC     := "X"
		SI2->I2_MOEDAS := "SNNNN"
		SI2->I2_VALOR  := _nTotal2
		SI2->I2_DTVENC := dDataOco
		SI2->I2_ROTINA := "RFINA12"
		SI2->I2_PERIODO:= cPeriodo
		SI2->I2_ORIGEM := "L.GER P/RFINA12"
		SI2->I2_FILORIG:= "01"
		
		SI2->I2_DEBITO := "1112020007"
		SI2->I2_CREDITO:= "3111010001"
		SI2->I2_HIST   := "RECEB. DE CONT. CONFED.Termos - " + cMes
		
		MsUnlock()
	endif
	
	
	dbselectArea("SI2")
	dbsetorder(3)
	dbseek( xFilial() + dtos(dDataOco) + "7100" )
	
	if _nTotal3 > 0 .and. eof()
		
		recLock("SI2",.T.)
		SI2->I2_FILIAL := "01"
		SI2->I2_NUM    := "7100" + "001"
		SI2->I2_LINHA  := "01"
		SI2->I2_DATA   := dDataOco
		SI2->I2_DC     := "X"
		SI2->I2_MOEDAS := "SNNNN"
		SI2->I2_VALOR  := _nTotal3
		SI2->I2_DTVENC := dDataOco
		SI2->I2_ROTINA := "RFINA12"
		SI2->I2_PERIODO:= cPeriodo
		SI2->I2_ORIGEM := "L.GER P/RFINA12"
		SI2->I2_FILORIG:= "01"
		
		SI2->I2_DEBITO := "1112020019"
		SI2->I2_CREDITO:= "3111060012"
		SI2->I2_HIST   := "RECEB. DE Contratos Stas Casas  - " + cMes
		
		MsUnlock()
		
	endif
*/	
endif

dbSelectArea("TMP")
dbCloseArea()

If File(cArqTmp+".DBF")
	Ferase(cArqTmp+".DBF")
EndIf

dbSelectArea("SA1")
dbSetOrder(1)

dbSelectArea("SE1")
dbSetOrder(1)

dbselectArea("SI2")
dbsetorder(1)

// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> __return(nil)
Return(nil)        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04


// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function Baixa_Promo
Static Function Baixa_Promo()

&& Baixa Parcela Promocao

_lMovimenta := .T.

if SE1->E1_SALDO == 0
	_lMovimenta := .f.
else
	Reclock( "SE1",.F.)
	SE1->E1_STATUS  	:= "B"
	SE1->E1_JUROS	 	:= nValorMJur
	SE1->E1_VALLIQ	 	:= nValorCred
	SE1->E1_BAIXA   	:= dDataOcor
	SE1->E1_SALDO    	:= if( nSaldo <0,0, nSaldo)
	SE1->E1_OK       	:= CHR(69)+CHR (120)
	nTotal				+= SE1->E1_VALLIQ
	MsUnlock()
endif

dbselectArea("SE5")

if nValorMJur > 0 .and. _lMovimenta
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial("SE5")
	SE5->E5_DATA    := dDataCred
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := nValorTit
	SE5->E5_NATUREZ := MV_PAR02 //"001"
	SE5->E5_BANCO   := MV_PAR03
	SE5->E5_AGENCIA := MV_PAR04 //"0409" //1874
	SE5->E5_CONTA   := MV_PAR05 //"6066347" //"7710534"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Juros s/Receb.Titulo"
	SE5->E5_TIPODOC := "JR"
	SE5->E5_VLMOED2 := nValorCred
	SE5->E5_LA      := "N"
	SE5->E5_NUMERO  := "1"
	SE5->E5_CLIFOR  := SA1->A1_COD
	SE5->E5_LOJA    := SA1->A1_LOJA
	SE5->E5_DTDIGIT := dDataCred
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := cPrefixo1 +" "
	SE5->E5_NUMERO  := SE1->E1_NUM
	SE5->E5_DTDISPO := dDataCred
	MsUnlock()
endif

IF _lMovimenta
	RECLOCK("SE5",.T.)

	SE5->E5_FILIAL  := xFilial("SE5")
	SE5->E5_DATA    := dDataCred
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := nValorTit
	SE5->E5_NATUREZ := MV_PAR02 //"001"
	SE5->E5_BANCO   := MV_PAR03
	SE5->E5_AGENCIA := MV_PAR04 //"0409" //1874
	SE5->E5_CONTA   := MV_PAR05 //"6066347" //"7710534"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Juros s/Receb.Titulo"
	SE5->E5_TIPODOC := "VL"
	SE5->E5_VLMOED2 := nValorCred
	SE5->E5_LA      := "N"
	SE5->E5_NUMERO  := "1"
	SE5->E5_CLIFOR  := SA1->A1_COD
	SE5->E5_LOJA    := SA1->A1_LOJA
	SE5->E5_DTDIGIT := dDataCred
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := cPrefixo1 +" "
	SE5->E5_NUMERO  := SE1->E1_NUM
	SE5->E5_DTDISPO := dDataCred

	MsUnlock()
ENDIF

/* Desabilitado por Nava / Nilton - 20/09/07
// Baixa Parcelas Anteriores

dbselectArea("SE1")
dbSetOrder(19)

DbSeek(xfilial()+SA1->A1_CODASSO)

Do While SE1->E1_CODASSO==SA1->A1_CODASSO .and. .not. (eof())
	
	if val(SE1->E1_NATUREZ)<>1
		DbSkip()
		Loop
	EndIf
	
	if SE1->E1_BAIXA<>CTOD(space(8))
		DbSkip()
		Loop
	EndIf
	
	if alltrim(SE1->E1_PREFIXO)=="01" .and. val(substr(SE1->E1_NUM,1,2))>7
		DbSkip()
		Loop
	EndIf
	
	if val(SE1->E1_PREFIXO)<95 .and. val(SE1->E1_PREFIXO)>1
		DbSkip()
		Loop
	EndIf
	
	Reclock( "SE1",.F.)
	SE1->E1_STATUS  := "B"
	SE1->E1_BAIXA   := ctod(substr(TMP->CAMPO,110,2)+"/"+substr(TMP->CAMPO,112,2)+"/"+substr(TMP->CAMPO,114,2))
	SE1->E1_SALDO   := 0
	SE1->E1_VALLIQ  := 0.00
	SE1->E1_OK      := CHR(69)+CHR(120)
	SE1->E1_HIST    := "Baixa por pagto Promocao 07/2001"
	MsUnlock()
	
	DbSkip()
	
EndDo
*/

return(nil)



// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function Baixa_Avulso
Static Function Baixa_Avulso( cConfeder, nValorMJur, nValorCred, dDataOcor, nValorTit, cPrefixo1 )

dbSelectArea("SE1")  //GERANDO Baixa para Boleto avulso Associativa (se houver)
dbordernickname("25")
dbseek( xFilial("SE1")+ cConfeder )
_lMovimenta:=.f.

Do While SE1->E1_CONFED==cConfeder .and. SE1->E1_NATUREZ<>"001" .and. .not. eof()
	DbSkip()
EndDo

IF EOF() .OR. SE1->E1_CONFED <> cConfeder
	
		@ 96,42 TO 290,405 DIALOG oDlg1 TITLE "ERRO!"
		@ 8,10 TO 68,170
		@ 23,22 SAY "Titulo Avulso nao encontrado: "
		@ 33,22 SAY cConfeder
		@ 77,078 BMPBUTTON TYPE 1 ACTION Close(oDlg1)
		ACTIVATE DIALOG oDlg1 CENTERED
	
	&&   _nTotal:= _nTotal + val( substr(TMP->CAMPO,253,13))/100
	&&   _nTotJur:= _nTotJur + val( substr(TMP->CAMPO,266,13))/100
	
elseif SE1->E1_SALDO == 0	 && Baixa Avulso se nao estiver ja baixado
	_lMovimenta := .f.
else

	Reclock( "SE1",.F.)
	SE1->E1_STATUS  := "B"
	SE1->E1_JUROS    := nValorMJur
	IF SE1->E1_VALOR == 0
		SE1->E1_VALOR    	:= nValorTit
	endif
	SE1->E1_VALLIQ   	:= nValorCred
	SE1->E1_BAIXA   	:= dDataOcor
	SE1->E1_SALDO    	:= if( nSaldo <0,0, nSaldo)
	SE1->E1_ARQBCO  	:= MV_PAR06
	SE1->E1_OK       	:= CHR(69)+CHR (120)
	nTotal				+= SE1->E1_VALLIQ
	MsUnlock()
endif

dbselectArea("SE5")

if nValorMJur > 0 .and. _lMovimenta
	RECLOCK("SE5",.T.)
	
	SE5->E5_FILIAL  := xFilial("SE5")
	SE5->E5_DATA    := dDataCred
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := nValorTit
	SE5->E5_NATUREZ := MV_PAR02 //"001"
	SE5->E5_BANCO   := MV_PAR03
	SE5->E5_AGENCIA := MV_PAR04 //"0409" //1874
	SE5->E5_CONTA   := MV_PAR05 //"6066347" //"7710534"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Juros s/Receb.Titulo"
	SE5->E5_TIPODOC := "JR"
	SE5->E5_VLMOED2 := nValorCred
	SE5->E5_LA      := "N"
	SE5->E5_NUMERO  := "1"
	SE5->E5_CLIFOR  := SA1->A1_COD
	SE5->E5_LOJA    := SA1->A1_LOJA
	SE5->E5_DTDIGIT := dDataCred
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := cPrefixo1 +" "
	SE5->E5_NUMERO  := SE1->E1_NUM
	SE5->E5_DTDISPO := dDataCred

	MsUnlock()
endif

if _lMovimenta
	recLock("SE5",.T.)
	SE5->E5_FILIAL  := xFilial("SE5")
	SE5->E5_DATA    := dDataCred
	SE5->E5_TIPO    := "DP"
	SE5->E5_VALOR   := nValorTit
	SE5->E5_NATUREZ := MV_PAR02 //"001"
	SE5->E5_BANCO   := MV_PAR03
	SE5->E5_AGENCIA := MV_PAR04 //"0409" //1874
	SE5->E5_CONTA   := MV_PAR05 //"6066347" //"7710534"
	SE5->E5_RECPAG  := "R"
	SE5->E5_BENEF   := SA1->A1_NREDUZ
	SE5->E5_HISTOR  := "Juros s/Receb.Titulo"
	SE5->E5_TIPODOC := "VL"
	SE5->E5_VLMOED2 := nValorCred
	SE5->E5_LA      := "N"
	SE5->E5_NUMERO  := "1"
	SE5->E5_CLIFOR  := SA1->A1_COD
	SE5->E5_LOJA    := SA1->A1_LOJA
	SE5->E5_DTDIGIT := dDataCred
	SE5->E5_MOTBX   := "NOR"
	SE5->E5_SEQ     := "01"
	SE5->E5_PREFIXO := cPrefixo1 +" "
	SE5->E5_NUMERO  := SE1->E1_NUM
	SE5->E5_DTDISPO := dDataCred

	MsUnlock()
endif

return(nil)
