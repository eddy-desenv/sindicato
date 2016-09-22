#include "rwmake.ch"
#include "topconn.ch"
User Function Rctarec()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ RELCAD2  ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 14.02.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao relatorio do contas a receber                    ³±±
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
cDesc1 := "Este programa ira imprimir a relacao de contas a receber"
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Relatorio de contas a receber"
cabec2 := ""

cabec1 := "Nome                                      CNPJ               Ano Titulo  Emissao    Vlr Titulo   Vencto    Natureza   Sindicato Dt.Baixa  Dt.Cred."        // 1234567890123456789012345678901234567890  99.999.999/0000-99 999 999999  99/99/99 99.999.99,99 99/99/99 999999999
        //           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
        // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
aReturn := { "Zebrado", 1,"Administração", 4, 2, 1, "",1 }
nomeprog := "RCTAREC"
nLastkey := 0                                                                                                                          
cPerg := "RCTAREC"
m_pag := 1
li := 0
pergunte(cPerg,.f.)
wnrel := "RCTAREC"
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
_aestr:={}
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
AADD(_aEstr,{"DDD"       , "C" , 02 , 0})
AADD(_aEstr,{"TELEFONE"  , "C" , 25 , 0})
AADD(_aEstr,{"CODASSO"   , "C" , 06 , 0})
AADD(_aEstr,{"SITUACAO"  , "C" , 02 , 0})
AADD(_aEstr,{"ERSIN"     , "C" , 02 , 0})
AADD(_aEstr,{"CATEGORIA" , "C" , 05 , 0})
AADD(_aEstr,{"BASE"      , "C" , 04 , 0})
AADD(_aEstr,{"NATUREZA"  , "C" , 10 , 0})
AADD(_aEstr,{"PARCELA"   , "C" , 07 , 0})
AADD(_aEstr,{"VALOR"     , "N" , 15 , 2})
AADD(_aEstr,{"DATAPAGTO" , "D" , 08 , 0})
AADD(_aEstr,{"DATAVENCTO", "D" , 08 , 0})
AADD(_aEstr,{"HISTORICO" , "C" , 50 , 0})
AADD(_aEstr,{"inativo"   , "C" , 01 , 0})
AADD(_aEstr,{"SINDICATO" , "C" , 02 , 0})
c_ArqImp := CriaTrab(_aEstr,.t.)
dbusearea(.t.,,c_ArqImp,"TMP",.T.)

titulo := mv_par05

CQUERY := " SELECT * FROM "+RETSQLNAME("SE1")+" SE1 INNER JOIN SA1010 SA1 ON E1_CLIENTE=A1_COD AND E1_LOJA=A1_LOJA "
CQUERY += " WHERE SA1.D_E_L_E_T_='' AND SE1.D_E_L_E_T_='' AND E1_EMISSAO<= '"+DTOS(MV_PAR02)+"' "
CQUERY += " AND (E1_DTCRED='' OR E1_DTCRED > '"+DTOS(MV_PAR02)+"') "                               
cquery += " AND E1_EMISSAO>= '"+DTOS(MV_PAR01)+"' AND E1_VALOR>0 "
IF !EMPTY(MV_PAR03)
	CQUERY += " AND  E1_NATUREZ IN "+FORMATIN(alltrim(MV_PAR03),"/")
ENDIF
IF !EMPTY(MV_PAR04)
	CQUERY += " AND  A1_SINDICA IN "+FORMATIN(alltrim(MV_PAR04),"/")
ENDIF
CQUERY += "ORDER BY E1_EMISSAO"
TCQUERY cQuery NEW ALIAS "TRB"
dbselectarea("trb")
SetRegua(RecCount())
LI := 80                   
t02 := t03:= t04:= t05:= t06:= ttot :=0
v02 := v03:= v04:= v05:= v06:= vtot :=0

dbgotop()
DO WHILE !EOF()
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		nLinha := prow() + 1
	endif
