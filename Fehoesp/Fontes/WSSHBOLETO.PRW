#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

User Function _MMMMMMM ; Return  // "dummy" function - Internal Use 

/**************************************************************************
* Definicao da estruturas utilizadas                                      *
***************************************************************************/
   
WSSTRUCT SINDICAL

WSDATA VALOR        	AS String 	OPTIONAL    
WSDATA ALIQ				AS STRING 	OPTIONAL
WSDATA ADIC				AS STRING 	OPTIONAL//ADICIONAL
WSDATA VENCTO			AS DATE 	OPTIONAL 
WSDATA DTPGTO			AS DATE 	OPTIONAL //PARA PARA PAGAMENTO
WSDATA APLACR			AS BOOLEAN 	OPTIONAL//APLICA ACRESCIMO S/N
WSDATA MULTA			AS FLOAT 	OPTIONAL
WSDATA MORA				AS FLOAT 	OPTIONAL
WSDATA CORREC			AS FLOAT 	OPTIONAL
WSDATA CODBCO			AS STRING 	OPTIONAL
WSDATA NOMEBCO			AS STRING 	OPTIONAL
WSDATA CONTA			AS STRING 	OPTIONAL
WSDATA AGENCIA			AS STRING 	OPTIONAL
WSDATA CEDENTE			AS STRING 	OPTIONAL
WSDATA SIND				AS STRING 	OPTIONAL
WSDATA CONTRB			AS STRING 	OPTIONAL
WSDATA MSG1				AS STRING 	OPTIONAL
WSDATA MSG2				AS STRING 	OPTIONAL
WSDATA MSG3				AS STRING 	OPTIONAL
WSDATA MSG4				AS STRING 	OPTIONAL
WSDATA MSG5				AS STRING 	OPTIONAL
WSDATA MSG6				AS STRING 	OPTIONAL
WSDATA MSG7				AS STRING 	OPTIONAL
WSDATA MSG8				AS STRING 	OPTIONAL
WSDATA MSG9				AS STRING 	OPTIONAL
WSDATA IMAGEM			AS STRING 	OPTIONAL
WSDATA MOEDA			AS STRING 	OPTIONAL
WSDATA CNAE				AS STRING 	OPTIONAL
WSDATA SDNOME			AS STRING 	OPTIONAL
WSDATA SDEND			AS STRING 	OPTIONAL
WSDATA SDBAIRRO			AS STRING 	OPTIONAL
WSDATA SDCEP			AS STRING 	OPTIONAL
WSDATA SDMUN			AS STRING 	OPTIONAL
WSDATA SDEST			AS STRING 	OPTIONAL
WSDATA SDCGC			AS STRING 	OPTIONAL
WSDATA SDENTIDA			AS STRING 	OPTIONAL
WSDATA SDENTID2			AS STRING 	OPTIONAL
WSDATA NUMTIT			AS STRING 	OPTIONAL //NUMERO DO TITULO
WSDATA NATUREZ			AS STRING 	OPTIONAL 
WSDATA PREFIXO			AS STRING 	OPTIONAL 
WSDATA TIT				AS STRING 	OPTIONAL 
WSDATA LINK				AS STRING 	OPTIONAL 

ENDWSSTRUCT


WSSTRUCT SBOLETO

WSDATA BASE			AS STRING 	OPTIONAL
WSDATA SINDIC		AS STRING 	OPTIONAL
WSDATA VENCTO		AS DATE 	OPTIONAL
WSDATA EMISSAO		AS DATE 	OPTIONAL
WSDATA PARCELA		AS STRING 	OPTIONAL
WSDATA ANO			AS STRING 	OPTIONAL
WSDATA VALOR		AS FLOAT 	OPTIONAL
WSDATA CGC			AS STRING 	OPTIONAL
WSDATA NUMERO		AS STRING 	OPTIONAL
WSDATA NATUREZ		AS STRING 	OPTIONAL
WSDATA E1NUM		AS STRING 	OPTIONAL

ENDWSSTRUCT

WSSTRUCT SCCONF

WSDATA FILIAL		AS STRING 	OPTIONAL
WSDATA CODIGO		AS STRING 	OPTIONAL
WSDATA ITEM			AS STRING 	OPTIONAL
WSDATA ANO			AS STRING 	OPTIONAL
WSDATA PARCELA		AS STRING 	OPTIONAL
WSDATA MESFOLHA		AS STRING 	OPTIONAL
WSDATA VLMIN		AS string 	OPTIONAL
WSDATA VENORIG		AS DATE 	OPTIONAL
WSDATA MULTA		AS FLOAT 	OPTIONAL
WSDATA JUROMES		AS FLOAT 	OPTIONAL
WSDATA APLACR		AS BOOLEAN 	OPTIONAL
WSDATA DTPAGTO		AS DATE 	OPTIONAL
WSDATA PORCENT		AS FLOAT 	OPTIONAL
WSDATA SINDICA		AS STRING 	OPTIONAL
WSDATA PAGTO		AS BOOLEAN 	OPTIONAL
WSDATA TIT			AS STRING 	OPTIONAL
WSDATA MSG1			AS STRING 	OPTIONAL
WSDATA MSG2			AS STRING 	OPTIONAL
WSDATA MSG3			AS STRING 	OPTIONAL
WSDATA MSG4			AS STRING 	OPTIONAL
WSDATA MSG5			AS STRING 	OPTIONAL
WSDATA MSG6			AS STRING 	OPTIONAL
WSDATA MSG7			AS STRING 	OPTIONAL

ENDWSSTRUCT 
              
WSSTRUCT SCASSO

WSDATA FILIAL		AS STRING 	OPTIONAL
WSDATA PREFIXO		AS STRING 	OPTIONAL
WSDATA NUMERO		AS STRING 	OPTIONAL
WSDATA ANO			AS STRING 	OPTIONAL
WSDATA PARCELA		AS STRING 	OPTIONAL
WSDATA MES			AS STRING 	OPTIONAL
WSDATA NATUREZ		AS STRING 	OPTIONAL
WSDATA DVENORIG		AS DATE 	OPTIONAL

ENDWSSTRUCT                                                                 

WSSTRUCT SCLCASSI

