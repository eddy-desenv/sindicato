#INCLUDE "PROTHEUS.CH"
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ASSOCIA   ºAutor  ³GISELE NUNCHERINO   º Data ³  04/23/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE SOLICITACAO DE ASSOCIACAO                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function ASSOCIA()

Local cHtml := ""

Web Extended Init cHtml 

	cHtml := ExecInPage("SINDASSOC")
                                      
Web Extended End


Return cHtml  

  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ASSOCIA   ºAutor  ³GISELE NUNCHERINO   º Data ³  04/23/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE SOLICITACAO DE ASSOCIACAO                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function ASSOCMAIL()

Local cHtml 		:= ''
LOCAL cEMailFrom 	:= ''
LOCAL cEMailTo		:= ''
LOCAL cTitulo		:= ''
LOCAL cCorpo		:= ''
LOCAL cAnexo		:= ''
LOCAL cRetEnv		:= ''

LOCAL oWS		:= WSCFGDICTIONARY():NEW()  

WSChgUrl( @OWS, "CFGDICTIONARY.APW" )

cEMailFrom := If(!(oWS:GETPARAM("MSALPHA","MV_PMAILAS")) .Or. (ValType(oWS:cGETPARAMRESULT)!="C") .Or. Empty(oWS:cGETPARAMRESULT) .Or. (oWS:cGETPARAMRESULT=='.F.'), "interior@sindhosp.com.br", Alltrim(oWS:cGETPARAMRESULT))
cEMailTo   := cEMailFrom

Web Extended Init cHtml 
   
    cTitulo 	:= 'Intenção de Associar-se'
    //CEMAILTO	:= GETMV("MV_PMAILCA")
    //cEMailTo	:= HTTPPOST->CEMAIL 
               
	HttpSetPart(.F.)		                   
    cCorpo		:= EXECINPAGE("ASSOCMAIL")
	cCorpo 		:= UpStrtran(cCorpo,chr(13) + chr(10),"")
	HttpSetPart(.T.)
	    
  
    CRETENV := u_ENVMAIL(cEmailFrom, cEMailTo, cTitulo, cCorpo, cAnexo )
    
    If EMPTY(CRETENV)
		HTTPPOST->MENSAGEM := "E-mail enviado com Sucesso!<br>Aguarde o contato de um dos nossos Representantes.<br><br>"
	Else
		HTTPPOST->MENSAGEM	:= CRETENV
	EndIf
	
	cHtml := ExecInPage("SINDASSOC")
                                      
Web Extended End


Return cHtml 
**** fim ***