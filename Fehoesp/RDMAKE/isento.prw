#include "rwmake.ch"
#include "topconn.ch"
User Function Isento()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Isento   ³ Autor ³ Marcello M. Navarro   ³ Data ³ 05;05/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Isencao de Pagamento para clientes ( baixa automatica )    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

@ 096,042 TO 375,505 DIALOG oDlg1 TITLE "Isencao de Pagamento de Clientes"
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa ira baixar automaticamente determinado cliente"
@ 086,014 SAY "CONFIRME PARA INICIAR A ATUALIZACAO DOS DADOS."
@ 110,168 BMPBUTTON TYPE 1 ACTION Iniciar()
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED
Return
**************************
Static Function Iniciar()
Close(oDlg1)
Processa( {|| ATUALIZA() })
Return
**************************
Static Function ATUALIZA()

LOCAL aArea 			:= GetArea()
LOCAL aAreaSE1			:= SE1->( GetArea() )
LOCAL cQuery
LOCAL cArqTmp
LOCAL _aEstr := {}
AADD(_aEstr,{"CODIGO"    , "C" , 06 , 0})
AADD(_aEstr,{"NOME"      , "C" , 50 , 0})
AADD(_aEstr,{"ENDERECO"  , "C" , 50 , 0})
AADD(_aEstr,{"BAIRRO"    , "C" , 50 , 0})
AADD(_aEstr,{"CEP"       , "C" , 09 , 0})
AADD(_aEstr,{"CIDADE"    , "C" , 30 , 0})
AADD(_aEstr,{"UF"        , "C" , 02 , 0})
AADD(_aEstr,{"CNPJ"      , "C" , 14 , 0})
AADD(_aEstr,{"DTCADAS"   , "D" , 08 , 0})
AADD(_aEstr,{"DTASSOC"   , "D" , 08 , 0})
AADD(_aEstr,{"TELEFONE"  , "C" , 25 , 0})
AADD(_aEstr,{"CODASSO"   , "C" , 06 , 0})
AADD(_aEstr,{"SITUACAO"  , "C" , 02 , 0})
AADD(_aEstr,{"ERSIN"     , "C" , 02 , 0})
AADD(_aEstr,{"CATEGORIA" , "C" , 05 , 0})
AADD(_aEstr,{"NATUREZA"  , "C" , 10 , 0})
AADD(_aEstr,{"TITULO"    , "C" , 12 , 0})
AADD(_aEstr,{"VALORTIT"  , "N" , 15 , 2})
AADD(_aEstr,{"DATAVENCTO", "D" , 08 , 0})
AADD(_aEstr,{"DATAPAGTO" , "D" , 08 , 0})
AADD(_aEstr,{"VALORREC"  , "N" , 15 , 2})
AADD(_aEstr,{"NUMBCO"    , "C" , 15 , 0})
AADD(_aEstr,{"BASE"      , "C" , 04 , 0})
AADD(_aEstr,{"INATIVO"   , "C" , 001, 0}) 
AADD(_aEstr,{"DTABERT"   , "D" , 008, 0}) 
AADD(_aEstr,{"DTINASS"   , "D" , 008, 0}) 
AADD(_aEstr,{"DTFIMASS"  , "D" , 008, 0}) 
AADD(_aEstr,{"VALASSOC"  , "N" , 017, 2})
AADD(_aEstr,{"FOLHA"     , "N" , 017, 2})  
AADD(_aEstr,{"CAPITAL"   , "N" , 017, 2}) 
AADD(_aEstr,{"CAPCENT"   , "C" , 001, 0}) 
AADD(_aEstr,{"FOLHA_CENT", "C" , 001, 0}) 
AADD(_aEstr,{"LEITOS"    , "N" , 017, 0}) 
AADD(_aEstr,{"FUNCION"   , "N" , 017, 0}) 
AADD(_aEstr,{"ESCR_CONT" , "C" , 014, 0}) 
AADD(_aEstr,{"FILANT"    , "C" , 001, 0}) 
AADD(_aEstr,{"HISTORICO" , "C" , 255, 0}) 
AADD(_aEstr,{"HISTORICO2", "C" , 255, 0}) 
AADD(_aEstr,{"HISTASS"   , "C" , 080, 0}) 
AADD(_aEstr,{"EMISSAO"   , "D" , 008, 0}) 
AADD(_aEstr,{"VENCREA"   , "D" , 008, 0}) 
AADD(_aEstr,{"JUROS"     , "N" , 017, 2}) 
AADD(_aEstr,{"VALBAIXA"  , "N" , 017, 2}) 
AADD(_aEstr,{"BOLETO"    , "C" , 015, 0}) 
AADD(_aEstr,{"ARQBCO"    , "C" , 012, 0}) 
AADD(_aEstr,{"VALCRED"   , "N" , 017, 2}) 
AADD(_aEstr,{"DTCRED"    , "D" , 008, 0}) 
AADD(_aEstr,{"NOMEESCR"  , "C" , 040, 0}) 
AADD(_aEstr,{"ENDESCR"   , "C" , 040, 0}) 
AADD(_aEstr,{"CEPESCR"   , "C" , 008, 0}) 
AADD(_aEstr,{"BAIRESCR"  , "C" , 020, 0}) 
AADD(_aEstr,{"MUNESCR"   , "C" , 020, 0}) 
AADD(_aEstr,{"ESTESCR"   , "C" , 002, 0}) 
AADD(_aEstr,{"FONEESCR"  , "C" , 020, 0}) 
AADD(_aEstr,{"HIST_PAGTO", "C" , 050, 0}) 
AADD(_aEstr,{"SINDICATO" , "C" , 002, 0}) 

