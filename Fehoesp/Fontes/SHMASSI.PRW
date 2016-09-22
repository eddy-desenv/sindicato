#include "Protheus.ch"

User Function SHMASSI()

Private cTitulo := "Base de Cálculo - Assistencial"
Private cAlias1 := "PAE"
Private cAlias2 := "PAF"
Private aRotina := {}

aAdd( aRotina ,{"Pesquisar" ,"AxPesqui"   ,0,1})
aAdd( aRotina ,{"Visualizar","u_AssiAtual",0,2})
aAdd( aRotina ,{"Incluir"   ,"u_AssiAtual",0,3})
aAdd( aRotina ,{"Alterar"   ,"u_AssiAtual",0,4})
aAdd( aRotina ,{"Excluir"   ,"u_AssiAtual",0,5})

dbSelectArea(cAlias2)
dbSetOrder(1)
cFilSZF := xFilial(cAlias2)

dbSelectArea(cAlias1)
dbSetOrder(2)
cFilSZE := xFilial(cAlias1)

mBrowse(,,,,cAlias1)

Return

User Function AssiAtual( cAlias, nRec, nOpc )
Local i := 0
Local nOpcA := 0
Local oGet
Local oDlg 
LOCAL nCOLS := 0

Private aHeader := {}
Private aCOLS := {}
Private nUsado := 0
Private bCpo := { |nField| Field(nField) }
Private aRecNo := {}
Private aTELA := {}
Private aGETS := {}

Private aPosEnch := {15, 1, 70, 315}
Private aSize := {}
Private aObjects := {}
Private aInfo := {}
Private aPosObj := {}
Private aPosGet := {}

aSize := MsAdvSize()
aInfo := {aSize[1],aSize[2],aSize[3],aSize[4],3,3}

aAdd(aObjects,{100,100,.T.,.T.})
aAdd(aObjects,{100,100,.T.,.T.})
aAdd(aObjects,{100,015,.T.,.F.})

aPosObj := MsObjSize(aInfo,aObjects)
aPosGet := MsObjGetPos((aSize[3]-aSize[1]),315,{{004,024,240,270}} )

dbSelectArea(cAlias1)
dbSetOrder(2)
dbGoTo(nRec)

For i := 1 To FCount()
	If nOpc == 3
      M->&( Eval( bCpo, i ) ) := CriaVar( FieldName( i ), .T. )
   Else
      M->&( Eval( bCpo, i ) ) := FieldGet( i )
   Endif
Next i

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(cAlias2)

While !Eof() .And. X3_ARQUIVO == cAlias2
   If X3USO( X3_USADO ) .And. cNivel >= X3_NIVEL
      aAdd( aHeader, { Trim( X3Titulo() ), X3_CAMPO, X3_PICTURE, X3_TAMANHO, X3_DECIMAL, X3_VALID, X3_USADO, X3_TIPO, X3_ARQUIVO, X3_CONTEXT } )
      nUsado++
   Endif
   dbSkip()
End

If nOpc == 3
   aAdd( aCOLS, Array( nUsado + 1 ) )
   nUsado := 0
   
   dbSelectArea("SX3")
   dbSetOrder(1)
   dbSeek(cAlias2)
   
   While !Eof() .And. X3_ARQUIVO == cAlias2
	   If X3USO(X3_USADO) .And. cNivel >= X3_NIVEL
		   nUsado++
		   aCOLS[ 1, nUsado ] := CriaVar( Trim( X3_CAMPO ), .T. )
      Endif
      dbSkip()
   End

   aCOLS[ 1, nUsado+1 ] := .F.
   aCOLS[ 1, aScan( aHeader, {|x| Trim( x[ 2 ] ) == "PAF_ITEM" } ) ] := StrZero(1,TamSX3("PAF_ITEM")[1],0)
Else
   dbSelectArea( cAlias2 )
   dbSetOrder( 1 )
   dbSeek( cFilSZF + PAE->PAE_CODIGO )

   While !Eof() .And. cFilSZF == PAF_FILIAL .And. PAF_CODIGO == PAE_CODIGO
      aAdd( aCOLS, Array( nUsado+1 ) )
      nCOLS ++
   
      For i := 1 To nUsado
         If aHeader[ i, 10 ] <> "V"
            aCOLS[ nCOLS, i ] := FieldGet( FieldPos( aHeader[ i, 2 ] ) )
         Else
            aCOLS[ nCOLS, i ] := CriaVar( aHeader[ i, 2 ], .T. )
         Endif
      Next i
   
      aAdd( aRecNo, RecNo() )
      aCOLS[ nCOLS, nUsado+1 ] := .F.
      dbSelectArea( cAlias2 )
      dbSkip()
   End

