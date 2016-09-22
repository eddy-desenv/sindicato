#INCLUDE "PROTHEUS.CH"
#INCLUDE "WEBEXDEF.CH"   
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"



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

	cHtml := ExecInPage("BOLETO")
                                      
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

Local cHtml 	:= ""
LOCAL CCGC 		:= HTTPPOST->CCGC
LOCAL OWS		:= WSSINDHOSP:NEW()
LOCAL ADADOS	:= {}		
LOCAL CMSG		:= ''
LOCAL NX		:= 0  
LOCAL AANO		:= {}
LOCAL ACONFED	:= {}
LOCAL AASSIST	:= {} 
LOCAL AASSOCI	:= {} 

Web Extended Init cHtml 

OWS:CCGC 	:= CCGC	            
ADADOS 		:= OWS:VERCADEMP()	

/* TIPOS DE BOLETOS 

 '1'-> SINDICAL
 '2'-> CONFEDERATIVA
 '3'-> ASSOCIATIVA
 '4'-> ASSOCIATIVA CONFEDERATIVA
 '5'-> ASSISTENCIAL/NEGOCIAL
		
*/  

IF LEN(ADADOS) > 0 //ENCONTROU A EMPRESA
    
    HTTPPOST->CCGC	  	:= ALLTRIM(OWS:AEMPRESA:CCGC)
    HTTPPOST->CRAZAO	:= ALLTRIM(OWS:AEMPRESA:CNOME)
    HTTPPOST->CCEP		:= ALLTRIM(OWS:AEMPRESA:CCEP)
    HTTPPOST->CEND		:= ALLTRIM(OWS:AEMPRESA:CEND)
    HTTPPOST->CBAIRRO	:= ALLTRIM(OWS:AEMPRESA:CBAIRRO)
    HTTPPOST->CMUN		:= ALLTRIM(OWS:AEMPRESA:CMUN)
    HTTPPOST->CEST		:= ALLTRIM(OWS:AEMPRESA:CUF)
    HTTPPOST->CEMAIL	:= ALLTRIM(OWS:AEMPRESA:CEMAIL)
    HTTPPOST->CTEL		:= ALLTRIM(OWS:AEMPRESA:CTEL)
    HTTPPOST->CFAX		:= ALLTRIM(OWS:AEMPRESA:CFAX)
    HTTPPOST->CCAPITAL	:= ALLTRIM(OWS:AEMPRESA:CCAPITAL)
    HTTPPOST->DINIATV	:= ALLTRIM(OWS:AEMPRESA:DINIATV)
    HTTPPOST->CCONTATO	:= ALLTRIM(OWS:AEMPRESA:CCONTATO)
    
    /* DADOS DA EMPRESA */
	HTTPSESSION->AEMPRESA := OWS:AEMPRESA
	
	DO CASE
		CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '125'
			IF OWS:AEMPRESA:DDTNASC == DDATABASE .AND. ALLTRIM(OWS:AEMPRESA:CINAT) == "X"  

/*************************************************************************************************************************************/
/*													S I N D I C A L																	 */ 
/*************************************************************************************************************************************/	

				IF ALLTRIM(HTTPPOST->TPBOLETO) == '1' //SINDICAL
					
					FOR NX := 0 TO 4
					    AADD(AANO,VAL(YEAR(DDATABASE))-NX)
					NEXT NX
					
					HTTPPOST->AANO 		:= AANO 
					HTTPPOST->CCAPITAL  := OWS:AEMPRESA:CCAPITAL
					HTTPPOST->DINIATV	:= OWS:AEMPRESA:DINIATV 
					cHtml := ExecInPage("GERABOL") 

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
					
					IF ALLTRIM(OWS:AEMPRESA:CNATUREZ) == '1000' .AND. (ALLTRIM(OWS:AEMPRESA:CSITUAC) == 'AS' .OR. ALLTRIM(OWS:AEMPRESA:CSITUAC) == 'SS')
						CMSG := 'Associado - Esta empresa já faz mensalmente o recolhimento desta contribuição confederativa juntamente com o pagamento da contribuição Associativa'
						cHtml := ExecInPage("BOLETO")
				    ELSE
                        /* MONTA A LISTA DE ANO/PARCEL */
					  	SZC->(DbOrderNickName("ANOPARCELA")) 
						IF SZC->(DBSEEK(XFILIAL("SZC")))  
                        	WHILE !SZC->(EOF())
                        		AADD(ACONFED,	{"FILIAL"	,SZC->ZC_FILIAL	},;
                        						{"CODIGO"	,SZC->ZC_CODIGO	},;
                        						{"ANO"		,SZC->ZC_ANO	},;
                        						{"PARCELA"	,SZC->ZC_PARCELA},;
                        						{"MESFOLHA"	,SZC->ZC_MESFOLH},;
                        						{"VLMIN"	,SZC->ZC_VLMIN	},;
                        						{"VENORIG"	,SZC->ZC_VLORIG },;
                        						{"MULTA"	,SZC->ZC_MULTA	},;
                        						{"JUROMES"	,SZC->ZC_JUROMES},;
                        						{"APLACR"	,SZC->ZC_APLZCR	},;
                        						{"DTPAGTO"	,SZC->ZC_DTPAGTO})
	                        	SZC->(DBSKIP())
	                        ENDDO
							
							//HTTPPOST->AANOPARCELA	:= AANO //PREENCHE O LISTBOX
							HTTPPOST->ACONFED	:= ACONFED
							cHtml := ExecInPage("GERABOL") 	                        
      					ELSE
      						//AANO := {}
      						ACONFED := {}
      						CMSG := "Base de Cálculo Nao Definida"
      						cHtml := ExecInPage("BOLETO")
      					ENDIF
				
					ENDIF

