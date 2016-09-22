#INCLUDE "PROTHEUS.CH"
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"




USER Function IEPAS()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPPOST->MSGATUA := NIL
	cHtml := ExecInPage("IEPAS")
                                      
Web Extended End


Return cHtml  

USER FUNCTION IEPAS2()
cMensagem :=""

lErro := .F.

cHtml 			:= ''
NX				:= 0
WSEXT 			:= WSSHEXTRATO():NEW()
WSEMP			:= WSSINDHOSP():NEW()   
SINDPGO			:= {}
CONFPGO			:= {}                                                                                          
ASSOPGO			:= {}
SINDABT			:= {}
CONFABT			:= {}
ASSOABT			:= {} 

cANO_SIND			:= Right(Alltrim(Str(Year(Date())-4)),2)
c_anoconf2          := Right(Alltrim(Str((Year(Date())))),2)                 
c_anoconf1          := Right(Alltrim(Str((Year(Date())-2))),2)   
HttpSession->XRaizURL  := HttpPost->VerURL 


Web Extended Init cHtml //Start "w_UserIsOn"

 
WSEMP:CCCGC :=U_LIMPACGC(HTTPPOST->CGC)

HTTPSESSION->CGC := U_LIMPACGC(HTTPPOST->CGC)

HTTPPOST->SINDABT := {}
HTTPPOST->CONFABT := {}
HTTPPOST->ASSOABT := {}
HTTPPOST->SINDPGO := {}
HTTPPOST->CONFPGO := {}
HTTPPOST->ASSOPGO := {}
xretorno := 0
Do  While .T.

	If  !( WSEMP:VERCADEMP() )   //ACHOU A EMPRESA
		HTTPPOST->ERRO := GetWSCError()
		cHtml := ExecInPage("ERRO")
		CONOUT(GetWSCError())
		Exit
	EndIf
 		
	If  Empty(WSEMP:oWSVERCADEMPRESULT:cCCODIGO)        
		xretnorno := 0
		httppost->erro := xretorno	
					
		cHtml := ExecInPage("ERRO")

//		HTTPPOST->MSGATUA := "CNPJ Não Encontrado! Deseja Se Cadastrar?"
//		cHtml := ExecInPage("SINDEXTR")
		Exit
	EndIf
		
	HTTPSESSION->AEMPRESA := WSEMP:oWSVERCADEMPRESULT:Clone() 
/*	
  	If  !( (HTTPSESSION->AEMPRESA:DDDTNASC == DATE() .And. Alltrim(HTTPSESSION->AEMPRESA:CCINAT) == "X") .Or.;
  	       (Alltrim(HTTPSESSION->AEMPRESA:CCINAT) != "X") )
		HTTPPOST->ERRO := "Cliente inativo - Favor entrar em contato com o departamento de Cadastro, através do telefone (11) 3331-1555 na opção 7 ou <BR> e-mail: cadastro@sindhosp.com.br"

			If  (HTTPSESSION->AEMPRESA:CCSINDICA == '02')
		       HTTPPOST->ERRO := "Cliente inativo - Essa empresa pertence ao SINDHOSPRU.<br>Favor entrar em contato com o departamento de arrecadação:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br<br>ou acesse o site: www.sindprudente.org.br"
			ElseIf  (HTTPSESSION->AEMPRESA:CCSINDICA == '03')
		   	 HTTPPOST->ERRO := "Cliente inativo - Essa empresa pertence ao SINDHORP.<br>Favor entrar em contato com o departamento de arrecadação:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br<br>ou acesse o site: www.sindribeiraopreto.org.br"
		 	ElseIf  (HTTPSESSION->AEMPRESA:CCSINDICA == '04') 
		   	 HTTPPOST->ERRO := "Cliente inativo - Essa empresa pertence ao SINDHOSCLAB-MOGI.<br>Favor entrar em contato com o departamento de arrecadação:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br<br>ou acesse o site: www.sindmogidascruzes.org.br"
		   ElseIf  (HTTPSESSION->AEMPRESA:CCSINDICA == '05') 
		   	 HTTPPOST->ERRO := "Cliente inativo - Essa empresa pertence ao SINDHOSCLAB-JUNDIAI.<br>Favor entrar em contato com o departamento de arrecadação:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br<br>ou acesse o site: www.sindjundiai.org.br"
		   ElseIf  (HTTPSESSION->AEMPRESA:CCSINDICA == '06') 
		   	 HTTPPOST->ERRO := "Cliente inativo - Essa empresa pertence ao SINDHOSCLAB-SUZANO.<br>Favor entrar em contato com o departamento de arrecadação:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br<br>ou acesse o site: www.sindsuzano.org.br"
		   EndIf 
			
		cHtml := ExecInPage("ERRO")
		Exit
	EndIf
*/
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
    
    //WSEXT:lLSIND 		:= IIF((HTTPPOST->CHKSIND <> NIL) .And. (WSEMP:oWSVERCADEMPRESULT:cCSINDICA == '01') 		,.T.,.F.)
  //  WSEXT:lLCONFNEG 	:= IIF((HTTPPOST->CHKCONFASSIST <> NIL) .And. (WSEMP:oWSVERCADEMPRESULT:cCSINDICA == '01'),.T.,.F.)
