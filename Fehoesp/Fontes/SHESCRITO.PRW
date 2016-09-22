
#INCLUDE "PROTHEUS.CH"
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESCRITO  ºAutor  ³GISELE NUNCHERINO   º Data ³  24/05/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA INICIAL DO CAD DE ESCRITORIO CONTABIL       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function ESCRITO()

Local cHtml := ""

Web Extended Init cHtml //Start "w_UserIsOn" 
    
//	cHtml := ExecInPage("MENU")
	
    IF HTTPSESSION->AEMPRESA <> NIL // TRATA-SE DE VINCULAR O ESCRITORIO CONTABIL COM A EMPRESA
		cHtml := ExecInPage("EMPESC")    
    ELSE
	    HTTPSESSION->AESCRITO 	:= NIL 
	    HTTPSESSION->XCGC		:= NIL  
	    HTTPSESSION->ROTINA		:= NIL
    	HTTPPOST->MSGATUA		:= NIL
	    
	    HTTPSESSION->PAGINA	:= 'ESCRITO'
	    
		cHtml := ExecInPage("INTROESCR")
    ENDIF 
    
Web Extended End


Return cHtml  



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FUNCESC  ºAutor  ³GISELE NUNCHERINO   º Data ³  24/05/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ VERIFICA SE O CNPJ/CPF/CEI ESTA OU NAO CADASTRO	          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function FUNCESC()

Local cHtml 	:= ""
LOCAL CCGC 		:= HTTPPOST->CGC
LOCAL OWS		:= WSSINDHOSP():NEW()
LOCAL OWSAUX	:= WSSINDHOSP():NEW()

Web Extended Init cHtml //Start "w_UserIsOn"  

/*IF HTTPPOST->CGC == NIL .OR. EMPTY(HTTPPOST->CGC)
	HTTPPOST->CGC := HTTPPOST->CGC2
ENDIF
*/

If  !( Empty(HttpSession->XBVOLTAR) )
	HTTPPOST->lVinculo := .T.  //**** Nao apresentar o botao Vincular ***
EndIf

CCGC := HTTPPOST->CGC

IF U_LIMPACGC(HTTPPOST->CGC) == NIL
	HTTPPOST->ERRO := "CNPJ em branco/invalido"
	cHtml := ExecInPage("ERRO")	        
ELSE
	
OWS:CCCGC 	:= U_LIMPACGC(CCGC)

