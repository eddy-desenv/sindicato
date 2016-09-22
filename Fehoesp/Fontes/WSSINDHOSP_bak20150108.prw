#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

User Function _YYYYYYY ; Return  // "dummy" function - Internal Use 

/**************************************************************************
* Definicao da estruturas utilizadas                                      *
***************************************************************************/
WSSTRUCT UserDados

WSDATA cEmail	             AS String    
WSDATA cCodigo	             AS String
WSDATA cNome	             AS String
WSDATA cFornec	             AS String
WSDATA cLoja	             AS String
WSDATA cUser	             AS String
WSDATA LADM		             AS BOOLEAN
WSDATA cPerfil	             AS STRING

ENDWSSTRUCT

           
WSSTRUCT SEmpresa

WSDATA cCodigo        	AS String OPTIONAL    
WSDATA cCGC	          	AS String OPTIONAL
WSDATA cLoja          	AS String OPTIONAL
WSDATA CFILIAL			AS STRING OPTIONAL
WSDATA CNOME			AS STRING OPTIONAL
WSDATA CCEP				AS STRING OPTIONAL
WSDATA CEND				AS STRING OPTIONAL
WSDATA CBAIRRO			AS STRING OPTIONAL
WSDATA CMUN				AS STRING OPTIONAL
WSDATA CUF				AS STRING OPTIONAL
WSDATA CEMAIL			AS STRING OPTIONAL
WSDATA CTEL				AS STRING OPTIONAL
WSDATA CFAX				AS STRING OPTIONAL
WSDATA CCAPITAL			AS STRING OPTIONAL
WSDATA DINIATV			AS DATE   OPTIONAL
WSDATA CCONTATO			AS STRING OPTIONAL
WSDATA CSITUAC			AS STRING OPTIONAL
WSDATA CINAT			AS STRING OPTIONAL
WSDATA CSINDICA			AS STRING OPTIONAL
WSDATA DDTNASC			AS DATE   OPTIONAL
WSDATA CNATUREZ			AS STRING OPTIONAL
WSDATA CBASE			AS STRING OPTIONAL
WSDATA CBASE2			AS STRING OPTIONAL
WSDATA ERSIN			AS STRING OPTIONAL
WSDATA CODESCR			AS STRING OPTIONAL
WSDATA CFOLCENT			AS STRING OPTIONAL
WSDATA CCAPCENT			AS STRING OPTIONAL
WSDATA CFILANTR			AS STRING OPTIONAL
WSDATA NCATEGOR			AS STRING OPTIONAL
WSDATA INISIND			AS DATE   OPTIONAL  //A1_INISIND
WSDATA CNAE				AS STRING OPTIONAL  
WSDATA PORTAL			AS STRING OPTIONAL  
WSDATA NLEITOS			AS STRING OPTIONAL
WSDATA NNUMFUN			AS STRING OPTIONAL

ENDWSSTRUCT
               

WSSTRUCT SESCRITO

WSDATA cCodigo        	AS String  OPTIONAL  
WSDATA cCGC	          	AS String OPTIONAL
WSDATA CFILIAL			AS STRING OPTIONAL
WSDATA CNOME			AS STRING OPTIONAL
WSDATA CCEP				AS STRING OPTIONAL
WSDATA CEND				AS STRING OPTIONAL
WSDATA CBAIRRO			AS STRING OPTIONAL
WSDATA CMUN				AS STRING OPTIONAL
WSDATA CUF				AS STRING OPTIONAL
WSDATA CEMAIL			AS STRING OPTIONAL
WSDATA CTEL				AS STRING OPTIONAL
WSDATA CFAX				AS STRING OPTIONAL
WSDATA CCONTATO			AS STRING OPTIONAL  


ENDWSSTRUCT

      
WSSTRUCT SEND

WSDATA ENDERECO     	AS String    
WSDATA BAIRRO       	AS String
WSDATA CEP				AS STRING
WSDATA MUN				AS STRING
WSDATA EST				AS STRING 
WSDATA ERSIN			AS STRING
WSDATA BASE				AS STRING
WSDATA BASE2			AS STRING
WSDATA SINDICATO		AS STRING

ENDWSSTRUCT

/***************************************************************************
* Definicao do Web Service de Controle do Usuario                         *
***************************************************************************/
WSSERVICE SINDHOSP

   WSDATA cUserCode                 AS String
   WSDATA cPassword			      	As String
   WSDATA sUserDados				as UserDados
   WSDATA AEMPRESA					as SEMPRESA
   WSDATA AESCRITO					as SESCRITO
   WSDATA AEND						as SEND
   WSDATA CROTINA					as STRING
   WSDATA LRETURN					as BOOLEAN
   WSDATA CCGC						as STRING
   WSDATA CODESCR					as STRING
   WSDATA CODEMP					as STRING
   WSDATA CEP						as STRING
   
   WSMETHOD Autenticar
   WSMETHOD CadEmpresa			
   WSMETHOD CADESCRIT			
   WSMETHOD VERCADEMP			
   WSMETHOD VERCADESC			
   WSMETHOD BUSCAESC			
   WSMETHOD VINCESCR			
   WSMETHOD VEREMPAUX			
   WSMETHOD VERESCAUX 			
   WSMETHOD BUSCACEP			
   WSMETHOD VEREMPESC			
   
ENDWSSERVICE


/*************************************************************************************************                                      
* METODO Autenticar
* Gisele Nuncherino  
* VERIFICA SE OS DADOS USUARIO E SENHA FORNECIDOS ESTAO CORRETOS
* PaRAMETROS: 
* cUserCode = CODIGO DO USUARIO  
* cPassword = senha do usuario
/*************************************************************************************************/


