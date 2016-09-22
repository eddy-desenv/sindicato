#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"
  
User Function _XXXXXXX ; Return  // "dummy" function - Internal Use 

/**************************************************************************
* Definicao da estruturas utilizadas                                      *
***************************************************************************/
                 
// TITULOS PAGOS
WSSTRUCT STITPAG

WSDATA CANO		            AS String 	OPTIONAL   
WSDATA DVENCTO	            AS DATE 	OPTIONAL   
WSDATA DPAGTO	            AS DATE  	OPTIONAL  
WSDATA NVALOR	            AS STRING  	OPTIONAL  
WSDATA CPARCELA				AS STRING 	OPTIONAL
WSDATA CTIPO				AS STRING  	OPTIONAL
WSDATA CMES					AS STRING 	OPTIONAL
WSDATA NVLPAGTO				AS STRING 	OPTIONAL
WSDATA CNAT					AS STRING   OPTIONAL

ENDWSSTRUCT
                
// TITULOS EM ABERTO
WSSTRUCT STITABT

WSDATA CANO		            AS String 	OPTIONAL   
WSDATA CPARCELA				AS STRING 	OPTIONAL
WSDATA CTIPO				AS STRING  	OPTIONAL
WSDATA DVENCTO	            AS DATE 	OPTIONAL   
WSDATA DPAGTO	            AS DATE  	OPTIONAL  
WSDATA CMES					AS STRING 	OPTIONAL
WSDATA NVALOR	            AS STRING  	OPTIONAL  
WSDATA CNAT					AS STRING   OPTIONAL
WSDATA CCHAVE               AS STRING   OPTIONAL
WSDATA OPCOES               AS STRING   OPTIONAL

ENDWSSTRUCT

// DADOS DA EMPRESA
WSSTRUCT _EMPRESA

WSDATA CCGC	             AS String  OPTIONAL   
WSDATA INISIND           AS String  OPTIONAL  // A1_INISIND   
WSDATA CCODIGO           AS String  OPTIONAL   
WSDATA CLOJA	         AS String  OPTIONAL   
WSDATA CFILIAL	         AS String  OPTIONAL   
WSDATA DINIATV	         AS DATE    OPTIONAL
WSDATA DDTNASC	         AS DATE    OPTIONAL
WSDATA CFOLCENT	         AS STRING  OPTIONAL//A1_FOLCENT
WSDATA CCAPCENT	         AS STRING  OPTIONAL//A1_CAPCENT
WSDATA CFILANTR	         AS STRING  OPTIONAL//FILANTROPICA
WSDATA CNATUREZ	         AS STRING  OPTIONAL//FILANTROPICA
WSDATA NCATEGOR	         AS INTEGER OPTIONAL//CATEGORIA
WSDATA CBASE			 AS STRING OPTIONAL

ENDWSSTRUCT
/***************************************************************************
* Definicao do Web Service de Controle do Usuario                         *
***************************************************************************/
WSSERVICE SHEXTRATO

   WSDATA LRETURN					as BOOLEAN
   WSDATA LSIND						as BOOLEAN
   WSDATA LCONFNEG					as BOOLEAN
   WSDATA LASSOC					as BOOLEAN
   WSDATA CCGC						as STRING
   WSDATA CCONFNEG					as STRING OPTIONAL
   WSDATA ATITPAG					as ARRAY OF STITPAG
   WSDATA ATITABT					as ARRAY OF STITABT
   WSDATA AEMPRESA					as _EMPRESA
   
   WSMETHOD LSTPAG		// LISTA OS TITULOS PAGOS
   WSMETHOD LSTABT		// LISTA OS TITULOS EM ABERTO
   
ENDWSSERVICE


/*************************************************************************************************                                      
* METODO LSTPAG
* Gisele Nuncherino  
* LISTA OS TITULOS PAGOS
* PaRAMETROS: 
* CCGC 	= CNPJ DA EMPRESA 
* CNAT  = NATUREZA DA EMPRESA
* 
/*************************************************************************************************/

WSMETHOD LSTPAG WSRECEIVE AEMPRESA, LSIND, LCONFNEG, LASSOC  WSSEND ATITPAG WSSERVICE SHEXTRATO

Local dEmissao

LOCAL LVALID 	:= .T.
Local ADADOS	:= {} 
LOCAL CANO		:= ''

