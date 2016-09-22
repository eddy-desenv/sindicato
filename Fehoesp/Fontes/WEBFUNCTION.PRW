#INCLUDE "PROTHEUS.CH"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "WEBEXDEF.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWEBFUNCTIONบ   Autor  ณMicrosiga       บ Data ณ  03/08/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ ORGANIZA O ARRAY CONFORME A ORDEM DOS CAMPOS NO SX3        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Organiza(aLayout, cAlias2)

Local aArea0 := GetArea()
Local _aAreaX3 := SX3->(GetArea())
Local nPva := 0
Local aTemp := {}
Local aTemp1 := {}
Local nXa

dbSelectArea("SX3")
dbSetOrder(4) //X3_ARQUIVO+X3_FOLDER+X3_ORDEM
dbSeek( cAlias2 )

While !eof() .and. SX3->X3_ARQUIVO == cAlias2
	
	nPva := ascan(aLayOut, {|x| upper(alltrim(x[1])) == Upper(Alltrim(X3_CAMPO))})
	if nPva > 0
		aadd(aTemp, aLayOut[nPva])
	endif

	dbSelectArea("SX3")
	dbSkip()
	
end

aTemp1 := aclone(aTemp)
RestArea(_aAreaX3)
restarea(aarea0)

Return aTemp1

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGRVALTEMPบ   Autor  ณGISELE NUNCHERINO บ Data ณ  22/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ GRAVA OS DADOS ALTERADOS DO CAD DE EMPRESA (SA1) NA TAB AUXบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SINDHOSP                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function GRVALTEMP(ADADOS)

LOCAL LVALID 	:= .T.
LOCAL NX		:= 0
LOCAL CCODIGO	:= ''
LOCAL CLOJA		:= ''
LOCAL NPOS		:= 0
LOCAL LGRAVA	:= .F.

IF LEN(ADADOS) <= 0
     
	LVALID := .F.