WSDATA PGTO		AS BOOLEAN 	OPTIONAL
WSDATA FILIAL	AS STRING 	OPTIONAL
WSDATA CODIGO	AS STRING 	OPTIONAL
WSDATA MESANO	AS STRING 	OPTIONAL
WSDATA PARCELA	AS STRING 	OPTIONAL
WSDATA DTPAGTO	AS DATE 	OPTIONAL
WSDATA DESCONT	AS FLOAT 	OPTIONAL
WSDATA VLMIN	AS FLOAT 	OPTIONAL
WSDATA VENCORI	AS DATE 	OPTIONAL
WSDATA MULTA	AS FLOAT 	OPTIONAL
WSDATA JUROS	AS FLOAT 	OPTIONAL
WSDATA APLACR   AS STRING 	OPTIONAL
WSDATA VLFOLHA  AS STRING 	OPTIONAL
WSDATA MSG1		AS STRING 	OPTIONAL
WSDATA MSG2		AS STRING 	OPTIONAL
WSDATA MSG3		AS STRING 	OPTIONAL
WSDATA MSG4		AS STRING 	OPTIONAL
WSDATA MSG5		AS STRING 	OPTIONAL
WSDATA MSG6		AS STRING 	OPTIONAL
WSDATA MSG7		AS STRING 	OPTIONAL

ENDWSSTRUCT


WSSTRUCT SPEDIDO

WSDATA FILIAL		AS STRING 	OPTIONAL
WSDATA PREFIXO		AS STRING 	OPTIONAL
WSDATA NUMERO		AS STRING 	OPTIONAL
WSDATA PARCELA		AS STRING 	OPTIONAL
WSDATA NATUREZ		AS STRING 	OPTIONAL
WSDATA CLIENTE		AS string 	OPTIONAL
WSDATA LOJA			AS STRING 	OPTIONAL
WSDATA VECNTO		AS DATE 	OPTIONAL
WSDATA VALOR		AS FLOAT 	OPTIONAL

ENDWSSTRUCT 


WSSTRUCT SANO

WSDATA ANO		AS STRING 	OPTIONAL

ENDWSSTRUCT 


/***************************************************************************
* Definicao do Web Service de Controle do Usuario                         *
***************************************************************************/
WSSERVICE SHBOLETO

   WSDATA INFOSIND					as SINDICAL
   WSDATA AEMPRESA					as StrEmpresa
   WSDATA ABOLETO					as SBOLETO
   WSDATA APEDIDO					as SPEDIDO
   WSDATA ACLCCONF					as ARRAY OF SCCONF
   WSDATA ACLCASSO					as ARRAY OF SCASSO
   WSDATA CLCASSI					as ARRAY OF SCLCASSI
   WSDATA LRETURN					as BOOLEAN
   WSDATA NULO						as STRING OPTIONAL
   WSDATA AANO						as ARRAY OF SANO
   WSDATA ANO						as STRING
   WSDATA CODIGO					as STRING
   WSDATA ITEM						as STRING
   WSDATA SINDICA					as STRING
   WSDATA INISIND					as STRING
   WSDATA TITULO					as STRING
   
   WSMETHOD BUSCAANO    // BUSCA OS ANOS PARA GERACAO DO BOLETO SINDICAL
   WSMETHOD BUSCADADO   // BUSCA OS DADOS PARA GERACAO DO BOLETO SINDICAL
   WSMETHOD BUSCACONF	// BUSCA OS DADOS P/ GERACAO DA CONTRIBUICAO CONFEDERATIVA
   WSMETHOD BUSCAASSO	// BUSCA OS DADOS P/ GERACAO DA CONTRIBUICAO ASSOCIATIVA
   WSMETHOD DADOSCONF	// BUSCA OS DADOS P/ CALCULO DA CONTRIBUICAO CONFEDERATIVA
   WSMETHOD DADOSASSO	// BUSCA OS DADOS P/ CALCULO DA CONTRIBUICAO CONFEDERATIVA
   WSMETHOD CALCASSI	// BUSCA OS DADOS P/ CALCULO DA CONTRIBUICAO ASSISTENCIAL
   WSMETHOD DADOSNEG	// BUSCA OS DADOS P/ GERACAO DA CONTRIBUICAO ASSISTENCIAL
   WSMETHOD GRAVADADO
   
ENDWSSERVICE


/*************************************************************************************************                                      
* METODO BUSCAANO
* Gisele Nuncherino  
* BUSCA OS ANOS PARA GERACAO DO BOLETO SINDICAL
* PaRAMETROS: 
* cUserCode = CODIGO DO USUARIO  
* cPassword = senha do usuario
/*************************************************************************************************/

WSMETHOD BUSCAANO WSRECEIVE NULO WSSEND AANO WSSERVICE SHBOLETO

Local lOk    := .T.
Local aDADOS := {}
                      
aAno := {} 

DbSelectArea("PAA")
DbSetOrder(1) //PAA_FILIAL+PAA_ANO

Do  While .T.

	If  !( DbSeek(xFilial("PAA")) )
		lOk := .F.      
		SetSoapFault("BUSCAANO", "Base de Calculo Nao Definida")
		Exit
	EndIf
                                          
    Do	While !( Eof() )

		If  (PAA_STATUS == 'I')
			DbSkip()
			Loop
		EndIf
		
   		aDADOS 			:= WsClassNew("SANO")     
   		aDADOS:ANO		:= PAA_ANO

   	    aadd(::aAno, aDADOS)
   	    
   	    DbSkip()
   	    
   	EndDo    

	::aAno := Asort(::aAno,,,{|x,y| x:ANO > y:ANO }) 
	
	Exit
EndDo	  
  	
Return lOk  
**** fim ***
       
               

/*************************************************************************************************                                      
* METODO BUSCADADO
* Gisele Nuncherino  
* BUSCA OS DADOS PARA GERACAO DO BOLETO SINDICAL
* PaRAMETROS: 
* cUserCode = CODIGO DO USUARIO  
* cPassword = senha do usuario
/*************************************************************************************************/

WSMETHOD BUSCADADO WSRECEIVE ANO, AEMPRESA WSSEND INFOSIND WSSERVICE SHBOLETO

Local nMeses, nDia, cMes, cAno, dData

LOCAL LVALID := .T.
LOCAL CCODIGO:= ''
LOCAL ALAYOUT:= {}
LOCAL ADADOS := {}

::INFOSIND:LINK  := Tabela("Z5", ::AEMPRESA:CSINDICA, .F.)
 
::INFOSIND:VALOR := ::AEMPRESA:CCAPITAL

