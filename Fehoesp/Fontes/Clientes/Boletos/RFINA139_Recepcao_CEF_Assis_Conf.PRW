#include "rwmake.ch"

User Function RFINA139()
SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,_CLOTE,N_OPC,CPERG")
SetPrvt("C_BORDERO,_CARQ,_NTOTAL,_NTOTAL2,_ASTRU,C_ARQTMP")
SetPrvt("_DATAPROC,_CPERIODO,_CCONTA,_CCGC,_DVENC,_NPREF")
SetPrvt("_NPARC,_LMOVIMENTA,_ALTCONF,")
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RFINA09  ³ Autor ³ Luiz E. D. Roz        ³ Data ³ 24/04/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorno de Contribuicoes   (Banco CEF)                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs.:     ³ E' atualizado os arquivo SE1, SEA                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
* Banco = 104
/* Assistencial
agencia=> "9999"
conta  => "999999"
*/
/* Termos
agencia=> "0242"
conta  => "00000973" -4 ( DIGITO NAO USADO )
*/
** Definir parametros p/ Baixa Termos
_oldArea  := alias()
_oldOrder := indexord()
_cTitulo   := "Retorno de Contribuicoes - Banco CEF"
_cLote:=""
n_Opc := 0
cPerg    := "FINA39"
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                                       ³
³ mv_par01   // Arquivo de entrada                                           ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Pergunte(cPerg,.T.)
C_BORDERO := ""
@ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a recepcao Bancaria das cobrancas "
@ 033,014 SAY "vindas pelo Banco Bradesco"
@ 063,014 SAY "CONFIRME PARA INICIAR A IMPORTACAO DE DADOS         "
@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar()
@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED
Return
***************************
Static Function Iniciar()
Close(oDlg1)
Processa( {|| Receber() })
Return
***************************
Static Function Receber()