ELSE
	
	NPOS 	:= Ascan(ADADOS,{|x| Upper(x[1]) == 'A1_COD' })
	CCODIGO := ADADOS[NPOS][2]

	NPOS 	:= Ascan(ADADOS,{|x| Upper(x[1]) == 'A1_LOJA' })
	CLOJA 	:= ADADOS[NPOS][2]
	
    LVALID := .T.   

	PA8->(DBSETORDER(1)) //FILIAL+CODIGO+LOJA
	If PA8->(DbSeek(xFilial("PA8")+PADR(CCODIGO,10)+PADR(CLOJA,2))) //JA EXISTE UMA ALTERACAO PENDENTE			
  
		Reclock("PA8",.F.)
			FOR NX := 1 TO LEN(ADADOS)
		
				IF ADADOS[NX][1] == 'A1_NOME'
					PA8->PA8_NOME		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_NOME)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_CEP'   
					PA8->PA8_CEP		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_CEP)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_END'
				    PA8->PA8_END		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_END)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_BAIRRO'			    
					PA8->PA8_BAIRRO		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_BAIRRO)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_MUN'				
					PA8->PA8_MUN		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_MUN)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_EST'				
					PA8->PA8_EST		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_EST)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_EMAIL'				
					PA8->PA8_EMAIL		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_EMAIL)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_TEL'				
					PA8->PA8_TEL		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_TEL)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_FAX'				
					PA8->PA8_FAX		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_FAX)
				ENDIF        

				IF ADADOS[NX][1] == 'A1_CAPITAL'				
					PA8->PA8_CAPITA	:= IIF(!EMPTY(ADADOS[nx][2]),val(ADADOS[nx][2]),PA8->PA8_CAPITA)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_DTINIC'				
					PA8->PA8_DTINIC		:= IIF(!EMPTY(ADADOS[nx][2]),ADADOS[nx][2],PA8->PA8_DTINIC)
				ENDIF 
				IF ADADOS[NX][1] == 'A1_SCONTAT'				
					PA8->PA8_CONTAT		:= IIF(!EMPTY(ADADOS[NX][2]),ADADOS[NX][2],PA8->PA8_CONTAT)
				ENDIF
			NEXT NX
			
			PA8->( MsUnlock() )   
		
	ELSE  //NAO EXISTEM ALTERACOES PENDENTES

		FOR NX := 1 TO LEN(ADADOS) 
			IF !EMPTY(ADADOS[NX][2]) .AND. !(LGRAVA)
				LGRAVA := .T.
			ENDIF
		NEXT NX
		
		IF LGRAVA
			Reclock("PA8",.T.)  
				FOR NX := 1 TO LEN(ADADOS) 


					IF ADADOS[NX][1] == 'A1_CGC'   
						PA8->PA8_CGC	:= ADADOS[NX][2]
					ENDIF 			
					IF ADADOS[NX][1] == 'A1_COD'   
						PA8->PA8_CODIGO	:= ADADOS[NX][2]
					ENDIF 			                    
					IF ADADOS[NX][1] == 'A1_LOJA'   
						PA8->PA8_LOJA	:= ADADOS[NX][2]
					ENDIF				
					IF ADADOS[NX][1] == 'A1_FILIAL'   
						PA8->PA8_FILIAL	:= XFILIAL("PA8")
					ENDIF 				
					IF ADADOS[NX][1] == 'A1_NOME'   
						PA8->PA8_NOME	:= ADADOS[NX][2]
					ENDIF 
					IF ADADOS[NX][1] == 'A1_CEP'   
						PA8->PA8_CEP	:= ADADOS[NX][2]
					ENDIF 
					IF ADADOS[NX][1] == 'A1_END'
					    PA8->PA8_END	:= ADADOS[NX][2]
					ENDIF 
					IF ADADOS[NX][1] == 'A1_BAIRRO'			    
						PA8->PA8_BAIRRO	:= ADADOS[NX][2]
					ENDIF 
					IF ADADOS[NX][1] == 'A1_MUN'				
						PA8->PA8_MUN	:= ADADOS[NX][2]
					ENDIF 
					IF ADADOS[NX][1] == 'A1_EST'				
						PA8->PA8_EST	:= ADADOS[NX][2]
					ENDIF 
					IF ADADOS[NX][1] == 'A1_EMAIL'				
						PA8->PA8_EMAIL	:= ADADOS[NX][2]
					ENDIF 
					IF ADADOS[NX][1] == 'A1_TEL'				
						PA8->PA8_TEL	:= ADADOS[NX][2]
					ENDIF 
					IF ADADOS[NX][1] == 'A1_FAX'				
						PA8->PA8_FAX	:= ADADOS[NX][2]
					ENDIF 
					IF ADADOS[NX][1] == 'A1_CAPITAL'				
						PA8->PA8_CAPITA	:= VAL(ADADOS[NX][2])
					ENDIF 
					IF ADADOS[NX][1] == 'A1_DTINIC'				
						IF VALTYPE(ADADOS[NX][2]) == 'C'
							PA8->PA8_DTINIC	:= CTOD(ADADOS[NX][2])
						ELSEIF VALTYPE(ADADOS[NX][2]) == 'D'
							PA8->PA8_DTINIC	:= ADADOS[NX][2]
						ENDIF
					ENDIF 
					IF ADADOS[NX][1] == 'A1_SCONTAT'				
						PA8->PA8_CONTAT	:= ADADOS[NX][2]
					ENDIF
					
				NEXT NX
			PA8->( MsUnlock() ) 
		ENDIF	
	ENDIF		
ENDIF            

RETURN LVALID  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGRVALTESCบ   Autor  ณGISELE NUNCHERINO บ Data ณ  22/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ GRAVA OS DADOS ALTERADOS DO CAD DE ESCRITORIOS   NA TAB AUXบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SINDHOSP                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

*/

User Function GRVALTESC(ADADOS)

LOCAL LVALID := .T.

IF LEN(ADADOS) <= 0
     
	LVALID := .F.

