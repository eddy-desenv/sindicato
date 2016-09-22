#include "rwmake.ch"
User Function RELfranc()
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � RELFRANC � Autor � Luis Mattos Duarte Jr.� Data � 03.08.05 ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Retorno de Contr.Sindical - Francesinha                    ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico SINDHOSP                                        ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
cDesc1 := "Este programa ir� imprimir O Retorno de Contr.Sindical - Francesinha"
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "G"
tipo := 15
limite := 220
Titulo := "Retorno de Contr.Sindical - Francesinha"
cabec2 := ""
CABEC1 := "Ersin Nome                                               CNPJ               Natureza   Titulo        Vencto      Vlr.Titulo  Dt.Baixa  Dt.Cred. Vlr. Recebido Situacao No.Banc�rio     Observacao"
//         xx    xxxxxxxxxxccccccccccddddddddddfffffffffftttttttttt 99.999.999/9999-99 xxxxxxxxxx 999-999999-9  99/99/99 99,999,999.99  99/99/99  99/99/99 99,999,999.99 zz       xXXXXXXXXXXXX
//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9         10        11        12        13        14        15       16         17
aReturn := { "Zebrado", 1,"Administra��o", 4, 2, 1, "",1 }
nomeprog := "RELFRANC"
nLastkey := 0
cPerg := "FINA26"
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
_cARQ := "\arquivos\RETORNO\"+SUBS(MV_PAR01,1,12)
If !File( allTrim( _cArq ))
	Help(" ",1,"ARRVAZ")
	Return
endif
_nTotal:= 0		 // totalizador de Assistencial
_nTotal2:= 0		 // totalizador de Termos
_aStru := {}
AADD( _aStru, { "CAMPO"       , "C" , 150 , 0 } )
c_ArqTmp := CriaTrab(_aStru,.t.)
dbUseArea(.t.,,c_ArqTmp,"TMP")
dbSelectArea("TMP")
Append From &(alltrim(_cArq)) SDF
dbGotop()
SETRegua(RecCount())
DDATA := CTOD("  /  /  ")
_dataproc := MV_par02
QTDREG := 0
valignor := 0
DATVALPG := VALBX := valcbx := 0
qtdje := valje := valcje:= 0
while !eof()
	INCREGUA()
	if Li >= 60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
	endif
	IF SUBS(TMP->CAMPO,106,16)== "DATA DO CREDITO:"
		CDATA := SUBS(TMP->CAMPO,123,5)+"/"+SUBS(TMP->CAMPO,131,2)
		DDATA := CTOD(CDATA)
	ENDIF
	if subs(tmp->campo,45,1)<>"," .or.  subs(tmp->campo,64,1)<>"," .or.;
		subs(tmp->campo,83,1)<>"," .or. subs(tmp->campo,103,1)<>"," .or. subs(tmp->campo,122,1)<>","
		DBSELECTAREA("TMP")
		DBSKIP()
		LOOP
	ENDIF
	_CGC := STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),14)
	DATAVENC := subs(TMP->CAMPO,128,04)+"0131"
	IncProc("Regs: "+strzero(qtdreg,6)+"- CNPJ: "+ALLTRIM(SUBS(TMP->CAMPO,1,14)))
	_lMovimenta := .t.
	if len(alltrim(SUBS(TMP->CAMPO,1,14)))==9 .AND. SUBS(_CGC,1,8) <> "47436373"
		dbSelectArea("SZ9")
		DBSETORDER(1)
		if dbseek( xFilial()+strzero(val(_cgc),13) )
			DBSELECTAREA("SA1")
			DBSETORDER(3)
			DBSEEK(XFILIAL()+sz9->z9_cgc)
			IF FOUND()
				_cgc := sz9->z9_cgc
				DBSELECTAREA("SE1")
				DBSETORDER(1)
				if dbseek( xFilial()+subs(TMP->CAMPO,130,02)+"S"+SA1->A1_COD+" DP")
					//					VALIGNOR +=  val( substr(TMP->CAMPO,034,11) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)
					@ LI,000 PSAY SA1->A1_ERSIN
					@ LI,006 PSAY SA1->A1_NOME
					@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
					@ LI,076 PSAY SE1->E1_NATUREZ
					@ LI,087 PSAY SE1->E1_PREFIXO+"-"+SE1->E1_NUM+"-"+SE1->E1_PARCELA
					@ LI,101 PSAY SE1->E1_VENCTO
					@ LI,110 PSAY SE1->E1_VALOR+SE1->e1_juros PICTURE "@E 99,999,999.99"
					@ LI,125 PSAY SE1->E1_BAIXA
					@ LI,135 PSAY SE1->E1_dtcred
					@ LI,144 PSAY SE1->E1_VALcred PICTURE "@E 99,999,999.99"
					DATVALPG  += SE1->E1_VALcred
					@ LI,158 PSAY SA1->A1_SITUAC
					@ li,167 psay SE1->e1_confed
					@ LI,182 psay "T�tulo j� existente."
					li++
					qtdje ++
					valje +=  SE1->E1_VALOR+SE1->e1_juros
					valcje+= se1->e1_valcred
					DBSELECTAREA("TMP")
					DBSKIP()
					LOOP
				ELSE
					DATAVENC := subs(TMP->CAMPO,128,04)+"0131"
					@ LI,000 PSAY SA1->A1_ERSIN
					@ LI,006 PSAY SA1->A1_NOME
					@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
					@ LI,076 PSAY "003"
					@ LI,087 PSAY subs(TMP->CAMPO,130,02)+"S"+"-"+Sa1->a1_cod+"-"
					@ LI,101 PSAY STOD(DATAVENC)
					@ LI,110 PSAY (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)+(val( substr(TMP->CAMPO,053,03) )*1000000)+(val( substr(TMP->CAMPO,057,03) )*1000)+val( substr(TMP->CAMPO,061,03) )+(VAL(SUBS(TMP->CAMPO,065,2))/100) PICTURE "@E 99,999,999.99"