/*************************************************************************************************************************************/
/*												A S S I S T E N C I A L / N E G O C I A L	  										 */ 
/*************************************************************************************************************************************/	
					
                ELSEIF ALLTRIM(HTTPPOST->TPBOLETO) == '5' //ASSISTENCIAL/NEGOCIAL
				
					/* 	Se a natureza da empresa em questão (A1_NATUREZ) for igual a "1000" e a situação (A1_SITUAC) igual a "AS" ou "SS", 
						o site não deve disponibilizar a impressão do boleto e exibir um alerta com a seguinte mensagem: 
						"Associado - Esta empresa já faz mensalmente o recolhimento desta contribuição confederativa juntamente com o 
						pagamento da contribuição Associativa."
					*/

					IF ALLTRIM(OWS:AEMPRESA:CNATUREZ) == '1000' 
						IF (ALLTRIM(OWS:AEMPRESA:CSITUAC) == 'AS' .OR. ALLTRIM(OWS:AEMPRESA:CSITUAC) == 'SS')
						CMSG := 'Associado - Esta empresa já faz mensalmente o recolhimento desta contribuição confederativa juntamente com o pagamento da contribuição Associativa'
						cHtml := ExecInPage("BOLETO")
				    ELSE
                        /* MONTA A LISTA DE ANO/PARCELA */
					  	SZE->(DbOrderNickName("BASE")) 
						IF SZE->(DBSEEK(XFILIAL("SZE")+ALLTRIM(OWS:AEMPRESA:CBASE)))  
							SZF->(DbOrderNickName("ANOPARCELA")) 
							IF SZF->(DBSEEK(XFILIAL("SZF")+SZE->ZE_CODIGO))
	                        	WHILE !SZF->(EOF())
	                        		AADD(AASSIST,	{"FILIAL"	,SZF->ZF_FILIAL	},;
	                        						{"CODIGO"	,SZF->ZF_CODIGO	},;
	                        						{"MESANO"	,SZF->ZF_MESANO	},;
	                        						{"PARCELA"	,SZF->ZF_PARCELA},;
	                        						{"DTPAGTO"	,SZF->ZF_DTPAGTO},;
	                        						{"DESCONT"	,SZF->ZF_DESCONT},;
	                        						{"VLMIN"	,SZF->ZF_VLMIN	},;
	                        						{"VENCORI"	,SZF->ZF_VENCORI},;
	                        						{"MULTA"	,SZF->ZF_MULTA	},;
	                        						{"JUROS"	,SZF->ZF_JUROMES},;
	                        						{"APLACR"	,SZF->ZF_APLACR	})
		                        	SZF->(DBSKIP())
		                        ENDDO
								HTTPPOST->AASSIST	:= AASSIST
								cHtml := ExecInPage("GERABOL") 	                        
		                    ELSE
		                    	AASSIST := {} 
    	  						CMSG := "Base de Cálculo Nao Definida"
      							cHtml := ExecInPage("BOLETO")
		     				ENDIF
      					ELSE
      						ACONFED := {}
      						CMSG := "Base de Cálculo Nao Definida"
      						cHtml := ExecInPage("BOLETO")
      					ENDIF
					ENDIF
				ENDIF
				    
			ELSE
				CMSG := "Cliente inativo - Favor entrar em contato com o departamento de Cadastro, através do telefone (11) 3331-1555 na opção 7 ou e-mail: cadastro@sindhosp.com.br"  
				cHtml := ExecInPage("BOLETO") //MSG DE EMPRESA INATIVA
			ENDIF
			
		CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '34'