WSMETHOD Autenticar WSRECEIVE cUserCode,cPassword WSSEND sUserDados WSSERVICE SINDHOSP

LOCAL LRETORNO 	:= .T.

PSWORDER(3) // ORDENA A BUSCA PELA SENHA   

IF PSWSEEK(PADR(ALLTRIM(::cPassword),6), .T.) 
	_ARETUSER := PSWRET(1) 
   
	 If (len(_ARETUSER) > 0 .AND. aScan( _ARETUSER[1][10], '000000' ) <> 0) .OR. _ARETUSER[1,2] == '000000' // administrador
 		IF (UPPER(ALLTRIM(padr(_ARETUSER[1,2],15))) == UPPER(ALLTRIM(padr(::cusercode,15))))
				
			::SUSERDADOS:cEmail := _ARETUSER[1,14]
			::SUSERDADOS:cCodigo := _ARETUSER[1,1]
			::SUSERDADOS:cNome := _ARETUSER[1,4] 
	   		::SUSERDADOS:cUser := _ARETUSER[1,2]
			::SUSERDADOS:cFornec := ""
			::SUSERDADOS:cLoja := ""
			::SUSERDADOS:LADM := .T.	     
 			::SUSERDADOS:CPERFIL := "A"
		ELSE
			lRetorno := .F.
			SetSoapFault("LOGIN","USUARIO/SENHA INVALIDOS") 	
		ENDIF  
	ELSE	 
			lRetorno := .F.
			SetSoapFault("LOGIN","USUARIO SEM PERMISSAO DE ACESSO")
	ENDIF   
ELSE
	lRetorno := .F.
	SetSoapFault("LOGIN","USUARIO/SENHA INVALIDOS") 	
ENDIF 

Return(lRetorno)   


    
/*************************************************************************************************                                      
* METODO CadEmpresa
* Gisele Nuncherino  
* Inclui/Altera o cadastro de uma empresa (cliente)
* PaRAMETROS: 
* SEMPRESA 	= DADOS DA EMPRESA  
* CROTINA	= ROTINA QUE DEVE SER EXECUTADA -> 3-INCLUSAO, 4-ALTERACAO
/*************************************************************************************************/


WSMETHOD CADEMPRESA WSRECEIVE AEMPRESA,CROTINA WSSEND LRETURN WSSERVICE SINDHOSP 
 
LOCAL LVALID 	:= .T.
LOCAL ADADOS 	:= {}   
LOCAL CNOME		:= '' 
LOCAL CCEP		:= '' 
LOCAL CEND		:= '' 
LOCAL CBAIRRO	:= '' 
LOCAL CMUN		:= '' 
LOCAL CUF		:= '' 
LOCAL CEMAIL	:= '' 
LOCAL CTEL		:= '' 
LOCAL CFAX		:= '' 
LOCAL CCAPITAL	:= '' 
LOCAL DINIATV	:= '' 
LOCAL CCONTATO	:= ''  
LOCAL CSINDICA	:= Posicione("SZR",2,xFilial("SZR")+Upper(::AEMPRESA:cMUN),"ZR_SINDICA")
LOCAL CNATUREZ	:= Posicione("SZS",1,xFilial("SZS")+CSINDICA,"ZS_NATUREZ")
PRIVATE LMSERROAUTO	:= .F.

::AEMPRESA:CCAPITAL := StrTran(StrTran(::AEMPRESA:CCAPITAL,".",""),",",".")