ELSE
	PA9->(DBSETORDER(2)) //FILIAL+CODIGO+LOJA  

	If PA9->(DbSeek(xFilial("PA9")+ADADOS[2][2])) //JA EXISTE UMA ALTERACAO PENDENTE			

		Reclock("PA9",.F.)  

			PA9->PA9_NOMESC			:= IIF(!EMPTY(ADADOS[3][2]),ADADOS[3][2],SZC->ZC_NOMESC)
			PA9->PA9_CEP			:= IIF(!EMPTY(ADADOS[4][2]),ADADOS[4][2],SZC->ZC_CEP)
		    PA9->PA9_END			:= IIF(!EMPTY(ADADOS[5][2]),ADADOS[5][2],SZC->ZC_END)
			PA9->PA9_BAIRRO			:= IIF(!EMPTY(ADADOS[6][2]),ADADOS[6][2],SZC->ZC_BAIRRO)
			PA9->PA9_MUN			:= IIF(!EMPTY(ADADOS[7][2]),ADADOS[7][2],SZC->ZC_MUN)
			PA9->PA9_EST			:= IIF(!EMPTY(ADADOS[8][2]),ADADOS[8][2],SZC->ZC_EST)
			PA9->PA9_EMAIL			:= IIF(!EMPTY(ADADOS[12][2]),ADADOS[12][2],SZC->ZC_EMAIL)
			PA9->PA9_FONE			:= IIF(!EMPTY(ADADOS[9][2]),ADADOS[9][2],SZC->ZC_FONE)
			PA9->PA9_FAX			:= IIF(!EMPTY(ADADOS[11][2]),ADADOS[11][2],SZC->ZC_FAX)
			PA9->PA9_CONTAT			:= IIF(!EMPTY(ADADOS[13][2]),ADADOS[13][2],SZC->ZC_CONTATO)
			/*SA1->A1_NOME		:= IIF(!EMPTY(ADADOS[5][2]),ADADOS[5][2],XSA1->A1_NOME)
			SA1->A1_CEP		:= IIF(!EMPTY(ADADOS[6][2]),ADADOS[6][2],XSA1->A1_CEP)
		    SA1->A1_END		:= IIF(!EMPTY(ADADOS[7][2]),ADADOS[7][2],XSA1->A1_END)
			XSA1->A1_BAIRRO		:= IIF(!EMPTY(ADADOS[8][2]),ADADOS[8][2],XSA1->A1_BAIRRO)
			XSA1->A1_MUN		:= IIF(!EMPTY(ADADOS[9][2]),ADADOS[9][2],XSA1->A1_MUN)
			XSA1->A1_UF			:= IIF(!EMPTY(ADADOS[10][2]),ADADOS[10][2],XSA1->A1_UF)
			XSA1->A1_EMAIL		:= IIF(!EMPTY(ADADOS[11][2]),ADADOS[11][2],XSA1->A1_EMAIL)
			XSA1->A1_TEL		:= IIF(!EMPTY(ADADOS[12][2]),ADADOS[12][2],XSA1->A1_TEL)
			XSA1->A1_FAX		:= IIF(!EMPTY(ADADOS[13][2]),ADADOS[13][2],XSA1->A1_FAX)
			XSA1->A1_CAMPITAL	:= IIF(!EMPTY(ADADOS[14][2]),ADADOS[14][2],XSA1->A1_CAMPITAL)
			XSA1->A1_DTINIC		:= IIF(!EMPTY(ADADOS[15][2]),ADADOS[15][2],XSA1->A1_DTINIC)
			XSA1->A1_CONTATO	:= IIF(!EMPTY(ADADOS[16][2]),ADADOS[16][2],XSA1->A1_CONTATO)*/
		PA9->( MsUnlock() )   
		
	ELSE  //NAO EXISTEM ALTERACOES PENDENTES
		
		Reclock("PA9",.T.)  
			PA9->PA9_FILIAL		:= ADADOS[10][2]
			PA9->PA9_COD		:= ADADOS[1][2]
			//PA9->PA9_LOJA		:= ADADOS[3][2]
			PA9->PA9_CGC		:= ADADOS[2][2]
			PA9->PA9_NOMESC		:= ADADOS[3][2]
			PA9->PA9_CEP		:= ADADOS[4][2]
		    PA9->PA9_END		:= ADADOS[5][2]
			PA9->PA9_BAIRRO		:= ADADOS[6][2]
			PA9->PA9_MUN		:= ADADOS[7][2]
			PA9->PA9_EST		:= ADADOS[8][2]
			PA9->PA9_EMAIL		:= ADADOS[12][2]
			PA9->PA9_FONE		:= ADADOS[9][2]
			PA9->PA9_FAX		:= ADADOS[11][2]
			//PA9->PA9_CAMPITAL	:= ADADOS[14][2]
			//PA9->PA9_DTINIC		:= ADADOS[15][2]
			PA9->PA9_CONTAT		:= ADADOS[13][2]
		PA9->( MsUnlock() ) 
	
	ENDIF		
