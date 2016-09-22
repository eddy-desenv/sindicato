#include "rwmake.ch"

User Function RFINA139()

 Local aBaixa := {} ////AJUSTE SE5

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
@ 033,014 SAY "vindas pelo Banco CEF"
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
01.3T Codigo do Banco na Compensacao 							1   3   3   - 	 Num 		‘104’ *G001
02.3T Lote de Serviço 												4   7   4   -   Num 				*G002
03.3T Tipo de Registro 												8   8   1   -   Num 		‘3’ 	*G003
04.3T Número Seqüencial Registro no Lote 						9  13   5   -   Num     		*G038
05.3T Código Segmento do Registro Detalhe 				  14  14   1   -  Alfa      ´T´  *G039
06.3T CNAB 															  15  15   1   -  Alfa Brancos 	 G004
07.3T Código de Movimento Retorno 							  16  17   2   -   Num 				*C044
08.3T Código Uso Exclusivo CAIXA 							  18  22   5   -   Num 		‘0’
09.3T Agência DV Uso Exclusivo CAIXA 						  23  23   1   -   Num     ‘0’
10.3T Código Cedente Código do Convênio no Banco 		  24  29   6   -   Num 				*G007
11.3T Uso Exclusivo Uso Exclusivo da CAIXA 				  30  32   3   -   Num 		‘0’
12.3T Número do Banco Número do Banco de Sacados 		  33  35   3   -   Num 				C079
13.3T Uso Exclusivo Uso Exclusivo da CAIXA 				  36  39   4   -   Num ‘0’
14.3T Modalidade Nosso Número                           40  41   2   -   Num 				*G069
15.3T Nosso Número Identificação do Título no Banco 	  42  56  15   -   Num 				*G069
16.3T Uso Exclusivo Uso Exclusivo CAIXA 					  57  57   1   -   Num ‘0’
17.3T Carteira Código da Carteira 							  58  58   1   -   Num 				C006
18.3T Número Documento - Seu Número do Documento 		  59  69  11   -  Alfa 				*C011
19.3T Uso Exclusivo Uso Exclusivo CAIXA 					  70  73   4 	-  Alfa Brancos
20.3T Vencimento Data de Vencimento do Título 			  74  81   8   -   Num 				*C012
21.3T Valor do Título 											  82  96  13   2   Num 				G070
22.3T Banco Cobrador/Recebedor Código do Banco 			  97  99   3   -   Num 				C045
23.3T Código da Agência Cobr/Receb 							 100 104   5   - 	 Num 				C086
24.3T Dígito Verificador da Agência Cobr/Rec 			 105 105   1   -   Num 				G009
25.3T Uso da Empresa Identificação do Título 			 106 130  25   -  Alfa 				C011
26.3T Código da Moeda 											 131 132   2   -   Num 				G065
27.3T Tipo de Inscrição 										 133 133   1   -   Num 				*G005
28.3TNúmero de Inscrição 										 134 148  15   -   Num 				*G006
29.3T Sacado Nome 												 149 188  40   -  Alfa
30.3T CNAB Uso Exclusivo FEBRABAN/CNAB 					 189 198  10   -  Alfa Brancos
31.3T Valor da Tarifa / Custas 								 199 213  13   2   Num 				G076
32.3T Motivo da Ocorrência 									 214 223  10   -  Alfa 				*C047
33.3T CNAB Uso Exclusivo FEBRABAN/CNAB 					 224 240  17   -  Alfa Brancos   G004


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

