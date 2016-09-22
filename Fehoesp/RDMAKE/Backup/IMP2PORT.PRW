#Include "RwMake.Ch"

User Function ImPort2()

cImpress1 := "Impressao Direto na Porta - LPT1"
cImpress2 := "Impressao Direto na Porta - LPT2"


Set( 24, "LPT1", .F. ) // Set Printer To Lpt1 e a mesma coisa
PrinterWin(.F.) // Impressao Dos/Windows
PreparePrint(.F., "", .F., "LPT1") // Prepara a impressao na porta especificada
InitPrint(1) // Inicia Cliente/Servidor

@ 10,10 PSAY cImpress1 // Imprimindo na LPT1


Set( 24, "LPT2", .F. ) // Set Printer To LPT2 e a mesma coisa
PrinterWin(.F.) // Impressao Dos/Windows
PreparePrint(.F., "", .F., "LPT2") // Prepara a impressao na porta especificada
InitPrint(1) // Inicia Cliente/Servidor

@ 10,10 PSAY cImpress2 // Imprimindo na LPT2


MS_FLUSH()

Return
