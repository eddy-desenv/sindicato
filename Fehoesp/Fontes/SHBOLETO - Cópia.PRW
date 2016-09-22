#INCLUDE "PROTHEUS.CH"
//#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"

#INCLUDE "SHBOLCEF_INCLUDES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BOLETO   ºAutor  ³GISELE NUNCHERINO   º Data ³  03/05/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE GERACAO DE BOLETOS		                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function BOLETO()

Local cHtml := ""

Web Extended Init cHtml 
    
	HTTPSESSION->TPBOLETO := NIL
	
	HTTPPOST->CGC := ""
	
	HttpPost->Boleto := If(Empty(HttpGet->Boleto),"1",HttpGet->Boleto) 
	
	IF  (HTTPSESSION->AEMPRESA <> NIL)
		HTTPPOST->CGC := HTTPSESSION->AEMPRESA:CCCGC
	ENDIF
	
	cHtml := ExecInPage("INTROBOLETO")
                                      
Web Extended End


Return cHtml  

                    
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CALCBOL  ºAutor  ³GISELE NUNCHERINO   º Data ³  03/05/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE CALCULO DE BOLETOS		                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function CALCBOL()           

Local lPago

Local cHtml 	:= ""
LOCAL CCGC 		:= IIF (HTTPPOST->CGC == NIL, HTTPSESSION->AEMPRESA:CCCGC, HTTPPOST->CGC)
LOCAL OWS		:= WSSINDHOSP():NEW()  
LOCAL WSEXT 	:= WSSHEXTRATO():NEW()
LOCAL WSBOL 	:= WSSHBOLETO():NEW()
LOCAL ADADOS	:= {}		
LOCAL CMSG		:= ''
LOCAL NX		:= 0  
LOCAL AANO		:= {}
LOCAL ACONFED	:= {}
LOCAL AASSIST	:= {} 
LOCAL AASSOCI	:= {} 
LOCAL CANO		:= ''
LOCAL ANOPAG	:= {}

WSChgUrl( @OWS	, "SINDHOSP.APW" )

WSChgUrl( @WSEXT, "SHEXTRATO.APW" )

WSChgUrl( @WSBOL, "SHBOLETO.APW" )

Web Extended Init cHtml 

If  Empty(u_LIMPACGC(CCGC))
	HTTPPOST->ERRO := "CNPJ em branco/invalido"
	cHtml := ExecInPage("ERRO")	        
ELSE
 
OWS:CCCGC 	:= U_LIMPACGC(CCGC)

/* TIPOS DE BOLETOS 

 '1'-> SINDICAL
 '2'-> CONFEDERATIVA
 '3'-> ASSOCIATIVA
 '4'-> ASSISTENCIAL/NEGOCIAL
		
*/                                     

Do  While .T.

HttpPost->Item := HttpGet->Item
HttpPost->Item := If(Empty(HttpPost->Item), "1", HttpPost->Item)

HttpPost->AnoParcela := HttpGet->AnoParcela
HttpPost->AnoParcela := If(Empty(HttpPost->AnoParcela), '', HttpPost->AnoParcela)
                     
If  !( Empty(HTTPGET->TPBOLETO) )
	HTTPPOST->TPBOLETO := HTTPGET->TPBOLETO
EndIf	

HTTPSESSION->TPBOLETO := HTTPPOST->TPBOLETO //ARMAZENA O TIPO DE BOLETO SELECIONADO

