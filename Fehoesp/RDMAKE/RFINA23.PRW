#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

User Function RFINA23()        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP6 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CTITULO,CCGC,NCNT,I,J,CDVC")
SetPrvt("NSUM,NDIG,CDIG,CVAR,NTAMANHO,LRET")
SetPrvt("CCPF,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿛rograma  � RFINA23  � Autor � Joao Carlos Andrade   � Data � 23/09/03 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri놹o � Validador do CNPJ dos Clientes                             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Especifico SINDHOSP                                        낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
_cTitulo  := "Validadando CNPJ"

@ 096,042 TO 375,505 DIALOG oDlg1 TITLE _cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a validacao do CNPJ dos clientes"
@ 086,014 SAY "CONFIRME PARA INICIAR A VALIDACAO                  "

@ 110,138 BMPBUTTON TYPE 1 ACTION FInicio()// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> @ 110,138 BMPBUTTON TYPE 1 ACTION Execute(FInicio)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED
Return

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao INICIAR()                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function FInicio
Static Function FInicio()
Close(oDlg1)
Processa( {|| FValida() })// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Processa( {|| Execute(FValida) })
Return

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao IMPORTAR()                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function FValida
Static Function FValida()
DbSelectArea("SA1")
DbSetOrder(1)
DbGotop()
ProcRegua(RecCount())
While !Eof()

   IncProc(_cTitulo)

   CGC1()
   If !lRET
      DbSelectArea("SZP")
      If !DbSeek(xFilial("SZP")+SA1->A1_CGC,.F.)
         RecLock("SZP",.T.)
         SZP->ZP_FILIAL := xFilial("SZP")
         SZP->ZP_CODIGO := SA1->A1_COD
         SZP->ZP_LOJA   := SA1->A1_LOJA
         SZP->ZP_NOME   := SA1->A1_NOME
         SZP->ZP_CGC    := SA1->A1_CGC
         SZP->ZP_MUN    := SA1->A1_MUN
         SZP->ZP_EST    := SA1->A1_EST
         MsUnLock()
      EndIf
   Endif

   DbSelectArea("SA1")
   dbSkip()
End
Return

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao CGC1()                                     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function CGC1
Static Function CGC1()
cCGC := SA1->A1_CGC
nCnt := 0
i := 1
j := 1
cDVC := ""
nSum := 0
nDIG := 0
cDIG :=""
cCGC	:= IIF(cCgc  == Nil,&(ReadVar()),cCGC)
cVar  := If(ValType(cVar) = "U", "M->A1_CGC", cVar)

If cCgc == "00000000000000"
	Return .T.
Endif

nTamanho:=Len(AllTrim(cCGC))

cDVC:=SubStr(cCGC,13,2)
cCGC:=SubStr(cCGC,1,12)

FOR j := 12 TO 13
	nCnt := 1
	nSum := 0
	FOR i := j TO 1 Step -1
                nCnt := nCnt + 1
		IF nCnt>9;nCnt:=2;EndIf
                nSum := nSum + (Val(SubStr(cCGC,i,1))*nCnt)
	Next i
	nDIG := IIF((nSum%11)<2,0,11-(nSum%11))
	cCGC := cCGC+STR(nDIG,1)
	cDIG := cDIG+STR(nDIG,1)
Next j
lRet:=IIF(cDIG==cDVC,.T.,.F.)

IF !lRet
	IF nTamanho < 14
		cDVC:=SubStr(cCGC,10,2)
		cCPF:=SubStr(cCGC,1,9)
		cDIG:=""

		FOR j := 10 TO 11
			nCnt := j
			nSum := 0
			For i:= 1 To Len(Trim(cCPF))
                                nSum := nSum + (Val(SubStr(cCPF,i,1))*nCnt)
                                nCnt := nCnt - 1
			Next i
			nDIG:=IIF((nSum%11)<2,0,11-(nSum%11))
			cCPF:=cCPF+STR(nDIG,1)
			cDIG:=cDIG+STR(nDIG,1)
		Next j
		lRet:=IIF(cDIG==cDVC,.T.,.F.)
		IF lRet;&cVar:=cCPF+Space(3);EndIF
	EndIF
EndIF
Return