Do  While .T.     

    If  (Val(::AEMPRESA:CCAPITAL) <= 0)
		LVALID := .F.      
        SetSoapFault("BUSCADADO", "Informe o valor do capital social, atraves do e-mail: arrecadacao@fehoesp.org.br")
        Exit
    EndIf


	PAA->(DBSETORDER(1)) //FILIAL+ANO

	If  !( PAA->(DbSeek(xFilial("PAA")+::ANO)) ) 
		LVALID := .F.      
		SetSoapFault("BUSCADADO", "Base de Calculo Nao Definida")
		Exit
	EndIf

	If  (PAA->PAA_STATUS == 'I')
		LVALID := .F.      
		SetSoapFault("BUSCADADO", "Base de Calculo Inativa! Ano: " + ::ANO)
		Exit
	EndIf

	CCODIGO := PAA->PAA_CODIGO
	
	//Verifica se entre o vencimento e a data da ativação da empresa tem menos que 30 dias de diferença
	If DateDiffDay( PAA->PAA_VENCTO , ::AEMPRESA:DINIATV ) <= 30
		::INFOSIND:VENCTO	:= ::AEMPRESA:DINIATV+30
	ElseIf  (Year(::AEMPRESA:DINIATV) == VAL(::ANO))
		::INFOSIND:VENCTO	:= ::AEMPRESA:DINIATV+30
	ElseIf  !( Empty(PAA->PAA_PAGTO) )
		::INFOSIND:VENCTO	:= PAA->PAA_PAGTO	
	ElseIf  !( Empty(PAA->PAA_VENCTO) )
		::INFOSIND:VENCTO	:= PAA->PAA_VENCTO
	Else
		SetSoapFault("BUSCADADO", "Data de Vencto nao Definida!")
		Exit
	EndIf		 

	PAB->(DBSETORDER(1)) //FILIAL+CODIGO

	If  !( PAB->(DbSeek(xFilial("PAB")+CCODIGO)) )
		LVALID := .F.      
		SetSoapFault("BUSCADADO", "Base de Calculo Nao Definida")    
		Exit
    EndIf

	::INFOSIND:APLACR := PAA->PAA_APLACR
	::INFOSIND:MSG1   := PAA->PAA_MENS01
	::INFOSIND:MSG2   := PAA->PAA_MENS02
	::INFOSIND:MSG3   := PAA->PAA_MENS03
	::INFOSIND:MSG4   := PAA->PAA_MENS04
	::INFOSIND:MSG5   := PAA->PAA_MENS05
	::INFOSIND:MSG6   := PAA->PAA_MENS06
	::INFOSIND:MSG7   := PAA->PAA_MENS07
	::INFOSIND:MSG8   := PAA->PAA_MENS08
	::INFOSIND:MSG9   := PAA->PAA_MENS09

	LVALID := .F.

	Do 	While PAB->( !EOF() .And. (PAB_FILIAL+PAB_CODIGO == xFilial("PAB")+CCODIGO) )
		
		If  (val(::AEMPRESA:CCAPITAL) >= PAB->PAB_CAPDE) .And. (val(::AEMPRESA:CCAPITAL) <= PAB->PAB_CAPATE)

			LVALID := .T.

			::INFOSIND:ALIQ 	:= str(PAB->PAB_ALIQT)
			::INFOSIND:ADIC 	:= str(PAB->PAB_ADIC)
			::INFOSIND:CONTRB 	:= str(PAB->PAB_CONTRB)
			
			/* 
			"	MV_MTAT1 ' multa nos primeiros 30 dias de atraso
			"	MV_MTAT2 ' multa após 30 dias de atraso ao mês
			"	MV_MORA ' juros de mora ao mês 
			"	MV_CORRE ' correção monetária ao mês 
			*/                   
			
            nDia := 31
            cMes := Alltrim(Str(Month(Date()))) 
            cAno := Alltrim(Str(Year(Date())))
            dData := CtoD(Alltrim(Str(nDia))+'/'+cMes+'/'+cAno)
          
            Do  While Empty(dData)
                --nDia
                dData := CtoD(Alltrim(Str(nDia))+'/'+cMes+'/'+cAno)
            EndDo

			nMeses := Int((dData - ::INFOSIND:VENCTO)/30)
//			nMeses := Int(nMeses) + If((nMeses-Int(nMeses)) > 0, 1, 0)
			           
			nMulta := 0
			
			If  (Date() > ::INFOSIND:VENCTO)
				 nMulta := PAA->PAA_MULTA1
			EndIf
				 
			If (Date() > ::INFOSIND:VENCTO + 30) 
				 nMulta += ((nMeses-1) * PAA->PAA_MULTA2)
			EndIf
			
			::INFOSIND:MULTA := nMulta
			
			::INFOSIND:CORREC 	:= (nMeses * PAA->PAA_CORREC)
			::INFOSIND:MORA		:= (nMeses * PAA->PAA_JUROS)

			ADADOS := {{"CODSIND",AEMPRESA:CSINDICA},{"NATUREZ",'003'}}
			
			ALAYOUT := U_VERLAYOUT('1', ADADOS)	

			IF  ALAYOUT[1][1] 
				::INFOSIND:CODBCO	:= ALLTRIM(ALAYOUT[2,2]) 
				::INFOSIND:NOMEBCO	:= ALAYOUT[3,2]
				::INFOSIND:CONTA	:= ALAYOUT[4,2]	
				::INFOSIND:AGENCIA	:= ALAYOUT[5,2]
				::INFOSIND:CEDENTE	:= ALAYOUT[6,2]
				::INFOSIND:SIND		:= ALAYOUT[7,2]
				::INFOSIND:IMAGEM	:= ALAYOUT[8,2]
				::INFOSIND:MOEDA	:= ALAYOUT[9,2]
				::INFOSIND:CNAE		:= ALAYOUT[10,2]
			
				SZQ->(DBSETORDER(1)) //FILIAL+CODIGO
				If  SZQ->(DbSeek(xFilial("SZQ")+PADR(AEMPRESA:CSINDICA,2))) 
					::INFOSIND:SDNOME   := SZQ->ZQ_NOME									                                            
					::INFOSIND:SDEND    := SZQ->ZQ_END									                                            
					::INFOSIND:SDBAIRRO := SZQ->ZQ_BAIRRO									                                            
					::INFOSIND:SDCEP    := SZQ->ZQ_CEP									                                            
					::INFOSIND:SDMUN    := SZQ->ZQ_MUN									                                            
					::INFOSIND:SDEST    := SZQ->ZQ_EST									                                            
					::INFOSIND:SDCGC    := SZQ->ZQ_CGC
					::INFOSIND:SDENTIDA := SZQ->ZQ_ENTSIND									                                            
					::INFOSIND:SDENTID2 := SZQ->ZQ_ENTSIN2									                                            
				ELSE
					LVALID := .F.      
					SetSoapFault("BUSCADADO", "Dados do Sindicato Nao Localizados")    
				ENDIF
				
			ENDIF			
			
			Exit
			
	    EndIf
	    
	    PAB->(DBSKIP())  
	    
	EndDo
	
	If  !( LVALID )                  
		SetSoapFault("BUSCADADO", "Base de Calculo Nao Definida")    		
	EndIf

	Exit
