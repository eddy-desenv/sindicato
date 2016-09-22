#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

User Function RFINA02()        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP6 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_OLDAREA,_OLDORDER,_CTITULO,_CTITULO1,N_OPC,CPERG")
SetPrvt("_CPATH,_CARQCONTRIB,_CARQASSOCIA,_CARQECONT,_CARQUIVO,_NINCLUIDOS")
SetPrvt("_NALTERADOS,_NINCONSIST,LCGC,_NCOD,_AESTRUTURA,C_ARQIMP")
SetPrvt("ANOC,_CROTINA,_CNOMEREL,_CTEXTO,W,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 22/12/04 ==>     #DEFINE PSAY SAY
#ENDIF

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RFINA02  ³ Autor ³ Andreia dos Santos    ³ Data ³ 03/03/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Importacao de Clientes.                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_oldArea  := alias()
_oldOrder := indexord()

_cTitulo  := "Importacao de Contribuintes"
_cTitulo1 := "Importacao de Escrit.Contab."
n_Opc := 0
cPerg := "FINA02"

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                         ³
³ mv_par01           // Arquivo a ser Importado(Contribuintes) ³
³ mv_par02           // Arquivo a ser Importado(Associados)    ³
³ mv_par03	     // Arquivo a ser Importado(Escr.Contabeis)³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

Pergunte(cPerg,.T.)
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Verifica diretorio de busca de arquivo para importacao      ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

dbSelectArea("SX6")  //Parametros
dbSetOrder(1)
dbSeek(xFilial("SX6")+"MV_DIR_IMP")
_cPath := AllTrim(SX6->X6_CONTEUD)+Space(50-Len(AllTrim(SX6->X6_CONTEUD)))

#IFNDEF WINDOWS
   DrawAdvWindow(_cTitulo,008,000,022,079)
   SetColor("B/BG,N/W")

   @ 011,010 Say "Este programa fara a importacao dos Cliente de um arquivo"
   @ 012,010 Say "tipo DBF, incluindo Clientes "

   SetColor("B/BG,W/N")

   @ 019,010 Say "CONFIRME PARA INICIAR A IMPORTACAO DE DADOS"

   While .T.
      n_Opc := Menuh({"Confirma","Parametros","Abandona"},22,04,"b/w,w+/n,r/w","CPA","",2)

      If n_Opc == 3 .or. Lastkey()==27
         Return
      Endif

      If n_Opc == 2
         Pergunte(cPerg,.T.)
         Loop
      Endif

      Exit
   End
   Importar()
#ELSE
   @ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
   @ 008,010 TO 100,222
   @ 023,014 SAY "Este programa fara a importacao dos Clientes de um arquivo"
   @ 033,014 SAY "tipo DBF, incluindo Clientes "


   @ 086,014 SAY "CONFIRME PARA INICIAR A IMPORTACAO DE DADOS         "

   @ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar()// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==>    @ 110,138 BMPBUTTON TYPE 1 ACTION Execute(Iniciar)
   @ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
   @ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)

   ACTIVATE DIALOG oDlg1 CENTERED
#ENDIF

Return

*-----------------*
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function Iniciar
Static Function Iniciar()
*-----------------*
Close(oDlg1)
Processa( {|| Importar() })// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Processa( {|| Execute(Importar) })
Return

*------------------*
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function Importar
Static Function Importar()
*------------------*

_cArqContrib := mv_par01
_cArqAssocia := mv_par02
_cArqECont   := mv_par03

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Verificando se o arquivo a ser importado existe             ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

If !File(AllTrim(_cArqContrib))
   Help(" ",1,"ARRVAZ")
   Return
endif

If !File(AllTrim(_cArqAssocia))
   Help(" ",1,"ARRVAZ")
   Return
endif

If !File(AllTrim(_cArqECont))
   Help(" ",1,"ARRVAZ")
   Return
endif

_cArquivo := alltrim(_cArqECont)

dbSelectArea("SZC")

DBGOTOP()

Do While !Eof()

   RecLock("SZC",.F.)
   DBDELETE()
   DBSKIP()

EndDo

Use (_cArquivo) ALIAS "TMP" NEW

dbGotop()

ProcRegua(RecCount(),22,05)

_nIncluidos := 0
_nAlterados := 0
_nInconsist := 0