/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Variaveis utilizadas para parametros                             ³
	³                                                                  ³
	³ mv_par01     ¦ CNPJ ?                                            ³
	³ mv_par02     ¦ Emissao de ?                                       ³
	³ mv_par03     ¦ Emissao ate?                                       ³
	³ mv_par04     ¦ Natureza   ?                                       ³
	³ mv_par05     ¦ Historico ?                                       ³
	³ mv_par06     ¦ Baixar ou Reverter ?                              ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

Pergunte( "ISENTO")

cQueryCount :=	"SELECT 	COUNT(*) NCOUNT FROM SE1010 SE1 " + ;
					"WHERE  	E1_FILIAL = '" + xFilial( "SE1" ) + "' AND " + ;
				 	"E1_CGC = '" + MV_PAR01 + "' AND E1_EMISSAO >= '" + DTOS(MV_PAR02) + ;
				 	"' AND E1_EMISSAO <= '" + DTOS(MV_PAR03) + "' " +;
   				"AND E1_NATUREZ = '" + MV_PAR04 + "' " + ;
					"AND SE1.D_E_L_E_T_=' ' AND E1_STATUS = '" + IIF( MV_PAR06 == 1, "A", "B" ) + "' " + ;
					IIF( MV_PAR06 == 2, "AND E1_IDENTEE = 'ISENTO' ", "" )

PADSQL( "ISENTO.SQL",cQueryCount, 80 )

TCQUERY cQueryCount NEW ALIAS "TRB"
nNumTit1 := TRB->( nCount )
TRB->( DbCloseArea() )

IF nNumTit1 == 0
	MsgStop( "Nao existem titulos com o CNPJ " + mv_par01 + ;
				" e entre " + DTOC(MV_PAR02) + " e " + DTOC(MV_PAR03) + " a serem " + IIF( MV_PAR06 == 1, "Baixados ", "Revertidos " ))
	RETURN
ENDIF

IF ! MsgYesNo( 	"Confirma a " + IIF( MV_PAR06 == 1, "Baixa ", "Reversao " ) + "dos " + STRZERO( nNumTit1, 4 ) + " titulos do "  + CHR(13) + CHR(10 ) + ;
					"CNPJ "+ mv_par01 + CHR(13) + CHR(10 ) + ;
					" entre " + DTOC(mv_par02) + " e " + DTOC(mv_par03) + " ?") 
	RETURN            
ENDIF
  
cArqtmp := CriaTrab(_aEstr,.t.)
dbusearea(.t.,,cArqTmp,"TMP",.T.)