aBaixa := {{"E1_PREFIXO"  ,"   "                  ,Nil    },;
           {"E1_NUM"      ,"200      "            ,Nil    },;
           {"E1_TIPO"     ,"NF "                  ,Nil    },;
           {"AUTMOTBX"    ,"NOR"                  ,Nil    },;
           {"AUTBANCO"    ,"104"                  ,Nil    },;
           {"AUTAGENCIA"  ,"00001"                ,Nil    },;
           {"AUTCONTA"    ,"0000000001"           ,Nil    },;
           {"AUTDTBAIXA"  ,dDataBase              ,Nil    },;
           {"AUTDTCREDITO",dDataBase              ,Nil    },;
           {"AUTHIST"     ,"BAIXA TESTE"          ,Nil    },;
           {"AUTJUROS"    ,0                      ,Nil,.T.},;
           {"AUTVALREC"   ,700                    ,Nil    }}

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
					cNumTit := "60004157" + SUBSTR( cNossoNum, 11, 5 )
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
				if empty(sz9->z9_ano)
					IF SUBS(SZ9->Z9_PARCELA,3,1)=="T"
						_nPREF := substr(SZ9->Z9_PARCELA,1,3)
					ELSE
						_nPREF := substr(SZ9->Z9_PARCELA,1,2)
					ENDIF
			  		_nPARC := substr(SZ9->Z9_PARCELA,4,1)
				else
		  			_npref    := subs(sz9->z9_ANO,3,2)
					_NPARC:=  subs(sz9->z9_PARCELA,4,1)
				ENDIF
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


				if ((eof() .and. _cCGC <> "99") .OR. _dvenc<>SE1->E1_vencto) .OR. (FOUND() .AND. se1->e1_saldo=0)  //
				////ctod(substr(TMP->RESTANTE,138 - nOffSet,2)+"/"+substr(TMP->RESTANTE,140 - nOffSet,2)+"/"+substr(-TMP->RESTANTE,144-nOffSet,2))<>SE1->E1_BAIXA  && Gera titulo se nao existe (Recepcao normal)
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
					
				 MSExecAuto({|x,y| Fina070(x,y)},aBaixa,3) /// ajuste se5
				
					            
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


				else

					_altconf:=.f.
					if alltrim(SE1->E1_CONFED)== cNumTit .and. .not. eof()
						if se1->e1_saldo <> 0
						_altconf:=.t.
            			endif
								EndIf
					if _altconf
						Reclock( "SE1",.F.)	&& Altera titulo se existe (Boleto Avulso)
						SE1->E1_STATUS  := "B"
						if .T. //se1->e1_valor > 0 .and. se1->e1_valor < 0.02
							SE1->E1_valor   := nValorTit
							SE1->E1_SALDO   := 0
						endif                        /
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

					else
						dbselectarea("sa1")
						dbsetorder(1)
						dbseek(xfilial()+"99999901" )
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
					CONFIRMSX8()
						msunlock()
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
imprelbx()
Return(nil)                          
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
    RptStatus({|| impREL() },titulo)
    return



Static function ImpREL()
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
			TMP->DTABERT   := stod(TRB->A1_DTinic)
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
				DATVALPG  += rel->E1_Vlrcred
			  if rel->sindicato == "01"
			  	VALTIT1+=rel->VLRcred
			  	 VALPG1 += 	REL->VLRreceb
			  	  QTDPG1  ++ 
			   elseif rel->sindicato == "02"
			  	VALTIT2+=REL->VLRcred
			  	 VALPG2 += 	REL->VLRreceb
			  	  QTDPG2  ++ 
			   elseif rel->sindicato == "03"
			  	VALTIT3+=REL->VLRcred
			  	 VALPG3 += 	REL->VLRreceb
			  	 			  	 QTDPG3  ++ 
			   elseif rel->sindicato == "04"
			  	VALTIT4+=REL->VLRcred
			  	 VALPG4 += 	REL->VLRreceb
			  	 QTDPG4  ++ 
			   elseif rel->sindicato == "05"
			  	VALTIT5+=REL->VLrcred
			  	 VALPG5 += 	REL->VLRreceb
			  	 QTDPG5  ++ 
			   elseif rel->sindicato == "06"
			  	VALTIT6+=REL->VLRcred
			  	 VALPG6 += 	REL->VLRreceb
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


