
#INCLUDE "PROTHEUS.CH"
//#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EMPRESA  ºAutor  ³GISELE NUNCHERINO   º Data ³  14/05/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA INICIAL DO CAD DE EMPRESA	                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function EMPRESA()

Local cHtml := ""

Web Extended Init cHtml 
                                          
    HTTPSESSION->AEMPRESA 	:= NIL  
    HTTPSESSION->AEMPAUX	:= NIL
    HTTPSESSION->EXIBEAUX 	:= 0
    HTTPSESSION->ROTINA		:= NIL
    HTTPPOST->CGC			:= NIL
    HTTPPOST->MSGATUA		:= NIL

	HTTPSESSION->PAGINA := 'EMPRESA'

	cHtml := ExecInPage("INTROEMP")
                                      
Web Extended End


Return cHtml  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FUNCEMP  ºAutor  ³GISELE NUNCHERINO   º Data ³  14/05/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ VERIFICA SE O CNPJ ESTA OU NAO CADASTRO	                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function FUNCEMP()

Local cHtml 	:= ""
LOCAL CCGC 		:= ''
LOCAL OWS		:= WSSINDHOSP():NEW() //EMPRESA
LOCAL OWSAUX	:= WSSINDHOSP():NEW() //AUXILIAR EMPRESA

Web Extended Init cHtml  

IF HTTPPOST->CGC <> NIL

	HTTPSESSION->CGC := Alltrim(HTTPPOST->CGC)

ENDIF
  
HTTPPOST->MSGATUA := NIL

CCGC := HTTPSESSION->CGC

Do  While .T.

If U_LIMPACGC(CCGC) == NIL
	HTTPPOST->ERRO := "CNPJ em branco/invalido"
	cHtml := ExecInPage("ERRO")	        
	Exit
EndIf

OWS:cCCGC 	:= Alltrim(U_LIMPACGC(CCGC))