IF !EMPTY(::CROTINA) .AND. ALLTRIM(::CROTINA)=='3' //INCLUSAO
             
	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Montando Lay-Out para execucao do processo Automatico              ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ 
	aadd(aDados,{"A1_COD"    		,NextNumero("SA1",1,"A1_COD",.T.)		,nil})
	aadd(aDados,{"A1_LOJA"   		,::AEMPRESA:cLoja						,nil})
	aadd(aDados,{"A1_NOME"   		,alltrim(::AEMPRESA:cNome)				,nil})
	aadd(aDados,{"A1_NREDUZ" 		,alltrim(::AEMPRESA:CNOME)				,nil})
	aadd(aDados,{"A1_TIPO"   		,'F'									,nil})
	aadd(aDados,{"A1_CEP"    		,::AEMPRESA:cCEP						,nil})
	aadd(aDados,{"A1_END"   		,Upper(alltrim(::AEMPRESA:cEnd))		,nil})
	aadd(aDados,{"A1_BAIRRO" 		,Upper(alltrim(::AEMPRESA:cBairro))		,nil})
	aadd(aDados,{"A1_MUN"    		,Upper(alltrim(::AEMPRESA:cMUN))		,nil})
	aadd(aDados,{"A1_EST"    		,alltrim(::AEMPRESA:cUF)				,nil})
	aadd(aDados,{"A1_CGC"    		,alltrim(::AEMPRESA:cCGC)				,nil})
	aadd(aDados,{"A1_ERSIN"  		,alltrim(::AEMPRESA:ERSIN)				,nil})
	aadd(aDados,{"A1_BASE"  		,alltrim(::AEMPRESA:CBASE)				,nil})
	aadd(aDados,{"A1_BASE2"  		,alltrim(::AEMPRESA:CBASE2)				,nil})
	aadd(aDados,{"A1_CATEG1"  		,'11400'								,nil})
	aadd(aDados,{"A1_SINDICA"  		,alltrim(CSINDICA)						,nil})
	aadd(aDados,{"A1_FISICO"  		,'1'									,nil})
	aadd(aDados,{"A1_NATUREZ"  		,'002' /*alltrim(CNATUREZ)*/			,nil}) //**** fixado em 15/02/2012 - Rodrigo ***
	aadd(aDados,{"A1_TEL"    		,alltrim(::AEMPRESA:cTel)				,nil})
	aadd(aDados,{"A1_EMAIL"  		,alltrim(::AEMPRESA:cEMail)				,nil})
	aadd(aDados,{"A1_FAX"  	 		,alltrim(::AEMPRESA:cFAX)				,nil})
	aadd(aDados,{"A1_DTINIC"  	 	,::AEMPRESA:DINIATV			   			,nil})
	aadd(aDados,{"A1_SCONTAT"  	 	,"A/C: "+alltrim(::AEMPRESA:CCONTATO)			,nil})
	aadd(aDados,{"A1_DIRADM"  	 	,"A/C: "+alltrim(::AEMPRESA:CCONTATO)			,nil})
	aadd(aDados,{"A1_CAPITAL"  	 	,VAL(::AEMPRESA:CCAPITAL)				,nil})
	aadd(aDados,{"A1_INAT"			,'X'									,nil}) 
	aadd(aDados,{"A1_DTCADAS"		,DATE()		   							,nil}) // DATA DE CADASTRO
	aadd(aDados,{"A1_TPCADAS"		,'W' 		   							,nil}) // TIPO DE CADASTRO
	aadd(aDados,{"A1_DATINAT"		,CtoD(Space(8))		   					,nil}) // DATA DA INATIVACAO (em branco)
    If  !( Empty(::AEMPRESA:NLEITOS) )
		aadd(aDados,{"A1_LEITOS" 		,Val(::AEMPRESA:NLEITOS)				,nil})
	EndIf	
    If  !( Empty(::AEMPRESA:NNUMFUN) )
		aadd(aDados,{"A1_NUMFUN" 		,Val(::AEMPRESA:NNUMFUN)				,nil})
	EndIf	
            
   	ADADOS :=  U_Organiza(ADADOS, "SA1")

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Gera cliente automatico                                            ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	MsExecAuto({|x,y|Mata030(x,y)},aDados,3)
	If lMsErroAuto
		While ( __lSx8 )
			RollBackSx8()
		EndDo
		LVALID 		:= .F. 
		::LRETURN	:= .F.
		SetSoapFault("CADEMPRESA", MOSTRAERRO())
	Else      
		LVALID 		:= .T.
		::LRETURN	:= .T.
		While ( __lSx8 )
			ConfirmSX8()
		EndDo
	EndIf

ELSEIF !EMPTY(::CROTINA) .AND. ALLTRIM(::CROTINA)=='4' //ALTERACAO
            
	CNOME		:= (Posicione("SA1",3,xFilial("SA1")+::AEMPRESA:CCGC,"A1_NOME"))
	CCEP		:= SA1->A1_CEP
	CEND		:= SA1->A1_END
	CBAIRRO		:= SA1->A1_BAIRRO
	CMUN		:= SA1->A1_MUN
	CUF			:= SA1->A1_EST
	CEMAIL		:= SA1->A1_EMAIL
	CTEL		:= SA1->A1_TEL
	CFAX		:= SA1->A1_FAX
	CCAPITAL	:= SA1->A1_CAPITAL
	DINIATV		:= SA1->A1_DTINIC
	CCONTATO	:= SA1->A1_SCONTAT
    NLEITOS     := SA1->A1_LEITOS
    NNUMFUN     := SA1->A1_NUMFUN

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Montando Lay-Out para execucao do processo Automatico              ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ   
                           
	
	AADD(ADADOS,{"A1_COD"   	,::AEMPRESA:CCODIGO			,nil})
	AADD(ADADOS,{"A1_LOJA"   	,::AEMPRESA:CLOJA			,nil})
	AADD(ADADOS,{"A1_CGC"   	,::AEMPRESA:CCGC			,nil})

	fAADD(@aDados, ::AEMPRESA:CNOME		, CNOME		, "A1_NOME"		, nil)	
	fAADD(@aDados, ::AEMPRESA:CCEP 		, CCEP 		, "A1_CEP" 		, nil)	
	fAADD(@aDados, ::AEMPRESA:CEND 		, CEND 		, "A1_END" 		, nil)	
	fAADD(@aDados, ::AEMPRESA:CBAIRRO 	, CBAIRRO 	, "A1_BAIRRO" 	, nil)	
	fAADD(@aDados, ::AEMPRESA:CMUN 		, CMUN 		, "A1_MUN" 		, nil)	
	fAADD(@aDados, ::AEMPRESA:CUF 		, CUF 		, "A1_EST" 		, nil)	
	fAADD(@aDados, ::AEMPRESA:CEMAIL	, CEMAIL	, "A1_EMAIL"	, nil)	
	fAADD(@aDados, ::AEMPRESA:CTEL		, CTEL		, "A1_TEL"		, nil)	
	fAADD(@aDados, ::AEMPRESA:CFAX		, CFAX		, "A1_FAX"		, nil)	
	fAADD(@aDados, ::AEMPRESA:CCONTATO	, CCONTATO	, "A1_SCONTAT"	, nil)	

	AADD(ADADOS, {"A1_CAPITAL", If(!Empty(::AEMPRESA:CCAPITAL) .And. !(Val(::AEMPRESA:CCAPITAL) == CCAPITAL), ::AEMPRESA:CCAPITAL,"0")	,nil})
	
	AADD(ADADOS, {"A1_DTINIC" , If(!Empty(::AEMPRESA:DINIATV) .And. !(::AEMPRESA:DINIATV == DINIATV), ::AEMPRESA:DINIATV, CTOD(''))	,nil})	
	
	AADD(ADADOS, {"A1_FILIAL"  	, ALLTRIM(::AEMPRESA:CFILIAL) ,nil})	
								   
    If  !( Empty(::AEMPRESA:NLEITOS) )
		aadd(ADADOS,{"A1_LEITOS" 		,If(Val(::AEMPRESA:NLEITOS) != NLEITOS, Val(::AEMPRESA:NLEITOS), 0)	,nil})
	EndIf	
	
    If  !( Empty(::AEMPRESA:NNUMFUN) )
		aadd(ADADOS,{"A1_NUMFUN" 		,If(Val(::AEMPRESA:NNUMFUN)	!= NNUMFUN, Val(::AEMPRESA:NNUMFUN), 0)	,nil})
	EndIf	

	ADADOS :=  U_Organiza(ADADOS, "SA1")

	IF U_GRVALTEMP(ADADOS)
		LVALID 		:= .T.
		::LRETURN	:= .T.
		While ( __lSx8 )
			ConfirmSX8()
		EndDo   
       	SA1->(DBSETORDER(3)) //FILIAL + CGC
		IF SA1->(DBSEEK(XFILIAL("SA1") + PADR(ALLTRIM(::AEMPRESA:CCGC),14)))
			RECLOCK("SA1",.F.)
			   	SA1->A1_INAT 	:= 'X' 
			   	SA1->A1_CODDESC := '  '  //CODIGO DA DESCRICAO      
			   	SA1->A1_DATINAT := Date() //DATA DA INATIVACAO      
			SA1->(MSUNLOCK())
		ELSE

			::LRETURN := .F.
			LVALID := .F. 
			SetSoapFault("CADEMPRESA", "Cadastro Oficial Nao Atualizado")			
			
		ENDIF
	ELSE

		While ( __lSx8 )
			RollBackSx8()
		EndDo
		LVALID 		:= .F. 
		::LRETURN	:= .F.
		SetSoapFault("CADEMPRESA", "Erro na Gravacao dos Dados na Tabela Auxiliar")		

	ENDIF
