#include "rwmake.ch"
#include "topconn.ch"
User Function RELescr()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ RELESCR  ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 27.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao relatorio do cadastro de escritórios             ³±±
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
cDesc1 := "Este programa ir  imprimir a relacao de escritórios e"
cDesc2 := "seus clientes."
cDesc3 := ""
cString := "SZC"
tamanho := "P"
tipo := 18
limite := 220
Titulo := "RELATORIO DE ESCRITORIOS CONTABEIS"
cabec2 := ""
cabec1 := "Nome                                       CNPJ               Cliente"
// 12345678901234567890123456789012345678901234567890 12.345.678/9012-34 xx   xxxxxxxxxxccccccccccxxxxxxxxxxcccccccccc xxxxxxxxxxxxxxxxxxxxccccc 99999-999 ccccccccccvvvvvvvvvv ff xxxxxxxxxxxxxxx xxxx xxxx xx    ccccc 66/66/99 99/99/99
//           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
aReturn := { "Zebrado", 1,"Administração", 4, 2, 1, "",1 }
nomeprog := "RELESCR"
nLastkey := 0
cPerg := "RELESC"
m_pag := 1
li := 80

/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³01       ¦ Qual Escritorio ?              ¦ C       ¦         14³
//³02       ¦ Qual Impressao ?               ¦ N       ¦          1³
//³03       ¦ Qual Ordem ?                   ¦ N       ¦          1³
//³04       ¦ Sindicato Hospitais            ¦ C       ¦          2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/

pergunte(cPerg,.f.)

wnrel := "RELESCR"
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
IF MV_PAR02 == 2
	tamanho := "G"
	CQUERY := " SELECT ZC_CODIGO,ZC_NOMESC,ZC_CGC,COUNT(A1_ESCCONT) AS NUMCLI,ZC_END,ZC_CEP,ZC_BAIRRO,ZC_MUN,ZC_EST,ZC_FONE,ZC_TEL2,ZC_FAX,ZC_EMAIL,ZC_EMAIL2,ZC_CONTATO,ZC_ERSIN,ZC_BASE,ZC_SITE,ZC_DTCADAS "
	CQUERY += " FROM "+RETSQLNAME("SZC")+" SZC RIGHT JOIN "+RETSQLNAME("SA1")+" SA1 "
	CQUERY += " ON ZC_CGC=A1_ESCCONT WHERE SZC.D_E_L_E_T_='' AND SA1.D_E_L_E_T_='' "
	IF !EMPTY(MV_PAR01)
		CQUERY += " AND ZC_CGC ='"+MV_PAR01+"' "
	ENDIF
	IF ! EMPTY( MV_PAR04)
		cQUERY += " AND A1_SINDICA = '" + MV_PAR04 + "' "	
	ENDIF

	CQUERY += " GROUP BY ZC_CODIGO,ZC_NOMESC,ZC_CGC,ZC_END,ZC_CEP,ZC_BAIRRO,ZC_MUN,ZC_EST,ZC_FONE,ZC_TEL2,ZC_FAX,ZC_EMAIL,ZC_EMAIL2,ZC_CONTATO,ZC_ERSIN,ZC_BASE,ZC_SITE,ZC_DTCADAS  "
	if mv_par03 == 1
		CQUERY += " order by ZC_NOMESC,ZC_CGC "
	elseif mv_par03 == 2
		CQUERY += " order by ZC_CEP,ZC_NOMESC,ZC_CGC "	
	ELSEif mv_paR03 == 3
		CQUERY += " order by NUMCLI "
	endif
ELSE
	tamanho := "M"
	CQUERY := " SELECT ZC_CODIGO,ZC_NOMESC,ZC_CGC,ZC_FONE,A1_SINDICA,A1_NOME,A1_SITUAC,A1_CODASSO,	A1_INAT,A1_CGC,A1_HIST ,ZC_EMAIL,ZC_CONTATO"
	CQUERY += " FROM "+RETSQLNAME("SZC")+" SZC INNER JOIN "+RETSQLNAME("SA1")+" SA1 "
	CQUERY += " ON ZC_CGC=A1_ESCCONT WHERE SZC.D_E_L_E_T_='' AND SA1.D_E_L_E_T_='' "
	IF !EMPTY(MV_PAR01)
		CQUERY += " AND ZC_CGC ='"+MV_PAR01+"' "
	ENDIF
	IF ! EMPTY( MV_PAR04)
		cQUERY += " AND A1_SINDICA = '" + MV_PAR04 + "' "	
	ENDIF

	CQUERY += " order by ZC_NOMESC,A1_SINDICA,A1_NOME "
