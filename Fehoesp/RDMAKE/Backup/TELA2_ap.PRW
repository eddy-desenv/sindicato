#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

User Function TELA2()        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP6 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("TXCGC,TXNOME,TXEND,")

/*/
*****************************************************************************
Gerador    : MKW - Windows� - Vers�o 1.0b
Gera豫o    : 17/06/98 - 10:13:07
*****************************************************************************
/*/

// Declara豫o de vari�veis:
TXcgc := Space(9)
TXNOME := Space(22)
TXEND := Space(34)

@ 71,5 To 397,628 Dialog Janela2 Title OemToAnsi("Consulta Cobranca")
@ 4,7 Get TXcgc Picture "@!" Valid .T. F3 "SA1"
@ 4,62 Get TXNOME Picture "@!" Valid .T.
@ 23,6 Get TXEND Picture "@!" Valid .T.
Activate Dialog Janela2 Centered
Return