/*************************************************************************************************************************************/
/*														A S S O C I A T I V A 														 */ 
/*************************************************************************************************************************************/	
			IF ALLTRIM(HTTPPOST->TPBOLETO) == '3'  // ASSOCIATIVA
				IF (ALLTRIM(OWS:AEMPRESA:CSITUAC) <> 'AS' .OR. ALLTRIM(OWS:AEMPRESA:CSITUAC) <> 'SS')
					CMSG := "Esta empresa não é contribuinte, portanto não deve essa contribuição" 
					cHtml := ExecInPage("BOLETO")
				ELSE			
				
					/* TITULOS EM ABERTO
						* E1_Prefixo identifica nos dois primeiros digitos o ANO
						* E1_NUM identifica nos dois primeiros digitos o MES
						* E1_CGC identifica o titulo do cliente a ser impresso
						* E1_PREFIXO com o terceiro digito diferente de "T"
						* E1_NATUREZ igual a “001”				         
				    */
				
				  	SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
				  	AASSOCI := {}
					IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(OWS:AEMPRESA:CCODIGO,6)+PADR(OWS:AEMPRESA:CLOJA,2))) //ACHO UM TITULO
						WHILE !SE1->(EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(OWS:AEMPRESA:CCODIGO,6)+PADR(OWS:AEMPRESA:CLOJA,2)
							IF EMPTY(SE1->E1_BAIXA) .AND. ALLTRIM(SE1->E1_NATUREZ) == '001' 
								IF SUBSTR(ALLTRIM(SE1->E1_PREFIXO),LEN(SE1->E1_PREFIXO),1) <> 'T'
									AADD(AASSOCI,	{"ANO"		,SUBSTR(ALLTRIM(SE1->E1_PREFIXO),1,2)							},;
													{"MES"		,SUBSTR(ALLTRIM(SE1->E1_NUM),1,2)								},;
													{"VLTIT"	,SE1->E1_VALOR													},;
													{"VENCTO"	,SE1->E1_VENCTO													},;
													{"DTPAGTO"	,Posicione("SZG",1,xFilial("SZG")+SE1->E1_VENCTO,"ZG_VENCCON")	},;
													{"VENCREAL" ,SE1->E1_VENCREA		  										})
								ENDIF
							ENDIF
							SE1->(DBSKIP())
						ENDDO
					ENDIF
					
				ENDIF
				
			ELSE
			
			ENDIF			
			
			cHtml := ExecInPage("GERABOL")
	ENDCASE 

ELSE // NAO ENCONTROU A EMPRESA

	DO CASE
		CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '125'
			cHtml := ExecInPage("xxxx")      //TELA DE CADASTRO
	
		CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '34'
			CMSG := "CNPJ Não Localizado"
			cHtml := ExecInPage("BOLETO")
	ENDCASE 

ENDIF

Web Extended End

Return cHtml 
  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GERABOL   ºAutor  ³GISELE NUNCHERINO   º Data ³  03/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ROTINA DE GERACAO DOS BOLETOS			                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SINDHOSP                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Web Function GERABOL()

Local cHtml 	:= ''
LOCAL CCGC 		:= HTTPPOST->CCGC
LOCAL OWS		:= WSSINDHOSP:NEW()
LOCAL CMSG		:= ''
LOCAL CANOSEL	:= '' 
LOCAL LVALID	:= .F.      
LOCAL LAPLACR	:= .F.  //APLICA ACRESCIMO
LOCAL NVAL		:= 0
LOCAL NALIQ		:= 0 // ALIQUOTA PARA CALCULO DO BOLETO SINDICAL
LOCAL NADIC		:= 0 // ADICIONAL PARA CALCULO DO BOLETO SINDICAL
LOCAL ALAYOUT	:= {} 
LOCAL AAUX		:= {}  
LOCAL ADADOS	:= {} // ARRAY PARA GRAVAR A TABELA SZ9
LOCAL AQTDMES	:= {}

Web Extended Init cHtml 

OWS:CCGC 	:= ALLTRIM(CCGC)
OWS:VERCADEMP()	

/* TIPOS DE BOLETOS 

 '1'-> SINDICAL
 '2'-> CONFEDERATIVA
 '3'-> ASSOCIATIVA
 '4'-> ASSOCIATIVA CONFEDERATIVA
 '5'-> ASSISTENCIAL/NEGOCIAL
		
*/  

IF OWS:AEMPRESA <> NIL //ENCONTROU A EMPRESA
    
	DO CASE
		CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '125'
/*************************************************************************************************************************************/
/*													S I N D I C A L																	 */ 
/*************************************************************************************************************************************/	
			IF ALLTRIM(HTTPPOST->TPBOLETO) == '1'  // SINDICAL
				CANOSEL := HTTPPOST->CANO
				/* 
					Verificar se já existe pagamento na tabela SE1:
					1.	E1_Prefixo com os dois primeiros dígitos iguais aos dois últimos dígitos do ano selecionado para a impressão. 
					2.	E1_Naturez igual a "003" 
				*/				
			  	SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
				IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(OWS:AEMPRESA:CCODIGO,6)+PADR(OWS:AEMPRESA:CLOJA,2))) //ACHO UM TITULO
					WHILE !SE1->(EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(OWS:AEMPRESA:CCODIGO,6)+PADR(OWS:AEMPRESA:CLOJA,2)
						
						IF !EMPTY(SE1->E1_BAIXA) .AND. ALLTRIM(SE1->E1_NATUREZ) == '003' .AND. SUBSTR(ALLTRIM(SE1->E1_PREFIXO),1,2) == SUBSTR(STR(YEAR(STOD(CANOSEL))),3,2) //TITULO BAIXADO
							LVALID 	:= .F.
							CMSG 	:= "Pagamento Já Efetuado"
						ELSE //NAO EXISTEM TITULOS
							LVALID := .T.
						ENDIF
						
						SE1->(DBSKIP())
					ENDDO
					
     			ELSE // NAO EXISTEM TITULOS
                   	LVALID := .T.
                ENDIF
                    
				IF LVALID //O TITULO NAO ESTA PAGO 
					// VERIFICAR O SINDICATO x LAYOUT x BANCO
					//OBS: para o cálculo dos anos 2006/2007/2008, o layout utilizado será do SINDHOSP
					IF VAL(CANOSEL) >= 2006 .AND. VAL(CANOSEL) <= 2008
						AAUX := {	{"CODSIND", "01" },;
									{"NATUREZ", '003'}}	
					ELSE  
						AAUX := {	{"CODSIND", ALLTRIM(OWS:AEMPRESA:CSINDICA)},;
									{"NATUREZ", '003'}}
					ENDIF
					ALAYOUT := VERLAYOUT('1', AAUX)
					IF ALAYOUT <> NIL .AND. ALAYOUT[1]
				        
						LVALID := .F.
						
						HTTPPOST->SINDICAL 	:= ALAYOUT[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'SIND'})][2] //codigo sindical 
						HTTPPOST->BCO 		:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'CODBCO'})][2]   
						HTTPPOST->NOMEBCO 	:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'NOMEBCO'})][2]   
						HTTPPOST->CEDENTE 	:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'CEDENTE'})][2]   
						HTTPPOST->VENCTO 	:= DDATABASE   
			    		HTTPPOST->NOMEMP 	:= ALLTRIM(OWS:AEMPRESA:CNOME)
			    		HTTPPOST->CGCEMP 	:= ALLTRIM(OWS:AEMPRESA:CCGC)
			    		HTTPPOST->ENDEMP 	:= ALLTRIM(OWS:AEMPRESA:CEND)
			    		//HTTPPOST->NUMEMP 	:= ALLTRIM(OWS:AEMPRESA:CNOME)
			    		HTTPPOST->BAIRROEMP := ALLTRIM(OWS:AEMPRESA:CBAIRRO)
			    		HTTPPOST->CEPEMP	:= ALLTRIM(OWS:AEMPRESA:CCEP)
			    		HTTPPOST->MUNEMP	:= ALLTRIM(OWS:AEMPRESA:CMUN)
			    		HTTPPOST->UFEMP		:= ALLTRIM(OWS:AEMPRESA:CUF)		       
						
						
					  	SZA->(DbOrderNickName("ANO")) 
						IF SZA->(DBSEEK(XFILIAL("SZA")+CANOSEL))  
					    	LAPLACR := SZA->ZA_APLACR						
							SZB->(DbOrderNickName("CODITEM")) 
							IF SZB->(DBSEEK(XFILIAL("SZB")+SZA->ZA_CODIGO))
								WHILE !SZB->(EOF()) .AND. XFILIAL("SZB")+SZA->ZA_CODIGO == SZB->(ZB_FILIAL+ZB_CODIGO)
								    IF VAL(HTTPPOST->CCAPITAL) >= SZB->ZB_CAPDE .AND. VAL(HTTPPOST->CCAPITAL) <= SZB->ZB_CAPATE
								    	NALIQ := SZB->ZB_ALIQUOT
								    	NADIC := SZB->ZB_ADIC  
								    	LVALID := .T.
								    ENDIF
									SZB->(DBSKIP())
								ENDDO  
							ELSE
								//ERRO - SEM TABELA DE BASE DE CALCULO
								LVALID := .F.
								CMSG := "Base de Cálculo Nao Definida"
								cHtml := ExecInPage("BOLETO")									
							ENDIF
						ELSE
							//ERRO - SEM TABELA DE BASE DE CALCULO
							LVALID := .F.   
							CMSG := "Base de Cálculo Nao Definida"
							cHtml := ExecInPage("BOLETO")							
						ENDIF								
					ELSE
						LVALID 	:= .F.
						CMSG := "Base de Cálculo Nao Definida"
						cHtml := ExecInPage("BOLETO")
					ENDIF
					
					IF LVALID 
                        
						HTTPPOST->VLTIT := (VAL(HTTPPOST->CCAPITAL) * NALIQ) + NADIC //VALOR DO TITULO
						
		        		AQTDMES := DateDiffYMD( DDATABASE , CTOD(HTTPPOST->DTINIATV))
		        		
		        		IF AQTDMES[1] > 0 //EXISTEM ANOS
		        			NVAL := (AQTDMES * 12) + AQTDMES[2]
		        		ELSE
		        			NVAL := AQTDMES[2]
		        		ENDIF                  
						
						/*
							MV_MTAT1 -> multa nos primeiros 30 dias de atraso
							MV_MTAT2 -> multa após 30 dias de atraso ao mês
							MV_MORA  -> juros de mora ao mês 
							MV_CORRE -> correção monetária ao mês 
                             
                            * 	Após abertura da empresa, esta tem 30 dias por lei para recolher a sindical 
                            	depois será cobrado com multa e juros.
                               		
							* 	Para as empresas com inicio das atividades até o dia 14/12, a empresa deverá 
								recolher o valor do ano inteiro, senão não deve ser emitido o boleto e deve aparecer uma mensagem: "Contribuinte - esta empresa deve recolher apenas nos próximos anos."
						*/ 
	                     
	                    /*
	                    	A correção monetária deverá ser impressa no campo "Outros Acréscimos" 
	                    	Os juros e multas devem ser impressos no campo "Mora/Multa", quando o conteúdo do campo "Aplicação de Acréscimos" for igual a "S".            
	                    */
                        IF HTTPPOST->DTINIATV <= STOD("14/12/" + CANOSEL) // RECOLHE
                             //1 MULTA
                        	IF DDATABASE > HTTPPOST->DTINIATV + 30 .AND. DDATABASE <= HTTPPOST->DTINIATV + 60 .AND. NALIQ > 0 .AND. NADIC > 0 //COBRAR MULTAS E JUROS
                         		HTTPPOST->MULTA := VAL(GETMV("MV_MTAT1")) * VAL(HTTPPOST->VLTIT) * VAL(GETMV("MV_MORA")) * NVAL
                         		HTTPPOST->ACRES	:= VAL(HTTPPOST->VLTIT) * VAL(GETMV("MV_CORRE")) 
                            ELSEIF DDATABASE > HTTPPOST->DTINIATV + 60 .AND. NALIQ > 0 .AND. NADIC > 0  //2 MULTA       
                            	HTTPPOST->MULTA := VAL(GETMV("MV_MTAT2")) * VAL(HTTPPOST->VLTIT) * VAL(GETMV("MV_MORA")) * NVAL
                            	HTTPPOST->ACRES	:= VAL(HTTPPOST->VLTIT) * VAL(GETMV("MV_CORRE"))
                            ELSE //SEM MULTA
								HTTPPOST->MULTA	:= 0                                            
								HTTPPOST->ACRES	:= 0
                            ENDIF
                        ELSE
                         	CMSG := "Contribuinte - esta empresa deve recolher apenas nos próximos anos"
                            cHtml := ExecInPage("BOLETO")
                        ENDIF
      				ELSE
          				CMSG := "Erro na Base de Cálculo"
                        cHtml := ExecInPage("BOLETO")	      				
      				ENDIF

				ENDIF
										
