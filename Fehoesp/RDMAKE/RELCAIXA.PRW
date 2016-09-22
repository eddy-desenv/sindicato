#include "rwmake.ch"
User Function RELcaixa()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ RELFRANC ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 03.08.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Retorno de Contr.Sindical - Francesinha                    ³±±
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
cDesc1 := "Este programa irá imprimir O Retorno de Contr.Sindical - Caixa"
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Retorno de Contr.Sindical - Caixa"
cabec2 := ""
CABEC1 := "Ersin Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Baixa  Dt.Cred. Vlr. Recebido Situacao No.Bancário     Observacao"
//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99/99/99 99,999,999.99 zz       xXXXXXXXXXXXX
//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15       16         17
aReturn := { "Zebrado", 1,"Administração", 4, 2, 1, "",1 }
nomeprog := "RELCAIXA"
nLastkey := 0
cPerg := "FINA25"
m_pag := 1
li := 80

pergunte(cPerg,.f.)
wnrel := "RELFRANC"
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
_cARQ := "\arquivos\retorno\"+MV_PAR01
If !File( allTrim( _cArq ))
	Help(" ",1,"ARRVAZ")
	Return
endif
_nTotal:= _NTOTALEX := _NTOTALCNE := _NTOTAL99 := 0
_STotal:= _STOTALEX := _STOTALCNE := _STOTAL99 := 0
_nTotal2:= 0
_aStru := {}
AADD( _aStru, { "CAMPO"       , "C" , 150 , 0 } )
c_ArqTmp := CriaTrab(_aStru,.t.)
dbUseArea(.t.,,c_ArqTmp,"TMP")
DATVALPG := QTDREG := 0
DATVALPG := QTDREGEX := QTDREGCNE := QTDREG99 := 0
dbSelectArea("TMP")
Append From &(alltrim(_cArq)) SDF
dbGotop()
ProcRegua(RecCount(),22,05)
if SUBS(TMP->CAMPO,1,1) == "A"
	dbskip()
	_dataproc := ctod(substr(TMP->CAMPO,028,2)+"/"+substr(TMP->CAMPO,026,2)+"/"+substr(TMP->CAMPO,024,2))
	_dataCRED := ctod(substr(TMP->CAMPO,036,2)+"/"+substr(TMP->CAMPO,034,2)+"/"+substr(TMP->CAMPO,032,2))
	dbSelectArea("TMP")
	while !eof() .and. SUBS(TMP->campo,1,1) == "G"
		IncProc("Boleto Num.: "+sUbs(tmp->campo,69,13))
		_dataproc := ctod(substr(TMP->CAMPO,028,2)+"/"+substr(TMP->CAMPO,026,2)+"/"+substr(TMP->CAMPO,024,2))
		_dataCRED := ctod(substr(TMP->CAMPO,036,2)+"/"+substr(TMP->CAMPO,034,2)+"/"+substr(TMP->CAMPO,032,2))
		DATAVENC := subs(TMP->CAMPO,22,04)+"0131"
		DBSELECTAREA("SE1")
		dbOrderNickName('18')  // DBSETORDER(18) // Alterado (UPDXFUN).
		if dbseek( xFilial()+substr(TMP->CAMPO,69,13) )
			if Li >= 60
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
			endif
			dbSelectArea("SA1")
			dbSetOrder(1)
			dbseek( xFilial()+ se1->e1_cliente+se1->e1_loja )
			@ LI,000 PSAY SA1->A1_ERSIN
			@ LI,006 PSAY SA1->A1_NOME
			@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
			@ LI,076 PSAY SE1->E1_NATUREZ
			@ LI,087 PSAY SE1->E1_PREFIXO+"-"+SE1->E1_NUM+"-"+SE1->E1_PARCELA
			@ LI,101 PSAY SE1->E1_VENCTO
			@ LI,110 PSAY SE1->E1_VALOR+SE1->e1_juros PICTURE "@E 99,999,999.99"
			@ LI,125 PSAY SE1->E1_BAIXA
			@ li,135 psay se1->e1_dtcred
			@ LI,144 PSAY SE1->E1_VALcred PICTURE "@E 99,999,999.99"
			DATVALPG  += SE1->E1_VALcred
			@ LI,158 PSAY SA1->A1_SITUAC
			@ li,167 psay SE1->e1_confed
			@ LI,181 psay "Título já existente."
			QTDREGEX++
			_nTotalEX+= SE1->E1_VALLIQ
			_STotalEX+= SE1->E1_VALCRED
			li++
			DBSELECTAREA("TMP")
			DBSKIP()
			LOOP
		ENDIF
		dbSelectArea("SZ9")
		if dbseek( xFilial()+substr(TMP->CAMPO,69,13) )
			_cCGC  := SZ9->Z9_CGC
			_dVenc := SZ9->Z9_VENCTO
			_nPREF := substr(SZ9->Z9_PARCELA,2,2)
			_nPARC := substr(SZ9->Z9_PARCELA,1,1)
		else
			dbSelectArea("SA1")
			dbSetOrder(3)
			dbseek( xFilial()+ substr(TMP->CAMPO,70,12) )
			IF FOUND()
				_cCGC  := SA1->A1_CGC
				_DVENC := _DATAPROC
			ELSE
				_cCGC   := "99"   && Boleto Avulso / Termo
			ENDIF
		endif
		if _cCGC <> "99"
			dbSelectArea("SA1")
			dbSetOrder(3)
			dbseek( xFilial()+ _cCGC )
			if eof()
				if Li >= 60
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
				endif
				@ LI,000 PSAY SA1->A1_ERSIN
				@ LI,006 PSAY SA1->A1_NOME
				@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
				@ LI,076 PSAY "003"
				@ LI,087 PSAY SUBS(dtos(_dvenc),3,2)+"S"+"-999999-"
				@ LI,101 PSAY STOD(DATAVENC)
				@ LI,110 PSAY (val( substr(TMP->CAMPO,82,12) )/100)+((val( substr(TMP->CAMPO,82,12) )/100)-(val( substr(TMP->CAMPO,82,12) )/100)) PICTURE "@E 99,999,999.99"
				//				@ LI,125 PSAY _DATAPROC
				//				@ li,135 psay _datacred
				@ LI,144 PSAY (val( substr(TMP->CAMPO,118,12) )/100) PICTURE "@E 99,999,999.99"
				DATVALPG  += (val( substr(TMP->CAMPO,118,12) )/100)
				@ LI,158 PSAY SA1->A1_SITUAC
				@ li,167 psay  substr(TMP->CAMPO,69,13)
				@ LI,181 psay "Cliente nao encontrado."
				QTDREGCNE++
				_nTotalCNE+= (val( substr(TMP->CAMPO,82,12) )/100)+((val( substr(TMP->CAMPO,82,12) )/100)-(val( substr(TMP->CAMPO,82,12) )/100))
				_STotalCNE+=  (val( substr(TMP->CAMPO,118,12) )/100)
				li++
				dbSelectArea("TMP")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('18')  // dbSetOrder(18) // Alterado (UPDXFUN).
		dbseek( xFilial()+substr(TMP->CAMPO,69,13) )
		_lMovimenta := .f.
		VALTIT   := (((val( substr(TMP->CAMPO,82,12) )/100)-(val( substr(TMP->CAMPO,118,12) )/100))/.4 )
		IF (val( substr(TMP->CAMPO,82,12) )/100)-VALTIT <1
			VALJUROS := 0
			VALTIT   := (val( substr(TMP->CAMPO,82,12) )/100)
		ELSE
			VALJUROS := (val( substr(TMP->CAMPO,82,12) )/100)-VALTIT
		ENDIF
		if eof()
			IF _cCGC <> "99"
				_lMovimenta := .t.
				if Li >= 60
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
				endif
				@ LI,000 PSAY SA1->A1_ERSIN
				@ LI,006 PSAY SA1->A1_NOME
				@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
				@ LI,076 PSAY "003"
				@ LI,087 PSAY SUBS(dtos(_dvenc),3,2)+"S"+SA1->A1_COD
				@ LI,101 PSAY STOD(DATAVENC)
				@ LI,110 PSAY (val( substr(TMP->CAMPO,82,12) )/100)+((val( substr(TMP->CAMPO,82,12) )/100)-(val( substr(TMP->CAMPO,82,12) )/100)) PICTURE "@E 99,999,999.99"
				//				@ LI,125 PSAY _DATAPROC
				//				@ li,135 psay _datacred
				@ LI,144 PSAY (val( substr(TMP->CAMPO,118,12) )/100) PICTURE "@E 99,999,999.99"
				DATVALPG  += (val( substr(TMP->CAMPO,118,12) )/100)
				@ LI,158 PSAY SA1->A1_SITUAC
				@ li,167 psay  substr(TMP->CAMPO,69,13)
				@ LI,181 psay "Titulo será gerado.Cliente encontrado."
				li++
				QTDREG++
				_nTotal+= (val( substr(TMP->CAMPO,82,12) )/100)+((val( substr(TMP->CAMPO,82,12) )/100)-(val( substr(TMP->CAMPO,82,12) )/100))
				_STotal+= (val( substr(TMP->CAMPO,118,12) )/100)
			ELSE
				_lMovimenta := .t.
				if Li >= 60
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
				endif
				@ LI,000 PSAY SA1->A1_ERSIN
				@ LI,006 PSAY SA1->A1_NOME
				@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
				@ LI,076 PSAY "003"
				@ LI,087 PSAY SUBS(dtos(_dvenc),3,2)+"S"+"-999999-"
				@ LI,101 PSAY STOD(DATAVENC)
				@ LI,110 PSAY (val( substr(TMP->CAMPO,82,12) )/100)+((val( substr(TMP->CAMPO,82,12) )/100)-(val( substr(TMP->CAMPO,82,12) )/100)) PICTURE "@E 99,999,999.99"
				//				@ LI,125 PSAY _DATAPROC
				//				@ li,135 psay _datacred
				@ LI,144 PSAY (val( substr(TMP->CAMPO,118,12) )/100) PICTURE "@E 99,999,999.99"
				DATVALPG  += (val( substr(TMP->CAMPO,118,12) )/100)
				@ LI,156 PSAY SA1->A1_SITUAC
				@ li,167 psay  substr(TMP->CAMPO,69,13)
				@ LI,181 psay "Titulo será gerado.Cliente 999999."
				QTDREG99++
				li++
				_nTotal99+= (val( substr(TMP->CAMPO,82,12) )/100)+((val( substr(TMP->CAMPO,82,12) )/100)-(val( substr(TMP->CAMPO,82,12) )/100))
				_STotal99+= (val( substr(TMP->CAMPO,118,12) )/100)
			ENDIF
		endif
		dbSelectArea("TMP")
		dbskip()
	enddo