/*

Header e Trailer do Arquivo

Registro Header de Arquivo

Campo                                                  Posição  Nº  Nº Formato Default Descricao
                                                        De Até Dig Dec 

01.0 Banco Código do Banco na Compensação 1 3 3 - Num ‘104’ G001
02.0 Lote Lote de Serviço 4 7 4 - Num '0000' *G002
03.0
Controle
Registro Tipo de Registro 8 8 1 - Num '0' *G003                                                    *
04.0 CNAB Uso Exclusivo FEBRABAN / CNAB 9 17 9 - Alfa Brancos G004
05.0 Tipo Tipo de Inscrição da Empresa 18 18 1 - Num *G005
06.0
Inscrição
Número Número de Inscrição da Empresa 19 32 14 - Num *G006
07.0 Uso Exclusivo Uso Exclusivo CAIXA 33 52 20 - Num ‘0’
08.0 Código Agência Mantenedora da Conta 53 57 5 - Num *G008
09.0
Agência
DV Dígito Verificador da Agência 58 58 1 - Alfa *G009
10.0
Cód.
Identif. Código Cedente Código do Convênio no Banco 59 64 6 - Num *G007
11.0 Uso Exclusivo Uso Exclusivo CAIXA 65 71 7 - Num ‘0’
12.0 Uso Exclusivo Uso Exclusivo CAIXA 72 72 1 - Num ‘0’
13.0 Nome da Empresa 73 102 30 - Alfa G013
14.0 Nome do Banco Nome do Banco 103 132 30 - Alfa G014
15.0 CNAB Uso Exclusivo FEBRABAN / CNAB 133 142 10 - Alfa Brancos G004
16.0 Código Código Remessa / Retorno 143 143 1 - Num G015
17.0 Data de Geração Data de Geração do Arquivo 144 151 8 - Num G016
18.0 Hora de Geração Hora de Geração do Arquivo 152 157 6 - Num G017
19.0 Seqüência (NSA) Número Seqüencial do Arquivo 158 163 6 - Num *G018
20.0 Layout do Arquivo No da Versão do Layout do Arquivo 164 166 3 - Num '050' *G019
21.0 Densidade de Gravação do Arquivo 167 171 5 - Num ‘0’ G020
22.0 Reservado Banco Para Uso Reservado do Banco 172 191 20 - Alfa G021
23.0 Reservado Empresa Para Uso Reservado da Empresa 192 211 20 - Alfa G022
24.0 Versão Aplicativo Versão Aplicativo CAIXA 212 215 4 - Alfa C077
25.0 CNAB Uso Exclusivo FEBRABAN / CNAB 216 240 25 - Alfa Brancos G004

Registro Trailer de Arquivo

Campo                                                  Posição  Nº  Nº Formato Default Descricao
                                                        De Até Dig Dec 

01.9 Banco Código do Banco na Compensação 1 3 3 - Num ‘104’ G001
02.9 Lote Lote de Serviço 4 7 4 - Num '9999' *G002
03.9
Controle
Registro Tipo de Registro 8 8 1 - Num '9' *G003
04.9 CNAB Uso Exclusivo FEBRABAN/CNAB 9 17 9 - Alfa Brancos G004
05.9 Quantidade de
Lotes
Quantidade de Lotes do Arquivo 18 23 6 - Num G049
06.9
Totais
Quantidade de
Registros
Quantidade de Registros do Arquivo 24 29 6 - Num G056
07.9 CNAB Uso Exclusivo FEBRABAN/CNAB 30 35 6 - Alfa Brancos G004
08.9 CNAB Uso Exclusivo FEBRABAN/CNAB 36 240 205 - Alfa Brancos G004
Leiaute de Arquivo Eletrônico Padrão CNAB 240
Cobrança Bancária CAIXA

Registro Detalhe - Segmento T (Obrigatório - Retorno)

Campo                                                  Posição  Nº  Nº Formato Default Descricao
                                                        De Até Dig Dec 
01.3T Codigo do Banco na Compensacao 					 1   3   3   - 	 Num 		‘104’ *G001
02.3T Lote de Serviço 									 4   7   4   -   Num 				*G002
03.3T Tipo de Registro 									 8   8   1   -   Num 		‘3’ 	*G003
04.3T Número Seqüencial Registro no Lote 				 9  13   5   -   Num     		*G038
05.3T Código Segmento do Registro Detalhe 				14  14   1   -  Alfa      ´T´  *G039
06.3T CNAB 												15  15   1   -  Alfa Brancos 	 G004
07.3T Código de Movimento Retorno 						16  17   2   -   Num 				*C044
08.3T Código Uso Exclusivo CAIXA 						18  22   5   -   Num 		‘0’
09.3T Agência DV Uso Exclusivo CAIXA 					23  23   1   -   Num     ‘0’
10.3T Código Cedente Código do Convênio no Banco 		24  29   6   -   Num 				*G007
11.3T Uso Exclusivo Uso Exclusivo da CAIXA 				30  32   3   -   Num 		‘0’
12.3T Número do Banco Número do Banco de Sacados 		33  35   3   -   Num 				C079
13.3T Uso Exclusivo Uso Exclusivo da CAIXA 				36  39   4   -   Num ‘0’
14.3T Modalidade Nosso Número                           40  41   2   -   Num 				*G069
15.3T Nosso Número Identificação do Título no Banco 	42  56  15   -   Num 				*G069
16.3T Uso Exclusivo Uso Exclusivo CAIXA 				57  57   1   -   Num ‘0’
17.3T Carteira Código da Carteira 						58  58   1   -   Num 				C006
18.3T Número Documento - Seu Número do Documento 		59  69  11   -  Alfa 				*C011
19.3T Uso Exclusivo Uso Exclusivo CAIXA 				70  73   4 	-  Alfa Brancos
20.3T Vencimento Data de Vencimento do Título 			74  81   8   -   Num 				*C012
21.3T Valor do Título 									82  96  13   2   Num 				G070
22.3T Banco Cobrador/Recebedor Código do Banco 			97  99   3   -   Num 				C045
23.3T Código da Agência Cobr/Receb 						100 104   5   - 	 Num 				C086
24.3T Dígito Verificador da Agência Cobr/Rec 			105 105   1   -   Num 				G009
25.3T Uso da Empresa Identificação do Título 			106 130  25   -  Alfa 				C011
26.3T Código da Moeda 									131 132   2   -   Num 				G065
27.3T Tipo de Inscrição 								133 133   1   -   Num 				*G005
28.3TNúmero de Inscrição 								134 148  15   -   Num 				*G006
29.3T Sacado Nome 										149 188  40   -  Alfa
30.3T CNAB Uso Exclusivo FEBRABAN/CNAB 					189 198  10   -  Alfa Brancos
31.3T Valor da Tarifa / Custas 							199 213  13   2   Num 				G076
32.3T Motivo da Ocorrência 								214 223  10   -  Alfa 				*C047
33.3T CNAB Uso Exclusivo FEBRABAN/CNAB 					224 240  17   -  Alfa Brancos   G004


Registro Detalhe - Segmento U (Obrigatório - Retorno)
Campo Posição Nº Nº Formato Default Des-
De Até Dig Dec crição
01.3U Banco Código do Banco na Compensação 1 3 3 - Num ‘104’ G001
02.3U Lote Lote de Serviço 4 7 4 - Num *G002
03.3U
Controle
Registro Tipo de Registro 8 8 1 - Num ‘3’ *G003
04.3U Nº do Registro Nº Seqüencial do Registro no Lote 9 13 5 - Num *G038
05.3U Segmento Cód. Segmento do Registro Detalhe 14 14 1 - Alfa ‘U’ *G039
06.3U CNAB Uso Exclusivo FEBRABAN/CNAB 15 15 1 - Alfa Brancos G004
07.3U
Serviço
Cód. Mov. Código de Movimento Retorno 16 17 2 - Num *C044
08.3U Acréscimos Juros / Multa / Encargos 18 32 13 2 Num C048
09.3U Vlr do Desconto Valor do Desconto Concedido 33 47 13 2 Num C049
10.3U Vlr do Abatimento Valor do Abat. Concedido/Cancel. 48 62 13 2 Num C050
11.3U Vlr IOF Valor do IOF Recolhido 63 77 13 2 Num G077
12.3U Vlr Pago Valor Pago pelo Sacado 78 92 13 2 Num C052
13.3U
Dados
do Título
Vlr Líquido Valor Líquido a ser Creditado 93 107 13 2 Num G078
14.3U Outras Despesas Valor de Outras Despesas 108 122 13 2 Num C054
15.3U Outros Créditos Valor de Outros Créditos 123 137 13 2 Num C055
16.3U Data da Ocorrência Data da Ocorrência 138 145 8 - Num C056
17.3U Data do Crédito Data da Efetivação do Crédito 146 153 8 - Num C057
18.3U Uso Exclusivo CAIXA Uso Exclusivo CAIXA 154 157 4 - Num ‘0’
19.3U Data do Débito da Tarifa Data do Débito da Tarifa 158 165 8 - Num
20.3U Código do Sacado Código do Sacado no Banco 166 180 15 - Num C080
21.3U Uso Exclusivo CAIXA Uso Exclusivo CAIXA 181 210 30 - Num ‘0’
22.3U Cód. Bco. Corr. Cód. Banco Correspondente Compens. 211 213 3 - Num *C031
23.3U Nosso Nº Banco Correspondente Nosso Nº Banco Correspondente 214 233 20 - Num *C032
24.3U CNAB Uso Exclusivo FEBRABAN/CNAB 234 240 7 - Alfa Brancos G004
Leiaute de Arquivo Eletrônico Padrão CNAB 240
Cobrança Bancária CAIXA
67.118 v002 Micro 26
Registro Detalhe - Segmento U (Obrigatório - Retorno)
Código de Movimento: 35, 36, 37 (Banco de Sacados)
Campo Posição Nº Nº Formato Default Des-
De Até Dig Dec crição
01.3U Banco Código do Banco na Compensação 1 3 3 - Num ‘104’ G001
02.3U Lote Lote de Serviço 4 7 4 - Num *G002
03.3U
Controle
Registro Tipo de Registro 8 8 1 - Num ‘3’ *G003
04.3U Nº do Registro Nº Seqüencial do Registro no Lote 9 13 5 - Num *G038
05.3U Segmento Cód. Segmento do Registro Detalhe 14 14 1 - Alfa ‘U’ *G039
06.3U CNAB Uso Exclusivo FEBRABAN/CNAB 15 15 1 - Alfa Brancos G004
07.3U
Serviço
Cód. Mov. Código de Movimento Retorno 16 17 2 - Num *C044
08.3U Acréscimos Juros / Multa / Encargos 18 32 13 2 Num C048
09.3U Vlr do Desconto Valor do Desconto Concedido 33 47 13 2 Num C049
10.3U Vlr do Abatimento Valor do Abat. Concedido/Cancel. 48 62 13 2 Num C050
11.3U Vlr IOF Valor do IOF Recolhido 63 77 13 2 Num G077
12.3U Vlr Pago Valor Pago pelo Sacado 78 92 13 2 Num C052
13.3U
Dados
do Título
Vlr Líquido Valor Líquido a ser Creditado 93 107 13 2 Num G078
14.3U Outras Despesas Valor de Outras Despesas 108 122 13 2 Num C054
15.3U Outros Créditos Valor de Outros Créditos 123 137 13 2 Num C055
16.3U Data da Ocorrência Data da Ocorrência 138 145 8 - Num C056
17.3U Data do Crédito Data da Efetivação do Crédito 146 153 8 - Num C057
18.3U Número do Banco de
Sacados
Número do Banco de Sacados 154 156 3 - Num C079
19.3U Nome do Banco de Sacados Nome do Banco de Sacados 157 176 20 - Alfa C079
20.3U Ajuste Vencimento ID Ajuste Vencimento 177 177 1 - Alfa C087
21.3U Ajuste Emissão ID Ajuste Emissão 178 178 1 - Alfa C087
22.3U Modelo Bloqueto - Bco
Sacados
ID Modelo Bloqueto - Banco Sacados 179 180 2 - Num G067A
23.3U Via Entrega / Distribuição ID Via Entrega / Distribuição 181 181 1 - Num C010/A
24.3U Espécie Título ID Espécie Título 182 183 2 - Num C015
25.3U Aceite ID Aceite 184 184 1 - Alfa
26.3U Código do Sacado no Banco Código do Sacado no Banco 185 199 15 - Alfa C080
27.3U Uso Exclusivo CAIXA Uso Exclusivo CAIXA 200 210 11 - Alfa Brancos
28.3U CNAB Uso Exclusivo FEBRABAN / CNAB 211 240 30 - Alfa G004

*/