Do While !Eof()

    #IFNDEF WINDOWS
       IncProc(22,05)
    #ELSE
       IncProc(_cTitulo1)
    #ENDIF

   if TMP->COD_ESCR==0
      dbSelectArea("TMP")
      dbSkip()
   EndIf

   lCgc := CGC(TMP->CGC_CON)
   If !lCgc
        Alert("CGC Invalido, registro nao sera importado")
   Else
        Alert("CGC OK, registro sera importado")
   Endif
   Return

   RecLock("SZC",.T.)
   SZC->ZC_FILIAL  := xFilial("SZC")
   SZC->ZC_CGC     := TMP->CGC_CON
   SZC->ZC_CODIGO  := strzero(TMP->COD_ESCR,4)
   SZC->ZC_NOMESC  := TMP->NOME_CON
   SZC->ZC_END     := TMP->END_CON
   SZC->ZC_CEP     := TMP->CEP_CON
   SZC->ZC_BAIRRO  := TMP->BAIRRO_CON
   SZC->ZC_MUN     := TMP->CIDADE_CON
   SZC->ZC_EST     := TMP->UF_CON
   SZC->ZC_FONE    := TMP->FONE_CON
   SZC->ZC_FAX     := TMP->FAX_CON
   SZC->ZC_EMAIL   := TMP->E_MAIL_CON

   dbcommit()
  _nIncluidos := _nIncluidos + 1
   MsUnLock()

   dbSelectArea("TMP")
   dbSkip()
Enddo

dbSelectArea("TMP")
dbCloseArea()

Tone(800,2)
Tone(1500,2)

#IFNDEF WINDOWS
   DrawAdvWindow("Termino de Importacao",010,010,021,069)
   SetColor("B/BG,N/W")
   @ 12,14 SAY "Escrit¢rios Importados"
   @ 12,37 GET _nIncluidos PICTURE "@E 999,999" WHEN .F.
   READ
//   @ 19,19 SAY "Pressione Qualquer Tecla para Continuar"
//   Inkey(0)
#ELSE
   @ 96,42 TO 290,405 DIALOG oDlg1 TITLE "Termino de Importacao"
   @ 8,10 TO 68,170
   @ 23,22 SAY "Escrit¢rios Importados"
   @ 23,95 GET _nIncluidos PICTURE "@E 999,999" WHEN .F.
   @ 77,078 BMPBUTTON TYPE 1 ACTION Close(oDlg1)
   ACTIVATE DIALOG oDlg1 CENTERED
#ENDIF

dbSelectArea("SA1")
dbSetOrder(1)

&& Limpa campo para codigo de envio de confederativa
&& (para nova posicao a importar)

dbGotop()

ProcRegua(RecCount(),22,05)

Do While !Eof()

   #IFNDEF WINDOWS
      IncProc(22,05)
   #ELSE
      IncProc(_cTitulo)
   #ENDIF

   RecLock("SA1",.f.)
//   SA1->A1_CONF    := " "	   && Envio Confed.
   SA1->A1_DTINASS := Ctod(space(8))
   SA1->A1_DTFIMAS := Ctod(space(8))
   SA1->A1_CODASSO := ""
   SA1->A1_SITUAC  := ""

   MsUnLock()
   dbSkip()
Enddo


dbgobottom()
_nCod := val(SA1->A1_COD)  && Ultimo Codigo incluido

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Criando Arquivo para Inconsistencia.                         ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
_aEstrutura := {}
AADD(_aEstrutura,{"DESCR","C",70,0})
c_ArqImp := CriaTrab(_aEstrutura,.t.)
dbUseArea(.t.,,c_ArqImp,"IMP",.T.)
dbSelectArea("IMP")

_cArquivo := alltrim(_cArqContrib)


Use (_cArquivo) ALIAS "TMP" NEW

dbGotop()

ProcRegua(RecCount(),22,05)

_nIncluidos := 0
_nAlterados := 0
_nInconsist := 0