IF OWS:VERCADESC()   
     
	IF !EMPTY(OWS:OWSVERCADESCRESULT:CCCGC)//ACHOU O ESCRITORIO
	
		OWSAUX:CCCGC 	:= CCGC 

		IF OWSAUX:VERESCAUX()  
    
			IF !EMPTY(OWSAUX:OWSVERESCAUXRESULT:CCCODIGO)   
				HTTPPOST->RAZAO2	:= ALLTRIM(OWSAUX:OWSVERESCAUXRESULT:CCNOME)
			    HTTPPOST->CEP2		:= ALLTRIM(OWSAUX:oWSVERESCAUXRESULT:CCCEP)
			    HTTPPOST->CEND2		:= ALLTRIM(OWSAUX:oWSVERESCAUXRESULT:CCEND)
			    HTTPPOST->BAIRRO2	:= ALLTRIM(OWSAUX:oWSVERESCAUXRESULT:CCBAIRRO)
			    HTTPPOST->MUN2		:= ALLTRIM(OWSAUX:oWSVERESCAUXRESULT:CCMUN)
			    HTTPPOST->EST2		:= ALLTRIM(OWSAUX:oWSVERESCAUXRESULT:CCUF)
			    HTTPPOST->EMAIL2	:= ALLTRIM(OWSAUX:oWSVERESCAUXRESULT:CCEMAIL)
			    HTTPPOST->FONE2		:= ALLTRIM(OWSAUX:oWSVERESCAUXRESULT:CCTEL)
			    HTTPPOST->FAX2		:= ALLTRIM(OWSAUX:oWSVERESCAUXRESULT:CCFAX)
			    HTTPPOST->CONTATO2	:= ALLTRIM(OWSAUX:oWSVERESCAUXRESULT:CCCONTATO) 
				HTTPSESSION->EXIBEAUX := 1
				HTTPSESSION->AUXEXIBE := 0			    
				HTTPSESSION->AESCAUX:= OWSAUX:oWSVERESCAUXRESULT			    
        	ELSE
        	
				HTTPSESSION->AESCAUX	:= NIL 			
				HTTPSESSION->EXIBEAUX 	:= 0
				HTTPSESSION->AUXEXIBE 	:= -1
			ENDIF        	
       	
		ELSE     

  			HTTPSESSION->AESCRITO 	:= NIL
			HTTPSESSION->AESCAUX	:= NIL 	
			HTTPPOST->ERRO			:= GETWSCERROR()
  			//cHtml := ExecInPage("MENU")
			cHtml := ExecInPage("ERRO")		    
		    CONOUT(GETWSCERROR())
		ENDIF
	    /* DADOS DO ESCRITORIO */
		HTTPSESSION->AESCRITO := OWS:OWSVERCADESCRESULT					    				 
		HTTPSESSION->ROTINA := '4' //ALTERACAO
	    HTTPSESSION->XCGC  	:= ALLTRIM(OWS:OWSVERCADESCRESULT:CCCGC)
	    HTTPPOST->RAZAO		:= ALLTRIM(OWS:OWSVERCADESCRESULT:CCNOME)   
			            
	    IF HTTPPOST->CEP == NIL .OR. EMPTY(HTTPPOST->CEP) 
		    HTTPPOST->CEP		:= ALLTRIM(OWS:OWSVERCADESCRESULT:CCCEP)
		    HTTPPOST->CEND		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCEND)
		    HTTPPOST->BAIRRO	:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCBAIRRO)
		    HTTPPOST->MUN		:= ALLTRIM(OWS:OWSVERCADESCRESULT:CCMUN)
		    HTTPPOST->EST		:= ALLTRIM(OWS:OWSVERCADESCRESULT:CCUF)
	    ENDIF
	
	    HTTPPOST->EMAIL		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCEMAIL)
	    HTTPPOST->TEL		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCTEL)
	    HTTPPOST->FAX		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCFAX)
	    HTTPPOST->CONTATO	:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCCONTATO)
			    
	    /* DADOS DO ESCRITORIO */
		HTTPSESSION->AESCRITO := OWS:oWSVERCADESCRESULT	
			    
  		//cHtml := ExecInPage("MENU")
		cHtml := ExecInPage("ESCRITO")
	
   	ELSE //NAO ACHOU O ESCRITORIO
			HTTPSESSION->ROTINA := '3' //INCLUSAO
		    HTTPSESSION->XCGC	:= HTTPPOST->CGC
		    HTTPPOST->RAZAO		:= ''
		    
		    IF HTTPPOST->CEP==NIL .OR. EMPTY(HTTPPOST->CEP)
			    HTTPPOST->CEP		:= ''
			    HTTPPOST->CEND		:= ''
			    HTTPPOST->BAIRRO	:= ''
			    HTTPPOST->MUN		:= ''
			    HTTPPOST->EST		:= ''  
		    ENDIF
		    
		    HTTPPOST->EMAIL		:= ''
		    HTTPPOST->TEL		:= ''
		    HTTPPOST->FAX		:= ''
		    HTTPPOST->CONTATO	:= ''     
		    
		    /* DADOS DO ESCRITORIO */
			HTTPSESSION->AESCRITO 	:= NIL	
		    HTTPSESSION->PAGINA 	:= "ESCRITO"
		    
		//	cHtml := ExecInPage("MENU")
			cHtml := ExecInPage("ESCRITO")	    
   	ENDIF 
ELSE
	HTTPSESSION->AESCRITO := NIL

//	cHtml := ExecInPage("MENU")
	HTTOPOST->ERRO := GETWSCERROR()
	cHtml := ExecInPage("ERRO")
	CONOUT(GetWSCError())
ENDIF

ENDIF

Web Extended End