endif
TCQUERY cQuery NEW ALIAS "TRB"
CARQ := "\arquivos\"+ALLTRIM(SUBS(CUSUARIO,7,15))
COPY TO &CARQ
dbselectarea("trb")
DBGOTOP()
SetRegua(RecCount())
IF MV_PAR02 == 2
	Titulo := "Escritórios Contabeis - Sintético"
	cabec2 := ""
	cabec1 := "Codigo Nome                                          CNPJ               Endereco                                           Bairro                    CEP       Cidade               UF  Clientes Fone"
            // 666666 123456789012345678901234567890123456789012345 12.345.678/9012-34 XXXXXXXXXXCCCCCCCCCCDDDDDDDDDDEEEEEEEEEEFFFFFFFFFF dddddddddd6666666666ppppp xxxxx-xxx ooooooooooiiiiiiiiii xx  9999,999
	TOTescr := TOTcli :=  0
	DO WHILE !EOF()
		INCREGUA()
		if Li >= 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
			nLinha := prow() + 1
		endif
		@ li,000 psay trb->zc_codigo
		@ LI,007 PSAY subs(trb->zc_nomesc,1,45)
		if len(alltrim(trb->zc_cgc)) == 14
			@ LI,053 PSAY trb->zc_cgc PICTURE "@r 99.999.999/9999-99"
		else
			@ LI,053 PSAY trb->zc_cgc
		ENDIF
		@ li,072 psay subs(trb->zc_end,1,50)
		@ li,123 psay subs(trb->zc_bairro,1,25)			 
		@ li,149 psay trb->zc_cep picture "@r 99999-999"
		@ li,159 psay subs(trb->zc_mun,1,20)			
		@ li,180 psay trb->zc_est
		@ li,184 psay TRB->NUMCLI PICTURE "@E 9999,999"
		@ li,193 psay trb->zc_fone
		totescr++
		totcli += trb->numcli
		li++
		DBSKIP()
	ENDDO
	LI++
	if Li >= 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		nLinha := prow() + 1
	endif
	@ li,000 psay "Total Escritórios: "
	@ li,023 psay totescr PICTURE "@E 9999,999"
	@ li,184 psay TOTCLI PICTURE "@E 9999,999"
	LI++
ELSE
	Titulo := "Escritórios Contabeis - Analitico"
	cabec2 := ""
//	cabec1 := "Codigo Nome                                               Situacao Assoc  Inat."
            // 666666 12345678901234567890123456789012345678901234567890 xx       999999 x 

	cabec1 :="Sind.  Nome                                               CNPJ               Cod.Assoc  Situacao Inat.  "
           //  99    12345678901234567890123456789012345678901234567890 44.444.444/0001-00 000000     xxxx     xx      
		   //
     	   //            1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
	       //  01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

	TOTescr := TOTcli :=  totsind2 :=  totsind3 :=  totsind4 :=  totsind5 :=  totsind6 := 0
	DO WHILE !EOF()
		INCREGUA()
		if Li >= 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		endif
		escant := trb->zc_nomesc
	    CNPJANT := TRB->ZC_CGC            
    	FONEANT := TRB->ZC_FONE
	    MAILANT := TRB->ZC_EMAIL
	    CONTANT := TRB->ZC_CONTATO

		cliescr :=  escsind2 :=  escsind3 :=  escsind4 :=  escsind5 :=  escsind6 := 0
		do while !eof() .and. trb->zc_nomesc ==  escant
			if Li >= 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
				nLinha := prow() + 1
			endif
			@ li,001 psay trb->a1_sindica
			@ LI,007 PSAY subs(trb->a1_nome,1,50)
			@ li,058 psay trb->a1_cgc picture "@r 99.999.999/9999-99" 
			@ li,077 psay trb->a1_codasso
			@ li,087 psay trb->a1_situac			
			@ li,096 psay trb->a1_inat

			li++
			cliescr++
 			IF TRB->A1_SINDICA=="02" 
 				ESCsind2 ++
 			ELSEIF TRB->A1_SINDICA=="03" 	
 				  escsind3 ++
 			ELSEIF TRB->A1_SINDICA=="04" 	 				  
 				  escsind4 ++
  			ELSEIF TRB->A1_SINDICA=="05" 	
 				escsind5 ++
 			ELSEIF TRB->A1_SINDICA=="06" 	
 				  escsind6 ++
 			ENDIF
			DBSKIP()
		ENDDO
		LI++
		if Li >= 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
			nLinha := prow() + 1
		endif

		totescr++
		totcli += CLIESCR
		totsind2 += escsind2 
		totsind3 += escsind3
		totsind4 += escsind4
		totsind5 += escsind5
		totsind6 += escsind6

//		@ li,000 psay "Total: "+subs(ESCANT,1,45)
//		@ li,072 psay cliescr PICTURE "@E 9999,999"
		LI ++
		@ li,000 psay "SIND 02"
		@ li,009 psay escsind2 picture "@e 999,999"
		li++
		@ li,000 psay "SIND 03"
		@ li,009 psay escsind3 picture "@e 999,999"
		li++

		@ li,000 psay "SIND 04"
		@ li,009 psay escsind4 picture "@e 999,999"
		li++
		@ li,000 psay "SIND 05"
		@ li,009 psay escsind5 picture "@e 999,999"
		li++
		@ li,000 psay "SIND 06"
		@ li,009 psay escsind6 picture "@e 999,999"		
		li += 2
		@ LI,000 PSAY "Total:"
		@ li,009 psay cliescr picture "@e 999,999"
		li+=2

		@ li,000 psay "Escrit.: "+subs(ESCANT,1,45)
		@ li,055 psay "CNPJ: "
		if len(alltrim(CNPJANT)) == 14
			@ LI,061 PSAY CNPJANT PICTURE "@r 99.999.999/9999-99"
		else
			@ LI,061 PSAY CNPJANT
		ENDIF
		@ li,085 psay "Fone: "+foneANT
		li ++
		@ li,000 psay "E-mail: " +MAILANT
		@ li,050 psay "Contato: "+ CONTANT
		LI++
		@ LI,00 PSAY REPLICATE("-",220)
		Li+= 2
	enddo
    
ENDIF                                                                                            
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
dbselectarea("TRB")
dbclosearea()
dbselectarea(_cAlias)
return
