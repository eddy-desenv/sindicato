
#INCLUDE "PROTHEUS.CH"
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EXTRATO   ºAutor  ³GISELE NUNCHERINO   º Data ³  04/23/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE EXTRATOS					              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function EXTRATO()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPPOST->MSGATUA := NIL
	cHtml := ExecInPage("SINDEXTR")
                                      
Web Extended End


Return cHtml  

  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GERAEXTR   ºAutor  ³GISELE NUNCHERINO   º Data ³  04/23/10  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ GERA OS EXTRATOS E CHAMA A PAGINA DE EXIBICAO DE EXTRATOS  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function GERAEXTR()

Local cMensagem, cSituacao

Local lErro := .F.

Local cHtml 			:= ''
LOCAL NX				:= 0
LOCAL WSEXT 			:= WSSHEXTRATO():NEW()
LOCAL WSEMP				:= WSSINDHOSP():NEW()   
LOCAL SINDPGO			:= {}
LOCAL CONFPGO			:= {}
LOCAL ASSOPGO			:= {}
LOCAL SINDABT			:= {}
LOCAL CONFABT			:= {}
LOCAL ASSOABT			:= {} 

Local cANO_SIND			:= Right(Alltrim(Str(Year(Date())-4)),2)
              

HttpSession->XRaizURL  := HttpPost->VerURL 


Web Extended Init cHtml //Start "w_UserIsOn"

IF U_LIMPACGC(HTTPPOST->CGC) == NIL
	HTTPPOST->ERRO := "CNPJ em branco/invalido"
	cHtml := ExecInPage("ERRO")	        
ELSE
 
WSEMP:CCCGC := U_LIMPACGC(HTTPPOST->CGC)

HTTPSESSION->CGC := HTTPPOST->CGC

HTTPPOST->SINDABT := {}
HTTPPOST->CONFABT := {}
HTTPPOST->ASSOABT := {}
HTTPPOST->SINDPGO := {}
HTTPPOST->CONFPGO := {}
HTTPPOST->ASSOPGO := {}