Do While !Eof()

    #IFNDEF WINDOWS
       IncProc(22,05)
    #ELSE
       IncProc(_cTitulo)
    #ENDIF

   dbSelectArea("SA1")
   dbSetOrder(3)         //Pesquisa por CGC
   dbSeek(xFilial("SA1")+TMP->PCC_CGC)

   If !Found()

      _nCod := _nCod + 1

      RecLock("SA1",.T.)
      SA1->A1_FILIAL  := xFilial("SA1")

      SA1->A1_COD     := strzero(_nCod,6)
      SA1->A1_LOJA    := "01"
      SA1->A1_TIPO    := "F"
      SA1->A1_CGC     := TMP->PCC_CGC
      SA1->A1_CEP     := TMP->CEP+TMP->CEP_CONT

      Ver_Asc2()

      SA1->A1_TEL     := if(!empty(TMP->TELEFONE),"("+TMP->DDD+")"+TMP->TELEFONE,"")
      SA1->A1_FAX     := if(!empty(TMP->FAX),"("+TMP->DDD+")"+TMP->FAX,"")

      ANOC:=SubStr(TMP->DATAINICIO,5,2)
      if val(ANOC)>10
	 ANOC:="19"+ANOC
      else
	 ANOC:="20"+ANOC
      EndIf

      SA1->A1_DTINIC  := Ctod(SubStr(TMP->DATAINICIO,1,2)+"/"+SubStr(TMP->DATAINICIO,3,2)+"/"+ANOC)
      SA1->A1_EMAIL   := TMP->E_MAIL
      SA1->A1_SCONTAT := TMP->CONTATO
      SA1->A1_FOLHA   := TMP->FOLHA_PGTO
      SA1->A1_NUMFUN  := TMP->NUM_FUNC

      SA1->A1_CAPITAL := 0
      SA1->A1_ISENTO  := TMP->ISENTO
      SA1->A1_ERSIN   := TMP->ERSIN
      SA1->A1_CATEG1  := TMP->CATEGORIA
      SA1->A1_BASE    := TMP->BASE
      SA1->A1_CONTRIB := TMP->CAT_LEITO

      SA1->A1_LEITOS  := TMP->LEITOS
      SA1->A1_NATHOSP := TMP->NATUREZA

      SA1->A1_NATUREZ:= "002"

//      if val(TMP->CODIGO)<2000	     Periodo Promocional

         SA1->A1_CODASSO := TMP->CODIGO
         SA1->A1_SITUAC  := TMP->SITUACAO

         if !empty(SA1->A1_CODASSO) .and. (SA1->A1_SITUAC == "AS" .or. SA1->A1_SITUAC == "SS")
            SA1->A1_NATUREZ:="001"    && Associativa
         else
            SA1->A1_NATUREZ:= "002"
         endif

	 if TMP->ASSOCCONF=="X"
            SA1->A1_NATUREZ:="1000"   && Associativa + Confederativa
	 EndIf

//      endif

      SA1->A1_DTIMPOR := dDataBase
      SA1->A1_ESCCONT := TMP->CGC_CON

      SA1->A1_CONF   := TMP->CONF	   && Envio Confed.
      SA1->A1_FILANT := TMP->FILANTRO	   && Filantropico

      dbcommit()

      _nIncluidos := _nIncluidos + 1

   else

      RecLock("SA1",.f.)
      SA1->A1_TIPO    := "F"
      SA1->A1_CGC     := TMP->PCC_CGC
      SA1->A1_CEP     := TMP->CEP+TMP->CEP_CONT

      Ver_Asc2()

      SA1->A1_TEL     := if(!empty(TMP->TELEFONE),"("+TMP->DDD+")"+TMP->TELEFONE,"")
      SA1->A1_FAX     := if(!empty(TMP->FAX),"("+TMP->DDD+")"+TMP->FAX,"")

      ANOC:=SubStr(TMP->DATAINICIO,5,2)
      if val(ANOC)>10
	 ANOC:="19"+ANOC
      else
	 ANOC:="20"+ANOC
      EndIf

      SA1->A1_DTINIC  := Ctod(SubStr(TMP->DATAINICIO,1,2)+"/"+SubStr(TMP->DATAINICIO,3,2)+"/"+ANOC)
      SA1->A1_EMAIL   := TMP->E_MAIL
      SA1->A1_SCONTAT := TMP->CONTATO
      SA1->A1_FOLHA   := TMP->FOLHA_PGTO
      SA1->A1_NUMFUN  := TMP->NUM_FUNC

      SA1->A1_CAPITAL := 0
      SA1->A1_ISENTO  := TMP->ISENTO
      SA1->A1_ERSIN   := TMP->ERSIN
      SA1->A1_CATEG1  := TMP->CATEGORIA
      SA1->A1_BASE    := TMP->BASE

      SA1->A1_CONTRIB := TMP->CAT_LEITO

      SA1->A1_LEITOS  := TMP->LEITOS
      SA1->A1_NATHOSP := TMP->NATUREZA

      SA1->A1_NATUREZ:= "002"

//      if val(TMP->CODIGO)<2000	     Periodo Promocional

         SA1->A1_CODASSO := TMP->CODIGO
         SA1->A1_SITUAC  := TMP->SITUACAO

         if !empty(SA1->A1_CODASSO) .and. ( SA1->A1_SITUAC == "AS" .or. SA1->A1_SITUAC == "SS" )
            SA1->A1_NATUREZ:="001"    && Associativa
         else
            SA1->A1_NATUREZ:= "002"
         endif

	 if TMP->ASSOCCONF=="X"
            SA1->A1_NATUREZ:="1000"   && Associativa + Confederativa
	 EndIf