IF EMPTY(::AEMPRESA:CCODIGO) .AND. EMPTY(::AEMPRESA:CLOJA)
	LVALID := .F. 
	SetSoapFault("LSTPAG", "Dados do Cliente Nao Informados")			
ELSE  
  	SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
	IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2)))    
		WHILE SE1->(!EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2) 
			IF ::LSIND 
				CANO := SUBSTR(ALLTRIM(STR(YEAR(Date())+1)),3,2)
				//O prefixo (E1_PREFIXO) dever ser igual aos dois últimos do ano, sendo que o ano deve ser maior ou igual ao ano atual - 4 
				IF ALLTRIM(SE1->E1_NATUREZ) == '003' .AND. VAL(SE1->E1_PREFIXO) >= VAL(CANO)-5 .AND. VAL(SE1->E1_PREFIXO) <= VAL(CANO) .AND. !empty(substr(dtoc(SE1->E1_BAIXA),1,2))
				 	// Ano 	Vencimento 	Pagamento 	Valor   
				 	ADADOS := WSCLASSNEW("STITPAG")    
				 	ADADOS:CANO 	:= SE1->E1_PREFIXO
				 	ADADOS:DVENCTO 	:= SE1->E1_VENCTO
				 	ADADOS:DPAGTO	:= SE1->E1_BAIXA
				 	ADADOS:NVALOR 	:= ALLTRIM(transform(SE1->E1_VALOR, '@E 999,999,999.99'))
				 	ADADOS:CNAT 	:= ALLTRIM(SE1->E1_NATUREZ) 
				 	ADADOS:NVLPAGTO := ALLTRIM(transform(SE1->(E1_VALOR-E1_SALDO), '@E 999,999,999.99'))
				 	AADD(::ATITPAG,ADADOS)                      
				ENDIF
            
                
			 /*	
			 	O prefixo (E1_PREFIXO) dever ser igual aos dois últimos dígitos do ano, sendo que o ano deve ser maior ou igual ao ano posterior - 3 (Alterado de 2)       
	           	O terceiro caractere do campo E1_PREFIXO deve ser diferente de "T" 
	    	 */  
			ENDIF
			IF ::LCONFNEG                   
				CANO := SUBSTR(ALLTRIM(STR(YEAR(Date())+1)),3,2)  
				IF (ALLTRIM(SE1->E1_NATUREZ) == '002' .OR. ALLTRIM(SE1->E1_NATUREZ) == '0301') .AND. VAL(SUBSTR(SE1->E1_PREFIXO,1,2)) >= VAL(CANO)-3 .AND. VAL(SUBSTR(SE1->E1_PREFIXO,1,2)) <= VAL(CANO) .AND. SUBSTR(SE1->E1_PREFIXO,3,1) <> 'T' .AND. !EMPTY(SE1->E1_BAIXA) .and. !empty(substr(dtoc(SE1->E1_BAIXA),1,2))   
			    	//Ano	Parcela	Vencimento	Pagamento	Valor	Contribuições  
				 	ADADOS 			:= WSCLASSNEW("STITPAG")
				 	ADADOS:CANO 	:= SUBSTR(SE1->E1_PREFIXO,1,2)
				 	ADADOS:CPARCELA := ALLTRIM(SE1->E1_PARCELA)
				 	ADADOS:DVENCTO	:= SE1->E1_VENCTO
				 	ADADOS:DPAGTO 	:= SE1->E1_BAIXA 
				 	ADADOS:NVALOR 	:= ALLTRIM(transform(SE1->E1_VALOR, '@E 999,999,999.99'))
				 	ADADOS:CTIPO 	:= IIF(ALLTRIM(SE1->E1_NATUREZ) == '002', 'CONFEDERATIVA', 'ASSISTENCIAL/NEGOCIAL') 
					ADADOS:CNAT 	:= ALLTRIM(SE1->E1_NATUREZ)				 	
				 	ADADOS:NVLPAGTO := ALLTRIM(transform(SE1->(E1_VALOR-E1_SALDO), '@E 999,999,999.99'))
				 	AADD(::ATITPAG,ADADOS)
				ENDIF   
            /*
            Os títulos a serem exibidos devem ser de até 12 meses retroativos:
			--> E1_PREFIXO = dois últimos dígitos do ANO
			--> E1_NUM = MÊS CORRENTE até MÊS CORRENTE - 12 
			--> O terceiro caractere do campo E1_PREFIXO deve ser diferente de "T"
			*/
			ENDIF
			IF ::LASSOC
			
				dEmissao := (date() - 365)
				dEmissao := CtoD("01/" + StrZero(Month(dEmissao),2) + "/" + StrZero(Year(dEmissao),4))
                   
				If 	(ALLTRIM(SE1->E1_NATUREZ) == '001' .OR. ALLTRIM(SE1->E1_NATUREZ) == '1000') .And.;
				         (Substr(SE1->E1_PREFIXO,3,1) <> 'T') .And. ((ALLTRIM(SE1->E1_PREFIXO)) == (Substr(ALLTRIM(STR(YEAR(SE1->E1_EMISSAO))),3,2))) .And.;
				         (SE1->E1_EMISSAO >= dEmissao) .And. (SE1->E1_EMISSAO <= date()) .And.;
				         (!EMPTY(alltrim(substr(dtoc(SE1->E1_BAIXA),1,2))))
				    //Ano	Mês	Vencimento	Valor	Pagamento	Valor Pago      
                    
               nMes := VAL(substr(SE1->E1_NUM,1,2))                                                      
               
               If  ((nMes >= 1) .And. (nMes <= 12))
					 	ADADOS := WSCLASSNEW("STITPAG")
					 	ADADOS:CANO 	:= substr(dtoc(SE1->E1_EMISSAO),7,4) //ALLTRIM(STR(YEAR(SE1->E1_EMISSAO)))
					 	ADADOS:CMES		:= strzero(VAL(substr(SE1->E1_NUM,1,2)),2) //ALLTRIM(STR(MONTH(SE1->E1_EMISSAO)))
					 	ADADOS:DVENCTO	:= SE1->E1_VENCTO
					 	ADADOS:NVALOR 	:= ALLTRIM(transform(SE1->E1_VALOR, '@E 999,999,999.99'))
					 	ADADOS:DPAGTO 	:= SE1->E1_BAIXA 					 						 	
					 	ADADOS:NVLPAGTO := ALLTRIM(transform(SE1->E1_SALDO, '@E 999,999,999.99'))     
					 	ADADOS:CNAT 	:= ALLTRIM(SE1->E1_NATUREZ)
					 	ADADOS:NVLPAGTO := ALLTRIM(transform(SE1->(E1_VALOR-E1_SALDO), '@E 999,999,999.99'))
					 	AADD(::ATITPAG,ADADOS)
				 	EndIf
		     	ENDIF
			ENDIF
			SE1->(DBSKIP())
		ENDDO	                  
    ELSE
    
		LVALID := .T.
		ADADOS := {}
		
	ENDIF
		    