IF OWS:VERCADEMP()   
                  
	IF !EMPTY(OWS:oWSVERCADEMPRESULT:CCCGC)//ACHOU A EMPRESA 

	    /* DADOS DA EMPRESA */
		HTTPSESSION->AEMPRESA := OWS:oWSVERCADEMPRESULT:Clone()
		HTTPSESSION->ROTINA   := '4' //ALTERACAO
	    HTTPPOST->CGC	  	  := ALLTRIM(OWS:oWSVERCADEMPRESULT:CCCGC)
        HTTPPOST->RAZAO		  := OWS:oWSVERCADEMPRESULT:CCNOME
      
     	If  !( (HTTPSESSION->AEMPRESA:DDDTNASC == DATE() .And. Alltrim(HTTPSESSION->AEMPRESA:CCINAT) == "X") .Or.;
  	       (Alltrim(HTTPSESSION->AEMPRESA:CCINAT) != "X") )
			HTTPPOST->ERRO := "Cliente c/ problemas no cadastro!<br>Favor entrar em contato com o departamento de cadastro do FEHOESP:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br"

			If  (HTTPSESSION->AEMPRESA:CCSINDICA == '01')
				HTTPPOST->ERRO := "Cliente  c/ problemas no cadastro!<br>Favor entrar em contato com o departamento de Cadastro, através do telefone (11) 3331-1555 na opção 7 ou <BR> e-mail: cadastro@sindhosp.com.br"
		    EndIf 

			cHtml := ExecInPage("ERRO")
			Exit
		EndIf

		OWSAUX:CCCGC 	:= U_LIMPACGC(CCGC)

		IF OWSAUX:VEREMPAUX() 
			IF !EMPTY(OWSAUX:OWSVEREMPAUXRESULT:CCCGC) //achou registro na tabela auxiliar        

				HTTPPOST->RAZAO2	:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCNOME)
			    HTTPPOST->CEP2		:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCCEP)
			    HTTPPOST->CEND2		:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCEND)
			    HTTPPOST->BAIRRO2	:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCBAIRRO)
			    HTTPPOST->MUN2		:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCMUN)
			    HTTPPOST->EST2		:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCUF)
			    HTTPPOST->EMAIL2	:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCEMAIL)
			    HTTPPOST->TEL2		:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCTEL)
			    HTTPPOST->FAX2		:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCFAX)
			    HTTPPOST->CAPITAL2	:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCCAPITAL)
			    HTTPPOST->INIATV2	:= OWSAUX:oWSVEREMPAUXRESULT:DDINIATV
			    HTTPPOST->CONTATO2	:= ALLTRIM(OWSAUX:oWSVEREMPAUXRESULT:CCCONTATO)
				HTTPSESSION->AEMPAUX:= OWSAUX:oWSVEREMPAUXRESULT			    
				HTTPSESSION->EXIBEAUX := 1
				HTTPSESSION->AUXEXIBE := 0

			ELSE            
				HTTPSESSION->AEMPAUX	:= NIL 			
				HTTPSESSION->EXIBEAUX 	:= 0
				HTTPSESSION->AUXEXIBE 	:= -1
			ENDIF
		ELSE
  			HTTPSESSION->AEMPRESA 	:= NIL
			HTTPSESSION->AEMPAUX	:= NIL 	  
			HTTPSESSION->EXIBEAUX 	:= NIL
			HTTPSESSION->AUXEXIBE 	:= -1 

       		If  Empty(GetWSCError(3))
       			HTTPPOST->ERRO := "Problema de Comunicação com o Servidor! Favor tentar novamente ou entrar em contato com a FEHOESP."
       		Else
				HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
			EndIf

			cHtml := ExecInPage("ERRO")		    

		    CONOUT(GETWSCERROR())
		ENDIF

	    IF HTTPPOST->CEP == NIL .OR. EMPTY(HTTPPOST->CEP)                                      
	
		    HTTPPOST->CEP		:= (ALLTRIM(OWS:oWSVERCADEMPRESULT:CCCEP))
		    HTTPPOST->CEND		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCEND)
		    HTTPPOST->BAIRRO	:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCBAIRRO)
		    HTTPPOST->MUN		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCMUN)
		    HTTPPOST->EST		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCUF)
	    ENDIF
	
	    HTTPPOST->EMAIL		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCEMAIL)
	    HTTPPOST->FONE		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCTEL)
	    HTTPPOST->FAX		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCFAX)
	    HTTPPOST->CAPITAL	:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCCAPITAL)  
	    HTTPPOST->INIATV	:= OWS:oWSVERCADEMPRESULT:DDINIATV //SUBSTR(CDATA,7,2) + '/' + SUBSTR(CDATA,5,2) + '/' + SUBSTR(CDATA,1,4)
	    HTTPPOST->CONTATO	:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCCONTATO)
	    HTTPPOST->NLEITOS	:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CNLEITOS)
	    HTTPPOST->NNUMFUN	:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CNNUMFUN)
	    
	    HTTPSESSION->XCAPITAL := HTTPPOST->CAPITAL
			    
	    /* DADOS DA EMPRESA */
		HTTPSESSION->AEMPRESA := OWS:oWSVERCADEMPRESULT	
//		HTTPSESSION->AUXEXIBE := 0			    
		//cHtml := ExecInPage("MENU")
		cHtml := ExecInPage("EMPRESA")
	
   ELSE //NAO ACHOU A EMPRESA
		HTTPSESSION->ROTINA := '3' //INCLUSAO
	    HTTPPOST->CGC	  	:= HTTPPOST->CGC
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
	    HTTPPOST->CAPITAL	:= ''
	    HTTPPOST->INIATV	:= ''
	    HTTPPOST->CONTATO	:= ''     
	    HTTPPOST->NLEITOS	:= ''
	    HTTPPOST->NNUMFUN	:= ''
	    
	    /* DADOS DA EMPRESA */
		HTTPSESSION->AEMPRESA := NIL	
		HTTPSESSION->AUXEXIBE := 0	    
		//cHtml := ExecInPage("MENU")
		cHtml := ExecInPage("EMPRESA")	    
  	ENDIF 
ELSE                             

	HTTPSESSION->AEMPRESA := NIL
	HTTPSESSION->AUXEXIBE := 0                    
	If  Empty(GetWSCError(3))
		HTTPPOST->ERRO := "Problema de Comunicação com o Servidor! Tente mais tarde!"
	Else
		HTTPPOST->ERRO:= Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
	EndIf	
	cHtml := ExecInPage("ERRO")
	CONOUT(GetWSCError())
