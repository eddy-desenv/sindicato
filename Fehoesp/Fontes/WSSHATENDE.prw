#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

User Function _ddddddd ; Return  // "dummy" function - Internal Use 
                                                                                                                                      
/**************************************************************************
* Definicao da estruturas utilizadas                                      *
***************************************************************************/
WSSTRUCT SEmprAtnd

WSDATA CFILIAL			AS STRING OPTIONAL
WSDATA CCGC	          	AS String OPTIONAL
WSDATA CCODIGO        	AS String OPTIONAL    
WSDATA CLOJA          	AS String OPTIONAL
WSDATA CNOME			AS STRING OPTIONAL
WSDATA CNREDUZ			AS STRING OPTIONAL
WSDATA CSINDICA			AS STRING OPTIONAL
WSDATA CSITUAC			AS STRING OPTIONAL
WSDATA DDTABERT			AS DATE OPTIONAL
WSDATA DDTCADAS			AS DATE OPTIONAL
WSDATA CEND				AS STRING OPTIONAL
WSDATA CUF				AS STRING OPTIONAL
WSDATA CMUN				AS STRING OPTIONAL
WSDATA CEST				AS STRING OPTIONAL
WSDATA CBAIRRO			AS STRING OPTIONAL
WSDATA CCAPITAL			AS STRING OPTIONAL
WSDATA CCEP				AS STRING OPTIONAL
WSDATA CTEL				AS STRING OPTIONAL
WSDATA CFAX				AS STRING OPTIONAL
WSDATA CEMAIL			AS STRING OPTIONAL
WSDATA CESCCONT			AS STRING OPTIONAL
WSDATA CCODASSO			AS STRING OPTIONAL
WSDATA CCATEG1			AS STRING OPTIONAL
WSDATA CFILANT			AS STRING OPTIONAL
WSDATA DDTINASS			AS DATE OPTIONAL
WSDATA DDTFIMAS			AS DATE OPTIONAL
WSDATA DDTNASC			AS DATE OPTIONAL
WSDATA DINIATV			AS DATE OPTIONAL
WSDATA CCONTATO			AS STRING OPTIONAL
WSDATA CINAT			AS STRING OPTIONAL
WSDATA CBASE			AS STRING OPTIONAL
WSDATA CBASE2			AS STRING OPTIONAL
WSDATA CFOLCENT			AS STRING OPTIONAL
WSDATA NCATEGOR			AS STRING OPTIONAL
WSDATA cNATUREZ			AS STRING OPTIONAL 
WSDATA cERSIN			AS STRING OPTIONAL

ENDWSSTRUCT 

WSSTRUCT SCombo
	WSDATA CVALUE 			AS STRING OPTIONAL
ENDWSSTRUCT    

WSSTRUCT strLogin
    WSDATA CODIGO AS STRING OPTIONAL
    WSDATA NOME   AS STRING OPTIONAL
ENDWSSTRUCT    
               
/***************************************************************************
* Definicao do Web Service de Controle do Usuario                         *
***************************************************************************/
WSSERVICE SHATENDE

   WSDATA AEMPRESA					as SEmprAtnd 
   WSDATA ACOMBO 					As Array Of SCombo
   WSDATA AESCRITO					as SESCRITO
   WSDATA AEND						as SEND
   WSDATA CROTINA					as STRING
   WSDATA LRETURN					as BOOLEAN
   WSDATA CCGC						as STRING OPTIONAL
   WSDATA CLCGC						as STRING OPTIONAL
   WSDATA CCOD						as STRING OPTIONAL
   WSDATA CNOME						as STRING OPTIONAL
   WSDATA CLNOME					as STRING OPTIONAL
   WSDATA CODESCR					as STRING OPTIONAL
   WSDATA CODEMP					as STRING OPTIONAL
   WSDATA CEP						as STRING OPTIONAL
   WSDATA CTIPO						as STRING OPTIONAL
   WSDATA USUARIO                   AS STRING OPTIONAL
   WSDATA SENHA                     AS STRING OPTIONAL 
   Wsdata StrLogin                  as strlogin
   
   WSMETHOD VERCADEMP			
   WSMETHOD VERCADESC			
   WSMETHOD BUSCAESC			
   WSMETHOD VINCESCR			
   WSMETHOD VEREMPAUX			
   WSMETHOD VERESCAUX 			
   WSMETHOD BUSCACEP			
   WSMETHOD VEREMPESC
   WSMETHOD GETCOMBO
   WSMETHOD GetLogin			
   