Return cHtml  
                    
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATUAESC  ºAutor  ³GISELE NUNCHERINO   º Data ³   24/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ATUALIZA/INCLUI O CADASTRO DO ESCRITORIO CONTABIL          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function ATUAESC()

Local cHtml 	:= ""
LOCAL CCGC 		:= HTTPPOST->CGC2
LOCAL OWS		:= WSSINDHOSP():NEW()

Web Extended Init cHtml //Start "w_UserIsOn" 

IF U_LIMPACGC(CCGC) == NIL
	HTTPPOST->ERRO := "CNPJ em branco/invalido"
	cHtml := ExecInPage("ERRO")	        
ELSE
	
OWS:cCCGC 		:= U_LIMPACGC(CCGC)

OWS:oWSAESCRITO := WSCLASSNEW("SINDHOSP_SESCRITO")

OWS:oWSAESCRITO:cCBAIRRO 		:= HTTPPOST->BAIRRO
//OWS:oWSAESCRITO:cCCAPITAL       := HTTPPOST->CAPITAL
OWS:oWSAESCRITO:cCCEP           := HTTPPOST->CEP
OWS:oWSAESCRITO:cCCGC           := U_LIMPACGC(CCGC)
OWS:oWSAESCRITO:cCCODIGO        := IIF (HTTPSESSION->AESCRITO <> NIL, HTTPSESSION->AESCRITO:cCCODIGO, '')
OWS:oWSAESCRITO:cCCONTATO       := HTTPPOST->CONTATO
OWS:oWSAESCRITO:cCEMAIL         := HTTPPOST->EMAIL
OWS:oWSAESCRITO:cCEND           := HTTPPOST->CEND
OWS:oWSAESCRITO:cCFAX           := HTTPPOST->FAX
OWS:oWSAESCRITO:cCFILIAL        := IIF (HTTPSESSION->AESCRITO <> NIL, HTTPSESSION->AESCRITO:CCFILIAL, '')
//OWS:oWSAESCRITO:cCLOJA          := IIF (HTTPSESSION->AESCRITO <> NIL, HTTPSESSION->AESCRITO:CCCLOJA, '01')
OWS:oWSAESCRITO:cCMUN           := HTTPPOST->MUN
OWS:oWSAESCRITO:cCNOME          := HTTPPOST->RAZAO
OWS:oWSAESCRITO:cCTEL           := HTTPPOST->TEL
OWS:oWSAESCRITO:cCUF            := HTTPPOST->EST

OWS:cCROTINA := HTTPSESSION->ROTINA
IF OWS:CADESCRIT()   
	IF OWS:lCADESCRITRESULT // ALTERACAO OU INCLUSAO COM SUCESSO 
	
        If  !( Empty( HttpSession->XBVOLTAR ) )
                   
			HTTPPOST->CGC := U_LIMPACGC(CCGC)
			
            Eval( &(HttpSession->XBVOLTAR) )

		ElseIf OWS:VERCADESC()   
        
			IF !EMPTY(OWS:OWSVERCADESCRESULT:CCCGC)//ACHOU O ESCRITORIO  
			    /* DADOS DO ESCRITORIO */
				HTTPSESSION->AESCRITO := OWS:oWSVERCADESCRESULT				 
				HTTPPOST->MSGATUA := "Dados Enviados Com Sucesso" 
				HTTPSESSION->AEMPRESA := NIL
				HTTPSESSION->AESCRITO := NIL
				cHtml := ExecInPage("INTROESCR")
			ELSE // NAO ACHOU 

				HTTPSESSION->AESCRITO := NIL					
				HTTPPOST->ERRO := "Escritorio Contabil Nao Localizado"
				cHtml := ExecInPage("ERRO")
			ENDIF  
			
		ELSE // ERRO
			HTTPSESSION->AESCRITO := NIL
			HTTPPOST->ERRO := GetWSCError()
			cHtml := ExecInPage("ERRO")			
			CONOUT(GetWSCError())		
		ENDIF 

   ELSE // NAO ALTEROU OU INCLUIU
		HTTPPOST->CGC := HTTPPOST->CGC   
		//HTTPSESSION->AESCRITO := NIL		
		HTTPPOST->MSGATUA := "Problema no Envio dos Dados"
		cHtml := ExecInPage("INTROESCR") 
   ENDIF 
