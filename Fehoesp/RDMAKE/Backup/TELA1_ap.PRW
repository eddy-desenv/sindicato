#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

User Function TELA1()        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP6 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CCGC,")

/*/
*****************************************************************************
Gerador    : MKW - Windows� - Vers�o 1.0b
Gera豫o    : 17/06/98 - 10:01:09
*****************************************************************************
/*/

// Declara豫o de vari�veis:
_cCGC := Space(14)

@ 101,82 To 316,433 Dialog janela1 Title OemToAnsi("Consulta Cobranca")
@ 43,41 Say OemToAnsi("Informe o C.G.C. :")
@ 40,89 Get _cCGC Picture "@!" Valid .T.
@ 77,45 BmpButton Type 1 Action MsgAlert("Acao do Botao!")
@ 76,112 BmpButton Type 2 Action MsgAlert("Acao do Botao!")
Activate Dialog janela1 Centered
Return
