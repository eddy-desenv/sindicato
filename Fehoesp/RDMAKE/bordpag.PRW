#include "rwmake.ch"
#include "topconn.ch"
User Function bordpag()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ BORDPAG  ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 25.02.16 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao relatorio O BORDERO DE PAGAMENTOS                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico IEPAS                                           ³±±
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
cDesc1 := "Este programa ira imprimir o bordero de pagamentos"
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Bordero de Pagamentos"
cabec2 := ""


cabec1 := "Titulo           Fornecedor                                Historico                                                     Vencimento         Valor  |       Financeiro       |       Tesoureiro       |       Presidente     |"
        // XXX-XXXXXXXXX-X  1234567890123456789012345678901234567890  123456789012345678901234567890123456789012345678901234567890  99/99/99    9,999,999.99
        //           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
        // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
aReturn := { "Zebrado", 1,"Administração", 4, 2, 1, "",1 }
nomeprog := "RCTAREC"
nLastkey := 0                                                                                                                          
cPerg := "BORDPAG"
m_pag := 1
li := 0
pergunte(cPerg,.f.)
wnrel := "BORDPAG"
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
/*_aestr:={}
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
AADD(_aEstr,{"FILANT"    , "C" , 01 , 0})
AADD(_aEstr,{"NATUREZA"  , "C" , 10 , 0})
AADD(_aEstr,{"NUMTITULO" , "C" , 12 , 0})
AADD(_aEstr,{"VALORTIT"  , "N" , 15 , 2}) 
AADD(_aEstr,{"VALCRED"   , "N" , 15 , 2})
AADD(_aEstr,{"DATABAIXA"     , "D" , 08 , 0})
AADD(_aEstr,{"DATACRED"  , "D" , 08 , 0})
AADD(_aEstr,{"DATAVENCTO", "D" , 08 , 0})
AADD(_aEstr,{"HISTORICO" , "C" , 50 , 0})
AADD(_aEstr,{"SINDICATO" , "C" , 02 , 0})
AADD(_aEstr,{"A1_TEL" , "C" , 15 , 0})
AADD(_aEstr,{"A1_TEL2" , "C" , 15 , 0})
AADD(_aEstr,{"A1_TEL3" , "C" , 15 , 0})
AADD(_aEstr,{"A1_EMAIL" , "C" , 60 , 0})
AADD(_aEstr,{"A1_EMAIL2" , "C" , 60 , 0})
AADD(_aEstr,{"A1_EMAIL3" , "C" , 60 , 0})
AADD(_aEstr,{"A1_DTINIC" , "D" , 08 , 0})
AADD(_aEstr,{"A1_DTCADAS" , "D" , 08 , 0})
AADD(_aEstr,{"A1_DTINASS" , "D" , 08 , 0})
AADD(_aEstr,{"A1_DTFIMAS" , "D" , 08 , 0})
AADD(_aEstr,{"A1_SITUAC" , "C" , 02 , 0})
AADD(_aEstr,{"A1_CATLEIT" , "C" , 03 , 0})
AADD(_aEstr,{"A1_VALASSO" , "N" , 08 , 2})
AADD(_aEstr,{"A1_BASE" , "C" , 04 , 0})
AADD(_aEstr,{"A1_CATEG1" , "C" , 05 , 0})
AADD(_aEstr,{"A1_CATEG2" , "C" , 05 , 0})
AADD(_aEstr,{"A1_SCONTAT" , "C" , 40 , 0})
AADD(_aEstr,{"A1_SINDICA" , "C" , 02 , 0})
AADD(_aEstr,{"A1_NOMPRES" , "C" , 40 , 0})
AADD(_aEstr,{"A1_ADMPROV" , "C" , 40 , 0})
AADD(_aEstr,{"A1_SUPERIN" , "C" , 40 , 0})
AADD(_aEstr,{"A1_DIRCLIN" , "C" , 40 , 0})
AADD(_aEstr,{"A1_DIRFIN" , "C" , 40 , 0})
AADD(_aEstr,{"A1_DIRRH" , "C" , 40 , 0})
AADD(_aEstr,{"A1_DIRADM" , "C" , 40 , 0})
AADD(_aEstr,{"A1_EMAIL10" , "C" , 60 , 0})
AADD(_aEstr,{"A1_COML" , "C" , 40 , 0})
AADD(_aEstr,{"A1_EMAIL12" , "C" , 60 , 0})
AADD(_aEstr,{"A1_FOLHA" , "N" , 10 , 2})
AADD(_aEstr,{"A1_CAPITAL" , "N" , 15 , 2})
AADD(_aEstr,{"A1_FISICO" , "C" , 01 , 0})
AADD(_aEstr,{"A1_CAPCENT" , "C" , 01 , 0})
AADD(_aEstr,{"A1_FOLCENT" , "C" , 01 , 0})
AADD(_aEstr,{"A1_NCONF" , "C" , 01 , 0})
AADD(_aEstr,{"A1_CONF" , "C" , 01 , 0})
AADD(_aEstr,{"A1_ENDCOB" , "C" , 40 , 0})
AADD(_aEstr,{"A1_LEITOS" , "N" , 05 , 0})
AADD(_aEstr,{"A1_ESCCONT" , "C" , 14 , 0})
AADD(_aEstr,{"E1_PREFIXO" , "C" , 03 , 0})
AADD(_aEstr,{"E1_NUM" , "C" , 06 , 0})
AADD(_aEstr,{"E1_EMISSAO" , "D" , 08 , 0})
AADD(_aEstr,{"E1_VENCREA" , "D" , 08 , 0})

c_ArqImp := CriaTrab(_aEstr,.t.)
dbusearea(.t.,,c_ArqImp,"TMP",.T.)
*/