//    WSEXT:lLASSOC 	:= IIF((HTTPPOST->CHKASSOC <> NIL) 																			,.T.,.F.) 
    WSEXT:lLSIND 		:= .T.
    WSEXT:lLCONFNEG 	:= .T.
    WSEXT:lLASSOC 	:= .T.
    
    HTTPSESSION->SIND 		:= IIF(WSEXT:lLSIND		,1,2)
    HTTPSESSION->CONFNEG 	:= IIF(WSEXT:lLCONFNEG	,1,2)
    HTTPSESSION->ASSOC 		:= IIF(WSEXT:lLASSOC		,1,2)
    

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
		xNUMTITCONF := 0
		XNUMTITASSO := 0	    
		xNUMCONFabt := 0
		XNUMASSOabt := 0	    
		conout("CANOCONF1"+C_ANOCONF1)
		conout("CANOCONF2"+C_ANOCONF2) 
		conout("TAMANHO ARRAY TIT PAGOS"+STR(LEN(WSEXT:OWSLSTPAGRESULT:oWSSTITPAG))) 
						
      	IF LEN(WSEXT:OWSLSTPAGRESULT:oWSSTITPAG) > 0
			FOR NX := 1 TO LEN(WSEXT:oWSLSTPAGRESULT:OWSSTITPAG)
				IF  (WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '003') .And. (Left(WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCANO,2) >= cANO_SIND) //SINDICAL
					AADD(SINDPGO,WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx])
				ENDIF
				conout("natureza"+WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT)
				
				IF WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '002' .OR. WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '0301' //CONFEDERATIVA
					AADD(CONFPGO,WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx])
                	conout("TITANO"+WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCANO)
			
                   	if WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCANO >= c_anoconf1 .AND. WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCANO <= c_anoconf2
                   	   XNUMTITCONF++
                   	ENDIF
                   	
