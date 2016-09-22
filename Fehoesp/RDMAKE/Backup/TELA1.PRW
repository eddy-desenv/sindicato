/*/
*****************************************************************************
Gerador    : MKW - Windows® - Versão 1.0b
Geração    : 17/06/98 - 10:01:09
*****************************************************************************
/*/

// Declaração de variáveis:
_cCGC := Space(14)

@ 101,82 To 316,433 Dialog janela1 Title OemToAnsi("Consulta Cobranca")
@ 43,41 Say OemToAnsi("Informe o C.G.C. :")
@ 40,89 Get _cCGC Picture "@!" Valid .T.
@ 77,45 BmpButton Type 1 Action MsgAlert("Acao do Botao!")
@ 76,112 BmpButton Type 2 Action MsgAlert("Acao do Botao!")
Activate Dialog janela1 Centered
Return
