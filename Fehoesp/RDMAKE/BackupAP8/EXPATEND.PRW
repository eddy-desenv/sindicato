#include "rwmake.ch"
#include "topconn.ch"
User Function atuAtend()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Atuatend ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 24/03/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Atualizacao do Atend Antigo                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß\ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_oldArea  := alias()
_oldOrder := indexord()
_cTitulo  := "Atualizacao do Atend"
n_Opc := 0
@ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a exportacao dos dados para o Atend"
@ 086,014 SAY "CONFIRME PARA INICIAR A EXPORTACAO DE DADOS         "
@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar()
@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED
Return
**************************
Static Function Iniciar()
Close(oDlg1)
Processa( {|| Exportar() })
Return
**************************
Static Function Importar()
_nIncluidos := 0
_nAlterados := 0
_nInconsist := 0
_cArqContrib := "\atend\contrib.dbf"
_cArqAssocia := "\atend\assoc.dbf"
If !File(AllTrim(_cArqContrib))
	Alert("Arquivo Contrib nao Encontrado!!")
	Return
endif
_cArquivo := alltrim(_cArqContrib)
if !dbUseArea(.t.,"DBFNTX",CARQCONTRIB,"CTRB",.F.,)
	Alert("Arquivo Contrib em Uso!!")
	return
endif
Set Index To \atend\contrib1,\atend\contrib2,\atend\contrib3,\atend\contrib5

If !File(AllTrim(_cArqassocia))
	Alert("Arquivo de Associados nao Encontrado!!")
	Return
endif
_cArquivo := alltrim(_cArqassocia)
if !dbUseArea(.t.,"DBFNTX",CARQassocia,"Cass",.F.,)
	Alert("Arquivo de Associados em Uso!!")
	return
endif
Set Index To \atend\assoc1,\atend\assoc2,\atend\assoc3,\atend\assoc4,\atend\assoc5
dbsetorder(3)
/*
dbGotop()
ProcRegua(RecCount(),22,05)
_NCOD := 34513
Do While !Eof()
#IFNDEF WINDOWS
IncProc(22,05)
#ELSE
IncProc(_cTitulo)
#ENDIF
dbSelectArea("SA1")
dbSetOrder(3)         //Pesquisa por CGC
dbSeek(xFilial("SA1")+TMP->PCC_CGC)
IF FOUND()
RecLock("SA1",.f.)
SA1->A1_TIPO    := "F"
SA1->A1_BASE    := TMP->BASE
SA1->A1_BASE2   := TMP->BASEMED2
SA1->A1_ERSIN   := TMP->ERSIN
SA1->A1_CATEG1  := TMP->CATEGORIA
_nAlterados := _nAlterados +1
MsUnLock()
ENDIF
dbSelectArea("TMP")
dbSkip()
Enddo
*/
/*
_cArquivo := alltrim(_cArqAssocia)
Use (_cArquivo) ALIAS "TMP1" NEW
dbGotop()
_cTitulo   := "Importacao de Associados"
ProcRegua(RecCount(),22,05)
while !eof()
#IFNDEF WINDOWS
IncProc(22,05)
#ELSE
IncProc(_cTitulo)
#ENDIF
if !empty(TMP1->CODIGO) .and. (TMP1->SITUACAO == "AS" .or. TMP1->SITUACAO == "SS" .or. TMP1->SITUACAO == "CT") // se associado ativo ou suspenso ou contrato
if empty(TMP1->CATEGORIA)   // se cat.leitos vazio
_nInconsist:= _nInconsist + 1
dbSelectArea("IMP")
RecLock("IMP",.T.)
IMP->DESCR := "Associado " + TMP1->CODIGO + " esta com categoria leitos em branco"
dbSelectArea("TMP1")
dbskip()
loop
endif
endif
dbSelectArea("SA1")
dbSetOrder(3)         //Pesquisa por CGC
dbSeek(xFilial("SA1")+TMP1->PCC_CGC)
If !Found()
dbSelectArea("TMP1")	   // Nao incluir se nao houver no Contrib.
dbskip()
loop
else
RecLock("SA1",.F.)
SA1->A1_TIPO    := "F"
SA1->A1_END     := TMP1->ENDERECO
SA1->A1_CEP     := TMP1->CEP+TMP1->CEPCOMPLEM
SA1->A1_MUN     := TMP1->CIDADE
SA1->A1_EST     := TMP1->ESTADO
SA1->A1_TEL     := TMP1->TELEFONE
SA1->A1_FAX     := TMP1->FAX
SA1->A1_BAIRRO  := TMP1->BAIRRO
SA1->A1_EMAIL   := TMP1->EMAIL
SA1->A1_INSCR   := TMP1->INSCRICAO
SA1->A1_ALVARA  := TMP1->ALVARA
//      SA1->A1_CAPITAL := VAL(TMP1->CAPITAL)
SA1->a1_MANTENE := TMP1->MANTENEDOR
SA1->A1_NOMPRES := TMP1->PRESIDENTE
SA1->A1_ADMPROV := TMP1->ADM_PROV
SA1->A1_DIRFIN  := TMP1->DIR_FIN
SA1->A1_DIRRH   := TMP1->DIR_RH
SA1->A1_ATIVIDA := TMP1->ATIVIDADE

ANOC:=SubStr(TMP1->DATAINICIO,5,2)
if val(ANOC)>10
ANOC:="19"+ANOC
else
ANOC:="20"+ANOC
EndIf
SA1->A1_DTINASS := Ctod(SubStr(TMP1->DATAINICIO,1,2)+"/"+SubStr(TMP1->DATAINICIO,3,2)+"/"+ANOC)
ANOC:=SubStr(TMP1->DATAFIM,5,2)
if val(ANOC)>10
ANOC:="19"+ANOC
else
ANOC:="20"+ANOC
EndIf
SA1->A1_DTFIMAS := Ctod(SubStr(TMP1->DATAFIM,1,2)+"/"+SubStr(TMP1->DATAFIM,3,2)+"/"+ANOC)
SA1->A1_SCONTAT := TMP1->CONTATO
SA1->A1_ERSIN   := TMP1->ERSIN
SA1->A1_MREGIAO := TMP1->MICROREG
SA1->A1_CATLEIT := TMP1->CATEGORIA
If val(TMP1->CATEGORIA) > 0
SA1->A1_VALASSO := VAL(TABELA("90",SA1->A1_CATLEIT))    &&  Valor Associativa
Endif
SA1->A1_LEITOS  := val( TMP1->LEITOS)
SA1->A1_NATUREZ := "002"
SA1->A1_CODASSO := TMP1->CODIGO
SA1->A1_SITUAC  := TMP1->SITUACAO
if !empty(SA1->A1_CODASSO) .and. ( SA1->A1_SITUAC == "AS" .or. SA1->A1_SITUAC == "SS" )
SA1->A1_NATUREZ:="001"    && Associativa
else
SA1->A1_NATUREZ:= "002"
endif
if SA1->A1_CATLEIT $ "66/67/68" //TMP1->ASSOCCONF=="X"
SA1->A1_NATUREZ:="1000"   && Associativa + Confederativa
SA1->A1_TPCLI  := "1"
EndIf
SA1->A1_DTIMPOR := dDataBase
SA1->A1_BASE    := TMP1->BASE
SA1->A1_BASE2   := TMP1->BASE2
SA1->A1_CATEG1  := TMP1->CATEGNOME
_nAlterados := _nAlterados + 1
endif
MsUnLock()
dbSelectArea("TMP1")

dbskip()
end

dbSelectArea("TMP1")
dbCloseArea()
*/
dbSelectArea("SX8")	  && Acerta Contadores automaticos de Clientes
DBGoTop()