_cArq  := ARQ := "\arquivos\retorno\"+mv_par01
If !File( allTrim( _cArq ))
	Help(" ",1,"ARRVAZ")
	Return
endif

_nTotal		:= 0
_nTotal2		:= 0
nOffSet 		:= 8 
XNATUREZA	:="002"

_aStru := {}
AADD( _aStru, { "COD_BANCO"  	, "C" , 003 , 0 } )
AADD( _aStru, { "LOTE"       	, "C" , 004 , 0 } )
AADD( _aStru, { "COD_REGIST"	, "C" , 001 , 0 } )
AADD( _aStru, { "RESTANTE"		, "C" , 232 , 0 } )

c_ArqTmp := CriaTrab(_aStru,.t.)
dbUseArea(.t.,,c_ArqTmp,"TMP")
dbSelectArea("TMP")
Append From &(alltrim(_cArq)) SDF
dbGotop()
ProcRegua(RecCount(),22,05)

if TMP->COD_REGIST == "0"  .AND. SUBSTR( TMP->RESTANTE, 143 - nOffSet, 1 ) == "2" //registro Header e eh retorno
	dbskip()
//	_dataproc := ctod(substr(TMP->RESTANTE,110,2)+"/"+substr(TMP->RESTANTE,112,2)+"/"+substr(TMP->RESTANTE,114,2))
//	_cPeriodo := substr(TMP->RESTANTE,112,2) + substr(TMP->RESTANTE,114,2)
	if TMP->COD_REGIST == "1"  //registro Lote
		_cConta := SUBSTR( TMP->RESTANTE, 60 - nOffSET, 6 )
		if _cconta == "074282"
			xsindica := "02"   
			XNATUREZA	:="002"
		elseif _cconta == "073939"
			xsindica := "03"   
			XNATUREZA	:="002"
		elseif _cconta == "074284"
			xsindica := "04"   
			XNATUREZA	:="002"
		elseif _cconta == "074278"
			xsindica := "05"
			XNATUREZA	:="002"
		elseif _cconta == "073962"
			xsindica := "06"
			XNATUREZA	:="002"
		elseif _cconta == "226766"
			xsindica := "02"   
			XNATUREZA	:="0301"
		elseif _cconta == "226769"
			xsindica := "03"   
			XNATUREZA	:="0301"
		elseif _cconta == "226770"
			xsindica := "04"   
			XNATUREZA	:="0301"
		elseif _cconta == "226771"
			xsindica := "05"
			XNATUREZA	:="0301"
		elseif _cconta == "226773"
			xsindica := "06"
			XNATUREZA	:="0301"
		endif
		DBSKIP()
		dbSelectArea("TMP")
		DO WHILE  ! TMP->( eof() ) .and. TMP->COD_REGIST == "3"
			IncProc(_cTitulo)
			
  			/*
			_cConta := substr( TMP->RESTANTE,29,7)
			if _cConta == "9999999"    && C/C Assistencial
				_cLote:="7555"	 && Lote para ASSISTENCIAL
				XNATUREZA := "0301"
			elseif _cConta $ "9999999/9999999/9999999/9999999/9999999/9999999"    && C/C Termos
				_cLote:="7560"	 && Lote para Termos
				XNATUREZA:="002"
			else
				_cLote:="7560"	 && Lote para Termos
				XNATUREZA:="314"
			endif
			*/
	
			if SUBSTR( TMP->RESTANTE, 14 - nOffSet, 1 ) == "T" .AND. SUBSTR( TMP->RESTANTE, 16 - nOffSet, 2 ) == "06" // "T" AND LIQUIDACAO
				//	_dataproc := ctod(substr(TMP->RESTANTE,110,2)+"/"+substr(TMP->RESTANTE,112,2)+"/"+substr(TMP->RESTANTE,114,2))
				//_cPeriodo := substr(TMP->RESTANTE,112,2) + substr(TMP->RESTANTE,114,2)
				_cCGC  := ""
				_dVENC := ctod("")
				_nPREF := ""
				_nPARC := ""

				cNossoNum := SUBSTR( TMP->RESTANTE, 42 - nOffSet, 15 )

				IF LEFT( cNossoNum,  7 ) == '0000000'
					cNumTit := SUBSTR( cNossoNum, 8, 4 ) + "000" + SUBSTR( cNossoNum, 12, 4 )
				ELSEIF LEFT( cNossoNum,  7 ) == '0000006'
					cNumTit := "60000000" + SUBSTR( cNossoNum, 11, 5 )
				ELSE