CQUERYRpt := " SELECT A1_COD,A1_NOME,A1_END,A1_BAIRRO,A1_CEP,A1_MUN,A1_EST,A1_CGC,A1_DTCADAS,A1_DTINASS,A1_TEL, "
CQUERYRpt += " A1_CODASSO,E1_NATUREZ,E1_PREFIXO,E1_NUM,E1_PARCELA, E1_VENCTO,E1_EMISSAO,E1_VALOR,E1_BAIXA, E1_SINDICA, "
CQUERYRpt += " E1_VALLIQ,E1_JUROS,A1_ERSIN,A1_SITUAC,E1_CONFED,A1_CATEG1,E1_HIST,E1_VALCRED,E1_DTCRED,A1_BASE,E1_ARQBCO, "
CQUERYRpt += " A1_INAT,A1_DTINIC,A1_DTINASS,A1_DTFIMAS,A1_VALASSO,A1_FOLHA,A1_CAPITAL,A1_CAPCENT,A1_FOLCENT,A1_LEITOS,A1_NUMFUN,A1_ESCCONT, "
CQUERYRpt += " A1_FILANT,A1_HIST,A1_HIST2,A1_HISTASS,E1_VENCREA "
CQUERYRpt += " FROM SE1010 SE1 LEFT JOIN SA1010 SA1 ON E1_CLIENTE=A1_COD AND E1_LOJA=A1_LOJA AND SA1.D_E_L_E_T_='' "
CQUERYRpt += " WHERE  	E1_FILIAL = '" + xFilial( "SE1" ) + "' AND " + ;
							 	"E1_CGC = '" + MV_PAR01 + "' AND E1_EMISSAO >= '" + DTOS(MV_PAR02) + ;
							 	"' AND E1_EMISSAO <= '" + DTOS(MV_PAR03) + "' " +;
		   					"AND E1_NATUREZ = '" + MV_PAR04 + "' " + ;
								"AND SE1.D_E_L_E_T_=' ' AND E1_STATUS = 'B' AND E1_IDENTEE = 'ISENTO' "

cDate := DTOS( dDataBase )

cWhere := 	"WHERE  	E1_FILIAL = '" + xFilial( "SE1" ) + "' AND " + ;
						 	"E1_CGC = '" + MV_PAR01 + "' AND E1_EMISSAO >= '" + DTOS(MV_PAR02) + ;
						 	"' AND E1_EMISSAO <= '" + DTOS(MV_PAR03) + "' " +;
		   				"AND E1_NATUREZ = '" + MV_PAR04 + "' " + ;
							"AND D_E_L_E_T_=' ' AND E1_STATUS = '" + IIF( MV_PAR06 == 1, "A", "B" ) + "' "

IF MV_PAR06 == 1 //baixar
	cQuery := 	"UPDATE SE1010 SET E1_STATUS = 'B', E1_SALDO = 0, E1_VALLIQ = 0, E1_BAIXA = '" + DTOS(MV_PAR07) +"', " +;
										"E1_OK = '" + CHR(69)+CHR (120) + "', E1_SITUACA = '1', " +;
										"E1_IDENTEE = 'ISENTO', E1_VALCRED = 0, E1_DESCONT = E1_VALOR, E1_DTCRED = '" +DTOS(MV_PAR07) + "' ," +;
										"E1_HIST  = '" + MV_PAR05 + "' "
	ELSE //reverter
	cQuery := 	"UPDATE SE1010 SET E1_STATUS = 'A', E1_SALDO = E1_VALOR, E1_VALLIQ = 0, E1_BAIXA = '' , " +;
										"E1_OK = '' , E1_SITUACA = '0', " +;
										"E1_IDENTEE = '', E1_VALCRED = 0, E1_DTCRED = ''," +;
										" E1_DESCONT = 0,E1_HIST='' "
ENDIF

cQuery    += cWhere + IIF( MV_PAR06 == 2, "AND E1_IDENTEE = 'ISENTO' ", "" )

PADSQL( "ISENTO.SQL",cQuery, 80 )
PADSQL( "ISENTOR.SQL",cQueryRpt, 80 )

IF MV_PAR06 == 2
	TCQUERY cQueryRpt NEW ALIAS "TRB"
ENDIF

TCSQLEXEC(cQuery)

IF MV_PAR06 == 1
	TCQUERY cQueryRpt NEW ALIAS "TRB"
ENDIF

RelBxs()

TRB->( DbCloseArea() )
TMP->( DbCloseArea() )
FERASE( cArqTmp )

RestArea( aAreaSE1 )
RestArea( aArea )
                                                             
MsgInfo( "Foram " + IIF( MV_PAR06 == 1, "Baixados ", "Revertidos " )+ STRZERO( nNumTit1, 6 ) +  " Titulos para o CNPJ " + mv_par01 )

RETURN

STATIC FUNCTION RELBXS()

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
cbcont := 0
cbtxt := ""
wnrel := ""
cDesc1 := "Este programa irá imprimir a relacao de baixas"
cDesc2 := ""
cDesc3 := ""
cString := "SE1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Relação de " + IIF( MV_PAR06 = 1, "Baixados", "Revertidos" )
cabec2 := ""
CABEC1 := "Ersin Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Baixa  Vlr. Recebido Situacao No.Bancário   Arquivo "
//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99,999,999.99 zz       xXXXXXXXXXXXX 
//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15
aReturn := { "Zebrado", 1,"Administração", 4, 2, 1, "",1 }
nomeprog := "RELBXS"
nLastkey := 0

