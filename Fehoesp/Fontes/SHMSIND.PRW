#include "Protheus.ch"

User Function SHMSIND()

Private cTitulo := "Base de Cálculo - Sindical"
Private cAlias1 := "PAA"
Private cAlias2 := "PAB"
Private aRotina := {}

aAdd( aRotina ,{"Pesquisar" ,"AxPesqui"    ,0,1})
aAdd( aRotina ,{"Visualizar","u_ASSOATUAL",0,2})
aAdd( aRotina ,{"Incluir"   ,"u_ASSOATUAL",0,3})
aAdd( aRotina ,{"Alterar"   ,"u_ASSOATUAL",0,4})
aAdd( aRotina ,{"Excluir"   ,"u_ASSOATUAL",0,5})

dbSelectArea(cAlias2)
dbSetOrder(1)
cFilSZB := xFilial(cAlias2)

dbSelectArea(cAlias1)
dbSetOrder(1)
cFilSZA := xFilial(cAlias1)

mBrowse(,,,,cAlias1)

Return

User Function ASSOATUAL( cAlias, nRec, nOpc )
Local i := 0
Local cCliente 
Local oCliente
Local nValor := 0
Local oValor
Local nOpcA := 0
Local oGet
Local oDlg 
LOCAL NCOLS	:= 0

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
dbSetOrder(1)
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
   aCOLS[ 1, aScan( aHeader, {|x| Trim( x[ 2 ] ) == "PAB_ITEM" } ) ] := StrZero(1,TamSX3("PAB_ITEM")[1],0)
Else                                                
   dbSelectArea( cAlias2 )
   dbSetOrder( 1 )
   dbSeek( cFilSZB + PAA->PAA_CODIGO )

   While !Eof() .And. cFilSZB == PAB_FILIAL .And. PAB_CODIGO == PAA_CODIGO
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

oGet := MSGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpc, "u_ASSOLinOk()","u_ASSOTudOk()","+PAB_ITEM",.T.)

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpcA:=1,If(u_ASSOTudok().And.Obrigatorio(aGETS,aTELA),oDlg:End(),nOpca:=0)},{||nOpca:=0,oDlg:End()})


If nOpcA == 1 .And. nOpc >= 3
	Begin Transaction
	If ASSOGrv( nOpc )
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

Static Function ASSOGrv( nOpc )
Local nP_Item
Local i := 0
Local y := 0
local lret := .T.

IF NOPC == 5 // EXCLUSAO
	(cAlias2)->(dbsetorder(1)) //ZB_FILIAL+ZB_CODIGO+ZB_ITEM  
	For i := 1 To Len( aCOLS )
  		nP_Item := GdFieldPos("PAB_ITEM")

   		If !aCOLS[ i, nUsado+1 ]	
			If (cAlias2)->(dbSeek( cFilSZB + M->PAA_CODIGO + aCOLS[ i, nP_Item ]))	
		    	RecLock( cAlias2, .F. )
		        	dbDelete()
		      	MsUnLock( cAlias2 )
		     ENDIF
		 ENDIF
	NEXT I
	(cAlias1)->(dbsetorder(1)) 
	IF (cAlias1)->(dbSeek( cFilSZA + M->PAA_ANO + M->PAA_CODIGO))
	   	RecLock( cAlias1, .F. )
	     	dbDelete()
	  	MsUnLock( cAlias1 )	
	ENDIF
	       
ELSE

(cAlias2)->(dbsetorder(1)) 
For i := 1 To Len( aCOLS )
   nP_Item := GdFieldPos("PAB_ITEM")

   If !aCOLS[ i, nUsado+1 ]
      If (cAlias2)->(dbSeek( cFilSZA + M->PAA_CODIGO + aCOLS[ i, nP_Item ]))
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
      
      (cAlias1)->(dbsetorder(1))
      If (cAlias1)->(dbSeek( cFilSZA + M->PAA_ANO + M->PAA_CODIGO))
         RecLock(cAlias1,.F.)
      Else
         RecLock(cAlias1,.T.)
      Endif      

      PAA->PAA_FILIAL  := cFilSZA
      PAA->PAA_CODIGO  := M->PAA_CODIGO
      PAA->PAA_ANO 	  := M->PAA_ANO
      PAA->PAA_APLACR  := M->PAA_APLACR
      PAA->PAA_VENCTO  := M->PAA_VENCTO
      PAA->PAA_PAGTO   := M->PAA_PAGTO
      PAA->PAA_MULTA1  := M->PAA_MULTA1
      PAA->PAA_MULTA2  := M->PAA_MULTA2      
      PAA->PAA_JUROS   := M->PAA_JUROS
      PAA->PAA_CORREC  := M->PAA_CORREC
      PAA->PAA_MENS01  := M->PAA_MENS01
      PAA->PAA_MENS02  := M->PAA_MENS02
      PAA->PAA_MENS03  := M->PAA_MENS03
      PAA->PAA_MENS04  := M->PAA_MENS04
      PAA->PAA_MENS05  := M->PAA_MENS05
      PAA->PAA_MENS06  := M->PAA_MENS06
      PAA->PAA_MENS07  := M->PAA_MENS07
      PAA->PAA_MENS08  := M->PAA_MENS08
      PAA->PAA_MENS09  := M->PAA_MENS09
      PAA->PAA_STATUS  := M->PAA_STATUS
      
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