/*                   		::cCANO              :=  WSAdvValue( oResponse,"_CANO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCMES              :=  WSAdvValue( oResponse,"_CMES","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCNAT              :=  WSAdvValue( oResponse,"_CNAT","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCPARCELA          :=  WSAdvValue( oResponse,"_CPARCELA","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cCTIPO             :=  WSAdvValue( oResponse,"_CTIPO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::dDPAGTO            :=  WSAdvValue( oResponse,"_DPAGTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::dDVENCTO           :=  WSAdvValue( oResponse,"_DVENCTO","date",NIL,NIL,NIL,"D",NIL,NIL) 
	::cNVALOR            :=  WSAdvValue( oResponse,"_NVALOR","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cNVLPAGTO          :=  WSAdvValue( oResponse,"_NVLPAGTO","string",NIL,NIL,NIL,"S",NIL,NIL) */

                   	
                   	
				ENDIF
				IF WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '001' .OR. WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '1000' //ASSOCIATIVA
					AADD(ASSOPGO,WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx])					
					XNUMTITASSO ++	    
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
			CONOUT("CNPJ:")		 //MARCUS PACHECO	
			CONOUT(ALLTRIM(WSEMP:OWSVERCADEMPRESULT:CCCGC))//MARCUS PACHECO
			CONOUT("VARIAVEL DA SITUAÇÃO 1:")//MARCUS PACHECO
			CONOUT(cSituacao)//MARCUS PACHECO
			IF cSituacao <> 'SS' .AND. cSituacao <> "AS"//MARCUS PACHECO
				CONOUT("DENTRO VARIAVEL DA SITUAÇÃO 1:")//MARCUS PACHECO
				CONOUT(cSituacao)//MARCUS PACHECO
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa não é associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3331-1555 opção 7, Fax (11) 3331-3344 e Email: cadastro@sindhosp.com.br"
			ELSE
			
				IF LEN(ASSOPGO)<=0
					HTTPPOST->MASSOPGO	:= "Não Existem Títulos Pagos"				
				ELSE
				    HTTPPOST->MASSOPGO	:= ''	
				ENDIF
			ENDIF								
		ELSE
			CONOUT("VARIAVEL DA SITUAÇÃO SEM TITULOS PAGOS:")//MARCUS PACHECO
			CONOUT(WSEMP:oWSVERCADEMPRESULT:CCSITUAC)//MARCUS PACHECO
			HTTPPOST->MSINDPGO	:= "Não Existem Títulos Pagos"
			HTTPPOST->MCONFPGO	:= "Não Existem Títulos Pagos"   
			IF cSituacao <> 'SS' .AND. cSituacao <> "AS"
				CONOUT("DENTRO VARIAVEL DA SITUAÇÃO SEM TITULOS PAGOS:")//MARCUS PACHECO
				CONOUT(WSEMP:oWSVERCADEMPRESULT:CCSITUAC)//MARCUS PACHECO
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa não é associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3331-1555 opção 7, Fax (11) 3331-3344 e Email: cadastro@sindhosp.com.br"
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
					CONOUT("ANO/PARCELA"+WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCANO+"/"+WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCANO)//MARCUS PACHECO
					AADD(CONFABT,WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX])					
					if WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCANO >= c_anoconf1 .AND. WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCANO <= c_anoconf2
						if WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCANO <> c_anoconf2
	                   	   XNUMCONFABT++
					    else
					    	if WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCPARCELA=='1'
					    		IF DTOS(DATE())>SUBS(DTOS(DATE()),1,4)+'0331'
					    			XNUMCONFABT++
					        	ENDIF
					        ELSE
					        	IF DTOS(DATE())>SUBS(DTOS(DATE()),1,4)+'0930'
					    			XNUMCONFABT++
					        	ENDIF
					        ENDIF
						ENDIF					       
                   	ENDIF   
                   
				ENDIF
				IF WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '001' .OR. WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX]:CCNAT == '1000' //ASSOCIATIVA
					AADD(ASSOABT,WSEXT:oWSLSTABTRESULT:oWSSTITABT[NX])					
                   	if WSEXT:oWSLSTabtRESULT:oWSSTITabt[nx]:ddvencto < date()
                   	   XNUMassoabt++
                   	ENDIF
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

			CONOUT("VARIAVEL DA SITUAÇÃO 2: ")//MARCUS PACHECO
			CONOUT(cSituacao)//MARCUS PACHECO
            IF cSituacao <> 'SS' .AND. cSituacao <> "AS" //MARCUS PACHECO
				CONOUT("DENTRO VARIAVEL DA SITUAÇÃO 2:")//MARCUS PACHECO
				CONOUT(cSituacao)//MARCUS PACHECO
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa não é associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3331-1555 opção 7, Fax (11) 3331-3344 e Email: cadastro@sindhosp.com.br"
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
			CONOUT("VARIAVEL DA SITUAÇÃO 3:")//MARCUS PACHECO
			CONOUT(WSEMP:oWSVERCADEMPRESULT:CCSITUAC)//MARCUS PACHECO
            IF cSituacao <> 'SS' .AND. cSituacao <> "AS"//MARCUS PACHECO
				CONOUT("DENTRO VARIAVEL DA SITUAÇÃO 3:")//MARCUS PACHECO
				CONOUT(WSEMP:oWSVERCADEMPRESULT:CCSITUAC)//MARCUS PACHECO
				HTTPPOST->MASSOPGO	:= "Prezado Contribuinte, esta empresa não é associada. Caso queira associar-se, favor entrar em contato com Depto. de Cadastro - Tel. (11) 3331-1555 opção 7, Fax (11) 3331-3344 e Email: cadastro@sindhosp.com.br"
			ELSE
				HTTPPOST->MASSOABT	:= "Não Existem Títulos em Aberto"
			ENDIF
		ENDIF
		
		Exit			
    EndDo
    
    If  !( lErro )
   	HttpPost->LogoFaixa := "header_extrato_boletos-todos.gif"
    	