/*************************************************************************************************************************************/
/*													C O N F E D E R A T I V A 														 */ 
/*************************************************************************************************************************************/	
			ELSEIF ALLTRIM(HTTPPOST->TPBOLETO) == '2'  // CONFEDERATIVA
			    
				// VERIFICAR O SINDICATO x LAYOUT x BANCO
				AAUX := {	{"CODSIND", ALLTRIM(OWS:AEMPRESA:CSINDICA)},;
							{"NATUREZ", ALLTRIM(OWS:AEMPRESA:CNATUREZ)}}
	
				ALAYOUT := VERLAYOUT('2', AAUX)
				
				IF ALAYOUT <> NIL .AND. ALAYOUT[1]
					LVALID := .T.
					
					/*
						verificar se já existe pagamento (registros) na tabela SE1:
						*	Os dois primeiros dígitos do campo E1_Prefixo com os dois últimos dígitos do ano selecionado no campo "Ano/Parcela". 
						*	O campo E1_Prefixo não deve possuir a letra "T" no último caractere. OK 
						*	E1_Parcela igual à parcela selecionada no campo "Ano/Parcela". 
						*	E1_Naturez igual a "002" ou "0301".    ok
					*/  
					
				  	SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
					IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(OWS:AEMPRESA:CCODIGO,6)+PADR(OWS:AEMPRESA:CLOJA,2))) //ACHO UM TITULO
						WHILE !SE1->(EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(OWS:AEMPRESA:CCODIGO,6)+PADR(OWS:AEMPRESA:CLOJA,2)
							
							IF !EMPTY(SE1->E1_BAIXA) .AND. (ALLTRIM(SE1->E1_NATUREZ) == '002' .OR. ALLTRIM(SE1->E1_NATUREZ) == '0301') 
								IF SUBSTR(ALLTRIM(SE1->E1_PREFIXO),1,2) == SUBSTR(HTTPPOST->CANOPARCELA,3,2) 
									IF SUBSTR(ALLTRIM(SE1->E1_PREFIXO),3,1) <> 'T' .AND. ALLTRIM(SE1->E1_PARCELA) == SUBSTR(HTTPPOST->CANOPARCELA,8,1) 
										LVALID := .F.
										CMSG := "Pagamento Já Efetuado"
									ENDIF
	                             ENDIF
							ENDIF
							SE1->(DBSKIP())
						ENDDO
						
	     			ELSE // NAO EXISTEM TITULOS
	                   	LVALID := .T.
	                ENDIF
					
					IF LVALID    
						
						LVALID := .F.
						                   
						HTTPPOST->BCO 		:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'CODBCO'})][2]   
						HTTPPOST->NOMEBCO 	:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'NOMEBCO'})][2]   
						HTTPPOST->CEDENTE 	:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'CEDENTE'})][2]   
			    		HTTPPOST->NOMEMP 	:= ALLTRIM(OWS:AEMPRESA:CNOME)
			    		HTTPPOST->CGCEMP 	:= ALLTRIM(OWS:AEMPRESA:CCGC)
			    		HTTPPOST->ENDEMP 	:= ALLTRIM(OWS:AEMPRESA:CEND)
			    		//HTTPPOST->NUMEMP 	:= ALLTRIM(OWS:AEMPRESA:CNOME)
			    		HTTPPOST->BAIRROEMP := ALLTRIM(OWS:AEMPRESA:CBAIRRO)
			    		HTTPPOST->CEPEMP	:= ALLTRIM(OWS:AEMPRESA:CCEP)
			    		HTTPPOST->MUNEMP	:= ALLTRIM(OWS:AEMPRESA:CMUN)
			    		HTTPPOST->UFEMP		:= ALLTRIM(OWS:AEMPRESA:CUF)		       
			    		HTTPPOST->VENCTO	:= Posicione("SZC",1,xFilial("SZC")+SUBSTR(HTTPPOST->CANOPARCELA,1,4)+SUBSTR(HTTPPOST->CANOPARCELA,8,1),"ZC_DTPAGTO")
						
						// POSSUI FUNCIONARIO
						IF HTTPPOST->FUNCIONARIO == 'S' .AND. DDATABASE > CTOD(HTTPPOST->VENCTO)

						  	SZD->(DbOrderNickName("CODIGO")) 
							IF SZD->(DBSEEK(XFILIAL("SZD")+HTTPPOST->CODCONF))
								WHILE !SZD->(EOF()) .AND. SZD->(ZD_FILIAL+ZD_CODIGO) == XFILIAL("SZD")+HTTPPOST->CODCONF
									
									IF SZD->ZD_CODSIND == ALLTRIM(OWS:AEMPRESA:CSINDICA)									     
								    	NVAL = SZD->ZD_PORCENT
								    ENDIF
								    SZD->(DBSKIP())                                                                                   
								ENDDO            
								
								IF (VAL(HTTPPOST->VLBRUTO) * NVAL) < Posicione("SZC",1,xFilial("SZC")+SUBSTR(HTTPPOST->CANOPARCELA,1,4)+SUBSTR(HTTPPOST->CANOPARCELA,8,1),"ZC_VLMIN")
									HTTPPOST->VLTIT := Posicione("SZC",1,xFilial("SZC")+SUBSTR(HTTPPOST->CANOPARCELA,1,4)+SUBSTR(HTTPPOST->CANOPARCELA,8,1),"ZC_VLMIN")
								ELSE
								    HTTPPOST->VLTIT := (VAL(HTTPPOST->VLBRUTO) * NVAL)
								ENDIF 
							
							ELSE
							
								LVALID := .F.
								CMSG := "Base de Cálculo Nao Definida"
								cHtml := ExecInPage("BOLETO")
							ENDIF
						    
							IF Posicione("SZC",1,xFilial("SZC")+SUBSTR(HTTPPOST->CANOPARCELA,1,4)+SUBSTR(HTTPPOST->CANOPARCELA,8,1),"ZC_APLACR")
								
								AQTDMES := DateDiffYMD( DDATABASE , CTOD(HTTPPOST->DTPAGTO))
				        		IF AQTDMES[1] > 0 //EXISTEM ANOS
	        						NVAL := (AQTDMES * 12) + AQTDMES[2]
				        		ELSE
	        						NVAL := AQTDMES[2]
				        		ENDIF                  
						    
							    HTTPPOST->MULTA 	:= HTTPPOST->VLTIT * Posicione("SZC",1,xFilial("SZC")+SUBSTR(HTTPPOST->CANOPARCELA,1,4)+SUBSTR(HTTPPOST->CANOPARCELA,8,1),"ZC_MULTA")
							    HTTPPOST->ACRESC 	:= HTTPPOST->VLTIT * Posicione("SZC",1,xFilial("SZC")+SUBSTR(HTTPPOST->CANOPARCELA,1,4)+SUBSTR(HTTPPOST->CANOPARCELA,8,1),"ZC_JUROMES") * NVAL
								/*
								*	Multas = Valor do Título * conteúdo do campo "Multa"
								*	Juros = Valor do Títulos * conteúdo do campo "Juros ao Mês" * quantidade de meses entre a data atual e o conteúdo do campo "Data para Pagamento" 
								*/
							ELSE
							
								HTTPPOST->MULTA 	:= 0
								HTTPPOST->ACRESC 	:= 0
							ENDIF
						ELSE
							
							HTTPPOST->VLTIT := Posicione("SZC",1,xFilial("SZC")+SUBSTR(HTTPPOST->CANOPARCELA,1,4)+SUBSTR(HTTPPOST->CANOPARCELA,8,1),"ZC_VLMIN")
													
						ENDIF     
						LVALID := .T.
					ENDIF	
				ELSE
					LVALID := .F.
				ENDIF					
			    
	
