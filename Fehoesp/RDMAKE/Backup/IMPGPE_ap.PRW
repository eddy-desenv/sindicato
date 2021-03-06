#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

User Function IMPGPE()        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP6 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("ASTRU,CARQ1,CARQNTX,CINDICE,CARQANT,CARQNOV")
SetPrvt("CARQIMP,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿛rograma  � IMPGPE   � Autor � ROGERIO LOUREIRO      � Data � 09.12.97 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Importacao de Contas a Pagar   (Sist. de Orcamentos)       낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴--컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Especifico para a Cut                                      낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇�         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             낢�
굇쳐컴컴컴컴컴컫컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛rogramador � Data   �         Motivo da Alteracao                     낢�
굇쳐컴컴컴컴컴컵컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇�            �        �                                                 낢�
굇읕컴컴컴컴컴컨컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

@ 0,0 TO 280,410 DIALOG oDlg TITLE "Importacao de Lancamentos para Folha"
@ 10,10 BITMAP SIZE 112,36 FILE "CUT.BMP"
@ 50,5 TO 110,200
@ 057,010 Say "Este programa tem a funcao de realizar a importacao de lancamentos,"
@ 067,010 Say "para modulo da Folha, atraves de arquivo TXT padronizado."

//@ 122,112 BMPBUTTON TYPE 5 ACTION Pergunte("CUT001")
@ 122,140 BMPBUTTON TYPE 1 ACTION Import1()// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> @ 122,140 BMPBUTTON TYPE 1 ACTION Execute(Import1)
@ 122,168 BMPBUTTON TYPE 2 ACTION Close(oDlg)
ACTIVATE DIALOG oDlg CENTERED
Return


****************
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function Import1
Static Function Import1()
****************

aStru:={}
AADD(aStru,{"TR_FIL" ,"C" ,2,0})
AADD(aStru,{"TR_MAT" ,"C" ,6,0})
AADD(aStru,{"TR_PD"  ,"C" ,3,0})
AADD(aStru,{"TR_VAL","N" ,13,2})
AADD(aStru,{"TR_CUT","N" ,13,2})

cArq1:=CriaTrab(aStru,.t.)
DbUseArea(.t.,,cArq1,"TRB")
DbSelectArea("TRB")

cArqNtx:=CriaTrab(nil,.f.)
cIndice:="TR_FIL+TR_MAT"
IndRegua("TRB",cArqNtx,cIndice,,,"Criando Indice ...")
dbGoTop()

cArqAnt := GetMv("MV_IMPGPE")
cArqNov := Subs(cArqAnt,1,3)+StrZero(Val(Subs(cArqAnt,4,5))+1,5) 
cArqImp := cArqAnt+".TXT"

dbSelectArea("TRB")
If File(cArqImp)
   APPEND FROM &cArqimp sdf
   DbGoTop()
   While ! eof()
		dbSelectArea("SRA")
		dbSetORder(1)
		If dbSeek(TRB->TR_FIL+TRB->TR_MAT)
			dbSelectArea("SRC")
			dbSeek(TRB->TR_FIL+TRB->TR_MAT+TRB->TR_PD)
			If ! Eof()
				RecLock("SRC",.F.)
			Else
				RecLock("SRC",.T.)		
			Endif
			SRC->RC_FILIAL := TRB->TR_FIL
			SRC->RC_MAT    := TRB->TR_MAT
			SRC->RC_PD		:= TRB->TR_PD
			SRC->RC_VALOR	:= TRB->TR_VAL
			SRC->RC_TIPO1  := "V"
			SRC->RC_CC		:= SRA->RA_CC
			SRC->RC_TIPO2  := "G"
			MsUnlock()

			If TRB->TR_CUT > 0			
				dbSeek(TRB->TR_FIL+TRB->TR_MAT+"748")
				If ! Eof()
					RecLock("SRC",.F.)
				Else
					RecLock("SRC",.T.)		
				Endif
				SRC->RC_FILIAL := TRB->TR_FIL
				SRC->RC_MAT    := TRB->TR_MAT
				SRC->RC_PD		:= "748"
				SRC->RC_VALOR	:= TRB->TR_CUT
				SRC->RC_TIPO1  := "V"
				SRC->RC_CC		:= SRA->RA_CC
				SRC->RC_TIPO2  := "G"			
				MsUnlock()
			Endif	
		Endif
		
		dbSelectArea("TRB")
		dbSkip()
	Enddo		
	dbSelectArea("SX6")
 	If dbSeek("  "+"MV_IMPGPE")
		RecLock("SX6",.F.)
		SX6->X6_CONTEUD := cArqNov
		MsUnlock()
	Endif	
Else
	Alert("Arquivo Nao encontrado")
Endif	

dbCloseArea("TRB")
dbSelectArea("SRA")

fErase( cArq1 )
fErase( cArqNtx + OrdBagExt() )
dbSelectArea("SRA")
dbSetOrder(1)
Close(oDlg)
Return