ENDIF	                         

	Exit
EndDo	

Web Extended End      	

Return cHtml  
                    
/*
ÜÜÜÜ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATUAEMP  ºAutor  ³GISELE NUNCHERINO   º Data ³   21/05/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ATUALIZA/INCLUI O CADASTRO DE EMPRESA	                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function ATUAEMP()

Local cHtml 	:= ""
LOCAL CCGC 		:= HTTPSESSION->CGC
LOCAL OWS		:= WSSINDHOSP():NEW()

Web Extended Init cHtml 

Do  While .T.         

	If  U_LIMPACGC(CCGC) == NIL
		 HTTPPOST->ERRO := "CNPJ em branco/invalido"
		 cHtml := ExecInPage("ERRO")	        
		 Exit
	EndIf
		
	If  (HTTPSESSION->SINDCEP == '01')
	
   	    HTTPPOST->ERRO := "Favor entrar em contato com o departamento de cadastro do FEHOESP:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br"

		HttpPost->XRedir := 'W_EMPRESA.APW'
			   
	    cHtml := ExecInPage("ERRO")
	   
	    Exit
	EndIf   

	OWS:cCCGC 		:= U_LIMPACGC(CCGC)
	OWS:oWSAEMPRESA := WSCLASSNEW("SINDHOSP_SEMPRESA")
	
	IF HTTPSESSION->AEMPRESA <> NIL .AND. (HTTPSESSION->AEMPRESA:CCSITUAC == 'AS' .OR. HTTPSESSION->AEMPRESA:CCSITUAC == 'SS')
	
		OWS:oWSAEMPRESA:cCBAIRRO 		:= HTTPSESSION->AUXBAIRRO
		OWS:oWSAEMPRESA:cCCAPITAL       := HTTPSESSION->AUXCAPITAL
		OWS:oWSAEMPRESA:cCCEP           := HTTPSESSION->AUXCEP
		OWS:oWSAEMPRESA:cCCGC           := U_LIMPACGC(CCGC)
		OWS:oWSAEMPRESA:cCCODIGO        := IIF (HTTPSESSION->AEMPRESA <> NIL, HTTPSESSION->AEMPRESA:cCCODIGO, '')
		OWS:oWSAEMPRESA:cCCONTATO       := HTTPSESSION->AUXCONTATO
		OWS:oWSAEMPRESA:cCEMAIL         := HTTPSESSION->AUXEMAIL
		OWS:oWSAEMPRESA:cCEND           := HTTPSESSION->CEND
		OWS:oWSAEMPRESA:cCFAX           := HTTPSESSION->AUXFAX
		OWS:oWSAEMPRESA:cCFILIAL        := IIF (HTTPSESSION->AEMPRESA <> NIL, HTTPSESSION->AEMPRESA:cCFILIAL, '')
		OWS:oWSAEMPRESA:cCLOJA          := IIF (HTTPSESSION->AEMPRESA <> NIL, HTTPSESSION->AEMPRESA:cCLOJA, '01')
		OWS:oWSAEMPRESA:cCMUN           := HTTPSESSION->AUXMUN
		OWS:oWSAEMPRESA:cCNOME          := HTTPSESSION->AUXRAZAO
		OWS:oWSAEMPRESA:cCTEL           := HTTPSESSION->AUXFONE
		OWS:oWSAEMPRESA:cCUF            := HTTPSESSION->AUXEST        
		OWS:oWSAEMPRESA:dDINIATV        := CTOD(HTTPSESSION->AUXINIATV)
		OWS:oWSAEMPRESA:CERSIN	        := HTTPSESSION->ERSIN   
		OWS:oWSAEMPRESA:CCBASE        	:= HTTPSESSION->BASE   
		OWS:oWSAEMPRESA:CCBASE2        	:= HTTPSESSION->BASE2
	
	ELSE                             
	
		OWS:oWSAEMPRESA:cCBAIRRO 		:= HTTPPOST->BAIRRO
		OWS:oWSAEMPRESA:cCCAPITAL       := If(!Empty(HTTPPOST->CAPITAL), HTTPPOST->CAPITAL, If(!Empty(HTTPSESSION->CAPITAL), HTTPSESSION->CAPITAL, '0'))
		OWS:oWSAEMPRESA:cCCEP           := HTTPPOST->CEP
		OWS:oWSAEMPRESA:cCCGC           := U_LIMPACGC(CCGC)
		OWS:oWSAEMPRESA:cCCODIGO        := IIF (HTTPSESSION->AEMPRESA <> NIL, HTTPSESSION->AEMPRESA:cCCODIGO, '')
		OWS:oWSAEMPRESA:cCCONTATO       := HTTPPOST->CONTATO
		OWS:oWSAEMPRESA:cCEMAIL         := HTTPPOST->EMAIL
		OWS:oWSAEMPRESA:cCEND           := HTTPPOST->CEND
		OWS:oWSAEMPRESA:cCFAX           := HTTPPOST->FAX
		OWS:oWSAEMPRESA:cCFILIAL        := IIF (HTTPSESSION->AEMPRESA <> NIL, HTTPSESSION->AEMPRESA:cCFILIAL, '')
		OWS:oWSAEMPRESA:cCLOJA          := IIF (HTTPSESSION->AEMPRESA <> NIL, HTTPSESSION->AEMPRESA:cCLOJA, '01')
		OWS:oWSAEMPRESA:cCMUN           := HTTPPOST->MUN
		OWS:oWSAEMPRESA:cCNOME          := HTTPPOST->RAZAO
		OWS:oWSAEMPRESA:cCTEL           := HTTPPOST->FONE
		OWS:oWSAEMPRESA:cCUF            := HTTPPOST->EST        
		OWS:oWSAEMPRESA:dDINIATV        := CTOD(HTTPPOST->INIATV)   
		OWS:oWSAEMPRESA:CERSIN	        := HTTPSESSION->ERSIN   
		OWS:oWSAEMPRESA:CCBASE        	:= HTTPSESSION->BASE   
		OWS:oWSAEMPRESA:CCBASE2        	:= HTTPSESSION->BASE2
		OWS:oWSAEMPRESA:CNLEITOS       	:= HTTPPOST->NLEITOS
		OWS:oWSAEMPRESA:CNNUMFUN       	:= HTTPPOST->NNUMFUN
	
	ENDIF
	
	OWS:cCROTINA := HTTPSESSION->ROTINA
	
	//WSMETHOD CADEMPRESA WSRECEIVE AEMPRESA,CROTINA WSSEND LRETURN 
	
	IF OWS:CADEMPRESA()   
	        
		IF OWS:lCADEMPRESARESULT // ALTERACAO OU INCLUSAO COM SUCESSO 
		
			IF OWS:VERCADEMP()   
	        
				IF !EMPTY(OWS:oWSVERCADEMPRESULT:CCCGC)//ACHOU A EMPRESA
				    /* DADOS DA EMPRESA */
					HTTPSESSION->AEMPRESA := OWS:oWSVERCADEMPRESULT
					IF EMPTY(OWS:oWSVERCADEMPRESULT:CCODESCR) // NAO TEM VINCULO COM ESCRITORIO CONTABIL
						HTTPPOST->MSGATUA := "Dados Enviados Com Sucesso. <br> Deseja Vincular um Escritório Contábil?"
					ELSE // JA TEM VINCULO COM O ESCRITORIO CONTABIL
						HTTPPOST->MSGATUA := "Dados Enviados Com Sucesso"
					ENDIF   
					HTTPSESSION->AEMPAUX := NIL
					HTTPSESSION->EXIBEAUX:= 0
					HTTPSESSION->ROTINA  := NIL
					cHtml := ExecInPage("INTROEMP")				
				ELSE // NAO ACHOU
					HTTPSESSION->AEMPRESA := NIL					
				ENDIF  
				
			ELSE // ERRO
				HTTPSESSION->AEMPRESA := NIL
				HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
				CHTML := EXECINPAGE("ERRO")
				CONOUT(GetWSCError())		
			ENDIF 
	
	   ELSE // NAO ALTEROU OU INCLUIU
			HTTPPOST->CGC := HTTPPOST->CGC   
			HTTPSESSION->AEMPRESA := NIL		
			HTTPPOST->MSGATUA := "Problema no Envio dos Dados"
			cHtml := ExecInPage("EMPRESA")   
	   ENDIF 
	ELSE
		HTTPSESSION->AEMPRESA := NIL
	
		If  Empty(GetWSCError(3))
			HTTPPOST->ERRO := "Problema de Comunicação com o Servidor! Favor tentar novamente ou entrar em contato com FEHOESP."
		Else
			HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
		EndIf
					
		cHtml := ExecInPage("ERRO")
		CONOUT(GetWSCError())
	ENDIF	
     
	Exit