//					@ LI,125 PSAY MV_PAR02
//					@ LI,135 PSAY MV_PAR02
					@ LI,144 PSAY (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100) PICTURE "@E 99,999,999.99"
					DATVALPG  += (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100)
					@ LI,158 PSAY SA1->A1_SITUAC
					@ li,167 psay _cgc
					@ LI,182 psay "T�tulo ser� baixado."
					li++
					VALbx +=  (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)+(val( substr(TMP->CAMPO,053,03) )*1000000)+(val( substr(TMP->CAMPO,057,03) )*1000)+val( substr(TMP->CAMPO,061,03) )+(VAL(SUBS(TMP->CAMPO,065,2))/100)
					valcbx+= (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100)
					QTDREG ++
				ENDIF
			ENDIF
		ELSE
			DBSELECTAREA("SE1")
			dbOrderNickName('20')  // DBSETORDER(20) // Alterado (UPDXFUN).
			dbseek( xFilial()+STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),14))
			DO WHILE !EOF() .AND. SUBS(SE1->E1_CGC,1,14) == STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),14)
				IF SE1->E1_PREFIXO == SUbs(TMP->CAMPO,130,02)+"S"
					IF SE1->E1_VALOR    ==  (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100) // .AND. se1->e1_arqbco==SUBS(MV_PAR01,1,12) .AND.  se1->e1_linarq  == tmp->(recno())
						DBSELECTAREA("SA1")
						DBSETORDER(1)
						DBSEEK(XFILIAL()+SE1->E1_CLIENTE)
						@ LI,000 PSAY SA1->A1_ERSIN
						@ LI,006 PSAY SA1->A1_NOME
						@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
						@ LI,076 PSAY SE1->E1_NATUREZ
						@ LI,087 PSAY SE1->E1_PREFIXO+"-"+SE1->E1_NUM+"-"+SE1->E1_PARCELA
						@ LI,101 PSAY SE1->E1_VENCTO
						@ LI,110 PSAY SE1->E1_VALOR+SE1->e1_juros PICTURE "@E 99,999,999.99"
						@ LI,125 PSAY SE1->E1_BAIXA
						@ LI,135 PSAY SE1->E1_dtcred
						@ LI,144 PSAY SE1->E1_VALcred PICTURE "@E 99,999,999.99"
						DATVALPG  += SE1->E1_VALcred
						@ LI,158 PSAY SA1->A1_SITUAC
						@ li,167 psay SE1->e1_confed
						@ LI,182 psay "T�tulo j� existente."
						qtdje ++
						valje +=  SE1->E1_VALOR+SE1->e1_juros
						valcje+= se1->e1_valcred
						li++
						DBSELECTAREA("TMP")
						GRAVA := .F.
						EXIT
					ENDIF
				ENDIF
				DBSELECTAREA("SE1")
				DBSKIp()
			ENDDO
			_cgc := STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),14)
			IF GRAVA
				_lMovimenta := .t.
				//				@ LI,000 PSAY SA1->A1_ERSIN
				//				@ LI,006 PSAY SA1->A1_NOME
				@ LI,057 PSAY _CGC
				@ LI,076 PSAY "003"
				@ LI,087 PSAY subs(TMP->CAMPO,130,02)+"S"+"-999999-"
				@ LI,101 PSAY STOD(DATAVENC)
				@ LI,110 PSAY (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)+(val( substr(TMP->CAMPO,053,03) )*1000000)+(val( substr(TMP->CAMPO,057,03) )*1000)+val( substr(TMP->CAMPO,061,03) )+(VAL(SUBS(TMP->CAMPO,065,2))/100) PICTURE "@E 99,999,999.99"
