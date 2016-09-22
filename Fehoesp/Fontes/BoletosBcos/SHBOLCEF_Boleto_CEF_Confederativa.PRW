#INCLUDE "PROTHEUS.CH"
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "SHBOLCEF_INCLUDES.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SHBOLCEF ºAutor  ³Antonio C Ferreira  º Data ³  07/out/2010 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Geracao do Boleto da Caixa Economica Federal Confederativa º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function SHBOLCEF()

Local nValorDocumento, cNossoNumero, cBanco, cAgencia, cCodCed, cCedente, cValor, cDigito

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

	cBanco	 := "104-0"	
	cAgencia := AllTrim(aDadosAgencia)
	cCodCed  := AllTrim(aDadosConta)
	                                        
	HttpPost->Banco   := cBanco
	HttpPost->Agencia := cAgencia
	HttpPost->CodCed  := cCodCed

	cCedente := StrTran(StrTran(cCodCed,".",""),"-","")

	cNossoNumero := aDadosTitulo
	cNossoNumero := "8000" + Right(Replicate("0",9)+cNossoNumero,9)
	
	HttpPost->NossoNumero := cNossoNumero

	cValor := StrTran(StrTran(Alltrim(Str(nValorDocumento,15,2)),",",""),".","")
	cValor := Right(Replicate("0",10) + cValor, 10)

	cDigito := "2402" + cNossoNumero

	HttpPost->Digito := fCalcDig11(cDigito,9,0)

	HttpPost->ValorDig := fCalcDig10(cNossoNumero + StrTran(cAgencia," / ","") + cCedente)
    
	HttpPost->CodBar 		 := fCodBarra(Left(cBanco,3), cMoeda, cValor, cCedente, "02820004", cNossoNumero, aDadosDtPagto)
	HttpPost->LinhaDigitavel := fLinhaDigitavel(HttpPost->CodBar)
	
	cHtml := ExecInPage("BOLCEFCONF")

Web Extended End

Return cHtml  
**** fim ***


//**************************
STATIC Function fCodBarra(cBanco, cMoeda, cValor, cCedente, cMeioNum, cNossoNumero, dDtVencmto)

Local cCmpLivre, cDigito, cVencto, cCodBar, cDig3

cCmpLivre := cCedente + cMeioNum + Right(cNossoNumero,9)

cDigito   := fCalcDig11(cCmpLivre,9,0)

cCmpLivre := cCmpLivre + cDigito

cVencto   := Alltrim(Str(dDtVencmto - CtoD("07/10/1997")))

cCodBar   := cBanco + cMoeda + cVencto + cValor + cCmpLivre

cDig3     := fCalcDig11(cCodBar, 9, 0)

cCodBar   := cBanco + cMoeda + cDig3 + cVencto + cValor + cCmpLivre

Return cCodBar
**** fim ***


//**************************
Function fLinhaDigitavel(cCodBar)

Local cCampo1, cCampo2, cCampo3, cCampo4, cCampo5
Local cCmpLivre := SubStr(cCodBar,20,25)

cCampo1 := Left(cCodBar,4) + SubStr(cCmpLivre,1,5)
cCampo1	:= cCampo1 + fCalcDig10(cCampo1)
cCampo1 := SubStr(cCampo1,1,5) + "." + SubStr(cCampo1,6,5)

cCampo2 := SubStr(cCmpLivre,6,10)
cCampo2 := cCampo2 + fCalcDig10(cCampo2)
cCampo2 := SubStr(cCampo2,1,5) + "." + SubStr(cCampo2,6,6)

cCampo3 := SubStr(cCmpLivre,16,10)
cCampo3 := cCampo3 + fCalcDig10(cCampo3)
cCampo3 := SubStr(cCampo3,1,5) + "." + SubStr(cCampo3,6,6)

cCampo4 := SubStr(cCodBar,5,1)

cCampo5 := SubStr(cCodBar,6,14)

Return cCampo1 + "  " + cCampo2 + "  " + cCampo3 + "  " + cCampo4 + "  " + cCampo5
**** fim ***


//valortal=fCalcDig10("11513024791005193100033")
//response.write valortal

//**************************
Function fCalcDig10(cCadeia)

Local nPos, nMult, nTotal, nRes

nMult := (Len(cCadeia) % 2) 
nMult := nMult + 1

nTotal := 0