ENDWSSERVICE

//Verifica Login e senha do usuario
WSMETHOD GetLogin WSRECEIVE USUARIO, SENHA WSSEND strlogin WSSERVICE SHATENDE

Local lRetorno   := .T.        
Local aArea      := GetArea()          
Local aRet       := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ CONSULTA USUARIO E SENHA DO PROTHEUS                                             |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PswOrder(2)
If PswSeek(::USUARIO)
   If ! PswName(::SENHA)
       lRetorno := .F. 
       SetSoapFault("Login" , "Senha invalida.")                           
   Else
   	   aRet := PswRet()      
       ::strLogin:CODIGO := aRet[1][2]
        ::strLogin:NOME := aRet[1][4]//usrretname(::Usuario)
   EndIf     
Else
       lRetorno := .F.
       SetSoapFault("Login" , "Usuario invalido.")                        
EndIf

RestArea(aArea)                             
Return lRetorno
 

/**************************************************************************************************
* PaRAMETROS: 
* CTIPO		= 1 = Lista de CNPJ / 2 = Lista de nomes
* ACOMBO	= Lista para preenchimento de combo
/*************************************************************************************************/
WSMETHOD GETCOMBO WSRECEIVE CTIPO,CNOME WSSEND ACOMBO WSSERVICE SHATENDE  
           
LOCAL CNOME_    := ''
LOCAL LVALID	:= .T.  
Local cQuery 	:= "" 
Local nI 		:= 0  
Local aArea		:= GetArea()  
Local cAlias	:= GetNextAlias()

Local cValor	:= "xxxxxx"

IF !EMPTY(::CNOME)
	CNOME_ := ::CNOME
ELSE
    CNOME_ := 'XXXXXX'	  
ENDIF 

dbSelectArea("SA1") 

IF (::CTIPO == "2")
    cQuery := "Select A1_NOME as VALUE FROM "+RetSqlName("SA1")+" WHERE A1_NOME LIKE '%"+CNOME_+"%' AND D_E_L_E_T_ = ''  ORDER BY A1_NOME" 
ELSE
    cQuery := "Select A1_CGC as VALUE FROM "+RetSqlName("SA1")+" WHERE A1_CGC LIKE '%"+CNOME_+"%' AND D_E_L_E_T_ = ''  ORDER BY A1_CGC"
ENDIF  


cQuery := ChangeQuery(cQuery)     
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias)	                              

	
   If !(cAlias)->( Eof() )   //LOCALIZOU 
		While !(cAlias)->( Eof() )  
		
		  If  (ALLTRIM((cAlias)->VALUE) != cValor)
		      cValor := ALLTRIM((cAlias)->VALUE)
		  
			  nI++ 
			  aAdd( ::ACOMBO, WsClassNew("SCombo") )
			  ::ACOMBO[nI]:CVALUE      := cValor 
		  EndIf
		  
		  (cAlias)->( dbSkip() )      
     	EndDo
	
		LVALID := .T.
	ELSE                                           
		//SetSoapFault("GETCOMBO", "CNPJ Nao Localizado")	
		LVALID := .F.
		//::AEMPRESA := WSCLASSNEW('SEmprAtnd')	
		SetSoapFault("GETCOMBO", "Nenhum registro localizado")
    ENDIF 
    RestArea(aArea)	
RETURN LVALID

    
/*************************************************************************************************                                      
* METODO VERCADEMP
* Alex Adriano
* VERIFICA SE A EMPRESA ESTA OU NAO CADASTRADA
* PaRAMETROS: 
* CCGC 		= CNPJ DA EMPRESA  
* CCOD 		= Código protheus 
* CNOME		= Nome da empresa  
* AEMPRESA	= RETORNO COM OS DADOS DA EMPRESA
/*************************************************************************************************/
WSMETHOD VERCADEMP WSRECEIVE CCGC,CLCGC,CCOD,CNOME,CLNOME WSSEND AEMPRESA WSSERVICE SHATENDE  
           
LOCAL CCGC_ 	:= ''
LOCAL CCOD_     := ''
LOCAL CNOME_    := ''
LOCAL LVALID	:= .T.  
Local cQuery := "" 