CQUERY := " SELECT * FROM "+RETSQLNAME("SEA")+" SEA INNER JOIN SE2010 SE2 ON "
CQUERY += " EA_NUMBOR=E2_NUMBOR AND EA_PREFIXO=E2_PREFIXO AND EA_NUM=E2_NUM AND EA_PARCELA=E2_PARCELA AND EA_FORNECE=E2_FORNECE AND EA_LOJA=E2_LOJA"
CQUERY += " WHERE SE2.D_E_L_E_T_='' AND SEA.D_E_L_E_T_=''  AND EA_NUMBOR='"+MV_PAR01+"' and EA_CART='P' "
CQUERY += " ORDER BY E2_VENCREA"

TCQUERY cQuery NEW ALIAS "TRB"
dbselectarea("trb")
SetRegua(RecCount())
LI := 80                   
t02 := t03:= t04:= t05:= t06:= ttot :=0
v02 := v03:= v04:= v05:= v06:= vtot :=0
TITULO := ALLTRIM(TITULO)+" Numero "+mv_par01+"    - ITAU BANKLINE AGENCIA "+TRB->EA_AGEDEP+"  CONTA "+trb->ea_numcon
dbgotop()
DO WHILE !EOF()
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		nLinha := prow() + 1
	endif

cabec1 := "Titulo           Fornecedor                                Historico                                                     Vencimento         Valor  |       Financeiro       |       Tesoureiro       |       Presidente     |"
        // XXX-XXXXXXXXX-X  1234567890123456789012345678901234567890  123456789012345678901234567890123456789012345678901234567890  99/99/99    9,999,999.99
        //           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
        // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	dbselectarea("sa2")
	dbsetorder(1)
	dbseek(xfilial()+trb->e2_fornece+trb->e2_loja)
	@ li,000 psay TRB->e2_prefixo+"-"+trb->e2_num+"-"+trb->e2_parcela
	@ li,017 psay subs(sa2->a2_nome,1,40)
	@ li,059 psay SUBS(trb->e2_HIST,1,60) 
	@ li,121 psay stod(trb->e2_vencrea)
	@ li,133 psay trb->e2_valor picture "@E 9,999,999.99"
	@ li,147 psay "|"
	@ li,172 psay "|"
	@ li,197 psay "|"
	@ li,220 psay "|"
   	
   	vtot += trb->e2_valor
	LI++    
	if len(alltrim(trb->E2_Hist))>60
		@ li,059 psay SUBS(trb->e2_HIST,61,60)
		@ li,147 psay "|"
	@ li,172 psay "|"
	@ li,197 psay "|"
	@ li,220 psay "|"
	LI++
	endif
	@ LI,000 PSAY REPLICATE ("-",220) 
	LI++
	dbselectarea("trb")
	dbskip()
ENDDO
li++
if Li >= 55
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	nLinha := prow() + 1
endif
li+=2
@ li,110 psay replicate("-",110)
LI++
@ li,110 psay "Total do Bordero"
@ li,133 psay VTOT picture "@E 9,999,999.99" 
@ li,147 psay "|"
@ li,172 psay "|"
@ li,197 psay "|"
@ li,220 psay "|"
li++
@ li,110 psay replicate("-",110)
LI++

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
dbselectarea("trb" )
dbclosearea("trb")
dbselectarea(_cAlias)
return