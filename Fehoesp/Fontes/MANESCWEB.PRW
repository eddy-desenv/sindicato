
#include "protheus.ch"

User Function MANESCWEB()
	Local aRotAux := {}
	Local aArea := SZC->(GetArea())
	
	Private lRefresh  := .T.
	Private cCadastro := "Manutenção - Cadastro de Escritórios Contábeis"
	
	If ValType( aRotina ) <> "A"
		Private aRotina := {}
	Endif
	
	aRotAux := AClone( aRotina )
	aRotina := {}

	aAdd( aRotina, {"Efetivar",'U_ROTMANESC',0,4} )

	dbSelectArea("PA9")
	dbSetOrder(1)

	MBrowse(,,,,"PA9")
	
	aRotina := {}
	aRotina := AClone( aRotAux )
	RestArea(aArea)
Return
  
		
USER FUNCTION ROTMANESC( cAlias, nReg, nOpc )
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
local aCpoAlt := {}
local aCPO		:= {}
local cCpo		:= '' 


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
SX3->(dbSeek("PA9"))
While SX3->(!EOF() .And. X3_ARQUIVO == "PA9")
	If SX3->(X3Uso(X3_USADO) .And. cNivel >= X3_NIVEL)
		AAdd( aCPO, RTrim( SX3->X3_CAMPO ) )
	Endif
	SX3->(dbSkip())
End

AAdd( aButtons, { "EXCLUIR", {|| U_DELAUXESX(),oDlg:End()}, "Cancela Alterações" } )

dbSelectArea(cAlias)
dbSetOrder(1)

RegToMemory(cAlias,.F.,.T.)

cCgc := "{|| M->"+aCPO[Ascan(aCPO,{|x| Upper(x) == 'PA9_CGC' })]+"}"
CCGC := EVAL(&CCGC)

For nX := 1 To Len( aCPO )
	If X3Obrigat( aCPO[ nX ] )
		Loop
	Endif
	cCpo := "M->"+aCPO[ nX ]
	If Empty(&cCpo) 
		CONOUT("ZC"+SUBSTR(aCPO[NX],4,LEN(ACPO[NX])))
		IF ("ZC"+SUBSTR(aCPO[NX],4,LEN(ACPO[NX])) == "ZC_CONTAT")
			cCpoAux := Posicione("SZC",2,xFilial("SZC")+cCgc,"ZC_CONTATO")
		ELSE	
			cCpoAux := Posicione("SZC",2,xFilial("SZC")+cCgc,"ZC"+SUBSTR(aCPO[NX],4,LEN(ACPO[NX]))) 
		ENDIF
		cCpo := "{|| M->" + aCPO[ nX ] +":=cCpoAux}"
		
		Eval(&cCpo)
		Loop
	Endif
	AAdd( aCpoAlt, aCPO[ nX ] )
Next nI 


DEFINE MSDIALOG oDlg TITLE "Alterações Via Web" FROM nTop, nLeft TO nBottom,nRight PIXEL
oDlg:lMaximized := .T.

oEnch := MSMGet():New(cAlias,,nOpc,,,,,{0,0,90,23},aCpoAlt,,,,,oDlg,,,,,,,,,)
oEnch:oBox:Align := CONTROL_ALIGN_ALLCLIENT

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nAcao := 1, oDlg:End()},{|| oDlg:End() },,aButtons)

IF NACAO == 1
   	
	dbSelectArea(cAlias)
    RecLock(cAlias,.F.)
    For nX := 1 To (cAlias)->(FCount())
    	If "FILIAL" $ FieldName(nX)
    		FieldPut(nX,xFilial("PA9"))
    	Else
    		FieldPut(nX,M->&(Eval(bCampo,nX)))
    	Endif
    Next nX
    MsUnLock()	
   	
   	SZC->(DBSETORDER(1))
	IF  SZC->(DBSEEK(XFILIAL("SZC")+M->PA9_COD))
	    
	    If  (SZC->ZC_CGC != PA9->PA9_CGC)
	        Alert("Codigo Escritório: " + M->PA9_COD + " Com CNPJs diferentes: Cadastro: " + SZC->ZC_CGC + " Alterado: " + PA9->PA9_CGC)
	    Else
	
			/* GRAVA AS INFORMACOES NO SZC */
			Begin Transaction
				DbSelectArea("SZC")
		      	RecLock("SZC",.F.)
		      		SZC->ZC_NOMESC 	:= IIF(!EMPTY(M->PA9_NOMESC),M->PA9_NOMESC,SZC->ZC_NOMESC)
		      		SZC->ZC_CEP 	:= IIF(!EMPTY(M->PA9_CEP),M->PA9_CEP,SZC->ZC_CEP)
		      		SZC->ZC_END 	:= IIF(!EMPTY(M->PA9_END),M->PA9_END,SZC->ZC_END)
		      		SZC->ZC_BAIRRO 	:= IIF(!EMPTY(M->PA9_BAIRRO),M->PA9_BAIRRO,SZC->ZC_BAIRRO)
		      		SZC->ZC_MUN 	:= IIF(!EMPTY(M->PA9_MUN),M->PA9_MUN,SZC->ZC_MUN)
		      		SZC->ZC_EST		:= IIF(!EMPTY(M->PA9_EST),M->PA9_EST,SZC->ZC_EST)
		      		SZC->ZC_EMAIL	:= IIF(!EMPTY(M->PA9_EMAIL),M->PA9_EMAIL,SZC->ZC_EMAIL)
		      		SZC->ZC_FONE	:= IIF(!EMPTY(M->PA9_FONE),M->PA9_FONE,SZC->ZC_FONE)
		      		SZC->ZC_CONTATO	:= IIF(!EMPTY(M->PA9_CONTAT),M->PA9_CONTAT,SZC->ZC_CONTATO) 
		      		SZC->ZC_INAT	:= ''
		      		SZC->ZC_CODDESC	:= ''
		      		SZC->ZC_DATINAT	:= CTOD('')
		      	MsUnLock()
		  	End Transaction
	         
			RecLock("PA9",.F.)
				PA9->(DBDELETE())
			MsUnLock()
		
			MsgInfo("Alterações Confirmadas com Sucesso")
			
		EndIf
	ELSE
		ALERT("Registro da Empresa Nao Localizado")
	ENDIF	
ENDIF

RETURN                                       


USER FUNCTION DELAUXESC()

   	SZC->(DBSETORDER(1))
	IF SZC->(DBSEEK(XFILIAL("SZC")+M->PA9_COD))
		/* GRAVA AS INFORMACOES NO SZC */
		Begin Transaction
			DbSelectArea("SZC")
	      	RecLock("SZC",.F.)
	      		SZC->ZC_INAT	:= ''
	      		SZC->ZC_CODDESC	:= ''
	      		SZC->ZC_DATINAT	:= CTOD('')
	      	MsUnLock()
	  	End Transaction

		RecLock("PA9",.F.)
			PA9->(DBDELETE())
		MsUnLock()

		MsgInfo("Alterações Descartadas Com Sucesso")
    ELSE
		ALERT("Registro da Empresa Nao Localizado")
	ENDIF	

RETURN