//					MsgInfo( "Titulo com nosso numero invalido " + cNossoNum )        
					CNUMTIT:= SUBS(CNOSSONUM,3,13)
//					TMP->( DbSkip() )
//					LOOP
				ENDIF					

            //TXT ->  000000600000007
				//SZ9 ->  6000000000007

            //TXT ->  000000014030586
            //SZ9 ->  14030000586

				IF SZ9->( DbSeek( xFilial("SZ9" ) + cNumTit ) )

//					msginfo( "Encontrei " + cNumTit )
					_cCGC  := SZ9->Z9_CGC
					_dVenc := SZ9->Z9_VENCTO
					_nPREF := substr(SZ9->Z9_PARCELA,1,2)
					_nPARC := substr(SZ9->Z9_PARCELA,4,1)
				else
					_cCGC   := "99"   && Boleto Avulso / Termo
//					msginfo( "NAO Encontrei " + cNumTit )
				endif
	//			if _cConta == "0162159"    && C/C Termos
	//				_NPREF := ALLTRIM(_NPREF)+"E"    // NAO TRATAR MAIS ESCRITORIO
	//			ENDIF
	
				if empty( _cCGC )
					dbSelectArea("TMP")
					dbsKip()
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

				TMP->( DbSkip() ) // Deveria pegar o proximo segmento U

				IF SUBSTR( TMP->RESTANTE, 14 - nOffSet, 1 ) <> "U" .OR. SUBSTR( TMP->RESTANTE, 16 - nOffSet, 2 ) <> "06" // "U" AND LIQUIDACAO
					LOOP
				ENDIF

				dbSelectArea("SE1")  //GERANDO Contas a receber
				dbOrderNickName('18')  // dbSetOrder(18) // Alterado (UPDXFUN).
				dbseek( xFilial("SE1") + cNumTit )
				_lMovimenta := .f.

				nValorTit := val( substr(TMP->RESTANTE,78-nOffSet, 15) )/100