IF  !( EMPTY(::CLCGC) )
	CCGC_ := "A1_CGC = '" + Alltrim(U_LIMPACGC(::CCGC)) + "' "
ELSEIF !EMPTY(::CCGC)
	CCGC_ := "A1_CGC LIKE '%" + U_LIMPACGC(::CCGC) + "%' "
ELSE
    CCGC_ := ''	  
ENDIF 

IF  !( EMPTY(::CCOD) )
	CCOD_ := If(!(Empty(CCGC_)), " Or ", "") + " A1_COD = '" + ::CCOD + "' "
ELSE
    CCOD_ := ''	  
ENDIF

IF  !( EMPTY(::CLNOME) )
	CNOME_ := If(!(Empty(CCGC_+CCOD_)), " Or ", "") + " A1_NOME = '" + Alltrim(::CLNOME) + "' "
ELSEIF !EMPTY(::CNOME)
	CNOME_ := If(!(Empty(CCGC_+CCOD_)), " Or ", "") + " A1_NOME LIKE '%" + ::CNOME + "%' "
ELSE
    CNOME_ := ''	  
ENDIF

	cQuery := "SELECT * FROM "+RetSqlName("SA1")+" WHERE ("+CCGC_+CCOD_+CNOME_+") AND D_E_L_E_T_ = ''"	
	If SELECT("WS_SA1") > 0 	
		dbSelectArea("WS_SA1")	
		dbCloseArea()		
	EndIf		                                        
		
	//cQuery := ChangeQuery(cQuery)	
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,, cQuery), "WS_SA1", .T., .T. )
	dbSelectArea("WS_SA1") 
	

	//SA1->(dbSetOrder(3)) //busca por cgc
	If !WS_SA1->( EOF() )   //LOCALIZOU 
		::AEMPRESA := WSCLASSNEW('SEmprAtnd')  
		::AEMPRESA:cCodigo        := WS_SA1->A1_COD   
		::AEMPRESA:cCGC	          := WS_SA1->A1_CGC
		::AEMPRESA:cLoja          := WS_SA1->A1_LOJA
		::AEMPRESA:CFILIAL		  := WS_SA1->A1_FILIAL
		::AEMPRESA:CNOME		  := WS_SA1->A1_NOME
		::AEMPRESA:CCEP			  := WS_SA1->A1_CEP
		::AEMPRESA:CEND			  := WS_SA1->A1_END 
		::AEMPRESA:CBAIRRO		  := WS_SA1->A1_BAIRRO 
		::AEMPRESA:CMUN			  := WS_SA1->A1_MUN 
		::AEMPRESA:CUF			  := WS_SA1->A1_EST 
		::AEMPRESA:CEMAIL		  := WS_SA1->A1_EMAIL 
		::AEMPRESA:CTEL			  := WS_SA1->A1_DDD + WS_SA1->A1_TEL
		::AEMPRESA:CFAX			  := WS_SA1->A1_FAX 
		::AEMPRESA:CCAPITAL		  := str(WS_SA1->A1_CAPITAL)
		::AEMPRESA:DINIATV		  := STOD(WS_SA1->A1_DTINIC) 
		::AEMPRESA:CCONTATO		  := WS_SA1->A1_SCONTAT
		::AEMPRESA:CINAT		  := If(!(Empty(WS_SA1->A1_INAT)), "Consumidor Inativo", "Consumidor Ativo")
		::AEMPRESA:CSINDICA		  := WS_SA1->A1_SINDICA +" - "+ POSICIONE("SZQ",1,XFILIAL("SZQ")+WS_SA1->A1_SINDICA,"ZQ_NOME")
		::AEMPRESA:DDTNASC		  := STOD(WS_SA1->A1_DTNASC) 
		::AEMPRESA:DDTCADAS		  := STOD(WS_SA1->A1_DTCADAS)
        ::AEMPRESA:DDTABERT		  := STOD(WS_SA1->A1_DTINIC)
		::AEMPRESA:CBASE		  := WS_SA1->A1_BASE
 		::AEMPRESA:CESCCONT		  := WS_SA1->A1_ESCCONT // CODIGO ESCRITORIO CONTABIL
		::AEMPRESA:CFOLCENT		  := WS_SA1->A1_FOLCENT 
		::AEMPRESA:NCATEGOR		  := WS_SA1->A1_CATEG1 
		::AEMPRESA:cNATUREZ		  := WS_SA1->A1_NATUREZ
		::AEMPRESA:CNREDUZ        := WS_SA1->A1_NREDUZ
		
		//ASSOCIADOS   
		::AEMPRESA:CSITUAC		  := U_SITUADESCR(WS_SA1->A1_SITUAC)
		::AEMPRESA:cERSIN		  := WS_SA1->A1_ERSIN +" - "+ POSICIONE("SX5",1,XFILIAL("SX5")+"96"+WS_SA1->A1_ERSIN,"X5_DESCRI") 
		::AEMPRESA:CCODASSO		  := WS_SA1->A1_CODASSO 
	    ::AEMPRESA:DDTINASS		  := STOD(WS_SA1->A1_DTINASS)
	    ::AEMPRESA:DDTFIMAS		  := STOD(WS_SA1->A1_DTFIMAS)
		::AEMPRESA:CCATEG1		  := WS_SA1->A1_CATEG1 +" - "+ POSICIONE("SZU",1,XFILIAL("SZU")+WS_SA1->A1_CATEG1,"ZU_NOME")    
		::AEMPRESA:CBASE		  := WS_SA1->A1_BASE +" - "+ POSICIONE("SX5",1,XFILIAL("SX5")+"97"+WS_SA1->A1_BASE,"X5_DESCRI")
		::AEMPRESA:CFILANT		  := WS_SA1->A1_FILANT  

		LVALID := .T.
	ELSE                                           
		//SetSoapFault("VERCADEMP", "CNPJ Nao Localizado")	
		LVALID := .F.
		//::AEMPRESA := WSCLASSNEW('SEmprAtnd')	
		SetSoapFault("VERCADEMP", "Empresa não localizada")
    ENDIF

