#include "rwmake.ch"
#include "topconn.ch"
User Function IEPASLOG()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ IEPASLOG ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 14.02.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao relatorio do LOG IEPAS                           ³±±
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
cDesc1 := "Este programa ira imprimir o log IEPAS"
cDesc2 := ""
cDesc3 := ""
cString := "SZX"
tamanho := "P"
tipo := 15
limite := 80
Titulo := "Relatorio de log Iepas"
cabec2 := ""

cabec1 := "Data     Hora     CNPJ                Status   Assoc. Confed."
		// 11/11/11 11:11:11 11.111.111/1111-11
        //           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
        // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
aReturn := { "Zebrado", 1,"Administração", 4, 2, 1, "",1 }
nomeprog := "IEPASLOG"
nLastkey := 0                                                                                                                          
cPerg := "IEPASLOG"
m_pag := 1
li := 0
pergunte(cPerg,.f.)
wnrel := "IEPASLOG"
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
titulo := mv_par05

CQUERY := " SELECT * FROM "+RETSQLNAME("SZX")+" SZX "
CQUERY += " WHERE D_E_L_E_T_='' AND ZX_DATA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR01)+"'
CQUERY += "ORDER BY ZX_DATA"
TCQUERY cQuery NEW ALIAS "TRB"
dbselectarea("trb")
SetRegua(RecCount())
LI := 80                   

dbgotop()
DO WHILE !EOF()
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		nLinha := prow() + 1
	endif
cabec1 := "Data     Hora     CNPJ                Status   Assoc. Confed."
		// 11/11/11 11:11:11 11.111.111/1111-11
        //           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
        // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	@ li,000 psay STOD(trb->zx_data)
	@ li,009 psaY trb->zx_hora
	@ li,018 psay trb->ZX_cgc   picture  "@r 99.999.999/9999-99"
	@ li,038 psay trb->zx_status
	@ li,047 psay trb->ZX_ASSOC picture "@E 99"
	@ li,054 psay trb->ZX_CONF picture "@E 99"

	LI++
	dbselectarea("trb")
	dbskip()
ENDDO                                                                                                                                                                                                                                                                                          
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
dbselectarea("trb" )
dbclosearea("trb")
dbselectarea(_cAlias)
return