IF OWS:VERCADEMP()   //ACHOU A EMPRESA

	IF !EMPTY(OWS:OWSVERCADEMPRESULT:CCCGC)
		    HTTPPOST->CGC	  	:= ALLTRIM(OWS:OWSVERCADEMPRESULT:CCCGC)
		    HTTPPOST->RAZAO		:= ALLTRIM(OWS:OWSVERCADEMPRESULT:CCNOME)
		    HTTPPOST->CEP		:= ALLTRIM(OWS:OWSVERCADEMPRESULT:CCCEP)
		    HTTPPOST->CEND		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCEND)
		    HTTPPOST->BAIRRO	:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCBAIRRO)
		    HTTPPOST->MUN		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCMUN)
		    HTTPPOST->EST		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCUF)
		    HTTPPOST->EMAIL		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCEMAIL)
		    HTTPPOST->TEL		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCTEL)
		    HTTPPOST->FAX		:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCFAX)
		    HTTPPOST->CAPITAL	:= ALLTRIM(transform(VAL(ALLTRIM(OWS:oWSVERCADEMPRESULT:CCCAPITAL)), '@E 999,999,999,999.99')) 
		    HTTPPOST->INIATV	:= OWS:oWSVERCADEMPRESULT:DDINIATV
		    HTTPPOST->CONTATO	:= ALLTRIM(OWS:oWSVERCADEMPRESULT:CCCONTATO)
			 
		    /* DADOS DA EMPRESA */
			HTTPSESSION->AEMPRESA := OWS:oWSVERCADEMPRESULT:CLONE()                 
			
	        CANO		:= SUBSTR(ALLTRIM(DTOC(HTTPSESSION->AEMPRESA:DDINIATV)),7,4)
	        
	        dDtAno  := CtoD("14/12/" + CANO)
	        
	        If  (HTTPSESSION->AEMPRESA:DDINIATV > dDtAno)
	            CANO := StrZero(Val(CANO)+1,4)
	        EndIf
	        
			IF !EMPTY(OWS:oWSVERCADEMPRESULT:CCODESCR)
		        OWS:CCCGC := OWS:oWSVERCADEMPRESULT:CCODESCR
		 		IF OWS:VERCADESC()
		 			HTTPSESSION->AESCRITO := OWS:oWSVERCADESCRESULT 
		 			
					HTTPPOST->CEI		:= OWS:oWSVERCADESCRESULT:cCCGC
					HTTPPOST->ESCRAZ	:= OWS:oWSVERCADESCRESULT:CCNOME
					HTTPPOST->ESCCEP	:= OWS:oWSVERCADESCRESULT:CCCEP
					HTTPPOST->ESCEND	:= OWS:oWSVERCADESCRESULT:CCEND
					HTTPPOST->ESCBAIR	:= OWS:oWSVERCADESCRESULT:CCBAIRRO
					HTTPPOST->ESCMUN	:= OWS:oWSVERCADESCRESULT:CCMUN	
					HTTPPOST->ESCUF		:= OWS:oWSVERCADESCRESULT:CCUF	
					HTTPPOST->ESCMAIL	:= OWS:oWSVERCADESCRESULT:CCEMAIL
					HTTPPOST->ESCTEL	:= OWS:oWSVERCADESCRESULT:CCTEL	
					HTTPPOST->ESCFAX	:= OWS:oWSVERCADESCRESULT:CCFAX	
					HTTPPOST->ESCCONT	:= OWS:oWSVERCADESCRESULT:CCCONTATO	
					
				    HTTPPOST->ESCCGC	  	:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCCGC)
				    HTTPPOST->ESCRAZAO	:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCNOME)
				    HTTPPOST->ESCCEP		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCCEP)
				    HTTPPOST->ESCEND		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCEND)
				    HTTPPOST->ESCBAIRRO	:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCBAIRRO)
				    HTTPPOST->ESCMUN		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCMUN)
				    HTTPPOST->EST			:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCUF)
				    HTTPPOST->ESCEMAIL	:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCEMAIL)
				    HTTPPOST->ESCTEL		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCTEL)
				    HTTPPOST->ESCFAX		:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCFAX)
				    HTTPPOST->ESCCONTATO:= ALLTRIM(OWS:oWSVERCADESCRESULT:CCCONTATO)		
	
		 		ENDIF
		 	ELSE
		 		HTTPSESSION->AESCRITO := ''
		 	ENDIF
		 		
	  	DO CASE
			CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '1234'
				IF (HTTPSESSION->AEMPRESA:DDDTNASC == DATE() .AND. ALLTRIM(HTTPSESSION->AEMPRESA:CCINAT) == "X") .OR. (ALLTRIM(HTTPSESSION->AEMPRESA:CCINAT) != "X")   
	/*************************************************************************************************************************************/
	/*													S I N D I C A L																	 */ 
	/*************************************************************************************************************************************/	
	
					IF ALLTRIM(HTTPPOST->TPBOLETO) == '1' //SINDICAL
						      
						/* VERIFICAR OS TITULOS PAGOS */
						/* WSMETHOD LSTTITPAG WSRECEIVE AEMPRESA, LSIND, LCONFNEG, LASSOC  WSSEND ATITPAG WSSERVICE SHEXTRATO */
						
						HttpPost->LogoFaixa := "header_sindical-todos.gif"
						                     
						If  (ALLTRIM(HTTPSESSION->AEMPRESA:CCCAPCENT) == 'S') 
							HTTPPOST->ERRO := "Capital Social centralizado!<br> Esta contribuição não é devida para este CNPJ!"
							cHtml := ExecInPage("ERRO")	
							Exit
						EndIf
						
						If  (ALLTRIM(HTTPSESSION->AEMPRESA:CCFILANTR) == 'X') .Or. (Val(HTTPSESSION->AEMPRESA:CNCATEGOR) >= 12000)
							HTTPPOST->ERRO := "Não existem títulos em aberto!"
							cHtml := ExecInPage("ERRO")	
							Exit
						EndIf
						
					    WSEXT:oWSAEMPRESA:cCCGC 	:= HTTPSESSION->AEMPRESA:CCCGC
					    WSEXT:oWSAEMPRESA:cCCODIGO 	:= HTTPSESSION->AEMPRESA:cCCODIGO
					    WSEXT:oWSAEMPRESA:cCFILANTR := HTTPSESSION->AEMPRESA:cCFILANTR
					    WSEXT:oWSAEMPRESA:cCFILIAL 	:= HTTPSESSION->AEMPRESA:cCFILIAL
					    WSEXT:oWSAEMPRESA:cCFOLCENT := HTTPSESSION->AEMPRESA:cCFOLCENT
					    WSEXT:oWSAEMPRESA:cCLOJA 	:= HTTPSESSION->AEMPRESA:cCLOJA
					    WSEXT:oWSAEMPRESA:dDINIATV 	:= HTTPSESSION->AEMPRESA:dDINIATV
					    WSEXT:oWSAEMPRESA:nNCATEGOR := VAL(HTTPSESSION->AEMPRESA:CNCATEGOR)
					    WSEXT:oWSAEMPRESA:CCNATUREZ := HTTPSESSION->AEMPRESA:CCNATUREZ						
					    
	    				WSEXT:lLSIND 		:= .T.
	   	 				WSEXT:lLCONFNEG 	:= .F.
					    WSEXT:lLASSOC 		:= .F.
	    					    
					    IF WSEXT:LSTPAG() 
							IF LEN(WSEXT:oWSLSTPAGRESULT:OWSSTITPAG) > 0
								FOR NX := 1 TO LEN(WSEXT:oWSLSTPAGRESULT:OWSSTITPAG)
									IF WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCNAT == '003' //SINDICAL
										AADD(ANOPAG,ALLTRIM(WSEXT:oWSLSTPAGRESULT:oWSSTITPAG[nx]:CCANO))
									ENDIF
								NEXT NX					   
						   	ELSE             
						   		ANOPAG := {}
						  	ENDIF 	
						ELSE
							HTTPPOST->ERRO := "Erro ao verificar os titulos pagos"
							cHtml := ExecInPage("ERRO")	
							Exit
						ENDIF					

						If  !( WSBOL:BUSCAANO() ) 
							HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
							cHtml := ExecInPage("ERRO")
							Exit
						ENDIF

						FOR NX := 1 TO Len(WSBOL:oWSBUSCAANORESULT:OWSSANO)

						    If  (Val(WSBOL:oWSBUSCAANORESULT:OWSSANO[NX]:cANO) < Val(CANO))
						        Loop
						    EndIf    
							
							lPago :=  (aScan( ANOPAG, {|x|  x   == SUBSTR(WSBOL:oWSBUSCAANORESULT:OWSSANO[NX]:cANO,3,2)+"S" } ) > 0)
							
							If  !( lPago )
								
								AADD(AANO,{WSBOL:oWSBUSCAANORESULT:OWSSANO[NX]:cANO, lPago})          
								
							EndIf	

						NEXT NX
                                         
                        If  (Len(AANO) <= 0)
							HTTPPOST->ERRO := "Não existem títulos em aberto!"
							cHtml := ExecInPage("ERRO")	
							Exit
						EndIf	

						HTTPSESSION->AANO 		:= AANO 
						HTTPSESSION->CCAPSOC  	:= HTTPPOST->CAPITAL
						HTTPSESSION->DATIV		:= HTTPPOST->INIATV
	
						cHtml := ExecInPage("SHCABEMP") 
						cHtml := ExecInPage("SHCABESC") 
						cHtml := ExecInPage("CALCSIND") 
					
	/*************************************************************************************************************************************/
	/*													C O N F E D E R A T I V A														 */ 
	/*************************************************************************************************************************************/	
											
					ELSEIF ALLTRIM(HTTPPOST->TPBOLETO) == '2' //CONFEDERATIVA
						
						/*
							Se a natureza da empresa em questão (A1_NATUREZ) for igual a "1000" e a situação (A1_SITUAC) igual a "AS" ou "SS", 
							o site NÃO deve disponibilizar a impressão do boleto e exibir a seguinte mensagem: 
							"Associado - Esta empresa já faz mensalmente o recolhimento desta contribuição confederativa juntamente com o 
							pagamento da contribuição Associativa." 
						*/
						
						HttpPost->LogoFaixa := "header_confederativa-todos.gif"
						                     
						If  (ALLTRIM(HTTPSESSION->AEMPRESA:CCFOLCENT) == 'S') 
							HTTPPOST->ERRO := "Folha de Pagamento centralizada!<br> Esta contribuição não é devida para este CNPJ!"
							cHtml := ExecInPage("ERRO")	
							Exit
						EndIf
						
						IF ALLTRIM(OWS:oWSVERCADEMPRESULT:CCNATUREZ) == '1000' .AND. (ALLTRIM(OWS:oWSVERCADEMPRESULT:CCSITUAC) == 'AS' .OR. ALLTRIM(OWS:oWSVERCADEMPRESULT:CCSITUAC) == 'SS')
							HTTPPOST->ERRO := 'Associado - Esta empresa já faz mensalmente o recolhimento desta contribuição confederativa juntamente com o pagamento da contribuição Associativa'
							cHtml := ExecInPage("ERRO")
					    ELSE
	                        /* MONTA A LISTA DE ANO/PARCEL */
							WSBOL:LLRETURN := .T.
							WSBOL:CCODIGO  := ''
							WSBOL:CITEM	   := ''
							WSBOL:oWSAEMPRESA := HTTPSESSION->AEMPRESA
							
							IF WSBOL:DADOSCONF()
								HTTPSESSION->ACONFED:= WSBOL:oWSDADOSCONFRESULT
								cHtml := ExecInPage("SHCABEMP")
								cHtml := ExecInPage("SHCABESC")
								cHtml := ExecInPage("CALCCONF")
	      					ELSE
	      						ACONFED := {}   
	      						HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))
	      						//HTTPPOST->ERRO := "Base de Cálculo Nao Definida"
	      						cHtml := ExecInPage("ERRO")
	      					ENDIF
					
						ENDIF     
						
	/*************************************************************************************************************************************/
	/*											ASSOCIATIVA / 	ASSOCIATIVA CONFEDERATIVA												 */ 
	/*************************************************************************************************************************************/	
	
					ELSEIF ALLTRIM(HTTPPOST->TPBOLETO) == '3'
						/* 	PL -12 - Se a situação da empresa (A1_SITUAC) for igual a “AS” ou “SS”, a natureza no título (E1_NATUREZ) for igual a
							“1000” OU "001" e o título ainda estiver em aberto (E1_baixa = " "), o site deve disponibilizar o boleto para impressão, porem:
							 Se a situação da empresa (A1_SITUAC) for diferente de “AS” ou “SS”, deve aparecer a seguinte mensagem: “Esta
							 empresa não é contribuinte, portanto não deve essa contribuição.”
							 Se a empresa em questão estiver inativa (A1_INAT = "X"), o site não deve disponibilizar a impressão do boleto e
							 exibir um alerta com a seguinte mensagem: “Cliente Inativo – Favor entrar em contato com o departamento de
							 Cadastro, através do telefone (11) 3331-1555 na opção 7 ou e-mail: cadastro@sindhosp.com.br”
						*/   

						HttpPost->LogoFaixa := "header_associativa-todos.gif"
						                     
						If (ALLTRIM(HTTPSESSION->AEMPRESA:cCSITUAC) == 'AS' .OR. ALLTRIM(HTTPSESSION->AEMPRESA:cCSITUAC) == 'SS') 
							If ALLTRIM(HTTPSESSION->AEMPRESA:CCINAT) == "X"
								HTTPPOST->ERRO := "Cliente c/ problemas no cadastro!<br>Favor entrar em contato com o departamento de cadastro do FEHOESP:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br"
					
								If  (HTTPSESSION->AEMPRESA:CCSINDICA == '01')
									HTTPPOST->ERRO := "Cliente c/ problemas no cadastro!<br>Favor entrar em contato com o departamento de Cadastro, através do telefone (11) 3331-1555 na opção 7 ou <BR> e-mail: cadastro@sindhosp.com.br"
							    EndIf 

								cHtml := ExecInPage("ERRO")
							Else
								WSBOL:oWSAEMPRESA	:= HTTPSESSION->AEMPRESA
								IF WSBOL:BUSCAASSO() 
									IF LEN(WSBOL:oWSBUSCAASSORESULT:OWSSCASSO) >0
										HTTPPOST->PARCELA := WSBOL:oWSBUSCAASSORESULT 
									   	cHtml := ExecInPage("SHCABEMP")
										cHtml := ExecInPage("SHCABESC")
										cHtml := ExecInPage("ASSOCIAT")	
									ELSE
										HTTPPOST->ERRO := "Títulos Não Localizados"
										cHtml := ExecInPage("ERRO")									
									ENDIF								
								ELSE
									HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
									cHtml := ExecInPage("ERRO")
								ENDIF
							EndIf
						Else
							HTTPPOST->ERRO := 'Esta empresa não é associada, portanto não deve essa contribuição'
							cHtml := ExecInPage("ERRO")
						EndIf



	/*************************************************************************************************************************************/
	/*												A S S I S T E N C I A L / N E G O C I A L	  										 */ 
	/*************************************************************************************************************************************/	
						
	                ELSEIF ALLTRIM(HTTPPOST->TPBOLETO) == '4' //ASSISTENCIAL/NEGOCIAL
					
						/* 	Se a natureza da empresa em questão (A1_NATUREZ) for igual a "1000" e a situação (A1_SITUAC) igual a "AS" ou "SS", 
							o site não deve disponibilizar a impressão do boleto e exibir um alerta com a seguinte mensagem: 
							"Associado - Esta empresa já faz mensalmente o recolhimento desta contribuição confederativa juntamente com o 
							pagamento da contribuição Associativa."
						*/
	
						HttpPost->LogoFaixa := "header_assistencial-negocia-todos.gif"
						                     
						If  (ALLTRIM(HTTPSESSION->AEMPRESA:CCFOLCENT) == 'S') 
							HTTPPOST->ERRO := "Folha de Pagamento centralizada!<br> Esta contribuição não é devida para este CNPJ!"
							cHtml := ExecInPage("ERRO")	
							Exit
						EndIf
						
						IF ALLTRIM(OWS:OWSVERCADEMPRESULT:CCNATUREZ) == '1000' 
							IF (ALLTRIM(OWS:OWSVERCADEMPRESULT:CCSITUAC) == 'AS' .OR. ALLTRIM(OWS:OWSVERCADEMPRESULT:CCSITUAC) == 'SS')
								HTTPPOST->ERRO := 'Associado - Esta empresa já faz mensalmente o recolhimento desta contribuição confederativa juntamente com o pagamento da contribuição Associativa'
								cHtml := ExecInPage("ERRO")
							ENDIF
					    ELSE   
					    	WSBOL:oWSAEMPRESA	:= HTTPSESSION->AEMPRESA:CLONE()
					    	IF WSBOL:CALCASSI()
					    		IF LEN(WSBOL:oWSCALCASSIRESULT:oWSSCLCASSI) > 0
									HTTPSESSION->AASSIST	:= WSBOL:oWSCALCASSIRESULT:oWSSCLCASSI 
									cHtml := ExecInPage("SHCABEMP") 
									cHtml := ExecInPage("SHCABESC")								
									cHtml := ExecInPage("CALCNEG") 	                        
			               ELSE                 
			               		HTTPPOST->XRedir   := "W_CALCBOL.APW"
			               		HTTPPOST->TPBOLETO := "2" //**** Redireciona para Confedereativa ***
	    	  					HTTPPOST->ERRO   := "Contribuição não aprovada em convenção coletiva!<br>A empresa deve recolher a Contribuição Confederativa!<br>Estamos direcionando para a impressão da Contribuição Confederativa."
	      						cHtml := ExecInPage('ERRO')
			     	       ENDIF
      					ELSE                                        
      						HTTPPOST->XRedir := "W_CALCBOL.APW"
	               			HTTPPOST->TPBOLETO := "2" //**** Redireciona para Confedereativa ***
							HTTPPOST->ERRO := "Contribuição não aprovada em convenção coletiva!<br>A empresa deve recolher a Contribuição Confederativa!<br>Estamos direcionando para a impressão da Contribuição Confederativa."
      						cHtml := ExecInPage('ERRO')
      					ENDIF
						ENDIF
					ENDIF
	
		        ELSE
					HTTPPOST->ERRO := "Cliente c/ problemas no cadastro!<br>Favor entrar em contato com o departamento de cadastro do FEHOESP:<br>telefone (11) 3221-9333 ou e-mail: arrecadacao@fehoesp.org.br"
		
					If  (HTTPSESSION->AEMPRESA:CCSINDICA == '01')
						HTTPPOST->ERRO := "Cliente c/ problemas no cadastro!<br>Favor entrar em contato com o departamento de Cadastro, através do telefone (11) 3331-1555 na opção 7 ou <BR> e-mail: cadastro@sindhosp.com.br"
				    EndIf 

					cHtml := ExecInPage("ERRO") //MSG DE EMPRESA INATIVA	        
				EndIf            
		ENDCASE
		
	ELSE // NAO ENCONTROU A EMPRESA
	
		DO CASE
			CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '124'
				HTTPPOST->CGC := CCGC
				W_FUNCEMP()      //TELA DE CADASTRO
		
			CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '3'
				HTTPPOST->CGC :=''
				HTTPPOST->ERRO := "CNPJ Não Localizado"
				cHtml := ExecInPage("ERRO")
		ENDCASE 
	
	ENDIF