RETURN LVALID


/*************************************************************************************************                                      
* METODO VERCADESC
* Gisele Nuncherino  
* VERIFICA SE EXISTE OU NAO ESCRITORIO ASSOCIADO
* PaRAMETROS: 
* CCGC		= CGC DO ESCRITORIO CONTABIL   
* AESCRIT	= RETORNO COM OS DADOS DO ASSOCIADO
/*************************************************************************************************/
WSMETHOD VERCADESC WSRECEIVE CCGC WSSEND AESCRITO WSSERVICE SHATENDE  

LOCAL LVALID	:= .T.  

IF !EMPTY(::CCGC)
	SZC->(DBSETORDER(2)) //busca por CGC   

	IF SZC->(dbSeek(xFilial("SZC") + PADR(::CCGC,14)))  //LOCALIZOU 
		::AESCRITO := WSCLASSNEW('SESCRITO')

		::AESCRITO:cCodigo 	:= SZC->ZC_CODIGO    
		::AESCRITO:cCGC	  	:= SZC->ZC_CGC
		::AESCRITO:CFILIAL 	:= SZC->ZC_FILIAL
		::AESCRITO:CNOME  	:= SZC->ZC_NOMESC
		::AESCRITO:CCEP	  	:= SZC->ZC_CEP
		::AESCRITO:CEND		:= SZC->ZC_END
		::AESCRITO:CBAIRRO	:= SZC->ZC_BAIRRO
		::AESCRITO:CMUN		:= SZC->ZC_MUN
		::AESCRITO:CUF		:= SZC->ZC_EST
		::AESCRITO:CEMAIL	:= SZC->ZC_EMAIL
		::AESCRITO:CTEL		:= SZC->ZC_FONE
		::AESCRITO:CFAX		:= SZC->ZC_FAX
		::AESCRITO:CCONTATO	:= SZC->ZC_CONTATO
		//::AESCRITO:ERSIN	:= SZC->ZC_ERSIN
		
		LVALID := .T.
    ENDIF
ELSE
	LVALID := .F. 
	SetSoapFault("VERCADESC", "Codigo do Escritorio Contabil Nao Informado")
ENDIF

RETURN LVALID  