ENDIF

RETURN LVALID



/*************************************************************************************************                                      
* METODO LSTABT
* Gisele Nuncherino  
* LISTA OS TITULOS PAGOS
* PaRAMETROS: 
* CCGC 	= CNPJ DA EMPRESA 
* CNAT  = NATUREZA DA EMPRESA
* 
/*************************************************************************************************/

WSMETHOD LSTABT WSRECEIVE AEMPRESA, LSIND, LCONFNEG, LASSOC, CCONFNEG  WSSEND ATITABT WSSERVICE SHEXTRATO

Local cAnoParcela
                                                                              
LOCAL LVALID 	:= .T.
LOCAL AANO		:= {}  
LOCAL ADADOS	:= {}
LOCAL CANO		:= ''
LOCAL CANOATUAL	:= ''//SUBSTR(ALLTRIM(STR(YEAR(Date()))),3,2)
LOCAL CANOABERT	:= ''//SUBSTR(ALLTRIM(STR(YEAR(::AEMPRESA:DINIATV))),3,2) 
LOCAL CAUXDATA	:= ''
LOCAL NX		:= 0                   
LOCAL AANOPAG	:= {}
                                       
Local aAnoAssis := {}

DbSelectArea("PAG")
DbSetOrder(1)


IF EMPTY(::AEMPRESA:CCODIGO) .AND. EMPTY(::AEMPRESA:CLOJA)

	LVALID := .F. 
	SetSoapFault("LSTABT", "Dados do Cliente Nao Informados")			
	