ELSE

	HTTPPOST->ERRO := 'Erro Na Localizacao Dos Dados'
	
ENDIF
	
	Exit
EndDo	

ENDIF        

Web Extended End

Return cHtml 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PREBOL   ºAutor  ³ Antonio C Ferreira º Data ³  07/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina para preparacao para a Impressao do Boleto para as  º±±
±±º          ³ outras rotinas do site.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function PREBOL()

Web Extended Init cHtml 
      
/* TIPOS DE BOLETOS 
 '1'-> SINDICAL
 '2'-> CONFEDERATIVA
 '3'-> ASSOCIATIVA / ASSOCIATIVA CONFEDERATIVA
 '4'-> ASSISTENCIAL/NEGOCIAL
*/

   

Web Extended End

Return cHtml  



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GERABOL   ºAutor  ³GISELE NUNCHERINO   º Data ³  07/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CHAMA A PAGINA DE IMPRESSAO DOS BOLETOS	                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function GERABOL()

Local cLink, cData, nValor, cComplemento, nMoraMulta, nCorrecao

Local cHtml := ""

LOCAL CVALOR 	:= 0
LOCAL NX	 	:= 0
LOCAL NAUX	 	:= 0
LOCAL CANO		:= HTTPGET->ANO
LOCAL OWSBOL	:= WSSHBOLETO():NEW()  
LOCAL CODIGO	:= ''
LOCAL CCOMPL	:= 0 
LOCAL I := 0
LOCAL NPORCENT	:= 0
            
Local lAcrescimo 	:= .F.
Local nJurosMes  	:= 0
Local nMulta     	:= 0
Local nValorMulta := 0
Local nValorJuros := 0
Local nMeses		:= 0
Local nVlrAliq 	:= 0
Local nVlrMin  	:= 0

Local cRaizURL  := HttpPost->VerURL 