Do  While .T.

	If  !( WSEMP:VERCADEMP() )   //ACHOU A EMPRESA
		HTTPPOST->ERRO := GetWSCError()
		cHtml := ExecInPage("ERRO")
		CONOUT(GetWSCError())
		Exit
	EndIf
		
	If  Empty(WSEMP:oWSVERCADEMPRESULT:cCCODIGO) 
		HTTPPOST->MSGATUA := "CNPJ Não Encontrado! Deseja Se Cadastrar?"
		cHtml := ExecInPage("SINDEXTR")
		Exit
	EndIf
		
	HTTPSESSION->AEMPRESA := WSEMP:oWSVERCADEMPRESULT:Clone() 
	
  	If  !( (HTTPSESSION->AEMPRESA:DDDTNASC == DATE() .And. Alltrim(HTTPSESSION->AEMPRESA:CCINAT) == "X") .Or.;
  	       (Alltrim(HTTPSESSION->AEMPRESA:CCINAT) != "X") )
		HTTPPOST->ERRO := "Cliente c/ problemas no cadastro!<br>Favor entrar em contato com o departamento de cadastro do FEHOESP:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br"
		cHtml := ExecInPage("ERRO")
		Exit
	EndIf

    WSEXT:oWSAEMPRESA:cCCGC 	:= HTTPPOST->CGC
    WSEXT:oWSAEMPRESA:cCCODIGO 	:= WSEMP:oWSVERCADEMPRESULT:cCCODIGO
    WSEXT:oWSAEMPRESA:cCFILANTR := WSEMP:oWSVERCADEMPRESULT:cCFILANTR
    WSEXT:oWSAEMPRESA:cCFILIAL 	:= WSEMP:oWSVERCADEMPRESULT:cCFILIAL
    WSEXT:oWSAEMPRESA:cCFOLCENT := WSEMP:oWSVERCADEMPRESULT:cCFOLCENT
    WSEXT:oWSAEMPRESA:cCLOJA 	:= WSEMP:oWSVERCADEMPRESULT:cCLOJA
    WSEXT:oWSAEMPRESA:dDINIATV 	:= WSEMP:oWSVERCADEMPRESULT:dDINIATV
    WSEXT:oWSAEMPRESA:dDDTNASC 	:= WSEMP:oWSVERCADEMPRESULT:dDDTNASC
    WSEXT:oWSAEMPRESA:nNCATEGOR := VAL(WSEMP:oWSVERCADEMPRESULT:CNCATEGOR)
    WSEXT:oWSAEMPRESA:CCNATUREZ := WSEMP:oWSVERCADEMPRESULT:CCNATUREZ
    
    WSEXT:lLSIND 		:= .T. //IIF((HTTPPOST->CHKSIND <> NIL)      ,.T.,.F.)
    WSEXT:lLCONFNEG 	:= .T. //IIF((HTTPPOST->CHKCONFASSIST <> NIL),.T.,.F.)
    WSEXT:lLASSOC 		:= .T. //IIF((HTTPPOST->CHKASSOC <> NIL) 																			,.T.,.F.) 
    
    HTTPSESSION->SIND 		:= IIF(WSEXT:lLSIND		,1,2)
    HTTPSESSION->CONFNEG 	:= IIF(WSEXT:lLCONFNEG	,1,2)
    HTTPSESSION->ASSOC 		:= IIF(WSEXT:lLASSOC	,1,2)
    

    //---------------------------------------------------------------------------------
    // Dados Cadastrais da Empresa e Contabil
    //---------------------------------------------------------------------------------
    HTTPPOST->CGC	  	:= ALLTRIM(WSEMP:OWSVERCADEMPRESULT:CCCGC)
    HTTPPOST->RAZAO		:= ALLTRIM(WSEMP:OWSVERCADEMPRESULT:CCNOME)
    HTTPPOST->CEP		:= ALLTRIM(WSEMP:OWSVERCADEMPRESULT:CCCEP)
    HTTPPOST->CEND		:= ALLTRIM(WSEMP:oWSVERCADEMPRESULT:CCEND)
    HTTPPOST->BAIRRO	:= ALLTRIM(WSEMP:oWSVERCADEMPRESULT:CCBAIRRO)
    HTTPPOST->MUN		:= ALLTRIM(WSEMP:oWSVERCADEMPRESULT:CCMUN)
    HTTPPOST->EST		:= ALLTRIM(WSEMP:oWSVERCADEMPRESULT:CCUF)
    HTTPPOST->EMAIL		:= ALLTRIM(WSEMP:oWSVERCADEMPRESULT:CCEMAIL)
    HTTPPOST->TEL		:= ALLTRIM(WSEMP:oWSVERCADEMPRESULT:CCTEL)
    HTTPPOST->FAX		:= ALLTRIM(WSEMP:oWSVERCADEMPRESULT:CCFAX)
    HTTPPOST->CAPITAL	:= ALLTRIM(transform(VAL(ALLTRIM(WSEMP:oWSVERCADEMPRESULT:CCCAPITAL)), '@E 999,999,999,999.99')) 
    HTTPPOST->INIATV	:= WSEMP:oWSVERCADEMPRESULT:DDINIATV
    HTTPPOST->CONTATO	:= ALLTRIM(WSEMP:oWSVERCADEMPRESULT:CCCONTATO)
    
    cSituacao := WSEMP:oWSVERCADEMPRESULT:CCSITUAC
	 
	If  !( Empty(WSEMP:oWSVERCADEMPRESULT:CCODESCR) )
	
        WSEMP:CCCGC := WSEMP:oWSVERCADEMPRESULT:CCODESCR
 	
 		If WSEMP:VERCADESC()
 	
			HTTPPOST->CEI		:= WSEMP:oWSVERCADESCRESULT:cCCGC
			HTTPPOST->ESCRAZ	:= WSEMP:oWSVERCADESCRESULT:CCNOME
			HTTPPOST->ESCCEP	:= WSEMP:oWSVERCADESCRESULT:CCCEP
			HTTPPOST->ESCEND	:= WSEMP:oWSVERCADESCRESULT:CCEND
			HTTPPOST->ESCBAIR	:= WSEMP:oWSVERCADESCRESULT:CCBAIRRO
			HTTPPOST->ESCMUN	:= WSEMP:oWSVERCADESCRESULT:CCMUN	
			HTTPPOST->ESCUF		:= WSEMP:oWSVERCADESCRESULT:CCUF	
			HTTPPOST->ESCMAIL	:= WSEMP:oWSVERCADESCRESULT:CCEMAIL
			HTTPPOST->ESCTEL	:= WSEMP:oWSVERCADESCRESULT:CCTEL	
			HTTPPOST->ESCFAX	:= WSEMP:oWSVERCADESCRESULT:CCFAX	
			HTTPPOST->ESCCONT	:= WSEMP:oWSVERCADESCRESULT:CCCONTATO	
			
		    HTTPPOST->ESCCGC	:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCCGC)
		    HTTPPOST->ESCRAZAO	:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCNOME)
		    HTTPPOST->ESCCEP	:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCCEP)
		    HTTPPOST->ESCEND	:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCEND)
		    HTTPPOST->ESCBAIRRO	:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCBAIRRO)
		    HTTPPOST->ESCMUN	:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCMUN)
		    HTTPPOST->EST		:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCUF)
		    HTTPPOST->ESCEMAIL	:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCEMAIL)
		    HTTPPOST->ESCTEL	:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCTEL)
		    HTTPPOST->ESCFAX	:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCFAX)
		    HTTPPOST->ESCCONTATO:= ALLTRIM(WSEMP:oWSVERCADESCRESULT:CCCONTATO)		

 		EndIf
 	EndIf

    /****************************************************************************/
    /*							T I T U L O S   P A G O S 						*/
    /****************************************************************************/

    Do  While .T.
    
	    If  !( WSEXT:LSTPAG() )
			cHtml := ExecInPage("SINDEXTR")	        
	        CONOUT(GetWSCError())
	        lErro := .T.
	        Exit
	    EndIf   
	    
        /*
            WSEXT:oWSLSTABTRESULT:oWSSTITPAG:xxxx
		*/  
		IF LEN(WSEXT:OWSLSTPAGRESULT:oWSSTITPAG) > 0
			FOR NX := 1 TO LEN(WSEXT:oWSLSTPAGRESULT:OWSSTITPAG)
				IF  (WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '003') .And. (Left(WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCANO,2) >= cANO_SIND) //SINDICAL
					AADD(SINDPGO,WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx])
				ENDIF
				IF WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '002' .OR. WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '0301' //CONFEDERATIVA
					AADD(CONFPGO,WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx])					
				ENDIF
				IF WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '001' .OR. WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '1000' //ASSOCIATIVA
					AADD(ASSOPGO,WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx])					
				ENDIF
			NEXT NX   

			HTTPPOST->SINDPGO := Asort(SINDPGO,,,{|x,y| x:CCANO > y:CCANO})
			HTTPPOST->CONFPGO := Asort(CONFPGO,,,{|x,y| x:CCANO+x:CCPARCELA > y:CCANO+y:CCPARCELA})
			HTTPPOST->ASSOPGO := Asort(ASSOPGO,,,{|x,y| x:CCANO+x:CCMES > y:CCANO+y:CCMES})
                                  
			IF LEN(SINDPGO)<=0
				HTTPPOST->MSINDPGO	:= "Não Existem Títulos Pagos"				
			ELSE
			    HTTPPOST->MSINDPGO	:= ''	
			ENDIF

			IF LEN(CONFPGO)<=0
				HTTPPOST->MCONFPGO	:= "Não Existem Títulos Pagos"				
			ELSE
			    HTTPPOST->MCONFPGO	:= ''	
			ENDIF

			IF  (cSituacao <> 'SS') .And. (cSituacao <> "AS")
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa não é associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br"
			ELSE
			
				IF LEN(ASSOPGO)<=0
					HTTPPOST->MASSOPGO	:= "Não Existem Títulos Pagos"				
				ELSE
				    HTTPPOST->MASSOPGO	:= ''	
				ENDIF
			ENDIF								
		ELSE
			HTTPPOST->MSINDPGO	:= "Não Existem Títulos Pagos"
			HTTPPOST->MCONFPGO	:= "Não Existem Títulos Pagos"   
			
			IF  (cSituacao <> 'SS') .And. (cSituacao <> "AS")
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa não é associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br"
			ELSE				
				HTTPPOST->MASSOPGO	:= "Não Existem Títulos Pagos"
			ENDIF
		ENDIF
		
		Exit
	EndDo
					
        CONOUT('INICIO')
    /****************************************************************************/
    /*						T I T U L O S   E M   A B E R T O					*/
    /****************************************************************************/	
    //LSTABT WSRECEIVE AEMPRESA, LSIND, LCONFNEG, LASSOC, CCONFNEG

    WSEXT:CCCONFNEG := ''

	WSEXT:oWSAEMPRESA := HTTPSESSION->AEMPRESA:Clone()	    

	Do  While .T.
	
    	If  !( WSEXT:LSTABT() )
			cHtml := ExecInPage("SINDEXTR")	        
        	CONOUT(GetWSCError())
        	lErro := .T.
			Exit
		EndIf
			
		IF LEN(WSEXT:oWSLSTABTRESULT:OWSSTITABT) > 0           
		           
			FOR NX := 1 TO LEN(WSEXT:oWSLSTABTRESULT:oWSSTITABT)	
				IF  (WSEXT:oWSLSTABTRESULT:OWSSTITABT[NX]:CCNAT == '003') .And. (Left(WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCANO,2) >= cANO_SIND) //SINDICAL
					AADD(SINDABT,WSEXT:oWSLSTABTRESULT:OWSSTITABT[NX])
				ENDIF
				IF WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '002' .OR. WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '0301' //CONFEDERATIVA
					AADD(CONFABT,WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX])					
				ENDIF
				IF WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '001' .OR. WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '1000' //ASSOCIATIVA
					AADD(ASSOABT,WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX])					
				ENDIF
			NEXT NX

			HTTPPOST->SINDABT := Asort(SINDABT,,,{|x,y| x:CCANO > y:CCANO})
			HTTPPOST->CONFABT := Asort(CONFABT,,,{|x,y| x:CCANO+x:CCPARCELA > y:CCANO+y:CCPARCELA})
			HTTPPOST->ASSOABT := Asort(ASSOABT,,,{|x,y| x:CCANO+x:CCMES > y:CCANO+y:CCMES})
			IF  (LEN(SINDABT) <= 0)
			    If  (HTTPSESSION->AEMPRESA:cCCAPCENT == 'S')
					HTTPPOST->MSINDABT	:= "Capital Social centralizado!<br> Esta contribuição não é devida para este CNPJ!"			
				Else
					HTTPPOST->MSINDABT	:= "Não Existem Títulos em Aberto"
				EndIf	
			ELSE
			    HTTPPOST->MSINDABT	:= ''	
			ENDIF

			IF LEN(CONFABT)<=0
			    If  (HTTPSESSION->AEMPRESA:cCFOLCENT == 'S')
					HTTPPOST->MCONFABT	:= "Folha de Pagamento centralizada!<br> Esta contribuição não é devida para este CNPJ!"			
				Else
					HTTPPOST->MCONFABT	:= "Não Existem Títulos em Aberto"
				EndIf				
			ELSE
			    HTTPPOST->MCONFABT	:= ''	
			ENDIF

            IF  (cSituacao <> 'SS') .And. (cSituacao <> "AS")
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa não é associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br"
			ELSE
			
				IF LEN(ASSOABT)<=0
					HTTPPOST->MASSOABT	:= "Não Existem Títulos em Aberto"
				ELSE
				    HTTPPOST->MASSOABT	:= ''	
				ENDIF				
					
	        ENDIF
		ELSE
			HTTPPOST->MSINDABT	:= "Não Existem Títulos em Aberto"
			HTTPPOST->MCONFABT	:= "Não Existem Títulos em Aberto"