//				@ LI,125 PSAY MV_PAR02
//				@ LI,135 PSAY MV_PAR02
				@ LI,144 PSAY (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100) PICTURE "@E 99,999,999.99"
				DATVALPG  += (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100)
				@ LI,158 PSAY SA1->A1_SITUAC
				@ li,167 psay _cgc
				@ LI,182 psay "T�tulo ser� baixado."
				li++
				VALbx +=  (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)+(val( substr(TMP->CAMPO,053,03) )*1000000)+(val( substr(TMP->CAMPO,057,03) )*1000)+val( substr(TMP->CAMPO,061,03) )+(VAL(SUBS(TMP->CAMPO,065,2))/100)
				valcbx+= (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100)
				QTDREG ++
			ELSE
				VALIGNOR +=  (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)
			endif
		ENDIF
	ELsE
		DBSELECTAREA("SA1")
		DBSETORDER(3)
		DBSEEK(XFILIAL()+STRZERO(VAL(SUBS(TMP->CAMPO,1,12)),12))
		IF FOUND() .AND. VAL(SA1->a1_CGC)>1000000 .AND. SUBS(_CGC,1,8) <> "47436373"
			_lMovimenta := .t.
			DBSELECTAREA("SE1")
			DBSETORDER(1)
			if dbseek( xFilial()+subs(TMP->CAMPO,130,02)+"S"+SA1->A1_COD+" DP")
				do while !eof() .and. subs(TMP->CAMPO,130,02)+"S"+SA1->A1_COD+" DP"==se1->e1_prefixo+se1->e1_num+se1->e1_parcela+"DP"
					IF SE1->E1_VALOR    == (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)  // .AND. se1->e1_arqbco==SUBS(MV_PAR01,1,12) .AND.  se1->e1_linarq  == tmp->(recno())
						DBSELECTAREA("SA1")
						DBSETORDER(1)
						DBSEEK(XFILIAL()+SE1->E1_CLIENTE)
						@ LI,000 PSAY SA1->A1_ERSIN
						@ LI,006 PSAY SA1->A1_NOME
						@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
						@ LI,076 PSAY SE1->E1_NATUREZ
						@ LI,087 PSAY SE1->E1_PREFIXO+"-"+SE1->E1_NUM+"-"+SE1->E1_PARCELA
						@ LI,101 PSAY SE1->E1_VENCTO
						@ LI,110 PSAY SE1->E1_VALOR+SE1->e1_juros PICTURE "@E 99,999,999.99"
						@ LI,125 PSAY SE1->E1_BAIXA
						@ LI,135 PSAY SE1->E1_dtcred
						@ LI,144 PSAY SE1->E1_VALcred PICTURE "@E 99,999,999.99"
						DATVALPG  += SE1->E1_VALcred
						@ LI,158 PSAY SA1->A1_SITUAC
						@ li,167 psay SE1->e1_confed
						@ LI,182 psay "T�tulo j� existente."
						qtdje ++
						valje +=  SE1->E1_VALOR+SE1->e1_juros
						valcje+= se1->e1_valcred
						li++
						_LMOVIMENTA := .F.
						EXIT
					ENDIF
					dbselectarea("se1")
					dbskip()
				enddo
			ENDIF
			DBSELECTAREA("SE1")
			IF _LMOVIMENTA
				@ LI,000 PSAY SA1->A1_ERSIN
				@ LI,006 PSAY SA1->A1_NOME
				@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
				@ LI,076 PSAY "003"
				@ LI,087 PSAY subs(TMP->CAMPO,130,02)+"S"+"-"+Sa1->a1_cod+"-"
				@ LI,101 PSAY STOD(DATAVENC)
				@ LI,110 PSAY (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)+(val( substr(TMP->CAMPO,053,03) )*1000000)+(val( substr(TMP->CAMPO,057,03) )*1000)+val( substr(TMP->CAMPO,061,03) )+(VAL(SUBS(TMP->CAMPO,065,2))/100) PICTURE "@E 99,999,999.99"