cabec1 := "Nome                                      CNPJ               Ano Titulo  Emissao    Vlr Titulo   Vencto    Natureza   Sindicato Dt.Baixa  Dt.Cred."
        // 1234567890123456789012345678901234567890  99.999.999/0000-99 999 999999  99/99/99 99.999.99,99   99/99/99  999999999
        //           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
        // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	@ li,000 psay subs(TRB->A1_NOME,1,40)
	@ li,042 psay TRB->a1_cgc   picture  "@r 99.999.999/9999-99"
	@ li,061 psay trb->e1_prefixo
	@ li,065 psay trb->e1_num
	@ li,073 psay stod(trb->e1_emissao)
	@ li,082 psay trb->e1_valor picture "@E 99,999,999.99"
	@ li,097 psay stod(trb->e1_vencto)
	@ li,107 psay trb->e1_naturez                                                                                                      
	@ li,118 psay trb->a1_sindica 
	@ li,128 psay stod(trb->e1_baixa)
	@ li,139 psay stod(trb->e1_dtcred)
		DBSELECTAREA("TMP")
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
					tmp->ddd       := trb->a1_ddd
					TMP->TELEFONE  := TRB->A1_TEL
					TMP->CODASSO   := TRB->A1_CODASSO
					TMP->SITUACAO  := TRB->A1_SITUAC
					TMP->ERSIN     := TRB->A1_ERSIN
					TMP->CATEGORIA := TRB->A1_CATEG1
					TMP->BASE      := TRB->A1_BASE
					TMP->NATUREZA  := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
					TMP->HISTORICO := SE1->E1_HIST
					tmp->parcela   := if(subs(se1->e1_prefixo,1,2)>"90","19","20")+subs(se1->e1_prefixo,1,2)
					tmp->valor     := se1->e1_valLIQ
					tmp->datapagto := se1->e1_baixa
					tmp->dataVENCTO:= se1->e1_VENCTO
					tmp->inativo   := TRB->a1_inat                
					TMP->SINDICATO := TRB->A1_SINDICA
					msunlock()
			

    if trb->a1_sindica == "02"

    	t02++
    	v02 += trb->e1_valor
    elseif trb->a1_sindica == "03"
    	t03++
    	v03 += trb->e1_valor
    elseif trb->a1_sindica == "04"
    	t04++
    	v04 += trb->e1_valor
    elseif trb->a1_sindica == "05"
    	t05++
    	v05 += trb->e1_valor
    elseif trb->a1_sindica == "06"
    	t06++
    	v06 += trb->e1_valor
	endif
   	ttot++
   	vtot += trb->e1_valor

	LI++
	dbselectarea("trb")
	dbskip()
ENDDO
li++
if Li >= 55
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	nLinha := prow() + 1
endif
if v02 <> 0
	@ li,000 psay "02 - SINDHOSPRU"
	@ li,065 psay t02 picture "@R 999999"
	@ li,082 psay V02 picture "@E 99,999,999.99"
	li++
endif
if v03 <> 0
	@ li,000 psay "03 - SINDRIBEIRAO"
	@ li,065 psay t03 picture "@R 999999"
	@ li,082 psay V03 picture "@E 99,999,999.99"
	li++
endif
if v04 <> 0
	@ li,000 psay "04 - SINDMOGI"
	@ li,065 psay t04 picture "@R 999999"
	@ li,082 psay V04 picture "@E 99,999,999.99"
	li++
endif
if v05 <> 0
	@ li,000 psay "05 - SINDJUNDIAI"
	@ li,065 psay t05 picture "@R 999999"
	@ li,082 psay V05 picture "@E 99,999,999.99"
	li++
endif
if v06 <> 0
	@ li,000 psay "06 - SINDSUZANO"
	@ li,065 psay t06 picture "@R 999999"
	@ li,082 psay V06 picture "@E 99,999,999.99"
	li++
endif   
LI++
li++
@ li,000 psay "TOTAL GERAL"
@ li,065 psay tTOT picture "@R 999999"
@ li,082 psay VTOT picture "@E 99,999,999.99"
li++

if LI <> 80
	roda(cbcont,cbtxt,tamanho)
endif
set device to screen
if aReturn[5] == 1
	set printer to
	dbcommit()
	ourspool(wnrel)
endif
MS_FLUSH()        
DBSELECTAREA("Tmp")
CARQ := "\arquivos\"+ALLTRIM(SUBS(CUSUARIO,7,15))
COPY TO &CARQ
DBCLOSEAREA("Tmp")
dbselectarea("trb" )
dbclosearea("trb")
dbselectarea(_cAlias)
return