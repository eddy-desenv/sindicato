
#include "protheus.ch"

User Function MANEMPWEB()
	Local aRotAux := {}
	Local aArea := SA1->(GetArea())
	
	Private lRefresh  := .T.
	Private cCadastro := "Manutenção - Cadastro de Empresas"
	
	If ValType( aRotina ) <> "A"
		Private aRotina := {}
	Endif
	
	aRotAux := AClone( aRotina )
	aRotina := {}

	aAdd( aRotina, {"Efetivar",'U_ROTMANEMP',0,4} )

	dbSelectArea("PA8")
	dbSetOrder(1)

	MBrowse(,,,,"PA8")
	
	aRotina := {}
	aRotina := AClone( aRotAux )
	RestArea(aArea)
Return
  
		
USER FUNCTION ROTMANEMP( cAlias, nReg, nOpc )
Local nX := 0
Local nAcao := 0
Local aButtons := {}
Local oDlg
Local oEnch
Local bCampo := {|nField| FieldName(nField) }
Local nTop := 0
Local nLeft := 0
Local nBottom := 0
Local nRight := 0
LOCAL CVAR	:= ''
Local aCPO := {}
Local aCpoAlt := {}
Local cCpo := ''
Local cCpoAux := '' 
Local cCgc	:= ''
Local cDDD
Local cTel

If SetMDIChild()
	oMainWnd:ReadClientCoors()
	nTop := 40
	nLeft := 30
	nBottom := oMainWnd:nBottom-80
	nRight := oMainWnd:nRight-70
Else
	nTop := 135
	nLeft := 0
	nBottom := TranslateBottom(.T.,28)
	nRight := 632
EndIf

//CAPTURAR O NOME DE TODOS OS CAMPOS CONFORME SX3.
SX3->(dbSetOrder(1))
SX3->(dbSeek("PA8"))
While SX3->(!EOF() .And. X3_ARQUIVO == "PA8")
	If SX3->(X3Uso(X3_USADO) .And. cNivel >= X3_NIVEL)
		AAdd( aCPO, RTrim( SX3->X3_CAMPO ) )
	Endif
	SX3->(dbSkip())
End

AAdd( aButtons, { "EXCLUIR", {|| U_DELAUXEMP(),oDlg:End()}, "Cancela Alterações" } )

dbSelectArea(cAlias)
dbSetOrder(1)

RegToMemory(cAlias,.F.,.T.)
                 
cCgc := "{|| M->"+aCPO[Ascan(aCPO,{|x| Upper(x) == 'PA8_CGC' })]+"}"
CCGC := EVAL(&CCGC)

For nX := 1 To Len( aCPO )
	If X3Obrigat( aCPO[ nX ] )
		Loop
	Endif
	cCpo := "M->"+aCPO[ nX ]
	If Empty(&cCpo)
		IF "A1"+SUBSTR(aCPO[NX],4,LEN(ACPO[NX])) == 'A1_CONTAT'
			cCpoAux := Posicione("SA1",3,xFilial("SA1")+cCgc,"A1_SCONTAT") 		 
		ELSEIF "A1"+SUBSTR(aCPO[NX],4,LEN(ACPO[NX])) == 'A1_CAPITA'
			cCpoAux := Posicione("SA1",3,xFilial("SA1")+cCgc,"A1_CAPITAL") 		 
		ELSE
			cCpoAux := Posicione("SA1",3,xFilial("SA1")+cCgc,"A1"+SUBSTR(aCPO[NX],4,LEN(ACPO[NX]))) 
		ENDIF
		cCpo := "{|| M->" + aCPO[ nX ] +":=cCpoAux}"
		
		Eval(&cCpo)
		Loop
	Endif
	AAdd( aCpoAlt, aCPO[ nX ] )
Next nI 

DEFINE MSDIALOG oDlg TITLE "Alterações Via Web" FROM nTop, nLeft TO nBottom,nRight PIXEL
oDlg:lMaximized := .T.

oEnch := MSMGet():New(cAlias,,nOpc,,,,,{0,0,90,23},aCpoAlt,,,,,oDlg)
oEnch:oBox:Align := CONTROL_ALIGN_ALLCLIENT

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nAcao := 1, oDlg:End()},{|| oDlg:End() },,aButtons)