PORCREC := 1
IF xSINDICA=="02"	
	PORCREC := .25
ELSEIF xSINDICA=="03"	
	PORCREC := .25
ELSEIF xSINDICA=="04"	
	PORCREC := .25
ELSEIF xSINDICA=="05"	
	PORCREC := .30
ELSEIF xSINDICA=="06"	
	PORCREC := .25
ENDIF	


				if eof() .and. _cCGC <> "99"	  && Gera titulo se nao existe (Recepcao normal)
					_lMovimenta := .t.
					RECLOCK("SE1",.T.)

					SE1->E1_FILIAL   := xFilial()
					SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
					SE1->E1_PREFIXO  := _nPref
					SE1->E1_SINDICA  := xSINDICA
					SE1->E1_PARCELA  := _nPARC
					SE1->E1_TIPO     := "DP"
					SE1->E1_NATUREZ  := XNATUREZA
					SE1->E1_CLIENTE  := SA1->A1_COD
					SE1->E1_CODASSO  := SA1->A1_CODASSO
					SE1->E1_CGC      := SA1->A1_CGC
					SE1->E1_CATEG1   := SA1->A1_CATEG1
					SE1->E1_ERSIN    := SA1->A1_ERSIN
					SE1->E1_BASE     := SA1->A1_BASE
					SE1->E1_LOJA     := SA1->A1_LOJA
					SE1->E1_NOMCLI   := SA1->A1_NOME
					SE1->E1_EMISSAO  := ctod("01"+ "/"+substr(dtos(_dVenc),5,2)+"/"+substr(dtos(_dVenc),3,2))
					SE1->E1_MOVIMEN  := ctod("01"+ "/"+substr(dtos(_dVenc),5,2)+"/"+substr(dtos(_dVenc),3,2))
					SE1->E1_EMIS1    := ctod("01"+ "/"+substr(dtos(_dVenc),5,2)+"/"+substr(dtos(_dVenc),3,2))
					SE1->E1_VENCTO   := _dVenc
					SE1->E1_VENCREA  := DataValida( _dVenc )
					SE1->E1_VENCORI  := _dVenc
					SE1->E1_HIST     := "Ref.Contr. de "+ substr(dtos( _dVenc ),5,2)+"/"+substr(dtos(_dVenc),3,2)
					SE1->E1_VALOR    := nValorTit
					SE1->E1_SALDO    := 0
					SE1->E1_VLCRUZ   := nValorTit
					SE1->E1_VALJUR   := 0
					SE1->E1_MOEDA    := 1
					//APOS BORDERO
					SE1->E1_PORTADO := "104"
					SE1->E1_AGEDEP	:=  "0242"
					SE1->E1_CONTA   := _cConta
					SE1->E1_SITUACA := "1"
					SE1->E1_OCORREN := "01"
					SE1->E1_ORIGEM  := "RFINA139"
					SE1->E1_STATUS  := "B"
					SE1->E1_JUROS   := 0
					SE1->E1_VALLIQ  := nValorTit
					SE1->E1_BAIXA   := ctod(substr(TMP->RESTANTE,138 - nOffSet,2)+"/"+substr(TMP->RESTANTE,140 - nOffSet,2)+"/"+substr(TMP->RESTANTE,144-nOffSet,2))
					se1->e1_dtcred  := ctod(substr(TMP->RESTANTE,146 - nOffSet,2)+"/"+substr(TMP->RESTANTE,148 - nOffSet,2)+"/"+substr(TMP->RESTANTE,152-nOffSet,2))
					se1->e1_valcred := nValorTit*PORCREC
					SE1->E1_OK      := CHR(69)+CHR(120)
					SE1->E1_CONFED  := cNumTit
					SE1->E1_ARQBCO  := MV_PAR01