ELSE
	HTTPSESSION->AEMPRESA := NIL
	HTTPPOST->ERRO := GetWSCError()
	cHtml := ExecInPage("ERRO")
	CONOUT(GetWSCError())
ENDIF	

ENDIF

Web Extended End

Return cHtml  
                    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EMPESC   ºAutor  ³GISELE NUNCHERINO   º Data ³  25/05/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE VINCULO DO ESCRITORIO CONTABIL 		  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function EMPESC()

Local cHtml := ""

Web Extended Init cHtml //Start "w_UserIsOn" 
    HTTPSESSION->AESCRITO 	:= NIL 
	HTTPSESSION->XCGC		:= NIL
    IF HTTPSESSION->AEMPRESA <> NIL // TRATA-SE DE VINCULAR O ESCRITORIO CONTABIL COM A EMPRESA
		cHtml := ExecInPage("EMPESC") 
    ELSE             
		cHtml := ExecInPage("ESCRITO")
    ENDIF
                                      
Web Extended End


Return cHtml 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESCINFO   ºAutor  ³GISELE NUNCHERINO   º Data ³  25/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ EXIBE OS DADOS DO ESCRITORIO CONTABIL QUE SERA VINCULADO	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function ESCINFO()

Local cHtml 	:= ""
LOCAL CCGC 		:= HTTPPOST->CGC
LOCAL OWS		:= WSSINDHOSP():NEW()

HttpSession->XBVOLTAR := NIL

Web Extended Init cHtml //Start "w_UserIsOn" 
     
Do  While .T.

	If  Empty(HTTPSESSION->AEMPRESA)
		HttpPost->XRedir := "w_Empresa.apw"
		HTTPPOST->ERRO := "CNPJ em branco/invalido"
		cHtml := ExecInPage("ERRO")	        
		Exit
	EndIf	


	If  Empty( u_LIMPACGC(CCGC) )
		HTTPPOST->ERRO := "CNPJ em branco/invalido"
		cHtml := ExecInPage("ERRO")	        
		Exit
	EndIf
	
	OWS:cCCGC := u_LIMPACGC(CCGC)
	
	If  !( OWS:VERCADESC() )
		HTTPSESSION->AESCRITO := NIL
		cHtml := ExecInPage("EMPESC")
		CONOUT(GetWSCError())
		Exit
	EndIf

	If  !( Empty(OWS:oWSVERCADESCRESULT:CCCGC) ) //ACHOU O ESCRITORIO
		
		/* DADOS DO ESCRITORIO */
		HTTPSESSION->AESCRITO 	:= OWS:oWSVERCADESCRESULT				
	    HTTPPOST->ESCCGC	  	:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCCGC)
	    HTTPPOST->ESCRAZAO		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCNOME)
	    HTTPPOST->ESCCEP		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCCEP)
	    HTTPPOST->ESCEND		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCEND)
	    HTTPPOST->ESCBAIRRO		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCBAIRRO)
	    HTTPPOST->ESCMUN		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCMUN)
	    HTTPPOST->EST			:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCUF)
	    HTTPPOST->ESCEMAIL		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCEMAIL)
	    HTTPPOST->ESCTEL		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCTEL)
	    HTTPPOST->ESCFAX		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCFAX)
	    HTTPPOST->ESCCONTATO	:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCCONTATO)		
	    
	    cHtml := ExecInPage("EMPESC")			
     
	Else // NAO ACHOU
		
		HTTPSESSION->AESCRITO := NIL

		HTTPPOST->CGC := u_LIMPACGC(CCGC)
		                           
		HTTPSESSION->ROTINA := '3' //**** Inclusao ***
		
		HttpSession->XBVOLTAR := "{|| w_ESCINFO() }"
		
	    cHtml := ExecInPage("ALTESC")			
     
	EndIf  

	Exit
EndDo

Web Extended End