EndDo	  
  	
RETURN LVALID  
       
               
/*************************************************************************************************                                      
* METODO DADOSCONF
* Gisele Nuncherino  
* BUSCA OS DADOS PARA CALCULO DO BOLETO CONFEDERATIVA
* PaRAMETROS: 
* cUserCode = CODIGO DO USUARIO  
* cPassword = senha do usuario
/*************************************************************************************************/

WSMETHOD DADOSCONF WSRECEIVE LRETURN, CODIGO, ITEM, AEMPRESA WSSEND ACLCCONF WSSERVICE SHBOLETO

LOCAL LVALID 	:= .T.
LOCAL I 		:= 0
LOCAL ADADOS 	:= {}
LOCAL APGTO 	:= {}
LOCAL CODIGO 	:= IIF(EMPTY(::CODIGO),'',PADR(::CODIGO,6))
LOCAL TIT		:= ''

/* 	Os dois primeiros dígitos do campo E1_Prefixo com os dois últimos dígitos do ano selecionado no campo "Ano/Parcela". 
	O campo E1_Prefixo não deve possuir a letra "T" no último caractere. 
	E1_Parcela igual à parcela selecionada no campo "Ano/Parcela". 
	E1_Naturez igual a "002" ou "0301".
*/

Do  While .T.
    
  	If  (Alltrim(::AEMPRESA:CFOLCENT) == 'S')
		LVALID := .F.      
		SetSoapFault("DADOSCONF", "Folha de Pagamento centralizada!<br> Esta contribuição não é devida para este CNPJ!")
		Exit
    EndIf

	SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO     
	IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2)))    
		WHILE SE1->(!EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2) 
			IF (ALLTRIM(SE1->E1_NATUREZ) == '002'.OR. ALLTRIM(SE1->E1_NATUREZ) == '0301') .AND. SUBSTR(SE1->E1_PREFIXO,3,1) <> 'T' .AND. !EMPTY(SE1->E1_BAIXA)   
	
	        	AADD(APGTO, {{"PARCELA"	,SE1->E1_PARCELA			},;
	        				 {"ANO"		,SUBSTR(SE1->E1_PREFIXO,1,2)}})
	 		ENDIF
	 		SE1->(DBSKIP())
	 	ENDDO
	ELSE
		APGTO := {}
	ENDIF
	
	/* MONTA A LISTA DE ANO/PARCEL */
	PAC->(DBSETORDER(2)) //PAC_FILIAL+PAC_CODIGO  

	IF  !( PAC->(DBSEEK(XFILIAL("PAC")+CODIGO)) ) 
		LVALID := .F.      
		SetSoapFault("DADOSCONF", "Base de Calculo Nao Definida")
		Exit
	ENDIF

   	Do  WHILE PAC->(!(EOF()) .And. (PAC_FILIAL == XFILIAL("PAC")) .And. (Empty(CODIGO) .Or. (PAC_CODIGO == CODIGO)))

		If  (PAC->PAC_STATUS == 'I') .Or.;
		      !( (Left(PAC->PAC_PARCEL,1) == "1") .And. (::AEMPRESA:DDTNASC < CTOD("01/02/" + PAC->PAC_ANO)) .Or.;
	           (Left(PAC->PAC_PARCEL,1) == "2") .And. (::AEMPRESA:DDTNASC < CTOD("01/08/" + PAC->PAC_ANO)) )
	        PAC->( DbSkip() )
	        Loop
	    EndIf        

   		LVALID := .T.
   		ADADOS 			:= WSCLASSNEW("SCCONF") 
   		ADADOS:FILIAL	:= PAC->PAC_FILIAL
   		ADADOS:CODIGO	:= PAC->PAC_CODIGO	
   		ADADOS:ANO		:= PAC->PAC_ANO		
   		ADADOS:PARCELA	:= PAC->PAC_PARCEL	
   		ADADOS:MESFOLHA := PAC->PAC_MESFOL	
		ADADOS:VLMIN	:= ALLTRIM(transform((PAC->PAC_VLMIN), '@E 999,999,999.99'))	
	    ADADOS:VENORIG	:= PAC->PAC_VENORI
	    ADADOS:MULTA	:= PAC->PAC_MULTA	
	    ADADOS:JUROMES	:= PAC->PAC_JURO	
	    ADADOS:APLACR	:= PAC->PAC_APLACR
	    ADADOS:DTPAGTO	:= PAC->PAC_DTPAGT	 
	    ADADOS:MSG1		:= PAC->PAC_MENS01
	    ADADOS:MSG2		:= PAC->PAC_MENS02
	    ADADOS:MSG3		:= PAC->PAC_MENS03
	    ADADOS:MSG4		:= PAC->PAC_MENS04
	    ADADOS:MSG5		:= PAC->PAC_MENS05
	    ADADOS:MSG6		:= PAC->PAC_MENS06
	    ADADOS:MSG7		:= PAC->PAC_MENS07
	    
	    IF LEN(APGTO)>0
	    	FOR I:=1 TO LEN(APGTO)
	    		IF STRZERO(VAL(APGTO[I][1][2]),2) == STRZERO(VAL(PAC->PAC_PARCEL),2) .AND. APGTO[I][2][2] == SUBSTR(PAC->PAC_ANO,3,2)
					ADADOS:PAGTO := .T.
				ENDIF	    			
	    	NEXT I
	    ELSE
		    ADADOS:PAGTO := .F.
	    ENDIF
	    
	   IF !EMPTY(::ITEM)    
			PAD->(DBSETORDER(1)) //PAD_FILIAL+PAD_CODIGO+PAD_ITEM 
			IF PAD->(DBSEEK(XFILIAL("PAD")+PADR(::CODIGO,6)+PADR(::ITEM,3)))  
			   WHILE PAD->( !(EOF()) .And. (PAD_FILIAL+PAD_CODIGO+PAD_ITEM == XFILIAL("PAD")+PADR(::CODIGO,6)+PADR(::ITEM,3)))
				    ADADOS:ITEM		:= PAD->PAD_ITEM
				    ADADOS:SINDICA	:= PAD->PAD_CODSIN
				    ADADOS:PORCENT	:= PAD->PAD_PORCEN
				    PAD->(DBSKIP())				     
	         ENDDO
	       ELSE
				LVALID := .F.      
				SetSoapFault("DADOSCONF", "Base de Calculo Nao Definida")	       
				Exit
	       ENDIF  
	   ELSEIF EMPTY(::ITEM) .AND. !EMPTY(CODIGO)
			PAD->(DBSETORDER(1)) //PAD_FILIAL+PAD_CODIGO+PAD_ITEM
			IF PAD->(DBSEEK(XFILIAL("PAD")+PADR(::CODIGO,6)))  
			   WHILE PAD->( !(EOF()) .And. (PAD_FILIAL+PAD_CODIGO == XFILIAL("PAD")+PADR(::CODIGO,6)) )                                            
			   		IF ALLTRIM(PAD->PAD_CODSIN) == ALLTRIM(::AEMPRESA:CSINDICA)
					    ADADOS:ITEM		:= PAD->PAD_ITEM
					    ADADOS:SINDICA	:= PAD->PAD_CODSIN
					    ADADOS:PORCENT	:= PAD->PAD_PORCEN
					ENDIF
					PAD->(DBSKIP())				     
	         ENDDO
	       ELSE
				LVALID := .F.      
				SetSoapFault("DADOSCONF", "Base de Calculo Nao Definida")	       
				Exit
	       ENDIF 
	       
	       If  Empty(ADADOS:SINDICA)
				  LVALID := .F.      
				  SetSoapFault("DADOSCONF", "Base de Calculo Nao Definida")	       
				  Exit
	       EndIf 
	   ELSE
		    ADADOS:ITEM		:= ''
		    ADADOS:SINDICA	:= ''
		    ADADOS:PORCENT	:= 0	     
	   ENDIF    
   
		ADADOS:TIT := '0' //**** CANCELADO: Passou para a funcao GRVBOL() ***
        
		If  Empty(ADADOS:PAGTO) .Or. !(ADADOS:PAGTO)
	    	AADD(::ACLCCONF,ADADOS)
	    EndIf	
	    
       	PAC->(DBSKIP())
	ENDDO
	::ACLCCONF := Asort(::ACLCCONF,,,{|x,y| x:ANO+X:PARCELA > y:ANO+Y:PARCELA}) 

	Exit
