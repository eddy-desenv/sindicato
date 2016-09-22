/*/
*****************************************************************************
Gerador    : MKW - Windows® - Versão 1.0b
Geração    : 17/06/98 - 10:13:07
*****************************************************************************
/*/

// Declaração de variáveis:
TXcgc := Space(9)
TXNOME := Space(22)
TXEND := Space(34)

@ 71,5 To 397,628 Dialog Janela2 Title OemToAnsi("Consulta Cobranca")
@ 4,7 Get TXcgc Picture "@!" Valid .T. F3 "SA1"
@ 4,62 Get TXNOME Picture "@!" Valid .T.
@ 23,6 Get TXEND Picture "@!" Valid .T.
Activate Dialog Janela2 Centered
Return