ENDIF            

RETURN LVALID


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณENVMAILบ     Autor  ณGISELE NUNCHERINO บ Data ณ  22/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ ENVIA EMAIL 												  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SINDHOSP                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ENVMAIL(cEmailFrom, cEmailTo, cTitulo, cCorpo, cAnexo )

Local lOK 		:= .T.
LOCAL cRet 		:= ""
LOCAL aEmails 	:= ''
LOCAL nCont 	:= 0
LOCAL cErro 	:= ''                                                          
LOCAL cSmtp 	:= ''
LOCAL cConta	:= ''
LOCAL senha 	:= ''
LOCAL oWS		:= WSCFGDICTIONARY():NEW()  

WSChgUrl( @OWS, "CFGDICTIONARY.APW" )

DEFAULT cEmailFrom := If(!(oWS:GETPARAM("MSALPHA","MV_PMAILCA")) .Or. (ValType(oWS:cGETPARAMRESULT)!="C") .Or. Empty(oWS:cGETPARAMRESULT) .Or. (oWS:cGETPARAMRESULT=='.F.'), "arrecadacao@fehoesp.org.br", Alltrim(oWS:cGETPARAMRESULT))

cSmtp 	:= If(!(oWS:GETPARAM("MSALPHA","MV_PSMTP"))  .Or. (ValType(oWS:cGETPARAMRESULT)!="C") .Or. Empty(oWS:cGETPARAMRESULT) .Or. (oWS:cGETPARAMRESULT=='.F.'), "smtp.fehoesp.org.br"	 , Alltrim(oWS:cGETPARAMRESULT))
cConta	:= If(!(oWS:GETPARAM("MSALPHA","MV_PCONTA")) .Or. (ValType(oWS:cGETPARAMRESULT)!="C") .Or. Empty(oWS:cGETPARAMRESULT) .Or. (oWS:cGETPARAMRESULT=='.F.'), "arrecadacao@fehoesp.org.br", Alltrim(oWS:cGETPARAMRESULT))
senha 	:= If(!(oWS:GETPARAM("MSALPHA","MV_PSENHA")) .Or. (ValType(oWS:cGETPARAMRESULT)!="C") .Or. Empty(oWS:cGETPARAMRESULT) .Or. (oWS:cGETPARAMRESULT=='.F.'), "arre10"				 , Alltrim(oWS:cGETPARAMRESULT))

aEmails  := Separa( AllTrim(cEmailTo), ';' )

If empty( cSmtp)
	//endereco SMTP em branco
	cRet := "Endereco SMTP em branco"
ElseIf Empty( cConta)
	//Conta de e-mail em branco
	cRet := "Conta de e-mail em branco"
Elseif Empty( senha)
	//Senha da conta esta em branco
	cRet := "Senha da conta esta em branco"
	//ElseIf !isEmail(  cEmailFrom )
	//E-mail de origem nใo ้ valido
	//	cRet := "E-mail de origem nใo ้ valido"