//	endif

      SA1->A1_DTIMPOR := dDataBase
      SA1->A1_ESCCONT := TMP->CGC_CON

//      SA1->A1_CONF   := TMP->CONF	   && Envio Confed.
      SA1->A1_FILANT := TMP->FILANTRO	   && Filantropico

      dbcommit()

      _nAlterados := _nAlterados +1

   Endif
   MsUnLock()

   dbSelectArea("TMP")
   dbSkip()
Enddo

// ASSOCIADOS

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

      SA1->A1_CAPITAL := 0
      SA1->A1_ERSIN   := TMP1->ERSIN
      SA1->A1_CATLEIT := TMP1->CATEGORIA

      If val(TMP1->CATEGORIA) > 0
         SA1->A1_VALASSO := VAL(TABELA("90",SA1->A1_CATLEIT))    &&  Valor Associativa
      Endif

      SA1->A1_LEITOS  := val( TMP1->LEITOS)

      SA1->A1_NATUREZ:= "002"

//      if VAL(TMP1->CODIGO)<2000	      // Periodo Promocional
         SA1->A1_CODASSO := TMP1->CODIGO
         SA1->A1_SITUAC  := TMP1->SITUACAO

         if !empty(SA1->A1_CODASSO) .and. ( SA1->A1_SITUAC == "AS" .or. SA1->A1_SITUAC == "SS" )
            SA1->A1_NATUREZ:="001"    && Associativa
         else
            SA1->A1_NATUREZ:= "002"
         endif


	 if TMP1->ASSOCCONF=="X"

            SA1->A1_NATUREZ:="1000"   && Associativa + Confederativa

	 EndIf

//      endif

      SA1->A1_INSCR   := TMP1->INSCRICAO
      SA1->A1_DTIMPOR := dDataBase

      _nAlterados := _nAlterados + 1

   endif

   MsUnLock()
   dbSelectArea("TMP1")

   dbskip()
end

dbSelectArea("TMP1")
dbCloseArea()

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
/*
dbSelectArea("IMP")
If RecCount()>0
   _cRotina := "RFINA04"
   _cNomeRel := "Inconsist. Importacao Clientes"
*   EXECBLOCK("EFINA07")     Checar rotina p/ emissao relatorio
Endif
*/
//dbSelectArea("IMP")
//dbCloseArea()

dbSelectArea("SA1")
dbSetOrder(1)

dbSelectArea(_oldArea)
dbSetOrder(_oldOrder) // Atencao (UPDXFUN).


Return



*-------------------------*
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> FUNCTION Ver_Asc2
Static FUNCTION Ver_Asc2()
*-------------------------*
* Retira caracteres invalidos para geracao bancaria

_cTexto := UPPER(TMP->NOME)

for w := 1 to len(_cTexto)

   if (substr(_cTexto,w,1)==" ") .or. (substr(_cTexto,w,1)=="Æ") .or. ;
      (substr(_cTexto,w,1)=="ƒ") .or. (substr(_cTexto,w,1)=="µ") .or. ;
      (substr(_cTexto,w,1)=="Ç") .or. (substr(_cTexto,w,1)=="¶")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"A")
   endif

   if (substr(_cTexto,w,1)=="‚") .or. (substr(_cTexto,w,1)=="ˆ") .or. ;
      (substr(_cTexto,w,1)=="") .or. (substr(_cTexto,w,1)=="Ò")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"E")
   endif

   if (substr(_cTexto,w,1)=="¡") .or. (substr(_cTexto,w,1)=="Ö")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"I")
   endif

   if (substr(_cTexto,w,1)=="¢") .or. (substr(_cTexto,w,1)=="ä") .or. ;
      (substr(_cTexto,w,1)=="“") .or. (substr(_cTexto,w,1)=="à") .or. ;
      (substr(_cTexto,w,1)=="å") .or. (substr(_cTexto,w,1)=="â")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"O")
   endif

   if (substr(_cTexto,w,1)=="£") .or. (substr(_cTexto,w,1)=="é")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"U")
   endif

   if (substr(_cTexto,w,1)=="‡") .or. (substr(_cTexto,w,1)=="€")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"C")
   endif

next w
SA1->A1_NOME := _cTexto
SA1->A1_NREDUZ  := _cTexto