ELSE  

	CANOATUAL	:= ALLTRIM(STR(YEAR(DATE())))
	CANOABERT	:= ALLTRIM(STR(YEAR(::AEMPRESA:DINIATV)))
	CANO 		:= alltrim(STR(VAL(CANOATUAL) - 4)) 
	
	/*  Verifica os Anos da Base de Calculo Assistencial/Negocial */
	
	DbSelectArea("PAE")
	DbOrderNickName("BASE")

	DbSeek(xFilial("PAE")+Alltrim(::AEMPRESA:CBASE))

    Do	While !( Eof() ) .And. (PAE_FILIAL+Alltrim(PAE_BASE) == xFilial("PAE")+Alltrim(::AEMPRESA:CBASE))

		If  (PAE_STATUS == 'I') 
			DbSkip()
			Loop
		EndIf	
	                
		DbSelectArea("PAF")
		DbSetOrder(1)
	
	    DbSeek(xFilial("PAF")+PAE->PAE_CODIGO)

		Do	While ( !(Eof()) .And. (PAF_FILIAL+PAF_CODIGO == xFilial("PAF")+PAE->PAE_CODIGO) )
			
			If  (PAF_STATUS == 'I')
	        	DbSkip()
	        	Loop
	    	EndIf        

	    	cAnoParcela := Right(Alltrim(PAF_MESANO),2)+Alltrim(PAF_PARCEL)
	    
	    	If  Empty(Ascan(aAnoAssis, cAnoParcela))
	    		aadd(aAnoAssis, cAnoParcela)
	    	EndIf
	
	    	DbSkip()
		EndDo
		
		DbSelectArea("PAE")
		DbSkip()
	EndDo	

	IF ::LSIND //SINDICAL  
	
		ADADOS:= {}   
	
        DbSelectArea("PAA")
        DbSetOrder(1)  //PAA_ANO+PAA_CODIGO
            
        DbSeek(xFilial("PAA"))
            
        Do  While !( Eof() ) .And. (PAA_FILIAL == xFilial("PAA"))
            
           	If  (PAA_STATUS == "I") //Inativo
           		DbSkip()
           		Loop
           	EndIf
            
    		If  (::AEMPRESA:DINIATV >= CTOD("15/12/"+PAA_ANO)) .And. (Val(PAA_ANO) > Val(CANOABERT)) .Or.;
    		    (::AEMPRESA:DINIATV <  CTOD("15/12/"+PAA_ANO)) .And. (Val(PAA_ANO) >= Val(CANOABERT))
    			aadd(AANO, Right(PAA_ANO,2))
    		EndIf
    		
    		DbSkip()
    	EndDo
	    	
		/*
		3)	Verificar se o título não foi pago:		  
			a)	O CNPJ no título (E1_CGC) deve ser igual ao CNPJ informado pelo usuário
			b)	A natureza do título (E1_NATUREZ) deve ser igual a "003"
			c)	O prefixo (E1_PREFIXO) dever ser igual aos dois últimos do ano, sendo que o ano deve ser maior ou igual ao ano atual -4
			d)	O título não pode estar como baixado (E1_BAIXA igual a " ")   
			
		4)	O título somente deve ser considerado em aberto caso a data atual seja menor que o vencimento do título.
		
		5)	A empresa não deverá contribuição caso:
			a)	Possuir capital centralizado (A1_CAPCENT = "S") 
		*/
		
		IIF(::AEMPRESA:CCAPCENT == NIL,'',::AEMPRESA:CCAPCENT)
                  
		IF  (ALLTRIM(::AEMPRESA:CCAPCENT) <> 'S') .AND. (ALLTRIM(::AEMPRESA:CFILANTR) <> 'X') .AND. (::AEMPRESA:NCATEGOR < 12000)

		  	SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO

			IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2))) //ACHO UM TITULO
				WHILE !SE1->(EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2)
					IF !empty(substr(dtoc(SE1->E1_BAIXA),1,2)) .AND. ALLTRIM(SE1->E1_NATUREZ) == '003' //TITULO BAIXADO
						conout(SE1->E1_PREFIXO)
						FOR NX := 1 TO LEN(AANO)  
							IF padr(ALLTRIM(SE1->E1_PREFIXO),2) == STRZERO(VAL(AANO[NX]),2)
								AADD(AANOPAG, AANO[NX])
							ENDIF
						NEXT NX	
			   		ENDIF
		            SE1->(DBSKIP())
				ENDDO
			ENDIF

            For NX := 1 TO LEN(AANO)
            
				If  (Len(AANOPAG) <= 0) .Or. (Ascan(AANOPAG,{|x| Upper(x) == AANO[NX] }) <= 0)
				
				 	ADADOS := WSCLASSNEW("STITABT")
				 	ADADOS:CANO 	:= Right(AANO[NX],2)
				 	ADADOS:CNAT 	:= '003' 
				 	AADD(::ATITABT, ADADOS)		
				 	
				EndIf
			
			Next NX    	
			
		ENDIF
		
	ENDIF


	IF ::LCONFNEG
		ADADOS	 := {}  
		AANOPAG := {}
		
		/*
		3)	Verificar se o título não foi pago: 
			a)	O CNPJ no título (E1_CGC) deve ser igual ao CNPJ informado pelo usuário 
			b)	A natureza do título (E1_NATUREZ) deve ser igual a "002" (TRATA-SE DE CONFEDERATIVA) ou "0301" (TRATA-SE DE ASSISTENCIAL/NEGOCIAL) 
			c)	O prefixo (E1_PREFIXO) dever ser igual aos dois últimos do ano, sendo que o ano deve ser maior ou igual ao ano atual - 2 
			d)	O terceiro caractere do campo E1_PREFIXO deve ser diferente de "T" 
			e)	O título não pode estar como baixado (E1_BAIXA igual a " ")      
			
		4)	O título somente deve ser considerado em aberto caso a data atual seja menor que o vencimento do título 			
		   
		6)	 A empresa não deverá contribuição caso: 
			A)	Possuir capital centralizado - (A1_FOLCENT = "S") 
			B)	Tratar-se de uma empresa filantrópica (igual a "X")
			C)	A categoria for maior ou igual a "12000" 
					
		*/
		IIF(::AEMPRESA:CFOLCENT == NIL,'',::AEMPRESA:CFOLCENT)
		IIF(::AEMPRESA:CFILANTR == NIL,'',::AEMPRESA:CFILANTR) 
				
	  	IF  (ALLTRIM(::AEMPRESA:CFOLCENT) <> 'S')
		  	AANOPAG := {}
		  	SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
			IF  SE1->(DBSEEK(XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2))) // EXISTE TITULO
				WHILE !SE1->(EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2)
					IF (!empty(substr(dtoc(SE1->E1_BAIXA),1,2))) .AND. (ALLTRIM(SE1->E1_NATUREZ) == '002' .OR. ALLTRIM(SE1->E1_NATUREZ) == '0301')   
						IF VAL(SUBSTR(ALLTRIM(SE1->E1_PREFIXO),1,2)) >= VAL(SUBSTR(STR(YEAR(DATE())),3,2))-2  .AND. SUBSTR(ALLTRIM(SE1->E1_PREFIXO),3,1) <> 'T' 
	                        SE1->( AADD(AANOPAG, {SUBSTR(ALLTRIM(E1_PREFIXO),1,2)+Alltrim(E1_PARCELA), E1_NATUREZ} ) ) 
	     				ENDIF
	     			ENDIF
	     			SE1->(DBSKIP())
	     		ENDDO                  
	     	ENDIF	
	     		
     		DbSelectArea("PAC")
     		DbSetOrder(1) //PAC_FILIAL+PAC_ANO+PAC_PARCEL
     		DbSeek(xFilial("PAC"))
     		
     		Do  While !( Eof() ) .And. (PAC_FILIAL == xFilial("PAC"))
     		
     		    If  (PAC_STATUS == "I") //Inativo
     		        DbSkip()
     		        Loop
     		    EndIf
     		    
     		    cANOCALC := PAC_ANO
     		
				If  (Len(AANOPAG) <= 0) .Or. (Ascan(AANOPAG,{|x| Upper(x[1]) == Right(PAC_ANO,2)+Left(PAC_PARCEL,1) }) <= 0)
					/*
						1)	Quando a data de cadastro da empresa quando igual ou maior que "01/02/ano atual", a primeira parcela da contribuição não de ser cobrada. 
						2)	Quando a data de cadastro da empresa quando igual ou maior que "01/08/ano atual", a segunda parcela da contribuição não de ser cobrada. 
					*/      
					
					If  (Left(PAC_PARCEL,1) == "1") .And. (::AEMPRESA:DDTNASC < CTOD("01/02/" + cANOCALC)) .Or.;
	 					(Left(PAC_PARCEL,1) == "2") .And. (::AEMPRESA:DDTNASC < CTOD("01/08/" + cANOCALC))
	 				
 						nPos := Ascan(AANOPAG,{|x| Left(Upper(x[1]),2) == Right(PAC_ANO,2) })
 							                                                 
 					    cOpcoes := 'XXXXX|ZZZZZ'    
 					    
 					    If  (nPos == 0) .Or. ((nPos > 0) .And. (Alltrim(aANOPAG[nPos][2]) == '002'))
 					        cOpcoes := StrTran(cOpcoes, "XXXXX", "Confederativa")
 					    EndIf    

 					    If  (Ascan(aAnoAssis, Right(PAC_ANO,2)+Left(PAC_PARCEL,1)) > 0) .And. ( (nPos == 0) .Or. ((nPos > 0) .And. (Alltrim(aANOPAG[nPos][2]) == '0301')) )
 					        cOpcoes := StrTran(cOpcoes, "ZZZZZ", "Assitencial/Negocial")
 					    EndIf    
 					        
						ADADOS := WSCLASSNEW("STITABT") 
						//Ano	Parcela	Contribuições	Emissão
						ADADOS:CANO    		:= Right(PAC_ANO,2)
						ADADOS:CPARCELA 	:= Left(PAC_PARCEL,1)
						ADADOS:CTIPO	 	:= ''
						ADADOS:CNAT 		:= '002'
						ADADOS:OPCOES       := cOpcoes
						AADD(::ATITABT,ADADOS)

					EndIf

				EndIf

		    	DbSkip()
		    
			EndDo
			
		ENDIF
	ENDIF
				
	IF ::LASSOC 
	
		/*
		1)	Verificar se o título não foi pago:
			a)	O CNPJ no título (E1_CGC) deve ser igual ao CNPJ informado pelo usuário
			b)	A natureza do título (E1_NATUREZ) deve ser igual a "001" quando tratar-se de Associativa e natureza do título (E1_NATUREZ) deve ser igual a "1000" quando tratar-se de Associativa/Confederativa.
			c)	Os títulos a serem exibidos devem ser de até 12 meses retroativos:
			"	E1_PREFIXO = dois últimos dígitos do ANO
			"	E1_NUM = MÊS CORRENTE até MÊS CORRENTE - 12 
			d)	O terceiro caractere do campo E1_PREFIXO deve ser diferente de "T"
			e)	O título não pode estar como baixado (E1_BAIXA igual a " ")
		2)	Se o campo A1_INISIND for diferente de " " e existirem mais de doze títulos em aberto, não deve aparecer os títulos em abertos e o site deve exibir a mensagem: "ENTRAR EM CONTATO COM DEPTO. DE ARRECADAÇÃO - TEL. (11) 3221-9333"
		*/
		
	  	SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
		IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2)))
			WHILE !SE1->(EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2)
				IF (empty(substr(dtoc(SE1->E1_BAIXA),1,2))) .AND. (ALLTRIM(SE1->E1_NATUREZ) == '001' .OR. ALLTRIM(SE1->E1_NATUREZ) == '1000')
					IF SUBSTR(ALLTRIM(SE1->E1_PREFIXO),3,1) <> 'T' 
						CAUXDATA := "30/" + SUBSTR(SE1->E1_PREFIXO,1,2) + '/' + CANOATUAL
						IF  VAL(SUBSTR(ALLTRIM(SE1->E1_PREFIXO),1,2))  <= VAL(SUBSTR(ALLTRIM(CANOATUAL),3,2))
						
						    PAG->( DbSeek(xFilial("PAG")+DtoS(SE1->E1_VENCTO)) )
						
							ADADOS := WSCLASSNEW("STITABT") 
							//Ano	Mês	Vencimento	Valor    
							ADADOS:CCHAVE       := SE1->( E1_FILIAL + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + Alltrim(E1_NATUREZ) )
							ADADOS:CANO    		:= SUBSTR(ALLTRIM(SE1->E1_PREFIXO),1,2)
							ADADOS:DVENCTO	 	:= SE1->E1_VENCTO
							ADADOS:DPAGTO	 	:= PAG->PAG_VENCON
							ADADOS:CMES	 		:= strzero(VAL(substr(SE1->E1_NUM,1,2)),2)
							ADADOS:CNAT 		:= ALLTRIM(SE1->E1_NATUREZ) 
							ADADOS:NVALOR 		:= ALLTRIM(transform(SE1->E1_VALOR, '@E 999,999,999.99'))
							AADD(::ATITABT,ADADOS)											   
						ENDIF		                            
					ENDIF
				ENDIF
				SE1->(DBSKIP())
			ENDDO
		ENDIF
	ENDIF
         
ENDIF
		
RETURN LVALID