ELSE

	::LRETURN := .F.
	LVALID := .F. 
	SetSoapFault("CADEMPRESA", "Rotina Inv·lida ou Nao Definida")
	
ENDIF	

RETURN LVALID	


STATIC Function fAADD(aDados, WSCampo, cValor, cCampo, cCampo2)

WSCampo := If( !Empty(WSCampo), Upper(Alltrim(WSCampo)), WSCampo)
cValor  := If(!Empty(cValor)  , Upper(Alltrim(cValor)) , cValor)
	
AADD(aDados, {cCampo, If(!Empty(WSCampo) .And. !(Alltrim(WSCampo) == Alltrim(cValor)), WSCampo, '')	,nil})

If  !( Empty(cCampo2) )
	AADD(aDados, {cCampo2, If(!Empty(WSCampo) .And. !(Alltrim(WSCampo) == Alltrim(cValor)), WSCampo, '')	,nil})
EndIf

Return .T.
**** fim ***


    
/*************************************************************************************************                                      
* METODO CADESCRIT
* Gisele Nuncherino  
* Inclui/Altera o cadastro de um escritorio contabil tabela (SZC)
* PaRAMETROS: 
* AESCRITO 	= DADOS DO ESCRITORIO CONTABIL   
* CROTINA	= ROTINA QUE DEVE SER EXECUTADA -> 3-INCLUSAO, 4-ALTERACAO
/*************************************************************************************************/


WSMETHOD CADESCRIT WSRECEIVE AESCRITO,CROTINA WSSEND LRETURN WSSERVICE SINDHOSP  

 
LOCAL LVALID 	:= .T.
LOCAL ADADOS 	:= {}   
LOCAL CNOME		:= '' 
LOCAL CCEP		:= '' 
LOCAL CEND		:= '' 
LOCAL CBAIRRO	:= '' 
LOCAL CMUN		:= '' 
LOCAL CUF		:= '' 
LOCAL CEMAIL	:= '' 
LOCAL CTEL		:= '' 
LOCAL CFAX		:= '' 
LOCAL CCONTATO	:= '' 
                       
PRIVATE LMSERROAUTO := .F.

IF !EMPTY(::CROTINA) .AND. ALLTRIM(::CROTINA)=='3' //INCLUSAO

    Begin Transaction
       
	Reclock("SZC",.T.)  
		SZC->ZC_FILIAL	 	:= XFILIAL("SZC")
		SZC->ZC_CODIGO		:= GetSXENum("SZC", "SZC_COD")
		SZC->ZC_CGC			:= ::AESCRITO:CCGC
		SZC->ZC_NOMESC		:= ::AESCRITO:CNOME
		SZC->ZC_CEP			:= ::AESCRITO:CCEP
	    SZC->ZC_END			:= ::AESCRITO:CEND
		SZC->ZC_BAIRRO		:= ::AESCRITO:CBAIRRO
		SZC->ZC_MUN			:= ::AESCRITO:CMUN
		SZC->ZC_EST			:= ::AESCRITO:CUF
		SZC->ZC_EMAIL		:= ::AESCRITO:CEMAIL
		SZC->ZC_FONE		:= ::AESCRITO:CTEL
		SZC->ZC_FAX			:= ::AESCRITO:CFAX
		SZC->ZC_CONTATO		:= ::AESCRITO:CCONTATO
		SZC->ZC_INAT		:= 'X'
		SZC->ZC_CODDESC		:= 'W'  //CODIGO DA DESCRICAO DO INATIVO
		SZC->ZC_ERSIN		:= ''
		SZC->ZC_BASE		:= ''
		SZC->ZC_DTCADAS		:= date()
		SZC->ZC_DATINAT		:= date()
	SZC->( MsUnlock() ) 
	SZC->( ConfirmSX8() )  
					
	END TRANSACTION
	LVALID := .T.
	::LRETURN := .T.
		