/*		cHtml := ExecInPage("SHCABEMP") 
		cHtml += ExecInPage("SHCABESC")								
		cHtml += ExecInPage("SINDLISTEXT")
	    httppost->erro := c_anoconf1 +"- "+c_anoconf2
	   	httppost->erro += str(xNUMTITCONF)    
	   	httppost->erro += str(xNUMTITasso)*/
		conout("xnumtitasso"+str(xnumtitasso))
		conout("xnumtitconf"+str(xnumtitconf))
		conout("xnumconfabt"+str(xnumconfabt))
		
		if (xnumtitasso==12 .and. xnumtitconf==4) 
			xretorno := "2"	
		ELSEIF   XNUMassoabt==0 .and.   XNUMconfabt=0 .AND. xnumtitasso>0 .and. xnumtitconf>0 
	  		xretorno := "2"	
		


/*		elseif xnumtitasso==12 .and. xnumtitconf <4 .or. (xnumtitasso>0 .and. XNUMassoabt==0 .and. xnumtitconf<>4)
			xretorno := "1"   
		elseif xnumtitasso<12 .and. xnumtitconf ==4 .or. (xnumtitconf>0 .and. XNUMconfabt==0 .and. xnumtitasso<>12)
			xretorno := "1"*/
		ELSEIF 	(XNUMconfabt<>0 .AND. XNUMASSOABT=0 .and. xnumtitasso>0 )
				xretorno := "1"  
		elseif  (XNUMconfabt=0 .AND. XNUMASSOABT<>0  )
				xretorno := "1"  
		elseif  (XNUMconfabt=0 .AND. XNUMASSOABT=0 .AND. XNUMTITASSO=0 )
	  		xretorno := "1"  
		else
			xretorno := "0"
		endif
		httppost->erro := xretorno	
	    
		
		XDAta := DTOS(DATE())                                                                              
		xtime := TIME()
		U_IEPASGRV(HTTPSESSION->CGC,XRETORNO,XNUMTITASSO,XNUMTITCONF)
//		
  /*		dbselectaREA("SZX")
		RECLOCK("SZX",.T.)
		SZX->ZX_FILIAL:= XFILIAL("szx")
		szx->zx_date  := date()
		szx->zx_hora  := time()
		szx->zx_cgc   := HTTPSESSION->CGC
		szx->zx_status:= xretorno
		szx->zx_assoc := xnumtitasso
		szx->zx_conf  := xnumtitconf
		msunlock()			      */
		cHtml := ExecInPage("ERRO")
	EndIf	
	
	Exit
EndDo
	
                 
Web Extended End

Return cHtml 


