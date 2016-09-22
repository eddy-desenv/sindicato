#INCLUDE "PROTHEUS.CH"
 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVERLAYOUT บAutor  ณGISELE NUNCHERINO   บ Data ณ  05/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  VERIFICA O LAYOUT E DADOS DO BANCO QUE DEVEM SER UTILIZADOSฑฑ
ฑฑบ          ณ  CTIPO -> TIPO DO BOLETO                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SINDHOSP                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

/* TIPOS DE BOLETOS 

 '1'-> SINDICAL
 '2'-> CONFEDERATIVA
 '3'-> ASSOCIATIVA
 '4'-> ASSOCIATIVA CONFEDERATIVA
 '5'-> ASSISTENCIAL/NEGOCIAL
		
*/
USER FUNCTION VERLAYOUT(CTIPO, ADADOS)
LOCAL ARETORNO 	:= {} 
LOCAL CNATUREZ	:= ''
LOCAL CSINDICA	:= ''
LOCAL CINISIND	:= ''
LOCAL CANO		:= ''
LOCAL NX 		:= 0

IF EMPTY(CTIPO) .OR. !(ALLTRIM(CTIPO) $ "1234") .OR. ADADOS == NIL .OR. LEN(ADADOS) <= 0 
	AADD(ARETORNO,{.F.})