/*************************************************************************************************                                      
* METODO BUSCAESC
* Gisele Nuncherino  
* VERIFICA SE EXISTE OU NAO ESCRITORIO CONTABIL PARA DETERMINADA EMPRESA 
* PaRAMETROS: 
* CODESCR		= CODIGO DO ESCRITORIO CONTABIL   
* AESCRIT	= RETORNO COM OS DADOS DO ESCRITORIO CONTABIL
/*************************************************************************************************/
WSMETHOD BUSCAESC WSRECEIVE CODESCR WSSEND AESCRITO WSSERVICE SHATENDE  

LOCAL LVALID	:= .T.  
IF !EMPTY(::CODESCR)
	SZC->(DBSETORDER(1)) //busca por CODIGO   

	IF SZC->(dbSeek(xFilial("SZC") + ::CODESCR))  //LOCALIZOU 
		::AESCRITO := WSCLASSNEW('SESCRITO')

		::AESCRITO:cCodigo 	:= SZC->ZC_CODIGO    
		::AESCRITO:cCGC	  	:= SZC->ZC_CGC
		::AESCRITO:CFILIAL 	:= SZC->ZC_FILIAL
		::AESCRITO:CNOME  	:= SZC->ZC_NOMESC
		::AESCRITO:CCEP	  	:= SZC->ZC_CEP
		::AESCRITO:CEND		:= SZC->ZC_END
		::AESCRITO:CBAIRRO	:= SZC->ZC_BAIRRO
		::AESCRITO:CMUN		:= SZC->ZC_MUN
		::AESCRITO:CUF		:= SZC->ZC_EST
		::AESCRITO:CEMAIL	:= SZC->ZC_EMAIL
		::AESCRITO:CTEL		:= SZC->ZC_FONE
		::AESCRITO:CFAX		:= SZC->ZC_FAX
		::AESCRITO:CCONTATO	:= SZC->ZC_CONTATO
		
		LVALID := .T.
    ENDIF
ELSE
	LVALID := .F. 
	SetSoapFault("BUSCAESC", "Codigo do Escritorio Contabil Nao Informado")
ENDIF

RETURN LVALID 

//User Function SITUADESCR
//ALEX ADRIANO - 16/07/2010
// METODO QUE TRADUZ O CODIGO DA SITUAÇÃO PELA DESCRIÇÃO DA MESMA
//WS_SA1->A1_SITUAC 
//AS=Socio Ativo;IS=Socio Inativo;SS=Socio Suspenso;CT=Contratos           
User Function SITUADESCR(cod)
if(cod == "AS")
  return "Socio Ativo"
ELSEIF(COD == "IS")
  return "Socio Inativo"  
ELSEIF(COD == "SS")
  return "Socio Suspenso" 
ELSEIF(COD == "CT")
  return "Contratos" 
ELSEIF Empty(COD)  
  return "Nao Socio"
else
 return cod
endif
RETURN



/*************************************************************************************************                                      
* METODO VINCESCR
* Gisele Nuncherino  
* VINCULA O ESCRITORIO CONTABIL COM DETERMINADA EMPRESA 
* PaRAMETROS: 
* CODESCR	= CODIGO DO ESCRITORIO CONTABIL   
* CODEMP	= CODIGO DA EMPRESA
/*************************************************************************************************/
WSMETHOD VINCESCR WSRECEIVE CODESCR,CODEMP WSSEND LRETURN WSSERVICE SHATENDE  

LOCAL LVALID	:= .T.  

IF !EMPTY(::CODESCR) .OR. !EMPTY(::CODEMP)
	
	SA1->(DBSETORDER(1)) //busca PELO CODIGO E LOJA
	IF SA1->(dbSeek(xFilial("SA1") + ::CODEMP))  //LOCALIZOU 
		RECLOCK("SA1",.F.)
			SA1->A1_ESCONT 	:= ::CODESCR 
		SA1->(MSUNLOCK())
		LVALID := .T.
	ELSE                                           
		SetSoapFault("VINCESCR", "Codigo da Empresa Nao Localizado")	
		LVALID := .F.	
    ENDIF
ELSE
	LVALID := .F. 
	SetSoapFault("VINCESCR", "Codigo do Escritorio Contabil/Empresa Nao Informado")
ENDIF

RETURN LVALID