//				@ LI,125 PSAY MV_PAR02
//				@ LI,135 PSAY MV_PAR02
				@ LI,144 PSAY (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100) PICTURE "@E 99,999,999.99"
				DATVALPG  += (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100)
				@ LI,158 PSAY SA1->A1_SITUAC
				@ li,167 psay _cgc
				@ LI,182 psay "T�tulo ser� baixado."
				li++
				VALbx +=  (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)+(val( substr(TMP->CAMPO,053,03) )*1000000)+(val( substr(TMP->CAMPO,057,03) )*1000)+val( substr(TMP->CAMPO,061,03) )+(VAL(SUBS(TMP->CAMPO,065,2))/100)
				valcbx+= (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100)
				QTDREG ++
				MsUnlock()
			ELSE
				VALIGNOR +=   (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)
			ENDIF
			dbselectArea("SE5")
		else // NAO CLIENTE
			GRAVA := .T.
			IF LEN(ALLTRIM(SUBS(TMP->CAMPO,1,14)))<12
				DBSELECTAREA("SE1")
				dbOrderNickName('20')  // DBSETORDER(20) // Alterado (UPDXFUN).
				dbseek( xFilial()+STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),12))
				DO WHILE !EOF() .AND. SUBS(SE1->E1_CGC,1,12) == STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),12)
					IF SE1->E1_PREFIXO == SUbs(TMP->CAMPO,130,02)+"S"
						IF SE1->E1_VALOR    ==  (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100) //  .AND. se1->e1_arqbco==SUBS(MV_PAR01,1,12) .AND.  se1->e1_linarq  == tmp->(recno())
							DBSELECTAREA("SA1")
							DBSETORDER(1)
							DBSEEK(XFILIAL()+SE1->E1_CLIENTE)
							
							DBSELECTAREA("TMP")
							@ LI,000 PSAY SA1->A1_ERSIN
							@ LI,006 PSAY SA1->A1_NOME
							@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
							@ LI,076 PSAY SE1->E1_NATUREZ
							@ LI,087 PSAY SE1->E1_PREFIXO+"-"+SE1->E1_NUM+"-"+SE1->E1_PARCELA
							@ LI,101 PSAY SE1->E1_VENCTO
							@ LI,110 PSAY SE1->E1_VALOR+SE1->e1_juros PICTURE "@E 99,999,999.99"
							@ LI,125 PSAY SE1->E1_BAIXA
							@ LI,135 PSAY SE1->E1_dtcred
							@ LI,144 PSAY SE1->E1_VALcred PICTURE "@E 99,999,999.99"
							DATVALPG  += SE1->E1_VALcred
							@ LI,158 PSAY SA1->A1_SITUAC
							@ li,167 psay SE1->e1_confed
							@ LI,182 psay "T�tulo j� existente."
							li++
							qtdje ++
							valje +=  SE1->E1_VALOR+SE1->e1_juros
							valcje+= se1->e1_valcred
							GRAVA := .F.
							EXIT
						ENDIF
					ENDIF
					DBSELECTAREA("SE1")
					DBSKIp()
				ENDDO
				_cgc := STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),12)
			else
				DBSELECTAREA("SE1")
				dbOrderNickName('20')  // DBSETORDER(20) // Alterado (UPDXFUN).
				dbseek( xFilial()+STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),14))
				DO WHILE !EOF() .AND. SUBS(SE1->E1_CGC,1,14) == STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),14)
					IF SE1->E1_PREFIXO == SUbs(TMP->CAMPO,130,02)+"S"
						IF SE1->E1_VALOR    ==  (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100) // .AND. se1->e1_arqbco==SUBS(MV_PAR01,1,12) .AND.  se1->e1_linarq  == tmp->(recno())
							DBSELECTAREA("SA1")
							DBSETORDER(1)
							DBSEEK(XFILIAL()+SE1->E1_CLIENTE)
							DBSELECTAREA("TMP")
							@ LI,000 PSAY SA1->A1_ERSIN
							@ LI,006 PSAY SA1->A1_NOME
							@ LI,057 PSAY SA1->A1_CGC PICTURE "@R 99.999.999/9999-99"
							@ LI,076 PSAY SE1->E1_NATUREZ
							@ LI,087 PSAY SE1->E1_PREFIXO+"-"+SE1->E1_NUM+"-"+SE1->E1_PARCELA
							@ LI,101 PSAY SE1->E1_VENCTO
							@ LI,110 PSAY SE1->E1_VALOR+SE1->e1_juros PICTURE "@E 99,999,999.99"
							@ LI,125 PSAY SE1->E1_BAIXA
							@ LI,135 PSAY SE1->E1_dtcred
							@ LI,144 PSAY SE1->E1_VALcred PICTURE "@E 99,999,999.99"
							DATVALPG  += SE1->E1_VALcred
							@ LI,158 PSAY SA1->A1_SITUAC
							@ li,167 psay SE1->e1_confed
							@ LI,182 psay "T�tulo j� existente."
							li++
							qtdje ++
							valje +=  SE1->E1_VALOR+SE1->e1_juros
							valcje+= se1->e1_valcred
							GRAVA := .F.
							EXIT
						ENDIF
					ENDIF
					DBSELECTAREA("SE1")
					DBSKIp()
				ENDDO
				_cgc := STRZERO(VAL(SUBS(TMP->CAMPO,1,14)),14)
			endif
			IF GRAVA
				_lMovimenta := .t.
				//				@ LI,000 PSAY SA1->A1_ERSIN
				//				@ LI,006 PSAY SA1->A1_NOME
				@ LI,057 PSAY _CGC
				@ LI,076 PSAY "003"
				@ LI,087 PSAY subs(TMP->CAMPO,130,02)+"S"+"-999999-"
				@ LI,101 PSAY STOD(DATAVENC)
				@ LI,110 PSAY (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)+(val( substr(TMP->CAMPO,053,03) )*1000000)+(val( substr(TMP->CAMPO,057,03) )*1000)+val( substr(TMP->CAMPO,061,03) )+(VAL(SUBS(TMP->CAMPO,065,2))/100) PICTURE "@E 99,999,999.99"