EndDo	  
  	
RETURN LVALID  


/*************************************************************************************************                                      
* METODO BUSCACONF
* Gisele Nuncherino  
* BUSCA OS DADOS PARA GERACAO DO BOLETO CONFEDERATIVA
* PaRAMETROS: 
* cUserCode = CODIGO DO USUARIO  
* cPassword = senha do usuario
/*************************************************************************************************/

WSMETHOD BUSCACONF WSRECEIVE SINDICA WSSEND INFOSIND WSSERVICE SHBOLETO

LOCAL LVALID := .T.
LOCAL ALAYOUT:= {}
LOCAL ADADOS := {}
 
::INFOSIND:LINK  := Tabela("Z5", ::SINDICA, .F.)

ADADOS := {{"CODSIND",::SINDICA},{"NATUREZ",'002'}}

ALAYOUT := U_VERLAYOUT('2', ADADOS)	
IF  ALAYOUT[1][1] 
	::INFOSIND:CODBCO	:= ALLTRIM(ALAYOUT[2,2]) 
	::INFOSIND:NOMEBCO	:= ALAYOUT[3,2]
	::INFOSIND:CONTA	:= ALAYOUT[4,2]	
	::INFOSIND:AGENCIA	:= ALAYOUT[5,2]
	::INFOSIND:CEDENTE	:= ALAYOUT[6,2]
	::INFOSIND:SIND		:= ALAYOUT[7,2]
	::INFOSIND:IMAGEM	:= ALAYOUT[8,2]
	::INFOSIND:MOEDA	:= ALAYOUT[9,2]
	::INFOSIND:CNAE		:= ALAYOUT[10,2]

	SZQ->(DBSETORDER(1)) //FILIAL+CODIGO
	If SZQ->(DbSeek(xFilial("SZQ")+::SINDICA)) 
		::INFOSIND:SDNOME   := SZQ->ZQ_NOME									                                            
		::INFOSIND:SDEND    := SZQ->ZQ_END									                                            
		::INFOSIND:SDBAIRRO := SZQ->ZQ_BAIRRO									                                            
		::INFOSIND:SDCEP    := SZQ->ZQ_CEP									                                            
		::INFOSIND:SDMUN    := SZQ->ZQ_MUN									                                            
		::INFOSIND:SDEST    := SZQ->ZQ_EST									                                            
		::INFOSIND:SDCGC    := SZQ->ZQ_CGC									                                            
		::INFOSIND:SDENTIDA := SZQ->ZQ_ENTSIND									                                            
		::INFOSIND:SDENTID2 := SZQ->ZQ_ENTSIN2									                                            
	ELSE
		LVALID := .F.      
		SetSoapFault('BUSCACONF', "Dados do Sindicato Nao Localizados")    
	ENDIF
	   
ELSE					
	LVALID := .F.      
	SetSoapFault('BUSCACONF', "Base de Cálculo Nao Definida")    								
ENDIF			


RETURN LVALID  

                     
/*************************************************************************************************                                      
* METODO BUSCAASSO
* Gisele Nuncherino  
* BUSCA OS DADOS PARA CALCULO DO BOLETO ASSOCIATIVA
* PaRAMETROS: 
* cUserCode = CODIGO DO USUARIO  
* cPassword = senha do usuario
/*************************************************************************************************/

WSMETHOD BUSCAASSO WSRECEIVE AEMPRESA WSSEND ACLCASSO WSSERVICE SHBOLETO
                                  
Local cAno, dDtAnoAnt

LOCAL LVALID := .T.
LOCAL ADADOS := {}

/*
Se a situação da empresa (A1_SITUAC) for igual a "AS" ou "SS", a natureza no título (E1_NATUREZ) for igual a "001" 
e o título ainda estiver em aberto (E1_baixa = " "), o site deve disponibilizar o boleto para impressão, buscar e 
analisar as informações da seguinte forma: 
	E1_Prefixo identifica nos dois primeiros dígitos o ANO 
	E1_NUM identifica nos dois primeiros dígitos o MÊS 
	E1_CGC verifica se o título está vinculado ao CNPJ informado pelo usuário 
	E1_PREFIXO com o terceiro digito diferente de "T" 
*/       

SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO 