ELSE  
	CTIPO := ALLTRIM(CTIPO)
	DO CASE
		CASE CTIPO $ '12' // SINDICAL/CONFEDERATIVA
			FOR NX := 1 TO LEN(ADADOS)
				IF ALLTRIM(ADADOS[NX][1]) == "CODSIND"
					CSINDICA := ALLTRIM(ADADOS[NX][2])
				ELSEIF ALLTRIM(ADADOS[NX][1]) == "NATUREZ"
					CNATUREZ := ALLTRIM(ADADOS[NX][2]) 
				ELSEIF ALLTRIM(ADADOS[NX][1]) == "ANO"
					CANO := ALLTRIM(ADADOS[NX][2])					
				ENDIF
			NEXT NX
			
			IF CTIPO == '1' .AND. VAL(CANO) >= 2006 .AND. VAL(CANO) <= 2008 // SERA SINDHOSP
		    	CSINDICA := GETMV("MV_SINDICA")
			ENDIF

 
			IF  PA7->(DBSEEK(XFILIAL("PA7")+padr(CSINDICA,6)+padr(CNATUREZ,6)))
					AADD(ARETORNO,  {.T.		, ''				})
					AADD(ARETORNO,	{"CODBCO"	, (PA7->PA7_CODBCO)	})
					AADD(ARETORNO,	{"NOMEBCO"	, ALLTRIM(PA7->PA7_NOMBCO)	})
					AADD(ARETORNO,	{"CONTA"	, (PA7->PA7_CONTA)	})
					AADD(ARETORNO,	{"AGENCIA"	, (PA7->PA7_AGENCI)	})
					AADD(ARETORNO,	{"CEDENTE"	, (PA7->PA7_CODCED)	})
					AADD(ARETORNO,	{"SIND"		, (PA7->PA7_SIND)	})//CODIGO SINDICAL
					AADD(ARETORNO,	{"IMAGEM"	, ALLTRIM(PA7->PA7_IMAGEM)	})//LOGO DO SINDICATO
					AADD(ARETORNO,	{"MOEDA"	, ALLTRIM(PA7->PA7_MOEDA)	})
					AADD(ARETORNO,	{"CNAE"		, ALLTRIM(PA7->PA7_CNAE)	})
					AADD(ARETORNO,	{"NATUREZA"	, ALLTRIM(PA7->PA7_NATURE)	})
		    ELSE
					AADD(ARETORNO,	{.F.})
		    ENDIF				
		        
		CASE CTIPO $ '3' // ASSOCIATIVA/ASSOCIATIVA CONFEDERATIVA
		/*
			Se "INISIND" estiver vazio, SINDICATO serแ igual a “01” (SINDHOSP) 
			SENรO SINDICATO serแ igual ao sindicato do cadastro do cliente (A1_SINDICA)		
		
		*/
			FOR NX := 1 TO LEN(ADADOS)
				IF ALLTRIM(ADADOS[NX][1]) == "CODSIND"
					CSINDICA := ALLTRIM(ADADOS[NX][2])
				ELSEIF ALLTRIM(ADADOS[NX][1]) == "NATUREZ"
					CNATUREZ := ALLTRIM(ADADOS[NX][2])
				ELSEIF ALLTRIM(ADADOS[NX][1]) == "INISIND"
					CINISIND := ALLTRIM(ADADOS[NX][2])					
				ENDIF
			NEXT NX

			IF EMPTY(CSINDICA)
				CSINDICA := GETMV("MV_SINDICA")
			ENDIF
			                                                             
			PA7->(dbsetorder(1))
			IF  PA7->(DBSEEK(XFILIAL("PA7")+PADR(CSINDICA,6)+CNATUREZ))
				AADD(ARETORNO, {.T.,''									})
				AADD(ARETORNO, {"CODBCO"	, alltrim(PA7->PA7_CODBCO)	})
				AADD(ARETORNO, {"NOMEBCO"	, ALLTRIM(PA7->PA7_NOMBCO)	})				
				AADD(ARETORNO, {"CONTA"		, alltrim(PA7->PA7_CONTA)	})
				AADD(ARETORNO, {"AGENCIA"	, alltrim(PA7->PA7_AGENCI)	})
				AADD(ARETORNO, {"CEDENTE"	, alltrim(PA7->PA7_CODCED)	})
				AADD(ARETORNO, {"SIND"		, alltrim(PA7->PA7_SIND)	})
				AADD(ARETORNO, {"IMAGEM"	, ALLTRIM(PA7->PA7_IMAGEM)	})//LOGO DO SINDICATO
				AADD(ARETORNO, {"MOEDA"		, ALLTRIM(PA7->PA7_MOEDA)	})
				AADD(ARETORNO, {"CNAE"		, ALLTRIM(PA7->PA7_CNAE)	})	  
				AADD(ARETORNO, {"NATUREZA"	, ALLTRIM(PA7->PA7_NATURE)	})
			ENDIF

			IF LEN(ARETORNO) <=0
				AADD(ARETORNO,	{.F.})											
			ENDIF
        
		CASE CTIPO $ '4'
			FOR NX := 1 TO LEN(ADADOS)
				IF ALLTRIM(ADADOS[NX][1]) == "CODSIND"
					CSINDICA := ALLTRIM(ADADOS[NX][2])
				ENDIF
			NEXT NX
					
			PA7->(DBSETORDER(1))//Cd Sindicato+Natureza  
			IF PA7->(DBSEEK(XFILIAL("PA7")+padr(CSINDICA,6)))
				WHILE PA7->(!EOF() .And. (PA7_FILIAL+PA7_CODSIN == XFILIAL("PA7")+padr(CSINDICA,6)))
					IF (ALLTRIM(PA7->PA7_NATURE) == '0301')
						AADD(ARETORNO, {.T.		   , ''				})
						AADD(ARETORNO,	{"CODBCO"	, ALLTRIM(PA7->PA7_CODBCO)	})
						AADD(ARETORNO,	{"NOMEBCO"	, ALLTRIM(PA7->PA7_NOMBCO)	})
						AADD(ARETORNO,	{"CONTA"	, (PA7->PA7_CONTA)	})
						AADD(ARETORNO,	{"AGENCIA"	, (PA7->PA7_AGENCI)	})
						AADD(ARETORNO,	{"CEDENTE"	, (PA7->PA7_CODCED)	})
						AADD(ARETORNO,	{"SIND"		, (PA7->PA7_SIND)	})//CODIGO SINDICAL
						AADD(ARETORNO,	{"IMAGEM"	, ALLTRIM(PA7->PA7_IMAGEM)	})//LOGO DO SINDICATO
						AADD(ARETORNO,	{"MOEDA"	, ALLTRIM(PA7->PA7_MOEDA)	})
						AADD(ARETORNO,	{"CNAE"		, ALLTRIM(PA7->PA7_CNAE)	})
						AADD(ARETORNO,	{"NATUREZA"	, ALLTRIM(PA7->PA7_NATURE)	})
				   ENDIF					
				  	PA7->(DBSKIP())
		    	ENDDO         
		    	IF LEN(ARETORNO) <= 0
					AADD(ARETORNO,	{.F.})		    	
				ENDIF
			ELSE
					AADD(ARETORNO,	{.F.})
			ENDIF
	ENDCASE
ENDIF

RETURN ARETORNO 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGRVBOL บAutor  ณGISELE NUNCHERINO      บ Data ณ  05/05/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SINDHOSP                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
      
USER FUNCTION GRVBOL(ADADOS)

Local cQuery, cTitulo, cRetorno

Local cNumero := ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'NUMERO'})][2]

/*
	NATUREZA
	N.บ DO BOLETO
	CNPJ
	VALOR
	ANO
	PARCELA
	DATA DE EMISSรO
	VENCIMENTO
	SINDICATO
	BASE
	E1NUM
*/

SX6->( DbGoTop() )

//Trava l๓gica para que os demais usuarios nใo obtenha o mesmo numero que o usuario atual.
Do While !( SX6->(RLock()) ) 
   inkey(3)
EndDo   

If  (Alltrim(cNumero) == 'CNPJ')

	cTitulo := ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'CGC'})][2]
	
	cRetorno := cTitulo
	