/*************************************************************************************************                                      
* METODO VEREMPAUX
* Gisele Nuncherino  
* LOCALIZA O REGISTRA DA EMPRESA NA TABELA AUXILIAR
* PaRAMETROS: 
* CCGC 		= CNPJ DA EMPRESA   
* AEMPRESA	= RETORNO COM OS DADOS DA EMPRESA
/*************************************************************************************************/
WSMETHOD VEREMPAUX WSRECEIVE CCGC WSSEND AEMPRESA WSSERVICE SHATENDE  

           
LOCAL CCGC_ 	:= ''
LOCAL LVALID	:= .T.  

IF !EMPTY(::CCGC)
	CCGC_ := U_LIMPACGC(::CCGC)
                     
	PA8->(dbSetOrder(2)) //busca por cgc
	IF PA8->(dbSeek(xFilial("PA8") + PADR(ALLTRIM(CCGC_),14)))  //LOCALIZOU 
		::AEMPRESA := WSCLASSNEW('SEmprAtnd')

		::AEMPRESA:cCodigo        := PA8->PA8_CODIGO   
		::AEMPRESA:cCGC	          := PA8->PA8_CGC
		::AEMPRESA:cLoja          := PA8->PA8_LOJA
		::AEMPRESA:CFILIAL		  := PA8->PA8_FILIAL
		::AEMPRESA:CNOME		  := PA8->PA8_NOME
		::AEMPRESA:CCEP			  := PA8->PA8_CEP
		::AEMPRESA:CEND			  := PA8->PA8_END 
		::AEMPRESA:CBAIRRO		  := PA8->PA8_BAIRRO 
		::AEMPRESA:CMUN			  := PA8->PA8_MUN 
		::AEMPRESA:CUF			  := PA8->PA8_EST 
		::AEMPRESA:CEMAIL		  := PA8->PA8_EMAIL 
		::AEMPRESA:CTEL			  := PA8->PA8_TEL
		::AEMPRESA:CFAX			  := PA8->PA8_FAX 
		::AEMPRESA:CCAPITAL		  := STR(PA8->PA8_CAPITA)
		::AEMPRESA:DINIATV		  := PA8->PA8_DTINIC 
		::AEMPRESA:CCONTATO		  := PA8->PA8_CONTAT
		
		LVALID := .T.
	ELSE                                           
		LVALID := .T.
		::AEMPRESA := WSCLASSNEW('SEmprAtnd')	
    ENDIF
ELSE
	LVALID := .F. 
	SetSoapFault("VEREMPAUX", "CNPJ Nao Informado")
ENDIF

RETURN LVALID


/*************************************************************************************************                                      
* METODO VERESCAUX
* Gisele Nuncherino  
* LOCALIZA O REGISTRA DO ESCRITORIO NA TABELA AUXILIAR
* PaRAMETROS: 
* CCGC 		= CNPJ DA EMPRESA   
* AESCRITO  = RETORNO COM OS DADOS DO ESCRITORIO
/*************************************************************************************************/
WSMETHOD VERESCAUX WSRECEIVE CCGC WSSEND AESCRITO WSSERVICE SHATENDE  

           
LOCAL CCGC_ 	:= ''
LOCAL LVALID	:= .T.  

IF !EMPTY(::CCGC)
	CCGC_ := U_LIMPACGC(::CCGC)

	PA9->(dbSetOrder(2)) //busca por cgc
	IF PA9->(dbSeek(xFilial("PA9") + CCGC_))  //LOCALIZOU 
		::AESCRITO := WSCLASSNEW('SESCRITO')

		::AESCRITO:cCodigo        := PA9->PA9_CODIGO   
		::AESCRITO:cCGC	          := PA9->PA9_CGC
		//::AESCRITO:cLoja          := PA9->PA9_LOJA
		::AESCRITO:CFILIAL		  := PA9->PA9_FILIAL
		::AESCRITO:CNOME		  := PA9->PA9_NOME
		::AESCRITO:CCEP			  := PA9->PA9_CEP
		::AESCRITO:CEND			  := PA9->PA9_END 
		::AESCRITO:CBAIRRO		  := PA9->PA9_BAIRRO 
		::AESCRITO:CMUN			  := PA9->PA9_MUN 
		::AESCRITO:CUF			  := PA9->PA9_EST 
		::AESCRITO:CEMAIL		  := PA9->PA9_EMAIL 
		::AESCRITO:CTEL			  := PA9->PA9_TEL
		::AESCRITO:CFAX			  := PA9->PA9_FAX 
		::AESCRITO:CCONTATO		  := PA9->PA9_CONTAT
		
		LVALID := .T.
	ELSE                                           
		LVALID := .T.
		::AESCRITO := WSCLASSNEW('SESCRITO')	
    ENDIF