IF  SE1->(DBSEEK(XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2)))

	dDtAnoAnt := (Date() - (365 * If(::AEMPRESA:CSINDICA == '01', 2 /*SindHosp 2 Anos*/, 1 /*Outros Sindicatos 1 ano*/)))
	dDtAnoAnt := CtoD('01/'+StrZero(Month(dDtAnoAnt),2)+'/'+StrZero(Year(dDtAnoAnt),4))

	Do	WHILE SE1->(!EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2) 

        //**** Para Sindicato SindHosp obter somente os ultimos 12 meses ***
		If  ((::AEMPRESA:CSINDICA == '01') .And. (SE1->E1_VENCTO < dDtAnoAnt))
		    SE1->( DbSkip() )
		    Loop
		EndIf

		IF (ALLTRIM(SE1->E1_NATUREZ) == '001' .OR. ALLTRIM(SE1->E1_NATUREZ) == '1000') .AND. SUBSTR(SE1->E1_PREFIXO,3,1) <> 'T' .AND. EMPTY(SE1->E1_BAIXA)   
		
			cAno := Left(SE1->E1_PREFIXO,2)
			cAno := If(Left(cAno,1)=='9', "19", "20") + cAno
		
	   		ADADOS 			:= WSCLASSNEW("SCASSO")     
	   		ADADOS:FILIAL	:= SE1->E1_FILIAL
	   		ADADOS:PREFIXO	:= SE1->E1_PREFIXO
	   		ADADOS:NUMERO	:= SE1->E1_NUM
	   		ADADOS:ANO		:= cAno
	   		ADADOS:MES		:= Left(SE1->E1_NUM,2)
	   		ADADOS:PARCELA	:= SE1->E1_PARCELA
		    ADADOS:NATUREZ	:= SE1->E1_NATUREZ

			PAG->(DBSETORDER(1)) //PAG_FILIAL+DTOS(PAG_VCTIT)+DTOS(PAG_VENCON)+PAG_CODIGO
			If  PAG->(DbSeek(xFilial("PAG")+DTOS(SE1->E1_VENCTO))) 
				ADADOS:DVENORIG   	:= PAG->PAG_VENCON
			Else	
				ADADOS:DVENORIG	:= SE1->E1_VENCTO
			EndIf	

	   	    AADD(::ACLCASSO,ADADOS)
 		ENDIF

 		SE1->(DBSKIP())

 	ENDDO

	If  (Len(::ACLCASSO) <= 0)
		LVALID := .F.      
		SetSoapFault("BUSCAASSO", "Titulos Nao Localizados")
	Else
	
		::ACLCASSO := Asort(::ACLCASSO,,,{|x,y| x:ANO+x:MES > y:ANO+y:MES}) 
		
	EndIf
ELSE
	LVALID := .F.      
	SetSoapFault("BUSCAASSO", "Titulos Nao Localizados")
ENDIF
  
  	
RETURN LVALID  

/*************************************************************************************************                                      
* METODO GRAVADADO
* Gisele Nuncherino  
* GRAVA OS DADOS PARA GERACAO DO BOLETO SINDICAL
* PaRAMETROS: 
* ABOLETO = DADOS A SEREM GRAVADOS 
/*************************************************************************************************/

WSMETHOD GRAVADADO WSRECEIVE ABOLETO WSSEND TITULO WSSERVICE SHBOLETO

LOCAL LVALID := .T.
LOCAL ADADOS := {}

ADADOS := { {"FILIAL"		, XFILIAL("SZ9")	},;
			{'NATUREZ'		, ::ABOLETO:NATUREZ },;
			{'NUMERO'       , ::ABOLETO:NUMERO	},;
			{'CGC'          , ::ABOLETO:CGC		},;
			{'VALOR'        , ::ABOLETO:VALOR	},;
			{'ANO'          , ::ABOLETO:ANO		},;
			{'PARCELA'      , ::ABOLETO:PARCELA },;
			{'EMISSAO'      , ::ABOLETO:EMISSAO },;
			{'VENCTO'       , ::ABOLETO:VENCTO	},;
			{'SINDIC'       , ::ABOLETO:SINDIC	},;
			{'BASE'         , ::ABOLETO:BASE	   },;
			{'E1NUM'        , ::ABOLETO:E1NUM   }}

::TITULO := U_GRVBOL(ADADOS)

RETURN LVALID  
                  

/*************************************************************************************************                                      
* METODO DADOSASSO
* Gisele Nuncherino  
* BUSCA OS DADOS PARA EMISSAO DO BOLETO CONFEDERATIVA
/*************************************************************************************************/

WSMETHOD DADOSASSO WSRECEIVE APEDIDO, AEMPRESA WSSEND INFOSIND WSSERVICE SHBOLETO

LOCAL LVALID := .T.
LOCAL ALAYOUT:= {}
LOCAL ADADOS := {}
 
::INFOSIND:MSG1  := ''
::INFOSIND:MSG2  := ''
::INFOSIND:MSG3  := ''

::INFOSIND:LINK  := Tabela("Z5", ::AEMPRESA:CSINDICA, .F.)

SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO 
IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(::APEDIDO:CLIENTE,6)+PADR(::APEDIDO:LOJA,2)+PADR(::APEDIDO:PREFIXO,3)+PADR(::APEDIDO:NUMERO,6)+PADR(::APEDIDO:PARCELA,1)))
	WHILE SE1->(!EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA) == XFILIAL("SE1")+PADR(::APEDIDO:CLIENTE,6)+PADR(::APEDIDO:LOJA,2)+::APEDIDO:PREFIXO+::APEDIDO:NUMERO+::APEDIDO:PARCELA
        IF ALLTRIM(SE1->E1_NATUREZ) == ALLTRIM(::APEDIDO:NATUREZ)
			::INFOSIND:VALOR 		:= STR(SE1->E1_VALOR)
			::INFOSIND:VENCTO		:= SE1->E1_VENCTO
			::INFOSIND:NUMTIT		:= SE1->E1_NUM
			::INFOSIND:NATUREZ	:= SE1->E1_NATUREZ
			::INFOSIND:PREFIXO	:= SE1->E1_PREFIXO
			

			ADADOS := {{"CODSIND",::AEMPRESA:CSINDICA},{"NATUREZ",SE1->E1_NATUREZ},{"INISIND",::AEMPRESA:INISIND}}
			ALAYOUT := U_VERLAYOUT('3', ADADOS)	

			IF ALAYOUT[1][1] 
				::INFOSIND:CODBCO	:= ALLTRIM(ALAYOUT[2,2]) 
				::INFOSIND:NOMEBCO	:= ALAYOUT[3,2]
				::INFOSIND:CONTA	:= ALAYOUT[4,2]	
				::INFOSIND:AGENCIA	:= ALAYOUT[5,2]
				::INFOSIND:CEDENTE	:= ALAYOUT[6,2]
				::INFOSIND:SIND		:= ALAYOUT[7,2]
				::INFOSIND:IMAGEM	:= ALAYOUT[8,2]
				::INFOSIND:MOEDA	:= ALAYOUT[9,2]
				::INFOSIND:CNAE		:= ALAYOUT[10,2]
			
				SZQ->(DBSETORDER(1)) //FILIAL+CODIGO
				If SZQ->(DbSeek(xFilial("SZQ")+::AEMPRESA:CSINDICA)) 
					::INFOSIND:SDNOME   := SZQ->ZQ_NOME									                                            
					::INFOSIND:SDEND    := SZQ->ZQ_END									                                            
					::INFOSIND:SDBAIRRO := SZQ->ZQ_BAIRRO									                                            
					::INFOSIND:SDCEP    := SZQ->ZQ_CEP									                                            
					::INFOSIND:SDMUN    := SZQ->ZQ_MUN									                                            
					::INFOSIND:SDEST    := SZQ->ZQ_EST									                                            
					::INFOSIND:SDCGC    := SZQ->ZQ_CGC									                                            
					::INFOSIND:SDENTIDA := SZQ->ZQ_ENTSIND									                                            
					::INFOSIND:SDENTID2 := SZQ->ZQ_ENTSIN2
				ELSE
					LVALID := .F.      
					SetSoapFault("DADOSASSO", "Dados do Sindicato Nao Localizados")    
				ENDIF   
				
				PAG->(DBSETORDER(1)) //PAG_FILIAL+DTOS(PAG_VCTIT)+DTOS(PAG_VENCON)+PAG_CODIGO
				If  PAG->(DbSeek(xFilial("PAG")+DTOS(::INFOSIND:VENCTO)) .And. (PAG_STATUS <> "I"))
					::INFOSIND:DTPGTO   	:= PAG->PAG_VENCON									                                            
	    			::INFOSIND:APLACR		:= PAG->PAG_APLACR
	    			::INFOSIND:MULTA		:= PAG->PAG_MULTA	
	    			::INFOSIND:MORA			:= PAG->PAG_JURO	
	    			::INFOSIND:MSG1			:= PAG->PAG_MENS01	
	    			::INFOSIND:MSG2			:= PAG->PAG_MENS02
	    			::INFOSIND:MSG3			:= PAG->PAG_MENS03
	    			::INFOSIND:MSG4			:= PAG->PAG_MENS04
	    			::INFOSIND:MSG5			:= PAG->PAG_MENS05
	    			::INFOSIND:MSG6			:= PAG->PAG_MENS06
	    			::INFOSIND:MSG7			:= PAG->PAG_MENS07
				ELSE
					LVALID := .F.      
					SetSoapFault("DADOSASSO", "Base de Cálculo Nao Definida")    
				ENDIF
				
				::INFOSIND:TIT := '0' //**** CANCELADO: Passou para a funcao GRVBOL() ***
				
			ELSE					
				LVALID := .F.      
				SetSoapFault("DADOSASSO", "Base de Cálculo Nao Definida")    								
			ENDIF			

        ENDIF
		SE1->(DBSKIP())
	ENDDO

ENDIF                            

If  LVALID .And. Empty(::INFOSIND:CODBCO)
	LVALID := .F.      
	SetSoapFault("DADOSASSO", "Título Não Localizado")    
ENDIF                            
	
RETURN LVALID  


/*************************************************************************************************                                      
* METODO CALCASSI
* Gisele Nuncherino  
* BUSCA OS DADOS PARA CALCULO DO BOLETO ASSOCIATIVA
* PaRAMETROS: 
* cUserCode = CODIGO DO USUARIO  
* cPassword = senha do usuario
/*************************************************************************************************/

WSMETHOD CALCASSI WSRECEIVE AEMPRESA WSSEND CLCASSI WSSERVICE SHBOLETO

LOCAL LVALID := .T.
LOCAL LPGTO  := .F.
LOCAL APGTOS := {}
LOCAL NX	 := 0

/*
verificar se já existe pagamento (registros) na tabela SE1, comparando os campos: 
	Os dois primeiros dígitos do campo E1_Prefixo com os dois últimos dígitos do ano selecionado no campo "Ano/Parcela". 
	O campo E1_Prefixo não deve possuir a letra "T" no ultimo caractere. 
	E1_Parcela igual à parcela selecionada no campo "Ano/Parcela". 
	E1_Naturez igual a "002" ou "0301".
*/       

SE1->(DBSETORDER(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO 
IF SE1->(DBSEEK(XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2)))
	WHILE SE1->(!EOF()) .AND. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA) == XFILIAL("SE1")+PADR(::AEMPRESA:CCODIGO,6)+PADR(::AEMPRESA:CLOJA,2) 
		IF (ALLTRIM(SE1->E1_NATUREZ) == '002' .OR. ALLTRIM(SE1->E1_NATUREZ) == '0301') .AND. SUBSTR(SE1->E1_PREFIXO,3,1) <> 'T' .AND. !EMPTY(SE1->E1_BAIXA)   
			AADD(APGTOS,{{"ANO"		, SUBSTR(SE1->E1_PREFIXO,1,2)	},;
						{"PARCELA"	, SE1->E1_PARCELA				}})
						
		ENDIF
 		SE1->(DBSKIP())
 	ENDDO 
ENDIF

PAF->(DBSETORDER(1)) 

/* MONTA A LISTA DE ANO/PARCELA */
PAE->(DbOrderNickName("BASE")) 