EndDo

Web Extended End

Return cHtml  
                    

/*
ÜÜÜÜ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SOLICALT ºAutor  ³GISELE NUNCHERINO   º Data ³  02/06/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ SOLICITACAO DE ALTERACAO PARA ASSOCIADOS	                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function SOLICALT()

Local cHtml 	:= ""
LOCAL OWS		:= WSSINDHOSP():NEW()
LOCAL CCGC 		:= HTTPGET->CGC

Web Extended Init cHtml 

IF U_LIMPACGC(CCGC) == NIL
	HTTPPOST->ERRO := "CNPJ em branco/invalido"
	cHtml := ExecInPage("ERRO")	        
ELSE                  

OWS:cCCGC 		:= U_LIMPACGC(CCGC)
OWS:oWSAEMPRESA := WSCLASSNEW("SINDHOSP_SEMPRESA")                           

HTTPSESSION->CGC		    	:= CCGC

cHtml := ExecInPage("SOLICALT")

ENDIF

Web Extended End

Return cHtml  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SOLICMAIL ºAutor  ³Antonio C Ferreira  º Data ³  20/12/2010 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ENVIA A PAGINA DE SOLICITACAO DE ASSOCIACAO POR E-MAIL     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function SOLICMAIL()

Local cHtml 		:= ''
LOCAL cEMailFrom 	:= ''
LOCAL cEMailTo		:= ''
LOCAL cTitulo		:= ''
LOCAL cCorpo		:= ''
LOCAL cAnexo		:= ''
LOCAL cRetEnv		:= ''

LOCAL oWS		:= WSCFGDICTIONARY():NEW()  

HttpPost->lOk   := .F.

WSChgUrl( @OWS, "CFGDICTIONARY.APW" )

cEMailFrom := If(!(oWS:GETPARAM("MSALPHA","MV_PMAILCD")) .Or. (ValType(oWS:cGETPARAMRESULT)!="C") .Or. Empty(oWS:cGETPARAMRESULT) .Or. (oWS:cGETPARAMRESULT=='.F.'), "arrecadacao@fehoesp.org.br", Alltrim(oWS:cGETPARAMRESULT))
cEMailTo   := cEMailFrom

Web Extended Init cHtml 
   
    cTitulo 	:= 'Solicitação Alteração Cadastral' + If(!Empty(HttpPost->DADOSEC), ' - Empresa Contabil ','')
    
    //CEMAILTO	:= GETMV("MV_PMAILCA")
    //cEMailTo	:= HTTPPOST->CEMAIL 
               
	HttpSetPart(.F.)		                   
   cCorpo		:= EXECINPAGE("SOLICALMAIL")
	cCorpo 		:= UpStrtran(cCorpo,chr(13)+chr(10)+chr(13)+chr(10),"")
	HttpSetPart(.T.)
	    
  
    CRETENV := u_ENVMAIL(cEmailFrom, cEMailTo, cTitulo, cCorpo, cAnexo )
    
    If EMPTY(CRETENV)
		HTTPPOST->MENSAGEM := "E-mail enviado com Sucesso!<br><br><br>"
		HTTPPOST->MENSAGEM += "Sua solicitação foi enviada para análise do departamento de Cadastro!<br>"
		HTTPPOST->MENSAGEM += "O prazo para alteração no sistema é de aproximadamente 24 horas!<br><br>"
		HTTPPOST->MENSAGEM += "Qualquer dúvida entrar em contato no telefone (11) 3221-9333<br>"
		HTTPPOST->MENSAGEM += "ou pelo e-mail: arrecadacao@fehoesp.org.br.<br>"
		HttpPost->lOk   := .T.
	Else
		HTTPPOST->MENSAGEM	:= "Problema no envio de e-mail entre em contato no Telefone (11) 3221-9333:<br><br>"
		HTTPPOST->MENSAGEM  += CRETENV
	EndIf
	
	cHtml := ExecInPage("SOLICMENSAG")
                                      
Web Extended End


Return cHtml 
**** fim ***
                    
 
/*
ÜÜÜÜ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SOLICCONF ºAutor  ³GISELE NUNCHERINO   º Data ³  02/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CONFIRMA SOLICITACAO DE ALTERACAO PARA ASSOCIADOS          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function SOLICCONF()

Local cHtml 	:= ""

Web Extended Init cHtml           

	W_ATUAEMP()

Web Extended End

Return cHtml  


/*
ÜÜÜÜ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EmpCEP ºAutor  ³GISELE NUNCHERINO   º Data ³   08/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ GATILHO PARA O CEP								          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function EmpCep()

Local cHtml 	:= ""
LOCAL OWS		:= WSSINDHOSP():NEW() //EMPRESA

HTTPSESSION->AUXEXIBE := IIF (HTTPSESSION->EXIBEAUX <> nil .and. (HTTPSESSION->EXIBEAUX) > 0, 3,0)
HTTPSESSION->EXIBEAUX := 0

HTTPSESSION->RAZAO 		:= HTTPPOST->RAZAO
HTTPSESSION->EMAIL		:= HTTPPOST->EMAIL
HTTPSESSION->TEL		:= HTTPPOST->TEL
HTTPSESSION->FAX		:= HTTPPOST->FAX
HTTPSESSION->CAPITAL	:= HTTPPOST->CAPITAL
HTTPSESSION->INIATV		:= HTTPPOST->INIATV
HTTPSESSION->CONTATO	:= HTTPPOST->CONTATO
HTTPSESSION->CGC		:= HTTPPOST->CGC
    
Web Extended Init cHtml           

Do  While .T.

	If  (HTTPPOST->CEP <> NIL) .And. !( Empty(HTTPPOST->CEP) )

		If  U_LIMPACGC(HTTPPOST->CEP) == NIL
			 HTTPPOST->ERRO := "CEP em branco/invalido"
			 cHtml := ExecInPage("ERRO")	        
			 Exit
		EndIf
		
		OWS:CCEP := U_LIMPACGC(HTTPPOST->CEP)
		
		If  OWS:BUSCACEP() // ACHOU O CEP
		    HTTPPOST->CEND 		:= OWS:oWSBUSCACEPRESULT:CENDERECO
			 HTTPPOST->BAIRRO 	:= OWS:oWSBUSCACEPRESULT:CBAIRRO
			 HTTPPOST->MUN 		:= OWS:oWSBUSCACEPRESULT:CMUN
			 HTTPPOST->EST 		:= OWS:oWSBUSCACEPRESULT:CEST
			 HTTPPOST->CEP			:= OWS:oWSBUSCACEPRESULT:CCEP
		    HTTPSESSION->ERSIN	:= OWS:oWSBUSCACEPRESULT:CERSIN
		    HTTPSESSION->BASE	:= OWS:oWSBUSCACEPRESULT:CBASE
		    HTTPSESSION->BASE2	:= OWS:oWSBUSCACEPRESULT:CBASE2
		    HTTPSESSION->SINDCEP:= OWS:oWSBUSCACEPRESULT:CSINDICATO
		Else
		    CONOUT(GETWSCERROR())
		    HTTPPOST->CEND 		:= ''
			 HTTPPOST->BAIRRO 	:= ''
			 HTTPPOST->MUN 		:= ''
			 HTTPPOST->EST 		:= ''
			 HTTPPOST->CEP			:= ''
		    HTTPSESSION->ERSIN	:= ''
		    HTTPSESSION->BASE	:= ''
		    HTTPSESSION->BASE2	:= ''
		    HTTPSESSION->SINDCEP:= ''
		EndIf                            

		HTTPPOST->RAZAO 	:= HTTPSESSION->RAZAO
	   HTTPPOST->EMAIL	:= HTTPSESSION->EMAIL
	   HTTPPOST->TEL		:= HTTPSESSION->TEL
	   HTTPPOST->FAX		:= HTTPSESSION->FAX
	   HTTPPOST->CAPITAL	:= HTTPSESSION->CAPITAL
	   HTTPPOST->INIATV	:= HTTPSESSION->INIATV
	   HTTPPOST->CONTATO	:= HTTPSESSION->CONTATO
	   HTTPPOST->CGC		:= HTTPSESSION->CGC
	   HTTPPOST->CGC2		:= HTTPSESSION->CGC

	EndIf
                       
	If (HTTPSESSION->AEMPAUX <> NIL) 
		HTTPPOST->RAZAO2	:= ALLTRIM(HTTPSESSION->AEMPAUX:CCNOME)
		HTTPPOST->CEP2		:= ALLTRIM(HTTPSESSION->AEMPAUX:CCCEP)
		HTTPPOST->CEND2		:= ALLTRIM(HTTPSESSION->AEMPAUX:CCEND)
		HTTPPOST->BAIRRO2	:= ALLTRIM(HTTPSESSION->AEMPAUX:CCBAIRRO)
		HTTPPOST->MUN2		:= ALLTRIM(HTTPSESSION->AEMPAUX:CCMUN)
		HTTPPOST->EST2		:= ALLTRIM(HTTPSESSION->AEMPAUX:CCUF)
		HTTPPOST->EMAIL2	:= ALLTRIM(HTTPSESSION->AEMPAUX:CCEMAIL)
		HTTPPOST->TEL2		:= ALLTRIM(HTTPSESSION->AEMPAUX:CCTEL)
		HTTPPOST->FAX2		:= ALLTRIM(HTTPSESSION->AEMPAUX:CCFAX)
		HTTPPOST->CAPITAL2	:= ALLTRIM(HTTPSESSION->AEMPAUX:CCCAPITAL)
		HTTPPOST->INIATV2	:= HTTPSESSION->AEMPAUX:DDINIATV
		HTTPPOST->CONTATO2	:= ALLTRIM(HTTPSESSION->AEMPAUX:CCCONTATO)
	EndIf

	If  (HTTPSESSION->SINDCEP == '01')
	
   	    HTTPPOST->ERRO := "Favor entrar em contato com o departamento de cadastro do SindHosp:<br>telefone (11) 3331-1555 na opção 7 ou <BR> e-mail: cadastro@sindhosp.com.br"

		HttpPost->XRedir := 'W_EMPRESA.APW'
			   
	   cHtml := ExecInPage("ERRO")
	   
	   Exit
	EndIf   

	cHtml := ExecInPage("EMPRESA")

   Exit
EndDo   

Web Extended End

Return cHtml  


/*
ÜÜÜÜ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³buscaesc ºAutor  ³GISELE NUNCHERINO   º Data ³   08/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ 													          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function BUSCAESC()

Local cHtml 	:= ""
LOCAL OWS		:= WSSINDHOSP():NEW() //EMPRESA E ESCRITORIO

Web Extended Init cHtml

IF EMPTY(HTTPSESSION->AEMPRESA:cCODESCR)
	HTTPSESSION->AESCRITO := NIL
	cHtml := ExecInPage("INTROESCR")  	
ELSE
                           
	OWS:CCODESCR := HTTPSESSION->AEMPRESA:cCODESCR
		
	HTTPPOST->lVinculo := .F.
	              
	IF OWS:BUSCAESC()    
		IF !EMPTY(OWS:OWSBUSCAESCRESULT:CCCGC)//ACHOU O ESCRITORIO
	    	HTTPPOST->CGC := OWS:OWSBUSCAESCRESULT:CCCGC     
	    	HTTPPOST->CEP := ''     
	    	
	    	HTTPPOST->lVinculo := .T.
	    	
	    	W_FUNCESC()
	    ELSE
			cHtml := ExecInPage("EMPRESA")    
	    ENDIF                 
	ENDIF

ENDIF

Web Extended End

Return cHtml  