Else
	
	CQUERY := "SELECT MAX(SUBSTRING(Z9_TITULO,"+Alltrim(Str(Len(cNumero)+1))+",9)) AS TITULO FROM " + RETSQLNAME("SZ9") 
	CQUERY += " WHERE SUBSTRING(Z9_TITULO,1,"+Alltrim(Str(Len(cNumero)))+")='" + cNumero + "' AND D_E_L_E_T_='' AND (SUBSTRING(Z9_TITULO,"+Alltrim(Str(9+Len(cNumero)))+",1)<>'' AND SUBSTRING(Z9_TITULO,"+Alltrim(Str(9+Len(cNumero)))+",1)<='9')"
	CQUERY := CHANGEQUERY(CQUERY) 
            
   	If  (Select("TBZ") > 0)
   		TBZ->(dbCloseArea())
   	EndIf
   			
	DBUSEAREA(.T.,"TOPCONN", TCGENQRY(,,CQUERY), "TBZ", .F., .T.)
      
	cTitulo := TBZ->( If(EOF() .Or. Empty(TITULO), StrZero(1,9), Soma1(TITULO)) )

	TBZ->(dbCloseArea())
	
	If  (Left(cNumero,1) == '9')  //Bradesco
	    cTitulo := fCalcDigito(cNumero, cTitulo)
	EndIf
	
	cRetorno := cTitulo
                                          
	cTitulo := cNumero+StrTran(cTitulo,'-','')

EndIf
    
RecLock('SZ9',.T.)
   	SZ9->Z9_FILIAL 	:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'FILIAL'})][2]
   	SZ9->Z9_NATUR 	:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'NATUREZ'})][2]
   	SZ9->Z9_TITULO	:= cTitulo
   	SZ9->Z9_CGC		:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'CGC'})][2]
   	SZ9->Z9_VALOR	:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'VALOR'})][2]
   	SZ9->Z9_ANO		:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'ANO'})][2]
   	SZ9->Z9_PARCELA	:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'PARCELA'})][2]
   	SZ9->Z9_EMISSAO	:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'EMISSAO'})][2]
   	SZ9->Z9_VENCTO	:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'VENCTO'})][2]
   	SZ9->Z9_SINDIC	:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'SINDIC'})][2]
   	SZ9->Z9_BASE	:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'BASE'})][2]
   	SZ9->Z9_E1NUM	:= ADADOS[aScan(ADADOS,{|x| UPPER(x[1]) == 'E1NUM'})][2]
	SZ9->Z9_VREAL	:= ctod(space(8))
MsUnLock()	

SX6->( MsUnLock() )


Return cRetorno
**** fim ***
      

Main user Function fMostraTit()
          
Alert( fCalcDigito('90', '000003976') )

Return .T.
**** fim ***


STATIC Function fCalcDigito(cNumero, cTitulo)

Local nA, nFator

Local xTitulo := "06" + cNumero + cTitulo //**** Carteira nao registrada (06) + Nossonumero ***

//**** Calculo no Modulo 11 com base 7 ***
Local aBase  := {7, 6, 5, 4, 3, 2}

Local nBase  := 6 //**** Inicia no ultimo de aBase = 2 ***

Local nValor := 0

For nA := 1 to Len(xTitulo)

	nFator := Val(SubStr(xTitulo,nA,1))
	
	nValor += (nFator * aBase[nBase])
	
	nBase  := If(nBase == Len(aBase), 1, nBase+1)

Next nA

nVInt  := Int(nValor / 11)
nResto := (nValor - (nVInt*11))

nDigito := (11 - nResto)

cTitulo += '-' + If(nResto == 0, '0', If(nResto == 1, 'P', Alltrim(Str(nDigito))))

Return cTitulo
**** fim ***



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCALCNNUM บAutor  ณGISELE NUNCHERINO    บ Data ณ  05/05/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SINDHOSP                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
      
USER FUNCTION CALCNNUM()
                                                    
LOCAL CQUERY 	:= ''
LOCAL NTIT		:= 0
LOCAL NNUMERO	:= 0

CQUERY := "SELECT MAX(SUBSTRING(PA9_TITULO,5,9)) AS TITULO FROM " + RetSqlName("PA9") + " PA9 "
CQUERY += " WHERE LEFT(PA9_TITULO,4)='7000' AND D_E_L_E_T_='' AND (SUBSTRING(PA9_TITULO,13,1)<>'' AND SUBSTRING(PA9_TITULO,13,1)<='9')"

ChangeQuery(cQuery)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),"TRB", .F., .T.)

WHILE !TRB->(EOF())

	If EMPTY(TRB->TITULO) 
		NTIT := 0
	Else 
		NTIT := TRB->TITULO
	ENDIF
	                
	NNUMERO := NTIT + 1
	NNUMERO := "7000" + String((9-Len(NNUMERO)),"0") + NNUMERO
	
	TRB->(DBSKIP())

ENDDO


RETURN