cPerg := "ISENTO"
/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³01       ¦ Informacoes Cadastrais ?       ¦ N       ¦          1³
//³02       ¦ Naturezas ?                    ¦ C       ¦         50³
//³03       ¦ Data Emissao de ?              ¦ D       ¦          8³
//³04       ¦ Data Emissao ate ?             ¦ D       ¦          8³
//³05       ¦ Data da Baixa de ?             ¦ D       ¦          8³
//³06       ¦ Data da Baixa Ate ?            ¦ D       ¦          8³
//³07       ¦ Quais Situacoes ?              ¦ C       ¦         10³
//³08       ¦ Quais Ersin ?                  ¦ C       ¦         30³
//³09       ¦ Do Banco ?                     ¦ C       ¦          3³
//³10       ¦ Até o Banco ?                  ¦ C       ¦          3³
//³11       ¦ Nome do Arquivo ?              ¦ C       ¦         12³
//³12       ¦ Data a Considerar ?            ¦ N       ¦          1³
//³13       ¦ Valor de ?                     ¦ N       ¦         17³
//³14       ¦ Valor Ate ?                    ¦ N       ¦         17³
//³15       ¦ Qto aos termos ?               ¦ N       ¦          1³
//³16       ¦ Sindicato Hospitais            ¦ C       ¦          2³
//³17       ¦ Data Inicio Sind. De ?         ¦ D       ¦          8³
//³18       ¦ Data Inicio Sind. Ate ?        ¦ D       ¦          8³
//³19       ¦ 1a Mensagem Boleto ?           ¦ C       ¦          8³
//³20       ¦ Cliente ?                      ¦ C       ¦          6³
//³21       ¦ Bordero ?                      ¦ C       ¦          6³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/

m_pag := 1
li := 80
wnrel := "RELBXS"
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)
if nLastkey == 27
	return
endif
SetDefault(aReturn,cString)
if nLastkey == 27
	return
endif
RptStatus({|| impREL() },titulo)
Return
**********
Static function ImpREL()

dbselectarea("trb")
SetRegua(RecCount())
VALTIT := VALPG := QTDPG := 0
mv_par12 = 1
IF mv_par12 == 1

	CABEC1 := "Ersin Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Baixa  Vlr. Recebido Sit. Sind."
	//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99,999,999.99 zz       xxxxxxxxxxxxxx
	//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15
	XDATA := TRB->E1_BAIXA
	CPODATA := "TRB->E1_BAIXA"
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	@ LI,000 PSAY "DATA: "+DTOC(STOD(TRB->E1_BAIXA))
ELSE
	CABEC1 := "Ersin Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Cred.  Vlr. Recebido Sit. No.Bancário    Arquivo      Sind."
	//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99,999,999.99 zz       x
	//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15
	XDATA := TRB->E1_DTCRED
	CPODATA := "TRB->E1_DTCRED"
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	@ LI,000 PSAY "DATA: "+DTOC(STOD(TRB->E1_DTCRED))
ENDIF
while !eof()
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	XNATUREZA := TRB->E1_NATUREZ
	NATVALTIT := NATVALPG := NATQTDPG := 0
	DBSELECTAREA("SED")
	DBSETORDER(1)
	DBSEEK(XFILIAL()+TRB->E1_NATUREZ)
	@ LI,000 PSAY "NATUREZA: "+ALLTRIM(TRB->E1_NATUREZ)+" "+SED->ED_DESCRIC
	LI+= 2
	dbselectarea("trb")
	DO WHILE !EOF() .AND. TRB->E1_NATUREZ == XNATUREZA
		
		datVALTIT := datVALPG := DATQTDPG := 0
		INCREGUA()
		if Li >= 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		endif
		IF mv_par12 == 1

			CABEC1 := "Ersin Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Baixa  Vlr. Recebido Situacao No.Bancário"
			//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99,999,999.99 zz       x
			//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
			//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15
			
			XDATA := TRB->E1_BAIXA
			CPODATA := "TRB->E1_BAIXA"
			@ LI,000 PSAY "DATA: "+DTOC(STOD(TRB->E1_BAIXA))
		ELSE
			CABEC1 := "Ersin Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Cred.  Vlr. Recebido Situacao No.Bancário"
			//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99,999,999.99 zz       x
			//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
			//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15
			
			XDATA := TRB->E1_DTCRED
			CPODATA := "TRB->E1_DTCRED"
			@ LI,000 PSAY "DATA: "+DTOC(STOD(TRB->E1_DTCRED))
		ENDIF
		LI+= 2
		dbselectarea("trb")
		DO WHILE !EOF() .AND. &CPODATA == XDATA
			
			if Li >= 60
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
			endif
			dbselectarea("szc")
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
			msunlock()
			@ LI,000 PSAY TRB->A1_ERSIN
			@ LI,006 PSAY TRB->A1_NOME
			@ LI,057 PSAY TRB->A1_CGC PICTURE "@R 99.999.999/9999-99"
			@ LI,076 PSAY TRB->E1_NATUREZ
			@ LI,087 PSAY TRB->E1_PREFIXO+"-"+TRB->E1_NUM+"-"+TRB->E1_PARCELA
			@ LI,101 PSAY STOD(TRB->E1_VENCTO)
			@ LI,110 PSAY TRB->E1_VALOR+trb->e1_juros PICTURE "@E 99,999,999.99"
			IF mv_par06 == 1
				@ LI,125 PSAY STOD(TRB->E1_BAIXA)
			ELSE
				@ LI,125 PSAY CTOD("") //STOD(TRB->E1_DTCRED)
			ENDIF
			IF ALLTRIM(TRB->E1_NATUREZ) == "003"
				@ LI,135 PSAY TRB->E1_VALcred PICTURE "@E 99,999,999.99"
				DATVALPG  += TRB->E1_VALcred
			else
				@ LI,135 PSAY TRB->E1_VALLIQ PICTURE "@E 99,999,999.99"
				DATVALPG  += TRB->E1_VALLIQ
			ENDIF
			@ LI,149 PSAY TRB->A1_SITUAC