/*************************************************************************************************************************************/
/*											A S S I S T E N C I A L / N E G O C I A L 												 */ 
/*************************************************************************************************************************************/	
			ELSEIF ALLTRIM(HTTPPOST->TPBOLETO) == '5'  // ASSISTENCIAL/NEGOCIAL
				// VERIFICAR O SINDICATO x LAYOUT x BANCO
				AAUX := {	{"CODSIND", ALLTRIM(OWS:AEMPRESA:CSINDICA)},;
							{"NATUREZ", ALLTRIM(OWS:AEMPRESA:CNATUREZ)}}
	
				ALAYOUT := VERLAYOUT('5', AAUX)
				
				IF ALAYOUT <> NIL .AND. ALAYOUT[1]
					
					/*  VERIFICAR SE JÁ EXISTE TITULO PAGO:
						* Os dois primeiros dígitos do campo E1_Prefixo com os dois últimos dígitos do ano selecionado no campo "Ano/Parcela". 
						* O campo E1_Prefixo não deve possuir a letra "T" no ultimo caractere. 
						* E1_Parcela igual à parcela selecionada no campo "Ano/Parcela". 
						* E1_Naturez igual a "002" ou "0301".
					*/											
					
				  	SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
					IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(OWS:AEMPRESA:CCODIGO,6)+PADR(OWS:AEMPRESA:CLOJA,2))) //ACHO UM TITULO
						WHILE !SE1->(EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(OWS:AEMPRESA:CCODIGO,6)+PADR(OWS:AEMPRESA:CLOJA,2)
							IF !EMPTY(SE1->E1_BAIXA) .AND. (ALLTRIM(SE1->E1_NATUREZ) == '002' .OR. ALLTRIM(SE1->E1_NATUREZ) == '0301') 
								IF SUBSTR(ALLTRIM(SE1->E1_PREFIXO),1,2) == SUBSTR(HTTPPOST->CANOPARCELA,3,2) 
									IF SUBSTR(ALLTRIM(SE1->E1_PREFIXO),3,1) <> 'T' .AND. ALLTRIM(SE1->E1_PARCELA) == SUBSTR(HTTPPOST->CANOPARCELA,8,1) 
										LVALID := .F.
										CMSG := "Pagamento Já Efetuado"
									ENDIF
	                             ENDIF
							ENDIF
							SE1->(DBSKIP())
						ENDDO
	     			ELSE // NAO EXISTEM TITULOS
	                   	LVALID := .T.
	                ENDIF
			    ELSE
					LVALID := .F.
					CMSG := "Base de Cálculo Nao Definida"
					cHtml := ExecInPage("BOLETO")
			    ENDIF
			    
			    IF LVALID   
			    
					HTTPPOST->BCO 		:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'CODBCO'})][2]   
					HTTPPOST->NOMEBCO 	:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'NOMEBCO'})][2]   
					HTTPPOST->CEDENTE 	:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'CEDENTE'})][2]   

		    		HTTPPOST->NOMEMP 	:= ALLTRIM(OWS:AEMPRESA:CNOME)
		    		HTTPPOST->CGCEMP 	:= ALLTRIM(OWS:AEMPRESA:CCGC)
		    		HTTPPOST->ENDEMP 	:= ALLTRIM(OWS:AEMPRESA:CEND)
		    		//HTTPPOST->NUMEMP 	:= ALLTRIM(OWS:AEMPRESA:CNOME)
		    		HTTPPOST->BAIRROEMP := ALLTRIM(OWS:AEMPRESA:CBAIRRO)
		    		HTTPPOST->CEPEMP	:= ALLTRIM(OWS:AEMPRESA:CCEP)
		    		HTTPPOST->MUNEMP	:= ALLTRIM(OWS:AEMPRESA:CMUN)
		    		HTTPPOST->UFEMP		:= ALLTRIM(OWS:AEMPRESA:CUF)			    
	
			    	IF HTTPPPOST->FUNCIONARIO == 'S'
			    		/* (Valor Bruto da Folha * % DA BASE/MÊS/ANO/PARCELA) < Valor Mínimo E Valor Mínimo > "0"  */
						IF VAL(HTTPPOST->VLFOLHA) * VAL(HTTPPOST->INDICE) < HTTPPOST->VLMIN .AND. HTTPPOST->VLMIN > 0 
							HTTPPOST->VLTIT	:= HTTPPOST->VLMIN
						ELSE
						    HTTPPOST->VLTIT := VAL(HTTPPOST->VLFOLHA) * VAL(HTTPPOST->INDICE)
						ENDIF 
						
						/* 	Campo da tabela "Aplicação de Acréscimos" = "S" 
							e data atual > "Vencimento Original" 
							o valor do título será igual ao (valor do título* Multa (fixa) * Juros (ao mês) + valor do título)
						*/
						
						IF HTTPPOST->APLACR .AND. DDATABASE > HTTPPOST->VENCORI						
							//HTTPPOST->VLTIT += HTTPPOST->VLTIT * HTTPPOST->MULTA * HTTPPOST->JUROS * QUANTIDADE MESES
						ENDIF
			    	ELSE
			    		CMSG := "As empresas sem funcionários devem recolher a Contribuição Confederativa"
						cHtml := ExecInPage("BOLETO") 
			    	ENDIF 
			    ELSE
		    		CMSG := "Base de Calculo Nao Definida"
					cHtml := ExecInPage("BOLETO") 
			    ENDIF
			ENDIF
						
		CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '34'