ELSEIF !EMPTY(::CROTINA) .AND. ALLTRIM(::CROTINA)=='4' //ALTERACAO
	CNOME		:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_NOMESC")
	CCEP		:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_CEP")
	CEND		:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_END")
	CBAIRRO		:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_BAIRRO")
	CMUN		:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_MUN")
	CUF			:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_EST")
	CEMAIL		:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_EMAIL")
	CTEL		:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_FONE")
	CFAX		:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_FAX")
	CCONTATO	:= Posicione("SZC",2,xFilial("SZC")+PADR(::AESCRITO:CCGC,14),"ZC_CONTATO")

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥Montando Lay-Out para execucao do processo Automatico              ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ             
   /*	ADADOS	:= { {"ZC_FILIAL"  	,::AESCRITO:CFILIAL ,nil},;
				 {"ZC_CODIGO"   ,::AESCRITO:CCODigo ,nil},;
				 {"ZC_CGC"  	,::AESCRITO:CCGC ,nil},;
			     {"ZC_DATINAT" 	,date()																,nil},;
			     {"ZC_CODDESC" 	,'W'																,nil},;
			     {"ZC_INAT" 	,'X'																,nil},;
*/	
	AADD(ADADOS,{"ZC_CODIGO"   ,::AESCRITO:CCODigo 			,nil})
	AADD(ADADOS,{"ZC_CGC"  	,::AESCRITO:CCGC 				,nil})
	
	::AESCRITO:CNOME := If(!( Empty(::AESCRITO:CNOME) ), Upper(Alltrim(::AESCRITO:CNOME)), ::AESCRITO:CNOME)
	CNOME            := If( !EMPTY(CNOME), Upper(ALLTRIM(CNOME)), CNOME)
	
	AADD(ADADOS, {"ZC_NOMESC", If(!(Empty(::AESCRITO:CNOME)) .And. !(Alltrim(::AESCRITO:CNOME) == Alltrim(CNOME)), ::AESCRITO:CNOME, ''),nil})

	::AESCRITO:CCONTATO := If(!Empty(::AESCRITO:CCONTATO), Upper(Alltrim(::AESCRITO:CCONTATO)), ::AESCRITO:CCONTATO)
	CCONTATO := If( !Empty(CCONTATO), Upper(Alltrim(CCONTATO)), CCONTATO)
	
	AADD(ADADOS, {"ZC_CONTATO", If(!(Empty(::AESCRITO:CCONTATO)) .And. !(Alltrim(::AESCRITO:CCONTATO) == Alltrim(CCONTATO)), ::AESCRITO:CCONTATO, '') ,nil})

	::AESCRITO:CFAX := If(!EMPTY(::AESCRITO:CFAX), Upper(Alltrim(::AESCRITO:CFAX)), ::AESCRITO:CFAX)
	CFAX := If(!Empty(CFAX), Upper(Alltrim(CFAX)), CFAX)

	AADD(ADADOS, {"ZC_FAX", If(!(Empty(::AESCRITO:CFAX)) .And. !(Alltrim(::AESCRITO:CFAX) == Alltrim(CFAX)), ::AESCRITO:CFAX, '') ,nil})
   
	::AESCRITO:CTEL := If(!Empty(::AESCRITO:CTEL), Upper(Alltrim(::AESCRITO:CTEL)), ::AESCRITO:CTEL)
	CTEL := If(!Empty(CTEL), Upper(Alltrim(CTEL)), CTEL)
	
	AADD(ADADOS, {"ZC_FONE", If(!(Empty(::AESCRITO:CTEL)) .And. !(Alltrim(::AESCRITO:CTEL) == Alltrim(CTEL)), ::AESCRITO:CTEL, '') ,nil})
	
	::AESCRITO:CEMAIL := If(!Empty(::AESCRITO:CEMAIL), Upper(Alltrim(::AESCRITO:CEMAIL)), ::AESCRITO:CEMAIL)
	CEMAIL := If(!Empty(CEMAIL), Upper(Alltrim(CEMAIL)), CEMAIL)
	
	AADD(ADADOS, {"ZC_EMAIL", If(!(Empty(::AESCRITO:CEMAIL)) .And. !(Alltrim(::AESCRITO:CEMAIL) == Alltrim(CEMAIL)), ::AESCRITO:CEMAIL, ''),nil})

	::AESCRITO:CUF := If(!Empty(::AESCRITO:CUF), Upper(Alltrim(::AESCRITO:CUF)), ::AESCRITO:CUF)
	CUF := If(!Empty(CUF), Upper(Alltrim(CUF)), CUF)
	
	AADD(ADADOS, {"ZC_EST", If(!(Empty(::AESCRITO:CUF)) .And. !(Alltrim(::AESCRITO:CUF) == Alltrim(CUF)), ::AESCRITO:CUF, '') ,nil})
	
	::AESCRITO:CMUN := If(!Empty(::AESCRITO:CMUN), Upper(Alltrim(::AESCRITO:CMUN)), ::AESCRITO:CMUN)
	CMUN := If(!Empty(CMUN), Upper(Alltrim(CMUN)), CMUN)
	
	AADD(ADADOS, {"ZC_MUN", If(!(Empty(::AESCRITO:CMUN)) .And. !(Alltrim(::AESCRITO:CMUN) == Alltrim(CMUN)), ::AESCRITO:CMUN, '') ,nil})
	
	::AESCRITO:CBAIRRO := If(!Empty(::AESCRITO:CBAIRRO), Upper(Alltrim(::AESCRITO:CBAIRRO)), ::AESCRITO:CBAIRRO)
	CBAIRRO := If(!Empty(CBAIRRO), Upper(Alltrim(CBAIRRO)), CBAIRRO)
	
	AADD(ADADOS, {"ZC_BAIRRO", If(!(Empty(::AESCRITO:CBAIRRO)) .And. !(Alltrim(::AESCRITO:CBAIRRO) == Alltrim(CBAIRRO)), ::AESCRITO:CBAIRRO, '') ,nil})
	
	::AESCRITO:CNOME := If(!Empty(::AESCRITO:CNOME), Upper(Alltrim(::AESCRITO:CNOME)), ::AESCRITO:CNOME)
	CNOME := If(!Empty(CNOME), Upper(Alltrim(CNOME)), CNOME)
	
	AADD(ADADOS, {"ZC_NOMESC", If(!(Empty(::AESCRITO:CNOME)) .And. !(Alltrim(::AESCRITO:CNOME) == Alltrim(CNOME)), ::AESCRITO:CNOME , '') ,nil})

	::AESCRITO:CCEP := If(!Empty(::AESCRITO:CCEP), Upper(Alltrim(::AESCRITO:CCEP)), ::AESCRITO:CCEP)
	CCEP := If(!Empty(CCEP), Upper(Alltrim(CCEP)), CCEP)
	
	AADD(ADADOS, {"ZC_CEP", If(!(Empty(::AESCRITO:CCEP)) .And. !(Alltrim(::AESCRITO:CCEP) == Alltrim(CCEP)), ::AESCRITO:CCEP, '') ,nil})

	::AESCRITO:CEND := If(!Empty(::AESCRITO:CEND), Upper(Alltrim(::AESCRITO:CEND)), ::AESCRITO:CEND)
	CEND := If(!Empty(CEND), Upper(Alltrim(CEND)), CEND)
	
	AADD(ADADOS, {"ZC_END", If(!(Empty(::AESCRITO:CEND)) .And. !(Alltrim(::AESCRITO:CEND) == Alltrim(CEND)), ::AESCRITO:CEND, '') ,nil})
	
	AADD(ADADOS, {"ZC_FILIAL"  	,::AESCRITO:CFILIAL ,nil})
		                  
	ADADOS :=  U_Organiza(ADADOS, "SZC")

	IF U_GRVALTESC(ADADOS)
	
		LVALID 		:= .T.
		::LRETURN	:= .T.
		While ( __lSx8 )
			ConfirmSX8()
		EndDo 
         
       	SZC->(DBSETORDER(2)) //FILIAL + CGC
		IF SZC->(DBSEEK(XFILIAL("SZC")+PADR(::AESCRITO:CCGC,14)))
			RECLOCK("SZC",.F.)
				SZC->ZC_INAT 	:= 'X' 
				SZC->ZC_CODDESC	:= 'W'  //CODIGO DA DESCRICAO INATIVO
			   	SZC->ZC_DATINAT := date() //DATA DA INATIVACAO      				
			SZC->(MSUNLOCK())
			LVALID := .T.
		ELSE

			::LRETURN := .F.
			LVALID := .F. 
			SetSoapFault("CADESCRIT", "Cadastro Oficial Nao Atualizado")			
			
		ENDIF
	ELSE

		While ( __lSx8 )
			RollBackSx8()
		EndDo
		LVALID 		:= .F. 
		::LRETURN	:= .F.
		SetSoapFault("CADESCRIT", "Erro na Gravacao dos Dados na Tabela Auxiliar")		

	ENDIF