USER FUNCTION ASSOLinOk()

LOCAL LVALID := .T.

IF !EMPTY(aCols[n,3]) .AND. aCols[n,4] > 0 .AND. aCols[n,3] >= aCols[n,4]
	ALERT("Capital Inicial Deve Ser Menor que Capital Final") 
	LVALID := .F.
ENDIF

IF !EMPTY(aCols[n,3]) .AND. aCols[n,3] <=0 
	ALERT("Capital Inicial Deve Possui Valor Positivo")
	LVALID := .F.	
ENDIF

IF !EMPTY(aCols[n,4]) .AND. aCols[n,4] <0 
	ALERT("Capital Final Deve Possui Valor Positivo")
	LVALID := .F.	
ENDIF

IF !EMPTY(aCols[n,5]) .AND. aCols[n,5] < 0 
	ALERT("Aliquota Deve Possui Valor Positivo") 
	LVALID := .F.	
ENDIF

IF !EMPTY(aCols[n,6]) .AND. aCols[n,6] < 0
	ALERT("Acrescimo Deve Possui Valor Positivo")
	LVALID := .F.	
ENDIF 

RETURN LVALID
                                    

/**********************************/
USER FUNCTION ASSOTudok()

LOCAL LVALID	 := .T.
LOCAL NX		 := 0
LOCAL NY		 := 0
LOCAL AX
LOCAL CMSG		:= ''


FOR NX:= 1 TO LEN(aCols)
	AX := aScan( aCols, {|x|  x[3]   == aCols[NX,3] } ) 
	IF AX > 0 .AND. AX <> NX 
		LVALID := .F.
		CMSG := "Capital Inicial Repetido!!!"
	ENDIF
NEXT NX 			    	

FOR NX:= 1 TO LEN(aCols)
	AX := aScan( aCols, {|x|  x[4]   == aCols[NX,4] } ) 
	IF AX > 0 .AND. AX <> NX
		LVALID := .F.
		CMSG := "Capital Final Repetido!!!"
	ENDIF
NEXT NX 

/** VERIFICA SE O CAPITAL INICIAL JA ESTA ESTABELECIADO EM ALGUM INTERVALO **/       
FOR NX:= 1 TO LEN(aCols)
	FOR NY:=1 TO LEN(ACOLS)
		IF NY <> NX
			IF ACOLS[NX,3] >= ACOLS[NY,3] .AND. ACOLS[NX,3] <= ACOLS[NY,4]
				LVALID := .F.
				CMSG := "Intervalo de Capital Já Definido!!!"			
	        ENDIF
	   ENDIF
	NEXT NY
NEXT NX 
  
/** VERIFICA SE O CAPITAL FINAL JA ESTA ESTABELECIADO EM ALGUM INTERVALO **/       
FOR NX:= 1 TO LEN(aCols)
	FOR NY:=1 TO LEN(ACOLS)
		IF NY <> NX
			IF ACOLS[NX,4] >= ACOLS[NY,3] .AND. ACOLS[NX,4] <= ACOLS[NY,3]
				LVALID := .F.
				CMSG := "Intervalo de Capital Já Definido!!!"			
	        ENDIF
	   ENDIF
	NEXT NY
NEXT NX

/** VERIFICA SE JA EXISTE REGISTRO COM OS MESMOS DADOS **/
PAA->(DBSETORDER(1))
IF (PAA->( dbSeek( XFILIAL("PAA") + M->PAA_ANO)))
	IF PAA->PAA_CODIGO <> M->PAA_CODIGO
		CMSG 	:= 'Ano Já Definido'
		LVALID 	:= .F.
	ENDIF
ENDIF
                
IIF (!LVALID,ALERT(CMSG),)

RETURN LVALID