IF NACAO == 1
   	
	dbSelectArea(cAlias)
    RecLock(cAlias,.F.)
    For nX := 1 To (cAlias)->(FCount())
    	If "FILIAL" $ FieldName(nX)
    		FieldPut(nX,xFilial("PA8"))
    	Else
    		FieldPut(nX,M->&(Eval(bCampo,nX)))
    	Endif
    Next nX
    MsUnLock()	
   	
   	SA1->(DBSETORDER(3))
	IF SA1->(DBSEEK(XFILIAL("SA1")+M->PA8_CGC))
		/* GRAVA AS INFORMACOES NO SA1 */
		Begin Transaction
			DbSelectArea("SA1")
	      	RecLock("SA1",.F.)
	      	    
	      	    If !EMPTY(M->PA8_TEL)        
	      	    	cDDD := SA1->A1_DDD     
	      	    	cTel := SA1->A1_TEL 
	      	    Else                   
	      	    	cDDD := SUBSTR(M->PA8_TEL, 1, 4)
	      	    	cDDD := STRTRAN(M->PA8_TEL,"(","")
	      	    	cDDD := STRTRAN(M->PA8_TEL,")","")
	      	    	
					cTel := SUBSTR(M->PA8_TEL, 5, 15)	      	    	
	      	    EndIf 
	      	    
	      		cDDD := IIF(!EMPTY(M->PA8_TEL),M->PA8_TEL,SA1->A1_TEL)
	      		cTel := IIF(!EMPTY(M->PA8_TEL),M->PA8_TEL,SA1->A1_TEL) 
	      		
	      		SA1->A1_BAIRRO 	:= IIF(!EMPTY(M->PA8_BAIRRO),M->PA8_BAIRRO,SA1->A1_BAIRRO)
	      		SA1->A1_END	 	:= IIF(!EMPTY(M->PA8_END),M->PA8_END,SA1->A1_END)
	      		SA1->A1_NOME 	:= IIF(!EMPTY(M->PA8_NOME),M->PA8_NOME,SA1->A1_NOME)
	      		SA1->A1_MUN 	:= IIF(!EMPTY(M->PA8_MUN),M->PA8_MUN,SA1->A1_MUN)
	      		SA1->A1_EST 	:= IIF(!EMPTY(M->PA8_EST),M->PA8_EST,SA1->A1_EST)
	      		SA1->A1_CEP 	:= IIF(!EMPTY(M->PA8_CEP),M->PA8_CEP,SA1->A1_CEP)
	      		SA1->A1_SCONTAT	:= IIF(!EMPTY(M->PA8_CONTATO),M->PA8_CONTATO,SA1->A1_SCONTAT)
	      		SA1->A1_DIRADM	:= IIF(!EMPTY(M->PA8_CONTATO),M->PA8_CONTATO,SA1->A1_SCONTAT)
	      		//SA1->A1_FAX		:= IIF(!EMPTY(M->PA8_FAX),M->PA8_FAX,SA1->A1_FAX)
	      		SA1->A1_TEL3	:= IIF(!EMPTY(M->PA8_TEL3),M->PA8_TEL3,SA1->A1_TEL3)
	      		SA1->A1_DDD     := cDDD
	      		SA1->A1_TEL		:= cTel
	      		SA1->A1_EMAIL	:= IIF(!EMPTY(M->PA8_EMAIL),M->PA8_EMAIL,SA1->A1_EMAIL)
	      		SA1->A1_CAPITAL	:= IIF(!EMPTY(M->PA8_CAPITA),M->PA8_CAPITA,SA1->A1_CAPITAL)
	      		SA1->A1_DTINIC	:= IIF(!EMPTY(M->PA8_DTINIC),M->PA8_DTINIC,SA1->A1_DTINIC)
	      		SA1->A1_INAT	:= ''
	      		SA1->A1_CODDESC	:= ''
	      		SA1->A1_DATINAT	:= CTOD('')
	      	MsUnLock()
	  	End Transaction
         
		RecLock("PA8",.F.)
			PA8->(DBDELETE())
		MsUnLock()
	
		MsgInfo("Alterações Confirmadas com Sucesso")
	ELSE
		ALERT("Registro da Empresa Nao Localizado")
	ENDIF	
ENDIF

RETURN                                       


USER FUNCTION DELAUXEMP()

	RecLock("PA8",.F.)
		PA8->(DBDELETE())
	MsUnLock()
             
	MsgInfo("Alterações Descartadas Com Sucesso")
	

RETURN