#INCLUDE "PROTHEUS.CH"
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "SHBOLCEF_INCLUDES.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ SHBOLITAU ºAutor  ³Antonio C Ferreira º Data ³ 06/dez/2010 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Geracao do Boleto da Banco Itau Associativa/Confederativa  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function SHBOLITAU()

Local nValorDocumento, cNossoNumero, cBanco, cAgencia, cCodCed, cCedente, cValor
//, nA, cDigito

Local cValorDig := ""

Local cHtml  	:= ""
Local cMoeda	:= "9"

Web Extended Init cHtml 

    HttpPost->RaizURL		:= aDadosRaizURL 

    HttpPost->SDNome		:= aDadosSDNome

	nValorDocumento 		:= Val(aDadosValorDocumento)
    
	HttpPost->DataPagto 	:= aDadosDtPagto
	HttpPost->ValorCobrado  := aDadosValorCobrado
	HttpPost->ValorMoraMulta:= aDadosMoraMulta
	HttpPost->ValorDocumento:= aDadosValorDocumento
	
	HttpPost->Carteira      := aDadosCarteira //"57"
	HttpPost->NumDoc        := aDadosNumDoc

	//------------------ Mensagem do Boleto -------------------------------
	HttpPost->MsgBoleto 	:= aDadosMensBoleto //"CONTRIBUI&Ccedil;&Atilde;O CONFEDERATIVA - " + aDadosParcela + " a Parcela de " + aDadosAno

	HttpPost->Mensagem1  	:= aDadosMensagem1
	HttpPost->Mensagem2  	:= aDadosMensagem2
	HttpPost->Mensagem3  	:= aDadosMensagem3
	HttpPost->Mensagem4  	:= aDadosMensagem4
	HttpPost->Mensagem5  	:= aDadosMensagem5
	HttpPost->Mensagem6  	:= aDadosMensagem6
	HttpPost->Mensagem7  	:= aDadosMensagem7

	//------------------ Imagens do Logotipo -------------------------------

	HttpPost->LogoTipo		:= aDadosLogoTipo
	
	If  !(".GIF" $ UPPER(HttpPost->LogoTipo))
		HttpPost->LogoTipo	+= ".gif"
	EndIf

	//----------------------------------------------------------------------

	HttpPost->CNPJ := AllTrim(aDadosCNPJ)

	If  (Len(HttpPost->CNPJ) == 14)
		HttpPost->CNPJ  := " CNPJ: " + Transform(HttpPost->CNPJ, "@R 99.999.999/9999-99")
	Else
		HttpPost->CNPJ	:= " CPF: " + Transform(HttpPost->CNPJ, "@R 999.999.999-99")
	EndIf

	HttpPost->Razao 	:= aDadosRazao
	HttpPost->XEndereco := aDadosEndereco
	HttpPost->Cep 		:= aDadosCEP

	cBanco	 := "341-7"	
	cAgencia := AllTrim(aDadosAgencia)
	cCodCed  := StrTran(AllTrim(aDadosConta),"-","")
	                                        
//	nA := At('-', cCodCed)  //**** Retirar o digito ***

// 	cCodCed := If(nA > 0, Left(cCodCed, nA-1), cCodCed)

	HttpPost->Banco   := cBanco
	HttpPost->Agencia := cAgencia
	HttpPost->CodCed  := cCodCed
	
	cCedente := StrTran(StrTran(cCodCed,".",""),"-","")

	cNossoNumero := aDadosNossoNumero
	
	HttpPost->NossoNumero := cNossoNumero

	cValor := StrTran(StrTran(Alltrim(Str(nValorDocumento,15,2)),",",""),".","")
	cValor := Right(Replicate("0",10) + cValor, 10)

//	cDigito := "2402" + cNossoNumero

//	HttpPost->Digito := fCalcDig11(cDigito,9,0)

	HttpPost->CodBar 		 := fCodBarra(Left(cBanco,3), cMoeda, cValor, cCedente, cAgencia, cNossoNumero, @cValorDig, aDadosDtPagto)
	HttpPost->LinhaDigitavel := fLinhaDigitavel(HttpPost->CodBar)
	
	HttpPost->ValorDig := cValorDig
    
	cHtml := ExecInPage("BOLITAUASSO")

Web Extended End

Return cHtml  
**** fim ***


/**************************
STATIC Function fCalcNumb(cNossoNumero)

Local nConta

Local aTab  := {7, 7, 3, 1, 9, 7, 3, 1, 9, 7, 3}

Local nSoma    := 0
Local nUnidade := 0
Local nDigito  := 0

For nConta := 1 to 10
	
	nUnidade := Val(SubStr(cNossoNumero, nConta, 1)) * aTab[nConta]
	nUnidade := Val(Right(Alltrim(Str(nUnidade)),1))
	
	nSoma    += nUnidade
	
Next nConta

nSoma := Right(nSoma,1)

nDigito := If(nSoma <= 0, 0, 10-nSoma)

Return nDigito
**** fim ***/



//**************************
STATIC Function fCodBarra(cBanco, cMoeda, cValor, cCedente, cAgencia, cNossoNumero, cValorDig, dDtVencmto)

Local cCmpLivre, cVencto, cCodBar, cDig3

cCmpLivre := cAgencia + Left(cCedente,5) + "175" + SubStr(cNossoNumero,6,8)

cValorDig := fCalcDig10(cCmpLivre)

cCmpLivre := "175" + SubStr(cNossoNumero,6,8) + cValorDig + cAgencia + cCedente + "000"

cVencto   := Alltrim(Str(dDtVencmto - CtoD("07/10/1997")))

cCodBar   := cBanco + cMoeda + cVencto + cValor + cCmpLivre

cDig3     := fCalcDig11(cCodBar, 9, 0)

cCodBar   := cBanco + cMoeda + cDig3 + cVencto + cValor + cCmpLivre

Return cCodBar
**** fim ***