/*/
					if _cConta=="0169641"
						_nTotal:= _nTotal + SE1->E1_VALLIQ     && Total de pagtos assist.
					EndIf
					if _cConta=="0162159"
						_nTotal2:= _nTotal2 + SE1->E1_VALLIQ    && Total de termos
					EndIf
/*/
					MSUNLOCK()
					CONFIRMSX8()

				else

					_altconf:=.f.
					if alltrim(SE1->E1_CONFED)== cNumTit .and. .not. eof()
						_altconf:=.t.
					EndIf
					if _altconf
						Reclock( "SE1",.F.)	&& Altera titulo se existe (Boleto Avulso)
						SE1->E1_STATUS  := "B"
						if .T. //se1->e1_valor > 0 .and. se1->e1_valor < 0.02
							SE1->E1_valor   := nValorTit
							SE1->E1_SALDO   := 0
						endif
						SE1->E1_JUROS   := nValorTit - SE1->E1_VALOR
						&& Coloca valor no titulo Confederativa
						if _cCGC=="99"
							//						SE1->E1_VALOR    := val( substr(TMP->RESTANTE,253,13) )/100
							SE1->E1_SALDO := 0
							//						SE1->E1_VLCRUZ   := val( substr(TMP->RESTANTE,253,13) )/100
						endif
						SE1->E1_VALLIQ  := nValorTit
						SE1->E1_BAIXA   := ctod(substr(TMP->RESTANTE,138 - nOffSet,2)+"/"+substr(TMP->RESTANTE,140 - nOffSet,2)+"/"+substr(TMP->RESTANTE,144-nOffSet,2))
						SE1->E1_OK      := CHR(69)+CHR (120)
						SE1->E1_PORTADO := "104"
						SE1->E1_AGEDEP  := "0242"
						SE1->E1_CONTA   := _cConta
						SE1->E1_SITUACA := "1"
						SE1->E1_OCORREN := "01"
						SE1->E1_ORIGEM  := "RFINA139"
						SE1->E1_ARQBCO  := MV_PAR01
						se1->e1_valcred := nValorTit*PORCREC
						se1->e1_dtcred  := ctod(substr(TMP->RESTANTE,146 - nOffSet,2)+"/"+substr(TMP->RESTANTE,148 - nOffSet,2)+"/"+substr(TMP->RESTANTE,152-nOffSet,2))

						MsUnlock()
						_lMovimenta:=.t.
					else
						dbselectarea("sa1")
						dbsetorder(1)
						dseek(xfilial()+"99999901" )
						RECLOCK("SE1",.T.)

						SE1->E1_FILIAL   := xFilial()
						SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
						SE1->E1_PREFIXO  := _nPref
						SE1->E1_SINDICA  := xSINDICA
						SE1->E1_PARCELA  := _nPARC
						SE1->E1_TIPO     := "DP"
						SE1->E1_NATUREZ  := XNATUREZA
						SE1->E1_CLIENTE  := "999999"
						SE1->E1_CODASSO  := ""
						SE1->E1_CGC      := ""
						SE1->E1_CATEG1   := ""
						SE1->E1_ERSIN    := ""
						SE1->E1_BASE     := ""
						SE1->E1_LOJA     := "01"
						SE1->E1_NOMCLI   := ""
						SE1->E1_EMISSAO  := ctod("01"+ "/"+substr(dtos(_dVenc),5,2)+"/"+substr(dtos(_dVenc),3,2))
						SE1->E1_MOVIMEN  := ctod("01"+ "/"+substr(dtos(_dVenc),5,2)+"/"+substr(dtos(_dVenc),3,2))
						SE1->E1_EMIS1    := ctod("01"+ "/"+substr(dtos(_dVenc),5,2)+"/"+substr(dtos(_dVenc),3,2))
						SE1->E1_VENCTO   := _dVenc
						SE1->E1_VENCREA  := DataValida( _dVenc )
						SE1->E1_VENCORI  := _dVenc
						SE1->E1_HIST     := "Ref.Contr. de "+ substr(dtos( _dVenc ),5,2)+"/"+substr(dtos(_dVenc),3,2)
						SE1->E1_VALOR    := nValorTit
						SE1->E1_SALDO    := 0
						SE1->E1_VLCRUZ   := nValorTit
						SE1->E1_VALJUR   := 0
						SE1->E1_MOEDA    := 1
						//APOS BORDERO
						SE1->E1_PORTADO := "104"
						SE1->E1_AGEDEP	:=  "0242"
						SE1->E1_CONTA   := _cConta
						SE1->E1_SITUACA := "1"
						SE1->E1_OCORREN := "01"
						SE1->E1_ORIGEM  := "RFINA139"
						SE1->E1_STATUS  := "B"
						SE1->E1_JUROS   := 0
						SE1->E1_VALLIQ  := nValorTit
						SE1->E1_BAIXA   := ctod(substr(TMP->RESTANTE,138 - nOffSet,2)+"/"+substr(TMP->RESTANTE,140 - nOffSet,2)+"/"+substr(TMP->RESTANTE,144-nOffSet,2))
						se1->e1_dtcred  := ctod(substr(TMP->RESTANTE,146 - nOffSet,2)+"/"+substr(TMP->RESTANTE,148 - nOffSet,2)+"/"+substr(TMP->RESTANTE,152-nOffSet,2))
						se1->e1_valcred := nValorTit*PORCREC
						SE1->E1_OK      := CHR(69)+CHR(120)
						SE1->E1_CONFED  := cNumTit
						SE1->E1_ARQBCO  := MV_PAR01
							_lMovimenta:=.T.
					endif

					dbselectArea("SE5")
					if _lMovimenta
						recLock("SE5",.T.)
						SE5->E5_FILIAL  := xFilial()
						SE5->E5_DATA    := ctod(substr(TMP->RESTANTE,138 - nOffSet,2)+"/"+substr(TMP->RESTANTE,140 - nOffSet,2)+"/"+substr(TMP->RESTANTE,144-nOffSet,2))
						SE5->E5_TIPO    := "DP"
						SE5->E5_VALOR   := nValorTit
						SE5->E5_NATUREZ := XNATUREZA
						SE5->E5_BANCO   := "104"
						SE5->E5_AGENCIA := "0242"
						SE5->E5_CONTA   := _cConta
						SE5->E5_RECPAG  := "R"
						SE5->E5_BENEF   := SA1->A1_NREDUZ
						SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
						SE5->E5_TIPODOC := "VL"                                                                                                                
						SE5->E5_VLMOED2 := nValorTit
						SE5->E5_LA      := "N"
						SE5->E5_CLIFOR  := SA1->A1_COD
						SE5->E5_LOJA    := SA1->A1_LOJA
						SE5->E5_DTDIGIT := dDATABASE
						SE5->E5_MOTBX   := "NOR"
						SE5->E5_SEQ     := "01"
						SE5->E5_PREFIXO := _nPREF
						SE5->E5_NUMERO  :=  SE1->E1_NUM //NAVA - SA1->A1_COD
						SE5->E5_PARCELA := _nPARC
						SE5->E5_DTDISPO := ctod(substr(TMP->RESTANTE,146 - nOffSet,2)+"/"+substr(TMP->RESTANTE,148 - nOffSet,2)+"/"+substr(TMP->RESTANTE,152-nOffSet,2))
						MsUnlock()
					endif
				endif
			endif	
			TMP-> ( DbSkip() )
	enddo
	endif