Return cHtml  
**** fim ***

                    
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VINCESC   ºAutor  ³GISELE NUNCHERINO   º Data ³  25/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ VINCULA O ESCRITORIO CONTABIL COM A EMPRESA EM QUESTAO	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function VINCESC()

Local cHtml 	:= ""
LOCAL OWS		:= WSSINDHOSP():NEW()
LOCAL CMSG		:= ''

Web Extended Init cHtml //Start "w_UserIsOn"  

Do  While .T.
                         
	If  Empty(HTTPSESSION->AEMPRESA)
	    HTTPPOST->ERRO := "Empresa não Cadastrada para Vínculo!"
		cHtml := ExecInPage('ERRO')
		Exit
	EndIf
	
	OWS:CCODEMP 		:= HTTPSESSION->AEMPRESA:CCCODIGO+HTTPSESSION->AEMPRESA:CCLOJA
	OWS:CCODESCR		:= HTTPSESSION->AESCRITO:CCCGC
	
	IF OWS:VINCESCR() 
		IF OWS:lVINCESCRRESULT // VINCULOU  
			CMSG := "Os dados da sua contabilidade foram vinculados a empresa: " + HTTPSESSION->AEMPRESA:cCNOME
			//HTTPSESSION->AESCRITO := NIL					
			//HTTPSESSION->AEMPRESA := NIL  
			HTTPPOST->MSGATUA := CMSG 
			HTTPPOST->XRedir  := "w_CALCBOL.apw?TPBOLETO=1&ITEM=1"  //**** Direciona para os Boletos ***         
			cHtml := ExecInPage('INTROESCR')
		ELSE
			CMSG := "Problemas Para Realizar a Operacao"
			HTTPSESSION->AESCRITO := NIL
			HTTPPOST->MSGATUA := CMSG
			CHTML := EXECINPAGE('INTROESCR')
		ENDIF
	ELSE // ERRO
	    HTTPPOST->ERRO:= GetWSCError()
		cHtml := ExecInPage('ERRO')
		CONOUT(GetWSCError())
	ENDIF	
	
	Exit
EndDo	

Web Extended End

Return cHtml  
                    
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LIMPAESC  ºAutor  ³GISELE NUNCHERINO   º Data ³  25/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ LIMPA OS DADOS DO ESCRITORIO CONTABIL					  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function LIMPAESC()
      
LOCAL CHTML:= ''

HTTPSESSION->AEMPRESA := NIL
HTTPSESSION->AESCRITO := NIL

Web Extended Init cHtml //Start "w_UserIsOn"  
	W_ESCRITO()
Web Extended End

Return cHtml  
                    