For nPos := 1 to Len(cCadeia)
	nRes := Val(SubStr(cCadeia, nPos, 1)) * nMult

	If  (nRes > 9)
		nRes := Int(nRes/10) + (nRes % 10)
	EndIf
		
	nTotal := nTotal + nRes

	nMult := If(nMult = 2, 1, 2)
Next nPos                     

nTotal := ((10-(nTotal % 10)) % 10 )

Return Alltrim(Str(nTotal))
**** fim ***


//valortal1=fCalcDig11("0339000000000103581481302647800076960003348",9,0)
//response.write valortal1

//**************************
Function fCalcDig11(cCadeia, nLimiteSup, cFlag)

Local nMult, nPos, nResto, nDigito

Local nTotal := 0

nMult := (Len(cCadeia) % (nLimiteSup-1)) + 1
nMult := If(nMult == 1, nLimiteSup, nMult)

For nPos := 1 to Len(cCadeia)
	nTotal := nTotal + (Val(SubStr(cCadeia, nPos, 1)) * nMult)

	nMult  := (nMult - 1)
	nMult  := If(nMult == 1, nLimiteSup, nMult)
Next nPos

nResto := (nTotal % 11)

If  (cFlag = 1)
	nDigito := nResto
Else

	nDigito := (11 - nResto)
	nDigito := If(nDigito > 9, 0, nDigito)
EndIf

Return Alltrim(Str(nDigito))
**** fim ***


Function fWBarCode1( cValor )

Local f, f1, f2, i, texto
Local cFino   := "1"
Local cLargo  := "3"
Local cAltura := "40"      

Local cTags	  := ""

Local aBarCodes := Array(100)

aBarCodes[01] := "00110"
aBarCodes[02] := "10001"
aBarCodes[03] := "01001"
aBarCodes[04] := "11000"
aBarCodes[05] := "00101"
aBarCodes[06] := "10100"
aBarCodes[07] := "01100"
aBarCodes[08] := "00011"
aBarCodes[09] := "10010"
aBarCodes[10] := "01010"

For f1 := 10 to 1 step -1

    For f2 := 10 to 1 Step -1

      	f := (f1-1) * 10 + f2
      	
      	If  (f <= 0) 
      		Exit
      	EndIf	

      	texto := ""

      	For i := 1 To 5
			texto += SubStr(aBarCodes[f1], i, 1) + SubStr(aBarCodes[f2], i, 1)
      	Next i
      	
      	aBarCodes[f] := texto
      	
    Next f2

Next f1

//Desenho da barra

// Guarda inicial
cTags += "<img src=Boletos/images/2.gif width=" + cFino + " height=" + cAltura + " border=0><img " + chr(13) + chr(10)
cTags += "src=Boletos/images/1.gif width=" + cFino + " height=" + cAltura + " border=0><img " + chr(13) + chr(10)
cTags += "src=Boletos/images/2.gif width=" + cFino + " height=" + cAltura + " border=0><img " + chr(13) + chr(10)
cTags += "src=Boletos/images/1.gif width=" + cFino + " height=" + cAltura + " border=0><img " + chr(13) + chr(10) 

texto := Alltrim(cValor)
texto := If((Len(texto)%2) <> 0, "0" + texto, texto)

// Draw dos dados
Do 	While (Len(texto) > 0)

	i := Val(Left(texto,2)) + 1
  
 	texto := Right(texto, Len(texto)-2)

  	f := aBarCodes[i]
  	
  	For i := 1 to 10 step 2
    	
    	f1 := If(SubStr(f, i, 1) == "0", cFino, cLargo)

	    cTags += "src=Boletos/images/2.gif width=" + f1 + " height=" + cAltura + " border=0><img " + chr(13) + chr(10)

    	f2 := If(SubStr(f, i + 1, 1) == "0", cFino, cLargo)
    	
	    cTags += "src=Boletos/images/1.gif width=" + f2 + " height=" + cAltura + " border=0><img " + chr(13) + chr(10)

  	Next i
  	
EndDo

// Draw guarda final
cTags += "src=Boletos/images/2.gif width=" + cLargo + " height=" + cAltura + " border=0><img " + chr(13) + chr(10)
cTags += "src=Boletos/images/1.gif width=" + cFino + " height=" + cAltura + " border=0><img " + chr(13) + chr(10)
cTags += "src=Boletos/images/2.gif width=1 height=" + cAltura + " border=0>" + chr(13) + chr(10)

Return cTags
**** fim ***