ELSEIF EMPTY(::CROTINA)

	::LRETURN := .F.
	LVALID := .F. 
	SetSoapFault("CADESCRIT", "Rotina Inv·lida ou Nao Definida")
	
ENDIF	

RETURN LVALID	


/*************************************************************************************************                                      
* METODO VERCADEMP
* Gisele Nuncherino  
* VERIFICA SE A EMPRESA ESTA OU NAO CADASTRADA
* PaRAMETROS: 
* CCGC 		= CNPJ DA EMPRESA   
* AEMPRESA	= RETORNO COM OS DADOS DA EMPRESA
/*************************************************************************************************/
WSMETHOD VERCADEMP WSRECEIVE CCGC WSSEND AEMPRESA WSSERVICE SINDHOSP  

LOCAL CCGC_ 	:= ''
LOCAL LVALID	:= .T.  

IF !EMPTY(::CCGC)

	IF U_LIMPACGC(::CCGC) == NIL
		HTTPPOST->ERRO := "CNPJ em branco/invalido"
		cHtml := ExecInPage("ERRO")	        
	ELSE
	
		CCGC_ := U_LIMPACGC(::CCGC)
	
		SA1->(dbSetOrder(3)) //busca por cgc
		IF SA1->(dbSeek(xFilial("SA1") + CCGC_))  //LOCALIZOU 
			::AEMPRESA := WSCLASSNEW('SEMPRESA')
	
			::AEMPRESA:cCodigo        := SA1->A1_COD   
			::AEMPRESA:cCGC	        := SA1->A1_CGC
			::AEMPRESA:cLoja          := SA1->A1_LOJA
			::AEMPRESA:CFILIAL		  := SA1->A1_FILIAL
			::AEMPRESA:CNOME		     := fSoChar(SA1->A1_NOME)
			::AEMPRESA:CCEP			  := fSoChar(SA1->A1_CEP)
			::AEMPRESA:CEND			  := fSoChar(SA1->A1_END)
			::AEMPRESA:CBAIRRO		  := fSoChar(SA1->A1_BAIRRO)
			::AEMPRESA:CMUN			  := fSoChar(SA1->A1_MUN)
			::AEMPRESA:CUF			     := fSoChar(SA1->A1_EST)
			::AEMPRESA:CEMAIL		     := fSoChar(SA1->A1_EMAIL) 
			::AEMPRESA:CTEL			  := SA1->A1_TEL
			::AEMPRESA:CFAX			  := SA1->A1_FAX 
			::AEMPRESA:CCAPITAL		  := str(SA1->A1_CAPITAL)
			::AEMPRESA:DINIATV		  := SA1->A1_DTINIC 
			::AEMPRESA:CCONTATO		  := SA1->A1_SCONTAT
			::AEMPRESA:CSITUAC		  := SA1->A1_SITUAC
			::AEMPRESA:CINAT		     := SA1->A1_INAT
			::AEMPRESA:CSINDICA		  := SA1->A1_SINDICA
			::AEMPRESA:DDTNASC		  := SA1->A1_DTCADAS
			::AEMPRESA:CBASE		     := SA1->A1_BASE
			::AEMPRESA:CODESCR		  := SA1->A1_ESCCONT // CODIGO DO ESCRITORIO CONTABIL   
			::AEMPRESA:CFILANTR       := SA1->A1_FILANT
			::AEMPRESA:CFOLCENT		  := SA1->A1_FOLCENT 
			::AEMPRESA:CCAPCENT		  := SA1->A1_CAPCENT 
			::AEMPRESA:NCATEGOR		  := SA1->A1_CATEG1 
			::AEMPRESA:cNATUREZ		  := SA1->A1_NATUREZ 
			::AEMPRESA:INISIND		  := SA1->A1_INISIND 
			::AEMPRESA:CNAE		  	  := SA1->A1_CNAE 
			::AEMPRESA:PORTAL	  	     := GETMV("MV_PORTAL")
			::AEMPRESA:NLEITOS	  	  := Alltrim(Str(SA1->A1_LEITOS))
			::AEMPRESA:NNUMFUN  	     := Alltrim(Str(SA1->A1_NUMFUN))
	
			LVALID := .T.
		ELSE                                           
			//SetSoapFault("VERCADEMP", "CNPJ Nao Localizado")	
			LVALID := .T.
			::AEMPRESA := WSCLASSNEW('SEMPRESA')	
	    ENDIF
    
    ENDIF