/*************************************************************************************************************************************/
/*								A S S O C I A T I V A - E - A S S O C I A T I V A / C O N F E D E R A T I V A 						 */ 
/*************************************************************************************************************************************/	
			
			// VERIFICAR O SINDICATO x LAYOUT x BANCO
			AAUX := {	{"CODSIND", ALLTRIM(OWS:AEMPRESA:CSINDICA)},;
						{"NATUREZ", ALLTRIM(OWS:AEMPRESA:CNATUREZ)},;
						{"INISIND", ALLTRIM(OWS:AEMPRESA:CNATUREZ)}}

			IF ALLTRIM(HTTPPOST->TPBOLETO) == '3'  // ASSOCIATIVA
				ALAYOUT := VERLAYOUT('3', AAUX)
			ELSE
				ALAYOUT := VERLAYOUT('4', AAUX)
			ENDIF
			
			IF ALAYOUT <> NIL .AND. ALAYOUT[1] 
				HTTPPOST->BCO 		:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'CODBCO'})][2]   
				HTTPPOST->NOMEBCO 	:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'NOMEBCO'})][2]   
				HTTPPOST->CEDENTE 	:= ADADOS[aScan(ALAYOUT,{|x| UPPER(x[1]) == 'CEDENTE'})][2]   
				HTTPPOST->VENCTO 	:= HTTPOST->VENCTO   
				HTTPPOST->VLTIT 	:= HTTPOST->VLTIT
				
	    		HTTPPOST->NOMEMP 	:= ALLTRIM(OWS:AEMPRESA:CNOME)
	    		HTTPPOST->CGCEMP 	:= ALLTRIM(OWS:AEMPRESA:CCGC)
	    		HTTPPOST->ENDEMP 	:= ALLTRIM(OWS:AEMPRESA:CEND)
	    		//HTTPPOST->NUMEMP 	:= ALLTRIM(OWS:AEMPRESA:CNOME)
	    		HTTPPOST->BAIRROEMP := ALLTRIM(OWS:AEMPRESA:CBAIRRO)
	    		HTTPPOST->CEPEMP	:= ALLTRIM(OWS:AEMPRESA:CCEP)
	    		HTTPPOST->MUNEMP	:= ALLTRIM(OWS:AEMPRESA:CMUN)
	    		HTTPPOST->UFEMP		:= ALLTRIM(OWS:AEMPRESA:CUF) 
	    		HTTPPOST->VENCTO	:= HTTPPOST->DTPAGTO		       
	    		
	        	IF Posicione("SZG",1,xFilial("SZG")+HTTPPOST->VENCTIT,"ZG_APLACR")
	        		
	        		AQTDMES := DateDiffYMD( DDATABASE , CTOD(HTTPPOST->DTPAGTO))
	        		IF AQTDMES[1] > 0 //EXISTEM ANOS
	        			NVAL := (AQTDMES * 12) + AQTDMES[2]
	        		ELSE
	        			NVAL := AQTDMES[2]
	        		ENDIF                  
		        		
	        		HTTPPOST->MULTA := HTTPPOST->VLTIT * Posicione("SZG",1,xFilial("SZG")+HTTPPOST->VENCTIT,"ZG_MULTA")
	        		HTTPPOST->JUROS := HTTPPOST->VLTIT * Posicione("SZG",1,xFilial("SZG")+HTTPPOST->VENCTIT,"ZG_JUROMES") * NVAL
		        	/*
			        *	Multas = "Valor do documento" * conteúdo do campo "Multa"
					*	Juros = "Valor do documento" * conteúdo do campo "Juros ao Mês" * quantidade de meses entre a data atual e o conteúdo do campo "Vencimento Considerado"
	                */                                                                 
                  ENDIF
	    
	    	ELSE
	    		CMSG := "Base de Calculo Nao Definida"
				cHtml := ExecInPage("BOLETO")		    	
	    	ENDIF
	ENDCASE 
	
	IF LVALID 
		AADD(ADADOS, 	{"FILIAL"	, XFILIAL("SZ9")},;
						{"NATUREZ"  , 				},;
						{"NUMERO"	, 				},;
						{"CGC"		, 				},;
						{"VALOR"	,				},;
						{"ANO"		, 				},;
						{"PARCELA"	,				},;
						{"EMISSAO"	, 				},;
						{"VENCTO"	,				},;
						{"SINDIC"	, 				},;
						{"BASE"		,				})
						
		U_GRVBOL(ADADOS) //GRAVA OS DADOS NA TABELA SZ9	
	ENDIF
ELSE
    
	DO CASE
		CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '125'
			cHtml := ExecInPage("XXXX") //PAGINA DE CADASTRO
		CASE ALLTRIM(HTTPPOST->TPBOLETO) $ '34'
			CMSG := 'CNPJ Não Localizado'
			cHtml := ExecInPage("BOLETO") //MSG DE EMPRESA NAO CADASTRADA
	ENDCASE 
	
	cHtml := ExecInPage("SINDASSOC")
                                      
Web Extended End


Return cHtml 