//			@ li,154 psay trb->e1_confed
//			@ li,169 psay trb->e1_arqbco    // MUDAR O SITUACAO PARA SIT  E AUMENTAR E1_HIST
			@ li,154 psay trb->e1_sindica
			IF MV_PAR06 == 1
				@ li,157 psay left( trb->E1_HIST, 50 )
			ELSE
				@ li,157 psay "TITULO REVERTIDO SEM HISTORICO"
			ENDIF
			LI++
			DATVALTIT += TRB->E1_VALOR+trb->e1_juros
			DATQTDPG ++
			dbselectarea("trb")
			DBSKIP()
		ENDDO
		li++
		@ LI,000 PSAY "Total da Data: "+DTOC(STOD(xDATA))
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
dbSelectArea("TMP")
CARQ := "\arquivos\"+ALLTRIM(SUBS(CUSUARIO,7,15))
COPY TO &CARQ
set device to screen
if aReturn[5] == 1
	set printer to
	dbcommit()
	ourspool(wnrel)
endif
MS_FLUSH()
return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PadSql   ³ Autor ³ 		MMN - 0990       ³ Data ³05/12/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Melhora a Visualizacao da Query no Analyzer                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³VIDEOLAR                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION PadSql( cName, cQuery, nCol )

LOCAL cNewQuery := ""
LOCAL nTab      := 7

DO While Len( cLine := Upper( Left( cQuery, nCol ) ) ) == nCol

   IF ( nPos := AT( 'FROM ',     cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'WHERE ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'GROUP ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'JOIN ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'UNION ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'ORDER ', cLine ) ) > 0
      cNewQuery += LEFT( cLine, nPos - 1 ) + chr(13) + chr(10) + chr(13) + chr(10)
      nPosSpace := AT( ' ', Subst( cLine, nPos ) )
      cNewQuery += PADR( Subst( cLine, nPos, nPosSpace ), nTab )
      nPos      := nPosSpace + nPos - 1
   ELSE
      nPosSpace := RAT( ' ', cLine )
      nPosComma := RAT( ',', cLine )
      nPosAnd   := RAT( ' AND ', cLine )
      nPos      := Max( nPosSpace, nPosComma )
      nPos      := Max( nPosAnd, nPos )  
      cNewQuery += LEFT( cLine, nPos ) + chr(13) + chr(10) + SPACE( nTab )
   ENDIF
        
   cQuery := Subst( cQuery, nPos + 1 )

ENDDO

IF ( nPos := AT( 'ORDER ', cLine ) ) > 0
   cLine := LEFT( cLine,  nPos - 1 ) + chr(13) + chr(10) + chr(13) + chr(10) + SUBST( cLine, nPos )
ENDIF

MEMOWRIT( cName, cNewQuery+ cLine, 1000 )

RETURN
                                                                           