//			HTTPPOST->ASSOABT	:= NIL
			IF  (cSituacao <> 'SS') .And. (cSituacao <> "AS")
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa não é associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br"
			ELSE
				HTTPPOST->MASSOABT	:= "Não Existem Títulos em Aberto"
			ENDIF
		ENDIF
		
		Exit			
    EndDo
      
    If  !( lErro )
    	HttpPost->LogoFaixa := "header_extrato_boletos-todos.gif"
    	
		cHtml := ExecInPage("SHCABEMP") 
		cHtml += ExecInPage("SHCABESC")								
		cHtml += ExecInPage("SINDLISTEXT")
	EndIf	
	
	Exit
EndDo

ENDIF
                 
Web Extended End

Return cHtml 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BOLSIND    ºAutor  ³GISELE NUNCHERINO   º Data ³  16/06/10  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE CALCULO DO BOLETO DA SINDICAL            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function BOLSIND()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPPOST->TPBOLETO := '1'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BOLCONF    ºAutor  ³GISELE NUNCHERINO   º Data ³  16/06/10  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE CALCULO DO BOLETO DA CONFEDERATIVA       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function BOLCONF()

Local cHtml := ""

Web Extended Init cHtml   
	
	HTTPPOST->TPBOLETO := '2'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BOLASSOC   ºAutor  ³GISELE NUNCHERINO   º Data ³  16/06/10  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE CALCULO DO BOLETO DA ASSOCIATIVA         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function BOLASSOC()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPPOST->TPBOLETO := '3'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BOLASSCONF ºAutor  ³GISELE NUNCHERINO   º Data ³  16/06/10  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE CALCULO DO BOLETO DA ASSOCIATIVA         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function BOLASSCONF()

Local cHtml := ""

Web Extended Init cHtml 

	HTTPPOST->TPBOLETO := '4'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BOLNEG	 ºAutor  ³GISELE NUNCHERINO   º Data ³  16/06/10  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE CALCULO DO BOLETO DA ASSISTENCIAL/NEGOCIAL±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function BOLNEG()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPPOST->TPBOLETO := '5'
	W_CALCBOL()
	                                      
Web Extended End


Return cHtml 