endif
dbSelectArea("TMP")
dbCloseArea()
If File(c_ArqTmp+".DBF")
	Ferase(c_ArqTmp+".DBF")
EndIf
li ++
@ li,000 psay "Titulos a Baixar Contribuintes: " +alltrim(str(qtdreg))
@ li,060 psay "Valor a Baixar: "
@ li,090 psay _NTOTAL picture "@e 999,999,999.99"
@ LI,110 PSAY "Valor Sindhosp: "
@ li,130 psay _sTOTAL picture "@e 999,999,999.99"
li ++
@ li,000 psay "Titulos a Baixar 999999:        " +alltrim(str(qtdreg99))
@ li,060 psay "Valor a Baixar:   "
@ li,090 psay _NTOTAL99 picture "@e 999,999,999.99"
@ LI,110 PSAY "Valor Sindhosp: "
@ li,130 psay _sTOTAL99 picture "@e 999,999,999.99"
li++
@ li,000 psay "Titulos já baixados:            " +alltrim(str(qtdregex))
@ li,060 psay "Valor já baixados: "
@ li,090 psay _NTOTALex picture "@e 999,999,999.99"
@ LI,110 PSAY "Valor Sindhosp: "
@ li,130 psay _sTOTALex picture "@e 999,999,999.99"
li ++
@ li,000 psay "Titulos Cliente nao Encontrados:" +alltrim(str(qtdregcne))
@ li,060 psay "Valor Nao Encontrado: "
@ li,090 psay _NTOTALcne picture "@e 999,999,999.99"
@ LI,110 PSAY "Valor Sindhosp: "
@ li,130 psay _sTOTALcne picture "@e 999,999,999.99"
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
dbSelectArea("SA1")
dbSetOrder(1)
dbSelectArea("SE1")
dbSetOrder(1)
Return(nil)