ELSE
	LVALID := .F. 
	SetSoapFault("VERCADEMP", "CNPJ Nao Informado")
ENDIF

RETURN LVALID


/*************************************************************************************************                                      
* METODO VERCADESC
* Gisele Nuncherino  
* VERIFICA SE EXISTE OU NAO ESCRITORIO CONTABIL PARA DETERMINADA EMPRESA 
* PaRAMETROS: 
* CCGC		= CGC DO ESCRITORIO CONTABIL   
* AESCRIT	= RETORNO COM OS DADOS DO ESCRITORIO CONTABIL
/*************************************************************************************************/
WSMETHOD VERCADESC WSRECEIVE CCGC WSSEND AESCRITO WSSERVICE SINDHOSP  

LOCAL LVALID := .T.  

Do  While .T.

	If  Empty( ::CCGC )
		LVALID := .F. 
		SetSoapFault("VERCADESC", "Codigo do Escritorio Contabil Nao Informado")
		Exit
	EndIf

	SZC->( DBSETORDER(2) ) //busca por CGC   
	
	::AESCRITO := WSCLASSNEW('SESCRITO')

	If  SZC->(dbSeek(xFilial("SZC") + PADR(::CCGC,14)))
	
		::AESCRITO:cCGC	  	:= SZC->ZC_CGC
		
		::AESCRITO:cCodigo 	:= SZC->ZC_CODIGO    
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
	
	EndIf	

	LVALID := .T.

    Exit
EndDo    

Return LVALID  
**** fim ***

/*************************************************************************************************                                      
* METODO BUSCAESC
* Gisele Nuncherino  
* VERIFICA SE EXISTE OU NAO ESCRITORIO CONTABIL PARA DETERMINADA EMPRESA 
* PaRAMETROS: 
* CODESCR		= CODIGO DO ESCRITORIO CONTABIL   
* AESCRIT	= RETORNO COM OS DADOS DO ESCRITORIO CONTABIL
/*************************************************************************************************/
WSMETHOD BUSCAESC WSRECEIVE CODESCR WSSEND AESCRITO WSSERVICE SINDHOSP  

LOCAL LVALID	:= .T.  
IF !EMPTY(::CODESCR)
	SZC->(DBSETORDER(2)) //busca por CGC   

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



/*************************************************************************************************                                      
* METODO VINCESCR
* Gisele Nuncherino  
* VINCULA O ESCRITORIO CONTABIL COM DETERMINADA EMPRESA 
* PaRAMETROS: 
* CODESCR	= CODIGO DO ESCRITORIO CONTABIL   
* CODEMP	= CODIGO DA EMPRESA
/*************************************************************************************************/
WSMETHOD VINCESCR WSRECEIVE CODESCR,CODEMP WSSEND LRETURN WSSERVICE SINDHOSP  

LOCAL LVALID	:= .T.  

IF !EMPTY(::CODESCR) .OR. !EMPTY00(::CODEMP)
	
	SA1->(DBSETORDER(1)) //busca PELO CODIGO E LOJA
	IF SA1->(dbSeek(xFilial("SA1") + ::CODEMP))  //LOCALIZOU 
		RECLOCK("SA1",.F.)
			SA1->A1_ESCCONT 	:= ::CODESCR 
		SA1->(MSUNLOCK())
		LVALID := .T.
		::LRETURN := .T.
	ELSE                                           
		SetSoapFault("VINCESCR", "Codigo da Empresa Nao Localizado")	
		LVALID := .F.	
		::LRETURN := .F.
    ENDIF