ElseIf Len( aEmails ) == 0
	//Nใo foi especificado email de destino
	cRet := "Nใo foi especificado email de destino"
Endif

If cRet == ""
	For nCont := 1 To Len( aEmails )
		aEmails[ nCont ] := Alltrim( aEmails[ nCont ] )
		//If !isEmail( aEmails[ nCont ] )
		//E-mail de destino invแlido
		//	cRet := "E-mail " + aEmails[ nCont ] + " invแlido"
		//	Exit
		//Endif
	Next nCont
Endif

If cRet == ""
	CONNECT SMTP SERVER cSmtp ACCOUNT cConta PASSWORD senha RESULT lResult
	If (lOk)
		//Usuแrio e senha para autentica็ใo. Preferencialmente recuperar de parโmetro.
		If MailAuth( cConta,  senha)
			//Percorre a lista de e-mail's de destino
			For nCont := 1 To Len( aEmails )
				SEND MAIL FROM  cEmailFrom TO AllTrim(cEmailTo) SUBJECT  cTitulo BODY  cCorpo ATTACHMENT  cAnexo RESULT lOk
				
				If ( ! lOk )
					GET MAIL ERROR cErro
					DEFAULT cErro := '(unknow)'
					cErro += ' (send)'
					conout( 'Erro durante o envio para ' + cEmailTo + ' >> ' + cErro )   
					cret := 'Erro durante o envio para ' + cEmailTo + ' >> ' + cErro 
				EndIf
			Next nCont
		Else
			GET MAIL ERROR cErro
			DEFAULT cErro := '(unknow)'
			cErro += ' (send)'
			ConOut('Autentica็ใo FALHOU para a Conta [' +  cConta + '] Senha: [' +  senha + '] ' + cErro)
			cret := 'Autentica็ใo FALHOU para a Conta [' +  cConta + '] ' + cErro
		Endif
		
		DISCONNECT SMTP SERVER
	   //	cRet := If(lOk, "", cErro )
	Else
		GET MAIL ERROR cErro
		DEFAULT cErro := '(unknow)'
		cErro += ' (send)'
		cRet := cErro
		ConOut('Erro durante a conexao para a Conta [' +  cConta + '] Senha: [' +  senha + '] ' + cErro)
	EndIf
Endif
REturn cRet

/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLIMPACGCบ Autor ณGisele Nuncherino   	บ  Data ณ26/04/2010   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Fun็ใo responsแvel para tirar A FORMATACAO DO CNPJ/CPF     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SINDHOSP                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

/*/

User Function LIMPACGC(CCGC)

Local cSaida := ""
Local cLetra := ""
Local cLetraAux := ""
Local nCont := 0
Local NTAM

IF CCGC == NIL 
	RETURN NIL
ENDIF

IF LEN(CCGC) <=0
	RETURN NIL
ENDIF
	
nTam := Len(CCGC)

For nCont := 1 to nTam

    cLetra = SubStr(CCGC, nCont, 1)

    IF cLetra $ ".-/"
    	cLetraAux := ""
	ELSE
		cLetraAux := cLetra
    ENDIF

    cSaida += cLetraAux

Next

Return cSaida



USER FUNCTION MES(valor)

VALOR := VAL(VALOR)
if (valor == 1)
	return "Janeiro"
ELSEif (valor == 2)
	return "Fevereiro"
ELSEif (valor == 3)
	return "Mar็o"
ELSEif (valor == 4)
	return "Abril"
ELSEif (valor == 5)	
	return "Maio"
ELSEif (valor == 6)
	return "Junho"
ELSEif (valor == 7)
	return "Julho"
ELSEif (valor == 8)
	return "Agosto"
ELSEif (valor == 9)
	return "Setembro"
ELSEif (valor == 10)
	return "Outubro"
ELSEif (valor == 11)
	return "Novembro"
ELSEif (valor == 12)
	return "Dezembro"
ENDIF
			
Return