Endif

DEFINE MSDIALOG oDlg TITLE cTitulo FROM aSize[7],aSize[1] TO aSize[6],aSize[5] OF oMainWnd PIXEL
EnChoice( cAlias1, nRec, nOpc, , , , , aPosObj[1], , 3)

oGet := MSGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpc, "u_ASSILinOk()","u_ASSITudOk()","+PAF_ITEM",.T.)

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpcA:=1,If(u_AssiTudok().And.Obrigatorio(aGETS,aTELA),oDlg:End(),nOpca:=0)},{||nOpca:=0,oDlg:End()})


If nOpcA == 1 .And. nOpc >= 3
	Begin Transaction
	If AssiGrv( nOpc )
		EvalTrigger()
		If __lSX8
			ConfirmSX8()
		Endif
	EndIf
	End Transaction
Else
	If __lSX8
		RollBackSX8()
	Endif
Endif

Return

Static Function AssiGrv( nOpc )
Local nP_Item
Local i := 0
Local y := 0
local lret := .T.

IF NOPC == 5
	(cAlias2)->(dbsetorder(2)) //CODIGOITEM
	For i := 1 To Len( aCOLS )
  		nP_Item := GdFieldPos("PAF_ITEM")

   		If !aCOLS[ i, nUsado+1 ]	
			If (cAlias2)->(dbSeek( cFilSZF + M->PAE_CODIGO + aCOLS[ i, nP_Item ]))	
		    	RecLock( cAlias2, .F. )
		        	dbDelete()
		      	MsUnLock( cAlias2 )
		     ENDIF
		 ENDIF
	NEXT I
	(cAlias1)->(dbsetorder(2)) 
	IF (cAlias1)->(dbSeek( cFilSZE + M->PAE_CODIGO))
	   	RecLock( cAlias1, .F. )
	     	dbDelete()
	  	MsUnLock( cAlias1 )	
	ENDIF
	       
ELSE

(cAlias2)->(dbsetorder(2)) //CODIGOITEM
For i := 1 To Len( aCOLS )
   nP_Item := GdFieldPos("PAF_ITEM")

   If !aCOLS[ i, nUsado+1 ]
      If (cAlias2)->(dbSeek( cFilSZF + M->PAE_CODIGO + aCOLS[ i, nP_Item ]))
         RecLock(cAlias2,.F.)
      Else
         RecLock(cAlias2,.T.)
      Endif
      
	  For y := 1 To Len( aHeader )
         If aHeader[ y, 10 ] <> "V"
            FieldPut( FieldPos( aHeader[ y, 2 ] ), aCOLS[ i, y ] )
         Endif
      Next y 
       
      MsUnLock()
      
      (cAlias1)->(dbsetorder(2)) //CODIGO
      If (cAlias1)->(dbSeek( cFilSZE + M->PAE_CODIGO))
         RecLock(cAlias1,.F.)
      Else
         RecLock(cAlias1,.T.)
      Endif      

      PAE->PAE_FILIAL  := cFilSZE
      PAE->PAE_CODIGO  := M->PAE_CODIGO
      PAE->PAE_BASE    := M->PAE_BASE
      //PAE->PAE_REGIAO := M->PAE_REGIAO
      PAE->PAE_MENS01  := M->PAE_MENS01
      PAE->PAE_MENS02  := M->PAE_MENS02
      PAE->PAE_MENS03  := M->PAE_MENS03
      PAE->PAE_MENS04  := M->PAE_MENS04
      PAE->PAE_MENS05  := M->PAE_MENS05
      PAE->PAE_MENS06  := M->PAE_MENS06
      PAE->PAE_MENS07  := M->PAE_MENS07
      PAE->PAE_STATUS  := M->PAE_STATUS
      
      MsUnLock()
   Else
      If !Found()
         Loop
	   Endif
      RecLock( cAlias1, .F. )
         dbDelete()
      MsUnLock( cAlias1 )
   Endif
Next i
    
ENDIF

Return( lRet )                                                                                     


/**********************************/
USER FUNCTION AssiLinOk()

LOCAL LVALID := .T.

RETURN LVALID
                                    

/**********************************/
USER FUNCTION AssiTudok()

LOCAL LVALID	 := .T.

RETURN LVALID