endif

/*
dbselectArea("SI2")
dbsetorder(3)
dbseek( xFilial() + dtos(_dataproc) + "7555" )
if _nTotal > 0 .and. eof()
	recLock("SI2",.T.)
	SI2->I2_FILIAL := "01"
	SI2->I2_NUM    := "7555" + "001"
	SI2->I2_LINHA  := "01"
	SI2->I2_DATA   := _dataproc
	SI2->I2_DC     := "X"
	SI2->I2_MOEDAS := "SNNNN"
	SI2->I2_VALOR  := _nTotal
	SI2->I2_DTVENC := _dataproc
	SI2->I2_ROTINA := "RFINA09"
	SI2->I2_PERIODO:= _cPeriodo
	SI2->I2_ORIGEM := "L.GER P/RFINA09"
	SI2->I2_FILORIG:= "01"
	SI2->I2_DEBITO := "1112030004"
	SI2->I2_CREDITO:= "3111020001"
	SI2->I2_HIST   := "RECEB. DE CONT. ASSISTENCIAL - " + STRZERO(MONTH(_dataproc),2) + "/" + STR(YEAR(_dataproc),4)
	MsUnlock()
endif
dbselectArea("SI2")
dbsetorder(3)
dbseek( xFilial() + dtos(_dataproc) + "7560" )
if _nTotal2 > 0 .and. eof()
	recLock("SI2",.T.)
	SI2->I2_FILIAL := "01"
	SI2->I2_NUM    := "7560" + "001"
	SI2->I2_LINHA  := "01"
	SI2->I2_DATA   := _dataproc
	SI2->I2_DC     := "X"
	SI2->I2_MOEDAS := "SNNNN"
	SI2->I2_VALOR  := _nTotal2
	SI2->I2_DTVENC := _dataproc
	SI2->I2_ROTINA := "RFINA09"
	SI2->I2_PERIODO:= _cPeriodo
	SI2->I2_ORIGEM := "L.GER P/RFINA09"
	SI2->I2_FILORIG:= "01"
	SI2->I2_DEBITO := "1112030002"
	SI2->I2_CREDITO:= "3111010001"
	SI2->I2_HIST   := "RECEB. Termos Acordo - " + STRZERO(MONTH(_dataproc),2) + "/" + STR(YEAR(_dataproc),4)
	MsUnlock()
endif
*/

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