/*
ÜÜÜÜ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EscCEP ºAutor  ³GISELE NUNCHERINO   º Data ³   08/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ GATILHO PARA O CEP								          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function EscCep()

Local cHtml 	:= ""
LOCAL OWS		:= WSSINDHOSP():NEW() //EMPRESA

If  !( Empty(HttpSession->XBVOLTAR) )
	HTTPPOST->lVinculo := .T.  //**** Nao apresentar o botao Vincular ***
EndIf

HTTPSESSION->AUXEXIBE := IIF (HTTPSESSION->EXIBEAUX <> nil .and. (HTTPSESSION->EXIBEAUX) > 0, 3,0)
HTTPSESSION->EXIBEAUX := 0

HTTPSESSION->RAZAO 		:= HTTPPOST->RAZAO
HTTPSESSION->RAZAO 		:= HTTPPOST->RAZAO
HTTPSESSION->EMAIL		:= HTTPPOST->EMAIL
HTTPSESSION->TEL		:= HTTPPOST->TEL
HTTPSESSION->FAX		:= HTTPPOST->FAX
HTTPSESSION->CONTATO	:= HTTPPOST->CONTATO
HTTPSESSION->CGC		:= HTTPPOST->CGC2
    
Web Extended Init cHtml           

IF HTTPPOST->CEP <> NIL .AND. !EMPTY(HTTPPOST->CEP)

	IF U_LIMPACGC(HTTPPOST->CEP) == NIL
		HTTPPOST->ERRO := "CEP em branco/invalido"
		cHtml := ExecInPage("ERRO")	        
	ELSE
	
		OWS:CCEP := U_LIMPACGC(HTTPPOST->CEP)
		
		IF OWS:BUSCACEP() // ACHOU O CEP
		
		    HTTPPOST->CEND 		:= OWS:oWSBUSCACEPRESULT:CENDERECO
			HTTPPOST->BAIRRO 	:= OWS:oWSBUSCACEPRESULT:CBAIRRO
			HTTPPOST->MUN 		:= OWS:oWSBUSCACEPRESULT:CMUN
			HTTPPOST->EST 		:= OWS:oWSBUSCACEPRESULT:CEST
			HTTPPOST->CEP		:= OWS:oWSBUSCACEPRESULT:CCEP
		    HTTPSESSION->ERSIN	:= OWS:oWSBUSCACEPRESULT:CERSIN
		    HTTPSESSION->BASE	:= OWS:oWSBUSCACEPRESULT:CBASE
		    HTTPSESSION->BASE2	:= OWS:oWSBUSCACEPRESULT:CBASE2
		ELSE
		    CONOUT(GETWSCERROR())
		    HTTPPOST->CEND 		:= ''
			HTTPPOST->BAIRRO 	:= ''
			HTTPPOST->MUN 		:= ''
			HTTPPOST->EST 		:= ''
			HTTPPOST->CEP		:= ''
		    HTTPSESSION->ERSIN	:= ''
		    HTTPSESSION->BASE	:= ''
		    HTTPSESSION->BASE2	:= ''
		ENDIF                            
		HTTPPOST->RAZAO 	:= HTTPSESSION->RAZAO
	    HTTPPOST->EMAIL		:= HTTPSESSION->EMAIL
	    HTTPPOST->TEL		:= HTTPSESSION->TEL
	    HTTPPOST->FAX		:= HTTPSESSION->FAX
	    HTTPPOST->CONTATO	:= HTTPSESSION->CONTATO
	    HTTPPOST->CGC2		:= HTTPSESSION->CGC

	    HTTPSESSION->XCGC	:= HTTPSESSION->CGC
    ENDIF
ENDIF
                             
IF HTTPSESSION->AESCAUX <> NIL 
	HTTPPOST->RAZAO2	:= ALLTRIM(HTTPSESSION->AESCAUX:CCNOME)
	HTTPPOST->CEP2		:= ALLTRIM(HTTPSESSION->AESCAUX:CCCEP)
	HTTPPOST->CEND2		:= ALLTRIM(HTTPSESSION->AESCAUX:CCEND)
	HTTPPOST->BAIRRO2	:= ALLTRIM(HTTPSESSION->AESCAUX:CCBAIRRO)
	HTTPPOST->MUN2		:= ALLTRIM(HTTPSESSION->AESCAUX:CCMUN)
	HTTPPOST->EST2		:= ALLTRIM(HTTPSESSION->AESCAUX:CCUF)
	HTTPPOST->EMAIL2	:= ALLTRIM(HTTPSESSION->AESCAUX:CCEMAIL)
	HTTPPOST->TEL2		:= ALLTRIM(HTTPSESSION->AESCAUX:CCTEL)
	HTTPPOST->FAX2		:= ALLTRIM(HTTPSESSION->AESCAUX:CCFAX)
	HTTPPOST->CONTATO2	:= ALLTRIM(HTTPSESSION->AESCAUX:CCCONTATO)
ENDIF	

//cHtml := ExecInPage("MENU")
cHtml := ExecInPage("ESCRITO")


Web Extended End

Return cHtml  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ALTESC   ºAutor  ³GISELE NUNCHERINO   º Data ³  24/05/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE MANUTENCAO DO  ESCRITORIO CONTABIL       º±±
±±º          ³ ATRAVES DA PAGINA DE VINCULACAO COM A EMPRESA              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function ALTESC()

Local cHtml := ""

Web Extended Init cHtml
    
    HTTPSESSION->XCGC := HTTPGET->CGC
    HTTPPOST->CGC     := HTTPGET->CGC
 
	cHtml := ExecInPage("ALTESC")
    
Web Extended End


Return cHtml  