IF  PAE->(DBSEEK(XFILIAL("PAE")+ALLTRIM(::AEMPRESA:CBASE)))  

    Do	While PAE->( !( Eof() ) .And. (PAE_FILIAL+Alltrim(PAE_BASE) == XFILIAL("PAE")+Alltrim(::AEMPRESA:CBASE)) )

		If  (PAE->PAE_STATUS == 'I') .Or.;
		    !( PAF->(DBSEEK(XFILIAL("PAF")+PAE->PAE_CODIGO)) )
			PAE->( DbSkip() )
			Loop
		EndIf	
	
		Do	While PAF->( !( Eof() ) .And. (PAF_FILIAL+PAF_CODIGO == XFILIAL("PAF")+PAE->PAE_CODIGO) )
			
			If  (PAF->PAF_STATUS == 'I') .Or.;
			      !( (Left(PAF->PAF_PARCEL,1) == "1") .And. (::AEMPRESA:DDTNASC < CTOD("01/02/" + SubStr(PAF->PAF_MESANO,4,4))) .Or.;
		             (Left(PAF->PAF_PARCEL,1) == "2") .And. (::AEMPRESA:DDTNASC < CTOD("01/08/" + SubStr(PAF->PAF_MESANO,4,4))) )
		        PAF->( DbSkip() )
		        Loop
		    EndIf        

			LPGTO := .F.
			
			For NX := 1 TO LEN(APGTOS)
				IF 	(Alltrim(APGTOS[NX][1][2]) == SUBSTR(PAF->PAF_MESANO,6,2)) .And. (Alltrim(APGTOS[NX][2][2]) == Alltrim(PAF->PAF_PARCEL))
			    	LPGTO := .T.
			 	ENDIF
			Next NX 
			
			If  LPGTO
			    PAF->(DBSKIP())
				Loop
			EndIf
 		 	
 		 	AASSIST := WSCLASSNEW('SCLCASSI')     
	 		AASSIST:PGTO 	:=  LPGTO			
	 		AASSIST:FILIAL	:=  PAF->PAF_FILIAL	
	    	AASSIST:CODIGO	:=  PAF->PAF_CODIGO	
	       	AASSIST:MESANO	:=  PAF->PAF_MESANO	
			AASSIST:PARCELA	:=  PAF->PAF_PARCEL	
		    AASSIST:DTPAGTO	:=  PAF->PAF_DTPAGT	
		    AASSIST:DESCONT :=  PAF->PAF_DESCON	
		    AASSIST:VLMIN	:=  PAF->PAF_VLMIN	
		    AASSIST:VENCORI	:=  PAF->PAF_VENCOR	
		    AASSIST:MULTA	:=  PAF->PAF_MULTA	
		    AASSIST:JUROS	:=  PAF->PAF_JURO	
		    AASSIST:APLACR	:=  PAF->PAF_APLACR	
		    AASSIST:VLFOLHA	:=  alltrim(transform(val(::AEMPRESA:CCAPITAL), '@E 999,999,999.99'))
		    AASSIST:MSG1	:=  Alltrim(PAE->PAE_MENS01)
		    AASSIST:MSG2	:=  Alltrim(PAE->PAE_MENS02)
		    AASSIST:MSG3	:=  Alltrim(PAE->PAE_MENS03)
		    AASSIST:MSG4	:=  Alltrim(PAE->PAE_MENS04)
		    AASSIST:MSG5	:=  Alltrim(PAE->PAE_MENS05)
		    AASSIST:MSG6	:=  Alltrim(PAE->PAE_MENS06)
		    AASSIST:MSG7	:=  Alltrim(PAE->PAE_MENS07)
		    
		    AADD(::CLCASSI, AASSIST)
		    
		    PAF->(DBSKIP())
		EndDo  
		
		PAE->( DbSkip() )
	
	EndDo
	
	If  (Len(::CLCASSI) <= 0)
		LVALID := .F.      
		SetSoapFault("CALCASSI", "Base de Cálculo Não Definida")
	Else
	
		::CLCASSI := Asort(::CLCASSI,,,{|x,y| SubStr(x:MESANO,4,4)+x:PARCELA > SubStr(y:MESANO,4,4)+y:PARCELA}) 
		
	EndIf
ELSE
	LVALID := .F.      
	SetSoapFault("CALCASSI", "Base de Cálculo Não Definida")
ENDIF	   

RETURN LVALID  


/*************************************************************************************************                                      
* METODO DADOSNEG
* Gisele Nuncherino  
* BUSCA OS DADOS PARA GERACAO DO BOLETO ASSISTENCIAL
/*************************************************************************************************/

WSMETHOD DADOSNEG WSRECEIVE SINDICA WSSEND INFOSIND WSSERVICE SHBOLETO

LOCAL LVALID := .T.
LOCAL ALAYOUT:= {}
LOCAL ADADOS := {}
 

::INFOSIND:MSG1  := ''
::INFOSIND:MSG2  := ''
::INFOSIND:MSG3  := ''
::INFOSIND:MSG4  := ''
::INFOSIND:MSG5  := ''
::INFOSIND:MSG6  := ''
::INFOSIND:MSG7  := ''

::INFOSIND:LINK  := Tabela("Z5", ::SINDICA, .F.)

ADADOS := {{"CODSIND",::SINDICA},{"NATUREZ",'0301'}}

ALAYOUT := U_VERLAYOUT('4', ADADOS)	

IF  ALAYOUT[1][1] 
	::INFOSIND:CODBCO	:= ALLTRIM(ALAYOUT[2,2]) 
	::INFOSIND:NOMEBCO	:= ALAYOUT[3,2]
	::INFOSIND:CONTA	:= ALAYOUT[4,2]	
	::INFOSIND:AGENCIA	:= ALAYOUT[5,2]
	::INFOSIND:CEDENTE	:= ALAYOUT[6,2]
	::INFOSIND:SIND		:= ALAYOUT[7,2]
	::INFOSIND:IMAGEM	:= ALAYOUT[8,2]
	::INFOSIND:MOEDA	:= ALAYOUT[9,2]
	::INFOSIND:CNAE		:= ALAYOUT[10,2]

	SZQ->(DBSETORDER(1)) //FILIAL+CODIGO
	If SZQ->(DbSeek(xFilial("SZQ")+::SINDICA)) 
		::INFOSIND:SDNOME   := SZQ->ZQ_NOME									                                            
		::INFOSIND:SDEND    := SZQ->ZQ_END									                                            
		::INFOSIND:SDBAIRRO := SZQ->ZQ_BAIRRO									                                            
		::INFOSIND:SDCEP    := SZQ->ZQ_CEP									                                            
		::INFOSIND:SDMUN    := SZQ->ZQ_MUN									                                            
		::INFOSIND:SDEST    := SZQ->ZQ_EST									                                            
		::INFOSIND:SDCGC    := SZQ->ZQ_CGC									                                            
		::INFOSIND:SDENTIDA := SZQ->ZQ_ENTSIND
		::INFOSIND:SDENTID2 := SZQ->ZQ_ENTSIN2
	ELSE
		LVALID := .F.      
		SetSoapFault("DADOSNEG", "Dados do Sindicato Nao Localizados")    
	ENDIF
					
ENDIF			


RETURN LVALID  