Local aMeses    := {"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}
                                          
If	!( Empty(HTTPGET->TPBOLETO) )
	HTTPSESSION->TPBOLETO := HTTPGET->TPBOLETO  //**** Redirecionado pela Assistencial para a Confederetiva ***
EndIf

WSChgUrl( @OWSBOL, "SHBOLETO.APW" )

HttpSession->aDados := Array(50) 

AFill(HttpSession->aDados, "")

//**** Informacao importante para que o ASP possa retornar ao link original do Protheus ***
If  !( Empty(cRaizURL) )   
    nX := At("/W_", UPPER(cRaizURL))
    cRaizURL := Left(cRaizURL, nX) + "w_boleto.apw"
EndIf

If  !( Empty(HttpSession->XRaizURL) )
	cRaizURL := HttpSession->XRaizURL
EndIf

If  !( Empty(HttpGet->XCHAVE) )
	HTTPGET->FILIAL	 := Left(HttpGet->XCHAVE,2)
	HTTPGET->PREFIXO := SubStr(HttpGet->XCHAVE,03,3)
	HTTPGET->NUMERO  := SubStr(HttpGet->XCHAVE,06,6)
	HTTPGET->PARCELA := SubStr(HttpGet->XCHAVE,12,1)
	HTTPGET->NATUREZ := SubStr(HttpGet->XCHAVE,16)
EndIf
                                        
If  Empty(HTTPGET->VALOR)
	NAUX	:= "0,00" 
Else
	NAUX 	:= StrTran(StrTran(StrTran(ALLTRIM(HTTPGET->VALOR),'R$ ',''),'.',''),',','.')
EndIf
		
Web Extended Init cHtml 
      
/* TIPOS DE BOLETOS 
 '1'-> SINDICAL
 '2'-> CONFEDERATIVA
 '3'-> ASSOCIATIVA / ASSOCIATIVA CONFEDERATIVA
 '4'-> ASSISTENCIAL/NEGOCIAL
*/

Do  While .T.

    If  Empty(HTTPSESSION->AEMPRESA) .Or. Empty(HTTPSESSION->AEMPRESA:CPORTAL)
        cHtml := w_Boleto()
        Exit
    EndIf
  
	HTTPSESSION->PORTAL := ALLTRIM(HTTPSESSION->AEMPRESA:CPORTAL)

	HTTPPOST->SINDICATO := HTTPSESSION->AEMPRESA:CCSINDICA 
	
	HTTPPOST->RAIZURL   := cRaizURL
	
	aDadosRaizURL   :=  cRaizURL

	aDadosSindicato := HTTPSESSION->AEMPRESA:CCSINDICA 
	aDadosCNPJ 		:= Alltrim(HTTPSESSION->AEMPRESA:CCCGC)

	aDadosRazao  	:= HTTPSESSION->AEMPRESA:CCNOME

	aDadosEndereco  := HTTPSESSION->AEMPRESA:CCEND
	cComplemento	:= SubStr(aDadosEndereco,AT(",",aDadosEndereco)+1,Len(aDadosEndereco))
	aDadosEndereco  := Left(aDadosEndereco,AT(",",aDadosEndereco)-1)
    cNumero 		:= AllTrim(SubStr(cComplemento, 1 ,AT(" ",Alltrim(cComplemento))))
    cComplemento    := SubStr(cComplemento, AT(" ",Alltrim(cComplemento))+1, Len(cComplemento))
    aDadosEndereco  += ", " + cNumero + " " + AllTrim(cComplemento) + " - " + AllTrim(HTTPSESSION->AEMPRESA:CCBAIRRO)
    
	aDadosCEP		:= Alltrim(transform(HTTPSESSION->AEMPRESA:CCCEP, '@R 99999-999'))
	aDadosCEP		+= " - " + AllTrim(HTTPSESSION->AEMPRESA:CCMUN) + "-" + HTTPSESSION->AEMPRESA:CCUF
                
	HTTPPOST->DDINIATV 	:= HTTPSESSION->AEMPRESA:DDINIATV
	HTTPPOST->NOME	 	:= HTTPSESSION->AEMPRESA:CCNOME
	HTTPPOST->UF	 	:= HTTPSESSION->AEMPRESA:CCUF
	HTTPPOST->MUN	 	:= HTTPSESSION->AEMPRESA:CCMUN
	HTTPPOST->BAIRRO 	:= HTTPSESSION->AEMPRESA:CCBAIRRO
	      
	HTTPPOST->RAZAO		:= HTTPSESSION->AEMPRESA:CCNOME
	HTTPPOST->CGC		:= ALLTRIM(HTTPSESSION->AEMPRESA:CCCGC)
	HTTPPOST->CEND		:= HTTPSESSION->AEMPRESA:CCEND
	CCOMPL 				:= SUBSTR(HTTPPOST->CEND,AT(",",HTTPPOST->CEND)+1,LEN(HTTPPOST->CEND))
	HTTPPOST->CENDNUM	:= SUBSTR(CCOMPL,1,AT(" ",ALLTRIM(CCOMPL)))
	HTTPPOST->CENDCOMPL	:= SUBSTR(CCOMPL,AT(" ",ALLTRIM(CCOMPL))+1, LEN(CCOMPL))
	HTTPPOST->CEP		:= ALLTRIM(transform(HTTPSESSION->AEMPRESA:CCCEP, '@R 99999-999'))
	HTTPPOST->EST		:= HTTPSESSION->AEMPRESA:CCUF
                  

	If  (HTTPSESSION->TPBOLETO == '1')  //SINDICAL

	
		OWSBOL:cANO 		:= CANO
		OWSBOL:oWSAEMPRESA  := HTTPSESSION->AEMPRESA:CLONE()

		If  !( OWSBOL:BUSCADADO() )
       	
       		If  Empty(GetWSCError(3))
       			HTTPPOST->ERRO := "Problema de Comunicação com o Servidor! Favor tentar novamente ou entrar em contato com FEHOESP."
       		Else
				HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
			EndIf
				
			cHtml := ExecInPage("ERRO")
            Exit
        EndIf    
		
		HTTPPOST->NOSSONUM	:= SUBSTR(ALLTRIM(HTTPPOST->CGC),1,LEN(ALLTRIM(HTTPPOST->CGC))-2)

		HTTPPOST->CANO		:= CANO
		HTTPPOST->CPARCELA	:= ''
		HTTPPOST->DEMISSAO	:= DATE()   
		HTTPPOST->DVENCTO	:= OWSBOL:oWSBUSCADADORESULT:DVENCTO
        HTTPPOST->APLACR	:= OWSBOL:oWSBUSCADADORESULT:lAPLACR
        HTTPPOST->MULTA		:= OWSBOL:oWSBUSCADADORESULT:nMULTA 
        HTTPPOST->AGENCIA	:= OWSBOL:oWSBUSCADADORESULT:cAGENCIA
        HTTPPOST->CONTA 	:= OWSBOL:oWSBUSCADADORESULT:CCONTA

      If  (Date() > HTTPPOST->DVENCTO)
          nDia := 31
          cMes := Alltrim(Str(Month(Date()))) 
          cAno := Alltrim(Str(Year(Date())))
          dData := CtoD(Alltrim(Str(nDia))+'/'+cMes+'/'+cAno)
          
          Do  While Empty(dData)
              --nDia
              dData := CtoD(Alltrim(Str(nDia))+'/'+cMes+'/'+cAno)
          EndDo
          
          cData := DtoC(dData)
      Else
          cData := DtoC(HTTPPOST->DVENCTO)
      EndIf    

        //**** Mensagens do Boleto ***                                 
		HTTPPOST->MSG1		:= OWSBOL:oWSBUSCADADORESULT:CMSG1
        HTTPPOST->MSG2		:= OWSBOL:oWSBUSCADADORESULT:CMSG2
        HTTPPOST->MSG3		:= OWSBOL:oWSBUSCADADORESULT:CMSG3
        HTTPPOST->MSG4		:= OWSBOL:oWSBUSCADADORESULT:CMSG4
        HTTPPOST->MSG5		:= OWSBOL:oWSBUSCADADORESULT:CMSG5
        HTTPPOST->MSG6		:= OWSBOL:oWSBUSCADADORESULT:CMSG6
        HTTPPOST->MSG7		:= OWSBOL:oWSBUSCADADORESULT:CMSG7
        HTTPPOST->MSG8		:= OWSBOL:oWSBUSCADADORESULT:CMSG8
        HTTPPOST->MSG9		:= OWSBOL:oWSBUSCADADORESULT:CMSG9
		         
        cLink := '<a href="http://' + Lower(OWSBOL:oWSBUSCADADORESULT:CLINK) + '">' + Lower(OWSBOL:oWSBUSCADADORESULT:CLINK) + '</a>'
		         
        //**** Substituicao dos Dados das Mensagens ***
        //**** XXXXX = Data Valida do Boleto
        //**** ZZZZZ = Link do site do sindicato
		         
        HTTPPOST->MSG1		:= StrTran(StrTran(HTTPPOST->MSG1,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG2		:= StrTran(StrTran(HTTPPOST->MSG2,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG3		:= StrTran(StrTran(HTTPPOST->MSG3,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG4		:= StrTran(StrTran(HTTPPOST->MSG4,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG5		:= StrTran(StrTran(HTTPPOST->MSG5,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG6		:= StrTran(StrTran(HTTPPOST->MSG6,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG7		:= StrTran(StrTran(HTTPPOST->MSG7,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG8		:= StrTran(StrTran(HTTPPOST->MSG8,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG9		:= StrTran(StrTran(HTTPPOST->MSG9,"XXXXX", cData), "ZZZZZ", cLink)
		//***//
		
                                        
   		HTTPPOST->LOGOTIPO  := OWSBOL:oWSBUSCADADORESULT:CIMAGEM
       	nPos := RAT('\',OWSBOL:oWSBUSCADADORESULT:CIMAGEM)
        
       	If  (nPos > 0)
       		HTTPPOST->LOGOTIPO  := RIGHT(OWSBOL:oWSBUSCADADORESULT:CIMAGEM, Len(OWSBOL:oWSBUSCADADORESULT:CIMAGEM)-nPos)
       	EndIf
       	
       	aDadosLogoTipo      := HTTPPOST->LOGOTIPO
							        
  		HTTPPOST->MOEDA	    := OWSBOL:oWSBUSCADADORESULT:CMOEDA
    	HTTPPOST->CNAE	    := OWSBOL:oWSBUSCADADORESULT:CCNAE
    	
    	aDadosSDNome        := OWSBOL:oWSBUSCADADORESULT:CSDNOME
        
		HTTPPOST->SDNOME    := OWSBOL:oWSBUSCADADORESULT:CSDNOME 
        HTTPPOST->SDEND	    := OWSBOL:oWSBUSCADADORESULT:CSDEND
        HTTPPOST->SDNUMEND  := SUBSTR(OWSBOL:oWSBUSCADADORESULT:CSDEND,AT(",",OWSBOL:oWSBUSCADADORESULT:CSDEND)+1,LEN(OWSBOL:oWSBUSCADADORESULT:CSDEND))			
		HTTPPOST->SDCOMPL   := ''			                                            
		HTTPPOST->SDBAIRRO  := OWSBOL:oWSBUSCADADORESULT:CSDBAIRRO
		HTTPPOST->SDCEP     := ALLTRIM(transform(OWSBOL:oWSBUSCADADORESULT:CSDCEP, '@R 99999-999'))   
		HTTPPOST->SDMUN     := OWSBOL:oWSBUSCADADORESULT:CSDMUN   
		HTTPPOST->SDEST     := OWSBOL:oWSBUSCADADORESULT:CSDEST 
		HTTPPOST->SDCGC     := ALLTRIM(transform(OWSBOL:oWSBUSCADADORESULT:CSDCGC   , '@R 99.999.999/9999-99'))
		HTTPPOST->SDENTIDA  := ALLTRIM(transform(OWSBOL:oWSBUSCADADORESULT:CSDENTIDA, '@R 999.999.99999-9'))
		HTTPPOST->SDENTID2  := OWSBOL:oWSBUSCADADORESULT:CSDENTID2

        HTTPPOST->CEDENTE	:= HTTPPOST->SDENTIDA  //**** Cedente mesmo código da Entidade ***
					                                  
		HTTPPOST->CAPITAL  := Transform(Val(StrTran(StrTran(HTTPSESSION->AEMPRESA:CCCAPITAL,'.',''),',','.')), '@E 999,999,999,999.99')
		
		nValor 	:= Val(StrTran(StrTran(HTTPPOST->CAPITAL,'.',''),',','.'))
		
		HTTPPOST->ALIQ 		:= OWSBOL:oWSBUSCADADORESULT:CALIQ
		 
		IF  ( Val(OWSBOL:oWSBUSCADADORESULT:CCONTRB) > 0 )
			nValor := Val(OWSBOL:oWSBUSCADADORESULT:CCONTRB)
		ELSE
			nValor := (nValor * Val(OWSBOL:oWSBUSCADADORESULT:CALIQ)/100)+VAL(OWSBOL:oWSBUSCADADORESULT:CADIC)
		ENDIF
		
		HTTPPOST->VLRDOC := Alltrim(Transform(nValor, '@E 999,999,999,999.99'))
		
        If  OWSBOL:oWSBUSCADADORESULT:lAPLACR .And. (Date() > HTTPPOST->DVENCTO)
            nCorrecao           := (nValor * (OWSBOL:oWSBUSCADADORESULT:nCORREC/100))
	        HTTPPOST->CORRMON   := Alltrim(transform(nCorrecao, '@E 999,999,999.99'))
                                                 
            nMoraMulta 			:= (nValor * (OWSBOL:oWSBUSCADADORESULT:nMORA/100)) + (nValor * (OWSBOL:oWSBUSCADADORESULT:nMULTA/100))
	        HTTPPOST->MORAMULTA	:= Alltrim(transform(nMoraMulta, '@E 999,999,999.99'))
			                          
			nValor				:= nValor + nMoraMulta + nCorrecao
	        HTTPPOST->VLRCOBR	:= Alltrim(transform(nValor, '@E 999,999,999,999.99'))
	 	Else
	 		HTTPPOST->VLRCOBR	:= '0'
	 		HTTPPOST->CORRMON 	:= '0' 
	 		HTTPPOST->MORAMULTA := '0'
	 	EndIf                                                  
	 	
        OWSBOL:oWSABOLETO:cANO 	  := CANO
        OWSBOL:oWSABOLETO:cBASE      := HTTPSESSION->AEMPRESA:cCBASE
        OWSBOL:oWSABOLETO:cCGC       := HTTPPOST->CGC
        OWSBOL:oWSABOLETO:dEMISSAO   := DATE()
        OWSBOL:oWSABOLETO:cNATUREZ   := '003'
        OWSBOL:oWSABOLETO:cNUMERO    := 'CNPJ' //**** Ira gravar o CNPJ como numero Sequencial do SZ9 ***
        OWSBOL:oWSABOLETO:cPARCELA   := ''
        OWSBOL:oWSABOLETO:cSINDIC    := HTTPSESSION->AEMPRESA:cCSINDICA
        OWSBOL:oWSABOLETO:nVALOR     := nValor
        OWSBOL:oWSABOLETO:dVENCTO    := HTTPPOST->DVENCTO
        OWSBOL:oWSABOLETO:cE1NUM     := ''

		If  !( OWSBOL:GRAVADADO() )
       	
       		If  Empty(GetWSCError(3))
       			HTTPPOST->ERRO := "Problema de Comunicação com o Servidor! Favor tentar novamente ou entrar em contato com FEHOESP."
       		Else
				HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
			EndIf
				
			cHtml := ExecInPage("ERRO")			
			Exit
		EndIf
		
		HTTPPOST->TIT := OWSBOL:cGRAVADADORESULT
		cHtml := ExecInPage("BOLSIND")			
		Exit
			                        
			
	ElseIf HTTPSESSION->TPBOLETO == '2' //CONFEDERATIVA
	        
	
		CODIGO 				:= HTTPGET->CODIGO
		
		HTTPPOST->TFUNCS := IF(HTTPGET->RFUNC == '1', "SIM", "NAO")
		
		OWSBOL:LLRETURN := .T.
		OWSBOL:CCODIGO  := CODIGO
		OWSBOL:CITEM 	 := ''
		OWSBOL:oWSAEMPRESA := HTTPSESSION->AEMPRESA:CLONE()

		If  !( OWSBOL:DADOSCONF() ) 
			HTTPPOST->ERRO := "Base de Cálculo Nao Definida"
			cHtml := ExecInPage("ERRO")
			Exit
		EndIf
		
		For NX := 1 to Len(OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF)

			HTTPPOST->FOLHA 		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:cMESFOLHA + '/' + OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CANO
			HTTPPOST->MESFOLHA 	:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CMESFOLHA
			HTTPPOST->DATAVENC 	:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:DVENORIG
			HTTPPOST->DATAPAGTO	:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:DDTPAGTO
			HTTPPOST->PARCELA	:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CPARCELA
			HTTPPOST->ANO		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CANO
			
			aDadosParcela 		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CPARCELA
			aDadosAno	  		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CANO

            CVALOR				:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CVLMIN
            NPORCENT			:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:NPORCENT
            
            lAcrescimo			:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:lAPLACR
            nJurosMes			:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:nJUROMES
            nMulta				:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:nMULTA

            //**** Mensagens do Boleto ***                                 
	        HTTPPOST->MSG1		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CMSG1
	        HTTPPOST->MSG2		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CMSG2
	        HTTPPOST->MSG3		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CMSG3
	        HTTPPOST->MSG4		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CMSG4
	        HTTPPOST->MSG5		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CMSG5
	        HTTPPOST->MSG6		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CMSG6
	        HTTPPOST->MSG7		:= OWSBOL:OWSDADOSCONFRESULT:OWSSCCONF[NX]:CMSG7
	         
            OWSBOL:CSINDICA 		:= HTTPSESSION->AEMPRESA:CCSINDICA 
                  
			If  !( OWSBOL:BUSCACONF() )
				HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
				cHtml := ExecInPage("ERRO")
				Exit
			EndIf	
                                              
            cLink := '<a href="http://' + Lower(OWSBOL:oWSBUSCACONFRESULT:CLINK) + '">' + Lower(OWSBOL:oWSBUSCACONFRESULT:CLINK) + '</a>'
	        cData := DtoC(HTTPPOST->DATAPAGTO)
	         
	        //**** Substituicao dos Dados das Mensagens ***
	        //**** XXXXX = Data Valida do Boleto
	        //**** ZZZZZ = Link do site do sindicato
	         
	        HTTPPOST->MSG1		:= StrTran(StrTran(HTTPPOST->MSG1,"XXXXX", cData), "ZZZZZ", cLink)
	        HTTPPOST->MSG2		:= StrTran(StrTran(HTTPPOST->MSG2,"XXXXX", cData), "ZZZZZ", cLink)
			HTTPPOST->MSG3		:= StrTran(StrTran(HTTPPOST->MSG3,"XXXXX", cData), "ZZZZZ", cLink)
			HTTPPOST->MSG4		:= StrTran(StrTran(HTTPPOST->MSG4,"XXXXX", cData), "ZZZZZ", cLink)
			HTTPPOST->MSG5		:= StrTran(StrTran(HTTPPOST->MSG5,"XXXXX", cData), "ZZZZZ", cLink)
			HTTPPOST->MSG6		:= StrTran(StrTran(HTTPPOST->MSG6,"XXXXX", cData), "ZZZZZ", cLink)
			HTTPPOST->MSG7		:= StrTran(StrTran(HTTPPOST->MSG7,"XXXXX", cData), "ZZZZZ", cLink)
			
			aDadosMensagem1	:= HTTPPOST->MSG1
			aDadosMensagem2	:= HTTPPOST->MSG2
			aDadosMensagem3	:= HTTPPOST->MSG3
			aDadosMensagem4	:= HTTPPOST->MSG4
			aDadosMensagem5	:= HTTPPOST->MSG5
			aDadosMensagem6	:= HTTPPOST->MSG6
			aDadosMensagem7	:= HTTPPOST->MSG7
			//***//

    		aDadosSDNome        := OWSBOL:oWSBUSCACONFRESULT:CSDNOME
        
			HTTPPOST->SDNOME   := OWSBOL:oWSBUSCACONFRESULT:CSDNOME 
	        HTTPPOST->SDEND	   := OWSBOL:oWSBUSCACONFRESULT:CSDEND
		    HTTPPOST->SDNUMEND := SUBSTR(OWSBOL:oWSBUSCACONFRESULT:CSDEND,AT(",",OWSBOL:oWSBUSCACONFRESULT:CSDEND)+1,LEN(OWSBOL:oWSBUSCACONFRESULT:CSDEND))			
			HTTPPOST->SDCOMPL  := ''			                                            
			HTTPPOST->SDBAIRRO := OWSBOL:oWSBUSCACONFRESULT:CSDBAIRRO
			HTTPPOST->SDCEP    := ALLTRIM(transform(OWSBOL:oWSBUSCACONFRESULT:CSDCEP, '@R 99999-999'))   
			HTTPPOST->SDMUN    := OWSBOL:oWSBUSCACONFRESULT:CSDMUN   
			HTTPPOST->SDEST    := OWSBOL:oWSBUSCACONFRESULT:CSDEST 
			HTTPPOST->SDCGC    := ALLTRIM(transform(OWSBOL:oWSBUSCACONFRESULT:CSDCGC, '@R 99.999.999/9999-99'))
		    HTTPPOST->SDENTIDA := ALLTRIM(transform(OWSBOL:oWSBUSCACONFRESULT:CSDENTIDA, '@R 999.999.99999-9'))
						  
      		HTTPPOST->LOGOTIPO  := OWSBOL:oWSBUSCACONFRESULT:CIMAGEM
        	nPos := RAT('\',OWSBOL:oWSBUSCACONFRESULT:CIMAGEM)
        
        	If  (nPos > 0)
        		HTTPPOST->LOGOTIPO  := RIGHT(OWSBOL:oWSBUSCACONFRESULT:CIMAGEM, Len(OWSBOL:oWSBUSCACONFRESULT:CIMAGEM)-nPos)
        	EndIf
							        
       	    aDadosLogoTipo      := HTTPPOST->LOGOTIPO
							        
			HTTPPOST->CODBCO	:= OWSBOL:oWSBUSCACONFRESULT:CCODBCO            
		    HTTPPOST->AGENCIA	:= OWSBOL:oWSBUSCACONFRESULT:cAGENCIA
		    HTTPPOST->CONTA 	:= OWSBOL:oWSBUSCACONFRESULT:CCONTA
		    
		    aDadosAgencia  	:= OWSBOL:oWSBUSCACONFRESULT:cAGENCIA
		    aDadosConta		:= OWSBOL:oWSBUSCACONFRESULT:CCONTA
		        
			/*
				(Valor Bruto da Folha * % SIND) < Valor Mínimo 
				 -> Valor do Título deve ser o valor mínimo atribuído no campo "Valor Mínimo" da 
				    tabela "Base de Cálculo Contrib. Confederativa"					
			*/
		    nVlrAliq := ((VAL(NAUX)*NPORCENT)/100)
		    nVlrMin  := VAL(CVALOR)

			If  ((HTTPPOST->TFUNCS != "SIM") .Or. (nVlrAliq < nVlrMin))
				                                  
				nValor := nVlrMin
				
			Else
			/*
				(Valor Bruto da Folha * % SIND) >= Valor Mínimo 
				-> Valor do Título deve ser o Valor Bruto da Folha * % Do Sindicato
			*/                                     

			   nValor := nVlrAliq

			EndIf
						
			HTTPPOST->VALOR := StrTran(Alltrim(Str(nValor,15,2)),'.',',')
			
			aDadosValorDocumento := StrTran(Alltrim(Str(nValor,15,2)),'.',',')
			
		    HTTPPOST->VLRCOBR   := "0"
		    HTTPPOST->MORAMULTA := "0"

			If  lAcrescimo .And. (Date() > HTTPPOST->DATAVENC)
			
				 nValorMulta := ((nValor * nMulta) / 100)
				                                                       
				 //**** Juros apos o vencimento + Numero de Meses ***
				 nMeses      := Int((Date() - HTTPPOST->DATAVENC)/30)
				 nResto      := (((Date() - HTTPPOST->DATAVENC)/30) - nMeses)
				 nMeses      += If(nResto > 0, 1, 0) //**** Passou 30 dias mais 1 mes ***
				 nValorJuros := ((nValor * (nMeses * nJurosMes)) / 100)
				 
				 nValor		 += (nValorMulta + nValorJuros)
				 
				HTTPPOST->MORAMULTA := StrTran(Alltrim(Str(nValorMulta + nValorJuros,15,2)),'.',',')
	
				HTTPPOST->VLRCOBR   := StrTran(Alltrim(Str(nValor,15,2)),'.',',')
				
				dVencto := HTTPPOST->DATAVENC
			
			Else
			
			    dVencto := 	HTTPPOST->DATAPAGTO
			
			EndIf
						
			aDadosDtPagto       := dVencto

			aDadosMoraMulta		:= Transform((nValorMulta + nValorJuros),'@R 999,999,999.99')
			
			aDadosValorCobrado  := Transform(nValor,'@R 999,999,999.99')
					
            OWSBOL:oWSABOLETO:cANO 	   := HTTPPOST->ANO
            OWSBOL:oWSABOLETO:cBASE    := HTTPSESSION->AEMPRESA:cCBASE
            OWSBOL:oWSABOLETO:cCGC     := HTTPPOST->CGC
            OWSBOL:oWSABOLETO:dEMISSAO := DATE()
            OWSBOL:oWSABOLETO:cNATUREZ := '002'
            OWSBOL:oWSABOLETO:cNUMERO  := '8000' //**** Confederativa prefixo 8000 ***
            OWSBOL:oWSABOLETO:cPARCELA := Right(HTTPPOST->ANO,2) + ' ' + HTTPPOST->PARCELA
            OWSBOL:oWSABOLETO:cSINDIC  := HTTPSESSION->AEMPRESA:cCSINDICA
            OWSBOL:oWSABOLETO:nVALOR   := VAL(Alltrim(Str(nValor,15,2)))
            OWSBOL:oWSABOLETO:dVENCTO  := dVencto
            OWSBOL:oWSABOLETO:cE1NUM   := ''
            
       		If  !( OWSBOL:GRAVADADO() )
	       		If  Empty(GetWSCError(3))
	       			HTTPPOST->ERRO := "Problema de Comunicação com o Servidor! Favor tentar novamente ou entrar em contato com FEHOESP."
	       		Else
					HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
				EndIf
				
				cHtml := ExecInPage("ERRO")
				Exit
       		EndIf
           		
//			Conout("GERABOL: HTTPPOST->RAIZURL: " + HTTPPOST->RAIZURL)

   		    aDadosMensBoleto  := "CONTRIBUICAO CONFEDERATIVA - " + aDadosParcela + " a Parcela de " + aDadosAno

			HTTPPOST->TIT     := OWSBOL:cGRAVADADORESULT
			
			aDadosTitulo      := OWSBOL:cGRAVADADORESULT
			
			aDadosCarteira    := "57"
			
			aDadosNumDoc      := aDadosTitulo
			
			aDadosNossoNumero := '8000' + Right(Replicate("0",9)+aDadosTitulo,9)
			
			cHtml := ExecInPage("BOLCONF")
                                   
/*
        	If  (HTTPPOST->CODBCO == '356')  
				cHtml := w_SHBOLBR()	//**** Banco Real ***
			Else
				cHtml := w_SHBOLCEF()	//**** Banco Caixa Economica Federal ***
			EndIf	
*/			

			Exit				
	
		Next NX
		
		Exit
		
	ElseIf (HTTPSESSION->TPBOLETO == '3') //ASSOCIATIVA / ASSOCIATIVA CONFEDERATIVA
	
		OWSBOL:oWSAPEDIDO:cCLIENTE := HTTPSESSION->AEMPRESA:CCCODIGO 
		OWSBOL:oWSAPEDIDO:cFILIAL  := HTTPGET->FILIAL
		OWSBOL:oWSAPEDIDO:cLOJA    := HTTPSESSION->AEMPRESA:CCLOJA
		OWSBOL:oWSAPEDIDO:cNATUREZ := HTTPGET->NATUREZ
		OWSBOL:oWSAPEDIDO:cNUMERO  := HTTPGET->NUMERO
		OWSBOL:oWSAPEDIDO:cPARCELA := HTTPGET->PARCELA
		OWSBOL:oWSAPEDIDO:cPREFIXO := HTTPGET->PREFIXO
		OWSBOL:oWSAEMPRESA		   := HTTPSESSION->AEMPRESA:CLONE()   
		
		aDadosParcela 		:= HTTPGET->PARCELA
		aDadosAno	  		:= HTTPGET->ANO
		
		IF  !( OWSBOL:DADOSASSO() )
			HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
			cHtml := ExecInPage("ERRO")		
			Exit
		EndIf

	    HTTPPOST->VALOR 	:= alltrim(OWSBOL:oWSDADOSASSORESULT:CVALOR)

		HTTPPOST->NUMTIT 	:= OWSBOL:oWSDADOSASSORESULT:CNUMTIT
		HTTPPOST->NATUREZ	:= OWSBOL:oWSDADOSASSORESULT:CNATUREZ
		HTTPPOST->PREFIXO	:= OWSBOL:oWSDADOSASSORESULT:CPREFIXO
		HTTPPOST->CODBCO	:= OWSBOL:oWSDADOSASSORESULT:CCODBCO
		HTTPPOST->NOMEBCO	:= OWSBOL:oWSDADOSASSORESULT:CNOMEBCO
		HTTPPOST->AGENCIA	:= OWSBOL:oWSDADOSASSORESULT:CAGENCIA
		HTTPPOST->CONTA		:= OWSBOL:oWSDADOSASSORESULT:CCONTA
		HTTPPOST->MOEDA		:= OWSBOL:oWSDADOSASSORESULT:CMOEDA
		                 
		HTTPPOST->DVENCTO   := OWSBOL:oWSDADOSASSORESULT:dVENCTO
		HTTPPOST->DTPGTO	:= HTTPGET->VENCORI
		
   		aDadosSDNome        := OWSBOL:oWSDADOSASSORESULT:CSDNOME
   		
	    aDadosAgencia  		:= OWSBOL:oWSDADOSASSORESULT:CAGENCIA
	    aDadosConta			:= OWSBOL:oWSDADOSASSORESULT:CCONTA
		        
		HTTPPOST->SDNOME   	:= OWSBOL:oWSDADOSASSORESULT:CSDNOME 
        HTTPPOST->SDEND	 	:= OWSBOL:oWSDADOSASSORESULT:CSDEND
        HTTPPOST->SDNUMEND 	:= OWSBOL:oWSDADOSASSORESULT:CSDEND
		HTTPPOST->SDCOMPL  	:= ''			                                            
		HTTPPOST->SDBAIRRO 	:= OWSBOL:oWSDADOSASSORESULT:CSDBAIRRO
		HTTPPOST->SDCEP    	:= ALLTRIM(transform(OWSBOL:oWSDADOSASSORESULT:CSDCEP, '@R 99999-999'))   
		HTTPPOST->SDMUN    	:= OWSBOL:oWSDADOSASSORESULT:CSDMUN   
		HTTPPOST->SDEST    	:= OWSBOL:oWSDADOSASSORESULT:CSDEST 
		HTTPPOST->SDCGC    	:= ALLTRIM(transform(OWSBOL:oWSDADOSASSORESULT:CSDCGC, '@R 99.999.999/9999-99'))			
	    HTTPPOST->SDENTIDA  := ALLTRIM(transform(OWSBOL:oWSDADOSASSORESULT:CSDENTIDA, '@R 999.999.99999-9'))
		
//		Conout("GERABOL: HTTPPOST->RAIZURL: " + HTTPPOST->RAIZURL)

        //**** Mensagens do Boleto ***                                 
		HTTPPOST->MSG1	:= OWSBOL:oWSDADOSASSORESULT:CMSG1
        HTTPPOST->MSG2	:= OWSBOL:oWSDADOSASSORESULT:CMSG2
        HTTPPOST->MSG3	:= OWSBOL:oWSDADOSASSORESULT:CMSG3
        HTTPPOST->MSG4	:= OWSBOL:oWSDADOSASSORESULT:CMSG4
        HTTPPOST->MSG5	:= OWSBOL:oWSDADOSASSORESULT:CMSG5
        HTTPPOST->MSG6	:= OWSBOL:oWSDADOSASSORESULT:CMSG6
        HTTPPOST->MSG7	:= OWSBOL:oWSDADOSASSORESULT:CMSG7
		         
        cLink := '<a href="http://' + Lower(OWSBOL:oWSDADOSASSORESULT:CLINK) + '">' + Lower(OWSBOL:oWSDADOSASSORESULT:CLINK) + '</a>'
        cData := HTTPPOST->DTPGTO
		         
        //**** Substituicao dos Dados das Mensagens ***
        //**** XXXXX = Data Valida do Boleto
        //**** ZZZZZ = Link do site do sindicato
		         
        HTTPPOST->MSG1	:= StrTran(StrTran(HTTPPOST->MSG1,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG2	:= StrTran(StrTran(HTTPPOST->MSG2,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG3	:= StrTran(StrTran(HTTPPOST->MSG3,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG4	:= StrTran(StrTran(HTTPPOST->MSG4,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG5	:= StrTran(StrTran(HTTPPOST->MSG5,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG6	:= StrTran(StrTran(HTTPPOST->MSG6,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG7	:= StrTran(StrTran(HTTPPOST->MSG7,"XXXXX", cData), "ZZZZZ", cLink)

		aDadosMensagem1	:= HTTPPOST->MSG1
		aDadosMensagem2	:= HTTPPOST->MSG2
		aDadosMensagem3	:= HTTPPOST->MSG3
		aDadosMensagem4	:= HTTPPOST->MSG4
		aDadosMensagem5	:= HTTPPOST->MSG5
		aDadosMensagem6	:= HTTPPOST->MSG6
		aDadosMensagem7	:= HTTPPOST->MSG7
		//***//

   		HTTPPOST->LOGOTIPO  := OWSBOL:oWSDADOSASSORESULT:CIMAGEM
       	nPos := RAT('\',OWSBOL:oWSDADOSASSORESULT:CIMAGEM)
        
       	If  (nPos > 0)
       		HTTPPOST->LOGOTIPO  := RIGHT(OWSBOL:oWSDADOSASSORESULT:CIMAGEM, Len(OWSBOL:oWSDADOSASSORESULT:CIMAGEM)-nPos)
       	EndIf
			   
   	    aDadosLogoTipo  := HTTPPOST->LOGOTIPO
							        
      	lAcrescimo	:= OWSBOL:oWSDADOSASSORESULT:lAPLACR
        nJurosMes	:= OWSBOL:oWSDADOSASSORESULT:nMORA
        nMulta		:= OWSBOL:oWSDADOSASSORESULT:nMULTA

		nValor 		:= VAL(HTTPPOST->VALOR)
		
		aDadosValorDocumento := StrTran(Alltrim(Str(nValor,15,2)),'.',',')
			
		HTTPPOST->MORAMULTA := "0"
		
		HTTPPOST->VLRCOBR   := "0"
			
		aDadosMoraMulta		:= "0"
			
		aDadosValorCobrado  := "0"
					
		If  lAcrescimo .And. (Date() > HTTPPOST->DVENCTO)
				
			nValorMulta := ((nValor * nMulta) / 100)
					                                                       
			//**** Juros apos o vencimento + Numero de Meses ***
			nMeses      := Int((Date() - HTTPPOST->DVENCTO)/30)
			nResto      := (((Date() - HTTPPOST->DVENCTO)/30) - nMeses)
			nMeses      += If(nResto > 0, 1, 0) //**** Passou 30 dias mais 1 mes ***
			nValorJuros := ((nValor * (nMeses * nJurosMes)) / 100)
					 
			nValor		 += (nValorMulta + nValorJuros)
					 
			HTTPPOST->MORAMULTA := StrTran(Alltrim(Str(nValorMulta + nValorJuros,15,2)),'.',',')
		
			HTTPPOST->VLRCOBR := StrTran(Alltrim(Str(nValor,15,2)),'.',',')
			
			HTTPPOST->DTPGTO  := DtoC(HTTPPOST->DVENCTO)
		
			aDadosMoraMulta		:= Transform((nValorMulta + nValorJuros),'@R 999,999,999.99')
				
			aDadosValorCobrado  := Transform(nValor,'@R 999,999,999.99')
						
		EndIf
			
		aDadosDtPagto       := CtoD(HTTPPOST->DTPGTO)

        OWSBOL:oWSABOLETO:cANO 	     := HTTPGET->ANO
        OWSBOL:oWSABOLETO:cBASE      := HTTPSESSION->AEMPRESA:cCBASE
        OWSBOL:oWSABOLETO:cCGC       := HTTPPOST->CGC
        OWSBOL:oWSABOLETO:dEMISSAO   := DATE()
        OWSBOL:oWSABOLETO:cNATUREZ   := '001'
        OWSBOL:oWSABOLETO:cNUMERO    := If(HTTPPOST->SINDICATO == '01', '7000', '8000') //**** Associativa prefixo SindHosp = 7000 / Outros = 8000 ***
        OWSBOL:oWSABOLETO:cPARCELA   := Right(HTTPGET->ANO,2) + ' ' + HTTPGET->PARCELA
        OWSBOL:oWSABOLETO:cSINDIC    := HTTPSESSION->AEMPRESA:cCSINDICA
        OWSBOL:oWSABOLETO:nVALOR     := nValor
        OWSBOL:oWSABOLETO:dVENCTO    := CtoD(HTTPPOST->DTPGTO)
        OWSBOL:oWSABOLETO:cE1NUM     := HTTPPOST->PREFIXO + HTTPPOST->NUMTIT + HTTPGET->PARCELA
           		
       	If  !( OWSBOL:GRAVADADO() )
       	
       		If  Empty(GetWSCError(3))
       			HTTPPOST->ERRO := "Problema de Comunicação com o Servidor! Favor tentar novamente ou entrar em contato com FEHOESP."
       		Else
				HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
			EndIf
				
			cHtml := ExecInPage("ERRO")
			Exit
   		EndIf
   		
   		nMes := Val(Left(HTTPPOST->NUMTIT,2))
   		
   		cMens := If(Alltrim(HTTPPOST->NATUREZ) == "001", "", "CONFEDERATIVA")
   		
   		aDadosMensBoleto  := "CONTRIBUICAO ASSOCIATIVA " + cMens + " - " + UPPER(aMeses[nMes]) + " DE " + aDadosAno

		HTTPPOST->TIT	  := OWSBOL:cGRAVADADORESULT

		aDadosTitulo      := OWSBOL:cGRAVADADORESULT
			
		aDadosCarteira    := "175"
		
		aDadosNumDoc      := HTTPPOST->PREFIXO + " " + HTTPPOST->NUMTIT

		aDadosNossoNumero := If(aDadosSindicato == '01', '7000', '8000') + Right(Replicate("0",9)+aDadosTitulo,9)
			
		cHtml := ExecInPage("BOLASSO")            		

/*
        	If  (HTTPPOST->CODBCO == '356')  
				cHtml := w_SHBOLBR()	//**** 356 - Banco Real ***
			Else
				cHtml := w_SHBOLITAU()	//**** 341 - Banco Itau ***
			EndIf	
*/

        Exit
			
	ElseIf (HTTPSESSION->TPBOLETO == '4')  //ASSISTENCIAL/NEGOCIAL
	
		CODIGO 	:= HTTPGET->CODIGO

  		HTTPPOST->TFUNCS := IIF (HTTPPOST->NFUNC == "1", "SIM","NAO")
  		
  		If  (HTTPPOST->NFUNC == "2")
  			 HTTPPOST->ERRO := "Empresa sem empregados, deve fazer recolhimento da Contribuição Confederativa no valor mínimo!"
			 cHtml := ExecInPage("ERRO")
			 Exit
		EndIf					
		
		If  (Val(NAUX) <= 0)
  			 HTTPPOST->ERRO := "Valor da Folha não informada!"
			 cHtml := ExecInPage("ERRO")
			 Exit
		EndIf					
		
	    		    		
		OWSBOL:LLRETURN := .T.
		OWSBOL:CCODIGO  := CODIGO
		OWSBOL:CITEM 	 := ''
		OWSBOL:oWSAEMPRESA := HTTPSESSION->AEMPRESA:CLONE()
		OWSBOL:CSINDICA := HTTPSESSION->AEMPRESA:CCSINDICA

  		I := VAL(HTTPGET->ITEM)
        
		If  !( OWSBOL:DADOSNEG() )
       	 	If  Empty(GetWSCError(3))
       	 	  	HTTPPOST->ERRO := "Problema de Comunicação com o Servidor! Favor tentar novamente ou entrar em contato com FEHOESP."
       	 	Else
			 	HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
			EndIf
				
			cHtml := ExecInPage("ERRO")
			Exit
		EndIf					
	        
		HTTPPOST->SDNOME   	:= OWSBOL:oWSDADOSNEGRESULT:CSDNOME 
      	HTTPPOST->SDEND	    := OWSBOL:oWSDADOSNEGRESULT:CSDEND
      	HTTPPOST->SDNUMEND 	:= OWSBOL:oWSDADOSNEGRESULT:CSDEND
		HTTPPOST->SDCOMPL  	:= ''			                                            
		HTTPPOST->SDBAIRRO 	:= OWSBOL:oWSDADOSNEGRESULT:CSDBAIRRO
		HTTPPOST->SDCEP    	:= ALLTRIM(transform(OWSBOL:oWSDADOSNEGRESULT:CSDCEP, '@R 99999-999'))   
		HTTPPOST->SDMUN    	:= OWSBOL:oWSDADOSNEGRESULT:CSDMUN   
		HTTPPOST->SDEST    	:= OWSBOL:oWSDADOSNEGRESULT:CSDEST
		HTTPPOST->SDCGC    	:= Transform(OWSBOL:oWSDADOSNEGRESULT:CSDCGC, '@R 99.999.999/9999-99')
	   	HTTPPOST->SDENTIDA  := ALLTRIM(transform(OWSBOL:oWSDADOSNEGRESULT:CSDENTIDA, '@R 999.999.99999-9'))
		HTTPPOST->CODBCO	:= OWSBOL:oWSDADOSNEGRESULT:CCODBCO
		HTTPPOST->NOMEBCO	:= OWSBOL:oWSDADOSNEGRESULT:CNOMEBCO
		HTTPPOST->CONTA		:= OWSBOL:oWSDADOSNEGRESULT:CCONTA
		HTTPPOST->AGENCIA	:= OWSBOL:oWSDADOSNEGRESULT:CAGENCIA
		HTTPPOST->MOEDA		:= OWSBOL:oWSDADOSNEGRESULT:CMOEDA

      	HTTPPOST->LOGOTIPO  := OWSBOL:oWSDADOSNEGRESULT:CIMAGEM
      	
        nPos := RAT('\',OWSBOL:oWSDADOSNEGRESULT:CIMAGEM)
        
        If  (nPos > 0)
        	HTTPPOST->LOGOTIPO  := RIGHT(OWSBOL:oWSDADOSNEGRESULT:CIMAGEM, Len(OWSBOL:oWSDADOSNEGRESULT:CIMAGEM)-nPos)
        EndIf
							        
		HTTPPOST->FOLHA 	:= HTTPSESSION->AASSIST[I]:CVLFOLHA
		HTTPPOST->MESFOLHA 	:= SUBSTR(HTTPSESSION->AASSIST[I]:CMESANO,1,2)
		HTTPPOST->DTVENCTO 	:= HTTPSESSION->AASSIST[I]:DVENCORI
		HTTPPOST->DTPAGTO  	:= HTTPSESSION->AASSIST[I]:DDTPAGTO
		HTTPPOST->PARCELA	:= HTTPSESSION->AASSIST[I]:CPARCELA
		HTTPPOST->ANO		:= SUBSTR(HTTPSESSION->AASSIST[I]:CMESANO,4,4)

		HTTPPOST->CODBCO := OWSBOL:oWSDADOSNEGRESULT:CCODBCO  
		
		cCedente := Alltrim(OWSBOL:oWSDADOSNEGRESULT:CCONTA)
  	   	If  Empty(cCedente)
      	 	HTTPPOST->ERRO := "Conta não definida no Cadastro de Sindicato!"
	
			cHtml := ExecInPage("ERRO")
			Exit
       	EndIf	 
		nPos := At("-", cCedente)
		nTam := If(nPos > 0, nPos-1, Len(cCedente))
		cCedente := Replicate("0", 7-nTam) + cCedente

      	HTTPPOST->CEDENTE		:= cCedente
      	
		/*
			(Valor Bruto da Folha * % SIND) < Valor Mínimo 
			 -> Valor do Título deve ser o valor mínimo atribuído no campo "Valor Mínimo" da 
			    tabela "Base de Cálculo Contrib. Assistencial/Negocial"					
		*/
      	nVLRMinimo	:= HTTPSESSION->AASSIST[I]:nVLMIN

		/*
			(Valor Bruto da Folha * % SIND) >= Valor Mínimo 
				-> Valor do Título deve ser o Valor Bruto da Folha * % Do Sindicato
		*/   
		nVlrFolha := (Val(NAUX) * (HTTPSESSION->AASSIST[I]:NDESCONT/100))
			
		nValor := If(nVlrFolha < nVLRMinimo, nVLRMinimo, nVlrFolha)
			
		HTTPPOST->VALOR     := StrTran(Alltrim(Str(nValor,15,2)),'.',',')
		
     	lAcrescimo	:= (HTTPSESSION->AASSIST[I]:cAPLACR == '1')
      	nJurosMes	:= HTTPSESSION->AASSIST[I]:nJUROS
      	nMulta		:= HTTPSESSION->AASSIST[I]:nMULTA
      
      	nValorMulta := 0
      	nValorJuros := 0
      
		HTTPPOST->MORAMULTA := "0"
		
		HTTPPOST->VLRCOBR   := "0"

		If  lAcrescimo .And. (Date() > HTTPPOST->DTVENCTO)
				
			nValorMulta := ((nValor * nMulta) / 100)
					                                                       
			//**** Juros apos o vencimento + Numero de Meses ***
			nMeses      := Int((Date() - HTTPPOST->DTVENCTO)/30) 
			nResto      := (((Date() - HTTPPOST->DTVENCTO)/30) - nMeses)
			nMeses      += If(nResto > 0, 1, 0) //**** Passou 30 dias mais 1 mes ***
			nValorJuros := ((nValor * (nMeses * nJurosMes)) / 100)
					 
			nValor	 	+= (nValorMulta + nValorJuros)
			
			HTTPPOST->MORAMULTA := StrTran(Alltrim(Str(nValorMulta + nValorJuros,15,2)),'.',',')
			
			HTTPPOST->VLRCOBR := StrTran(Alltrim(Str(nValor,15,2)),'.',',')

		Else	
		
			HTTPPOST->DTVENCTO := HTTPPOST->DTPAGTO
					 
		EndIf
				
		HTTPPOST->CORRMON   := "0"
		


        //**** Mensagens do Boleto ***                                 
		HTTPPOST->MSG1		:= HTTPSESSION->AASSIST[I]:CMSG1
        HTTPPOST->MSG2		:= HTTPSESSION->AASSIST[I]:CMSG2
        HTTPPOST->MSG3		:= HTTPSESSION->AASSIST[I]:CMSG3
        HTTPPOST->MSG4		:= HTTPSESSION->AASSIST[I]:CMSG4
        HTTPPOST->MSG5		:= HTTPSESSION->AASSIST[I]:CMSG5
        HTTPPOST->MSG6		:= HTTPSESSION->AASSIST[I]:CMSG6
        HTTPPOST->MSG7		:= HTTPSESSION->AASSIST[I]:CMSG7
		         
        cLink := '<a href="http://' + Lower(OWSBOL:oWSDADOSNEGRESULT:CLINK) + '">' + Lower(OWSBOL:oWSDADOSNEGRESULT:CLINK) + '</a>'
        cData := DtoC(HTTPPOST->DTPAGTO)
		         
        //**** Substituicao dos Dados das Mensagens ***
        //**** XXXXX = Data Valida do Boleto
        //**** ZZZZZ = Link do site do sindicato
		         
        HTTPPOST->MSG1		:= StrTran(StrTran(HTTPPOST->MSG1,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG2		:= StrTran(StrTran(HTTPPOST->MSG2,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG3		:= StrTran(StrTran(HTTPPOST->MSG3,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG4		:= StrTran(StrTran(HTTPPOST->MSG4,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG5		:= StrTran(StrTran(HTTPPOST->MSG5,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG6		:= StrTran(StrTran(HTTPPOST->MSG6,"XXXXX", cData), "ZZZZZ", cLink)
        HTTPPOST->MSG7		:= StrTran(StrTran(HTTPPOST->MSG7,"XXXXX", cData), "ZZZZZ", cLink)
		//***//
		
        OWSBOL:oWSABOLETO:cANO 	  	 := HTTPPOST->ANO
        OWSBOL:oWSABOLETO:cBASE      := HTTPSESSION->AEMPRESA:cCBASE
        OWSBOL:oWSABOLETO:cCGC       := HTTPPOST->CGC
        OWSBOL:oWSABOLETO:dEMISSAO   := DATE()
        OWSBOL:oWSABOLETO:cNATUREZ   := '0301' //HTTPSESSION->AEMPRESA:CCNATUREZ
        If  (HTTPPOST->CODBCO == '237')  //**** Bradesco ***
        	OWSBOL:oWSABOLETO:cNUMERO    := '90' //**** Assistencial/Negocial prefixo 90 (Bradesco usa 11 digitos em nossonumero) ***
        Else	
        	OWSBOL:oWSABOLETO:cNUMERO    := '8000' //**** Assistencial/Negocial prefixo 8000 (mesmo da Confederativa) ***
        EndIf	
        OWSBOL:oWSABOLETO:cPARCELA   := Right(HTTPPOST->ANO,2) + ' ' + HTTPPOST->PARCELA
        OWSBOL:oWSABOLETO:cSINDIC    := HTTPSESSION->AEMPRESA:cCSINDICA
        OWSBOL:oWSABOLETO:nVALOR     := nValor
        OWSBOL:oWSABOLETO:dVENCTO    := HTTPPOST->DTVENCTO
        OWSBOL:oWSABOLETO:cE1NUM     := ''
           		
   		If  !( OWSBOL:GRAVADADO() )
       		If  Empty(GetWSCError(3))
       			HTTPPOST->ERRO := "Problema de Comunicação com o Servidor! Favor tentar novamente ou entrar em contato com FEHOESP."
       		Else
				HTTPPOST->ERRO := Alltrim(Substr(GetWSCError(3),At(":",GetWSCError(3))+1,Len(GetWSCError(3))))    			
			EndIf
				
			cHtml := ExecInPage("ERRO")
			Exit
   		EndIf			
                                                  
		HTTPPOST->TIT	 := OWSBOL:cGRAVADADORESULT
		cHtml := ExecInPage("BOLNEG")
		Exit

	EndIf
     
	Exit
EndDo
                                      
Web Extended End


Return cHtml  