ELSE
	LVALID := .F. 
	SetSoapFault("VERESCAUX", "CNPJ Nao Informado")
ENDIF

RETURN LVALID

/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BUSCACEPº Autor ³Gisele Nuncherino   	º  Data ³28/04/2010   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Função responsável POR BUSCAR OS DADOS CEP			      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SHATENDE                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

/*/

WSMETHOD BUSCACEP WSRECEIVE CEP WSSEND AEND WSSERVICE SHATENDE  

LOCAL LVALID 	:= .T.

IF EMPTY(::CEP)
	LVALID := .F. 
	SetSoapFault("BUSCACEP", "CEP Nao Informado")
ENDIF 
	
CEP->(DBSETORDER(1)) 
IF CEP->(DbSeek(xFilial("CEP")+::CEP)) 
    LVALID := .T.
	::AEND:ENDERECO	:= CEP->CEP_END
	::AEND:BAIRRO   := CEP->CEP_BAIRRO
	::AEND:CEP      := CEP->CEP_NUM
	::AEND:MUN      := CEP->CEP_MUN
	::AEND:EST      := CEP->CEP_EST
	::AEND:ERSIN    := Posicione("SZO",1,xFilial("SZO")+CEP->CEP_MUN,"ZO_ERSIN")
	::AEND:BASE     := Posicione("SZO",1,xFilial("SZO")+CEP->CEP_MUN,"ZO_BASE")
	::AEND:BASE2    := Posicione("SZO",1,xFilial("SZO")+CEP->CEP_MUN,"ZO_BASE2")
ELSE
	LVALID := .F. 
	SetSoapFault("BUSCACEP", "CEP Nao Localizado")
ENDIF

Return LVALID


/*************************************************************************************************                                      
* METODO VERCADESC
* Gisele Nuncherino  
* VERIFICA SE EXISTE OU NAO ESCRITORIO CONTABIL PARA DETERMINADA EMPRESA 
* PaRAMETROS: 
* CODESCR	= CODIGO DO ESCRITORIO CONTABIL   
* AESCRIT	= RETORNO COM OS DADOS DO ESCRITORIO CONTABIL
/*************************************************************************************************/
WSMETHOD VEREMPESC WSRECEIVE CODESCR WSSEND AESCRITO WSSERVICE SHATENDE  

LOCAL LVALID	:= .T.  

IF !EMPTY(::CODESCR)
	
	SZC->(DBORDERNICKNAME("ESCONT")) //busca por A1_ESCONT
	IF SZC->(dbSeek(xFilial("SZC") + ::CODESCR))  //LOCALIZOU 
		::AESCRITO := WSCLASSNEW('SESCRITO')

		::AESCRITO:cCodigo 	:= SZC->ZC_CODIGO    
		::AESCRITO:cCGC	  	:= SZC->ZC_CGC
		::AESCRITO:CFILIAL 	:= SZC->ZC_FILIAL
		::AESCRITO:CNOME	:= SZC->ZC_NOMESC
		::AESCRITO:CCEP	  	:= SZC->ZC_CEP
		::AESCRITO:CEND		:= SZC->ZC_END
		::AESCRITO:CBAIRRO	:= SZC->ZC_BAIRRO
		::AESCRITO:CMUN		:= SZC->ZC_MUN
		::AESCRITO:CUF		:= SZC->ZC_EST
		::AESCRITO:CEMAIL	:= SZC->ZC_EMAIL
		::AESCRITO:CTEL		:= SZC->ZC_FONE
		::AESCRITO:CFAX		:= SZC->ZC_FAX
		::AESCRITO:CCONTATO	:= SZC->ZC_CONTATO
		
		LVALID := .T.
	ELSE                                           
		SetSoapFault("VERCADESC", "Codigo do Escritorio Contabil Nao Localizado")	
		LVALID := .F.	
    ENDIF
ELSE
	LVALID := .F. 
	SetSoapFault("VERCADESC", "Codigo do Escritorio Contabil Nao Informado")
ENDIF

RETURN LVALID  