_cTexto := UPPER(TMP->ENDERECO)
for w := 1 to len(_cTexto)

   if (substr(_cTexto,w,1)==" ") .or. (substr(_cTexto,w,1)=="Æ") .or. ;
      (substr(_cTexto,w,1)=="ƒ") .or. (substr(_cTexto,w,1)=="µ") .or. ;
      (substr(_cTexto,w,1)=="Ç") .or. (substr(_cTexto,w,1)=="¶")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"A")
   endif

   if (substr(_cTexto,w,1)=="‚") .or. (substr(_cTexto,w,1)=="ˆ") .or. ;
      (substr(_cTexto,w,1)=="") .or. (substr(_cTexto,w,1)=="Ò")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"E")
   endif

   if (substr(_cTexto,w,1)=="¡") .or. (substr(_cTexto,w,1)=="Ö")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"I")
   endif

   if (substr(_cTexto,w,1)=="¢") .or. (substr(_cTexto,w,1)=="ä") .or. ;
      (substr(_cTexto,w,1)=="“") .or. (substr(_cTexto,w,1)=="à") .or. ;
      (substr(_cTexto,w,1)=="å") .or. (substr(_cTexto,w,1)=="â")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"O")
   endif

   if (substr(_cTexto,w,1)=="£") .or. (substr(_cTexto,w,1)=="é")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"U")
   endif

   if (substr(_cTexto,w,1)=="‡") .or. (substr(_cTexto,w,1)=="€")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"C")
   endif

next w

SA1->A1_END := _cTexto



_cTexto := UPPER(TMP->BAIRRO)
for w := 1 to len(_cTexto)

   if (substr(_cTexto,w,1)==" ") .or. (substr(_cTexto,w,1)=="Æ") .or. ;
      (substr(_cTexto,w,1)=="ƒ") .or. (substr(_cTexto,w,1)=="µ") .or. ;
      (substr(_cTexto,w,1)=="Ç") .or. (substr(_cTexto,w,1)=="¶")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"A")
   endif

   if (substr(_cTexto,w,1)=="‚") .or. (substr(_cTexto,w,1)=="ˆ") .or. ;
      (substr(_cTexto,w,1)=="") .or. (substr(_cTexto,w,1)=="Ò")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"E")
   endif

   if (substr(_cTexto,w,1)=="¡") .or. (substr(_cTexto,w,1)=="Ö")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"I")
   endif

   if (substr(_cTexto,w,1)=="¢") .or. (substr(_cTexto,w,1)=="ä") .or. ;
      (substr(_cTexto,w,1)=="“") .or. (substr(_cTexto,w,1)=="à") .or. ;
      (substr(_cTexto,w,1)=="å") .or. (substr(_cTexto,w,1)=="â")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"O")
   endif

   if (substr(_cTexto,w,1)=="£") .or. (substr(_cTexto,w,1)=="é")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"U")
   endif

   if (substr(_cTexto,w,1)=="‡") .or. (substr(_cTexto,w,1)=="€")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"C")
   endif

next w

SA1->A1_BAIRRO  := _cTexto

_cTexto := UPPER(TMP->CIDADE)
for w := 1 to len(_cTexto)

   if (substr(_cTexto,w,1)==" ") .or. (substr(_cTexto,w,1)=="Æ") .or. ;
      (substr(_cTexto,w,1)=="ƒ") .or. (substr(_cTexto,w,1)=="µ") .or. ;
      (substr(_cTexto,w,1)=="Ç") .or. (substr(_cTexto,w,1)=="¶")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"A")
   endif

   if (substr(_cTexto,w,1)=="‚") .or. (substr(_cTexto,w,1)=="ˆ") .or. ;
      (substr(_cTexto,w,1)=="") .or. (substr(_cTexto,w,1)=="Ò")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"E")
   endif

   if (substr(_cTexto,w,1)=="¡") .or. (substr(_cTexto,w,1)=="Ö")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"I")
   endif

   if (substr(_cTexto,w,1)=="¢") .or. (substr(_cTexto,w,1)=="ä") .or. ;
      (substr(_cTexto,w,1)=="“") .or. (substr(_cTexto,w,1)=="à") .or. ;
      (substr(_cTexto,w,1)=="å") .or. (substr(_cTexto,w,1)=="â")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"O")
   endif

   if (substr(_cTexto,w,1)=="£") .or. (substr(_cTexto,w,1)=="é")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"U")
   endif

   if (substr(_cTexto,w,1)=="‡") .or. (substr(_cTexto,w,1)=="€")
      _cTexto := strtran(_cTexto,substr(_cTexto,w,1),"C")
   endif

next w

SA1->A1_MUN     := _cTexto

SA1->A1_EST     := UPPER(TMP->UF)

return