ELSE
	LVALID := .F.      
	::LRETURN := .F.
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
WSMETHOD VEREMPAUX WSRECEIVE CCGC WSSEND AEMPRESA WSSERVICE SINDHOSP  

           
LOCAL CCGC_ 	:= ''
LOCAL LVALID	:= .T.  

IF !EMPTY(::CCGC)

	IF U_LIMPACGC(::CCGC) == NIL
		HTTPPOST->ERRO := "CNPJ em branco/invalido"
		cHtml := ExecInPage("ERRO")	        
	ELSE
		CCGC_ := U_LIMPACGC(::CCGC)
	                     
		PA8->(dbSetOrder(2)) //busca por cgc
		IF PA8->(dbSeek(xFilial("PA8") + PADR(ALLTRIM(CCGC_),14)))  //LOCALIZOU 
			::AEMPRESA := WSCLASSNEW('SEMPRESA')
	
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
			::AEMPRESA := WSCLASSNEW('SEMPRESA')	
	    ENDIF
    
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
WSMETHOD VERESCAUX WSRECEIVE CCGC WSSEND AESCRITO WSSERVICE SINDHOSP  

           
LOCAL CCGC_ 	:= ''
LOCAL LVALID	:= .T.  

IF !EMPTY(::CCGC)

	IF U_LIMPACGC(::CCGC) == NIL
		HTTPPOST->ERRO := "CNPJ em branco/invalido"
		cHtml := ExecInPage("ERRO")	        
	ELSE
	
		CCGC_ := U_LIMPACGC(::CCGC)
	
		PA9->(dbSetOrder(2)) //busca por cgc
		IF PA9->(dbSeek(xFilial("PA9") + CCGC_))  //LOCALIZOU 
			::AESCRITO := WSCLASSNEW('SESCRITO')
	
			::AESCRITO:cCodigo        := PA9->PA9_COD   
			::AESCRITO:cCGC	          := PA9->PA9_CGC
			//::AESCRITO:cLoja          := PA9->PA9_LOJA
			::AESCRITO:CFILIAL		  := PA9->PA9_FILIAL
			::AESCRITO:CNOME		  := PA9->PA9_NOMESC
			::AESCRITO:CCEP			  := PA9->PA9_CEP
			::AESCRITO:CEND			  := PA9->PA9_END 
			::AESCRITO:CBAIRRO		  := PA9->PA9_BAIRRO 
			::AESCRITO:CMUN			  := PA9->PA9_MUN 
			::AESCRITO:CUF			  := PA9->PA9_EST 
			::AESCRITO:CEMAIL		  := PA9->PA9_EMAIL 
			::AESCRITO:CTEL			  := PA9->PA9_FONE
			::AESCRITO:CFAX			  := PA9->PA9_FAX 
			::AESCRITO:CCONTATO		  := PA9->PA9_CONTAT
			
			LVALID := .T.
		ELSE                                           
			LVALID := .T.
			::AESCRITO := WSCLASSNEW('SESCRITO')	
	    ENDIF
    
    ENDIF
ELSE
	LVALID := .F. 
	SetSoapFault("VERESCAUX", "CNPJ Nao Informado")
ENDIF

RETURN LVALID

/*

‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥BUSCACEP∫ Autor ≥Gisele Nuncherino   	∫  Data ≥28/04/2010   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ FunÁ„o respons·vel POR BUSCAR OS DADOS CEP			      ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ SINDHOSP                                                   ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ

/*/

WSMETHOD BUSCACEP WSRECEIVE CEP WSSEND AEND WSSERVICE SINDHOSP  

LOCAL LVALID 	:= .T.

IF EMPTY(::CEP)
	LVALID := .F. 
	SetSoapFault("BUSCACEP", "CEP Nao Informado")
ENDIF 
	
CEP->(DBSETORDER(1)) 
IF CEP->(DbSeek(xFilial("CEP")+::CEP)) 
    LVALID := .T.
	::AEND:ENDERECO	:= Alltrim(Upper(u_NoAccent(CEP->CEP_END)))
	::AEND:BAIRRO   	:= Upper(u_NoAccent(CEP->CEP_BAIRRO))
	::AEND:CEP      	:= CEP->CEP_NUM
	::AEND:EST      	:= Upper(CEP->CEP_EST)
	::AEND:ERSIN    	:= Posicione("SZO",1,xFilial("SZO")+Upper(u_NoAccent(Alltrim(CEP->CEP_MUN))),"ZO_ERSIN")
	::AEND:MUN      	:= Upper(u_NoAccent(SZO->ZO_MUN))
	::AEND:BASE     	:= SZO->ZO_BASE
	::AEND:BASE2    	:= SZO->ZO_BASE2
	::AEND:SINDICATO  := SZO->ZO_SINDICA
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
WSMETHOD VEREMPESC WSRECEIVE CODESCR WSSEND AESCRITO WSSERVICE SINDHOSP  

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


STATIC Function fSoChar(cString)
                     
Local nA

Local cSoChar := '' 

cString := Alltrim(cString)

For nA := 1 to Len(cString)
    If  (SubStr(cString,nA,1) $ ' 0123456789ABCDEFGHIJKLMNOPQRSTUWVXYZabcdefghijklmnopqrstuwvxyz|\,.;:/?<>[]~^¡·…ÈÕÌ”Û⁄˙¬‚ Í√„’ı‹¸!@#$®&*_-+=')
    	cSoChar += SubStr(cString,nA,1)
    EndIf
Next nA

Return cSoChar
**** fim ***