//				@ LI,125 PSAY MV_PAR02
//				@ LI,135 PSAY MV_PAR02
				@ LI,144 PSAY (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100) PICTURE "@E 99,999,999.99"
				DATVALPG  += (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100)
				@ LI,158 PSAY SA1->A1_SITUAC
				@ li,167 psay _cgc
				@ LI,182 psay "T�tulo ser� baixado."
				li++
				VALbx +=  (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)+(val( substr(TMP->CAMPO,053,03) )*1000000)+(val( substr(TMP->CAMPO,057,03) )*1000)+val( substr(TMP->CAMPO,061,03) )+(VAL(SUBS(TMP->CAMPO,065,2))/100)
				valcbx+= (val( substr(TMP->CAMPO,111,03) )*1000000)+(val( substr(TMP->CAMPO,115,03) )*1000)+val( substr(TMP->CAMPO,119,03) )+(VAL(SUBS(TMP->CAMPO,123,2))/100)
				MsUnlock()
				QTDREG ++
				dbselectArea("SE5")
			ELSE
				VALIGNOR +=  (val( substr(TMP->CAMPO,034,03) )*1000000)+(val( substr(TMP->CAMPO,038,03) )*1000)+val( substr(TMP->CAMPO,042,03) )+(VAL(SUBS(TMP->CAMPO,046,2))/100)
			endif
		ENDIF
	endif
	dbSelectArea("TMP")
	dbskip()
enddo
li ++
@ li,000 psay "Titulos a Baixar: " +alltrim(str(qtdreg))
@ li,060 psay "Valor a Baixar: "
@ li,080 psay valbx picture "@e 999,999,999.99"
@ li,100 psay "Valor Sindhosp: "
@ li,120 psay valcbx picture "@e 999,999,999.99"
li++
@ li,000 psay "Titulos Encontrados: " +alltrim(str(qtdje))
@ li,060 psay "Valor Encontrado: "
@ li,080 psay valje Picture "@e 999,999,999.99"
@ li,100 psay "Valor Sindhosp: "
@ li,120 psay valcje picture "@e 999,999,999.99"
li++
if LI <> 80
	roda(cbcont,cbtxt,tamanho)
endif
DBSELECTAREA("Tmp")
DBCLOSEAREA("Tmp")
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