Do While ! Eof()
	
	* Atencao: Alterar codigo da empresa caso seja fora da Empresa Base 010
	
	if (ALLTRIM(X8_FILIAL)=="\SIGA\DADOSADV\SA1990") .and. (X8_ALIAS=="SA1")
		
		Reclock("SX8",.F.)
		
		replace X8_NUMERO with strzero(_nCod+1,6)
		
		MsUnlock()
		
	EndIf
	
	DbSkip()
	
EndDo

Tone(800,2)
Tone(1500,2)

#IFNDEF WINDOWS
	DrawAdvWindow("Termino de Importacao",010,010,021,069)
	SetColor("B/BG,N/W")
	@ 12,14 SAY "Clientes Incluidos"
	@ 12,37 GET _nIncluidos PICTURE "@E 999,999" WHEN .F.
	@ 14,14 SAY "Clientes Alterados"
	@ 14,37 GET _nAlterados PICTURE "@E 999,999" WHEN .F.
	@ 16,14 SAY "Clientes Inconsistentes"
	@ 16,37 GET _nInconsist PICTURE "@E 999,999" WHEN .F.
	READ
	@ 19,19 SAY "Pressione Qualquer Tecla para Continuar"
	Inkey(0)
#ELSE
	@ 96,42 TO 290,405 DIALOG oDlg1 TITLE "Termino de Importacao"
	@ 8,10 TO 68,170
	@ 23,22 SAY "Clientes Incluidos"
	@ 23,95 GET _nIncluidos PICTURE "@E 999,999" WHEN .F.
	@ 33,22 SAY "Clientes Alterados"
	@ 33,95 GET _nAlterados PICTURE "@E 999,999" WHEN .F.
	@ 43,14 SAY "Clientes Inconsistentes"
	@ 43,37 GET _nInconsist PICTURE "@E 999,999" WHEN .F.
	@ 77,078 BMPBUTTON TYPE 1 ACTION Close(oDlg1)
	ACTIVATE DIALOG oDlg1 CENTERED
#ENDIF
*/
dbSelectArea("SA1")
dbSetOrder(1)

dbSelectArea(_oldArea)
dbSetOrder(_oldOrder)


Return

