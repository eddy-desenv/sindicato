#include "Protheus.ch"

User Function SHMCONF()

Private cTitulo := "Base de Cálculo - Confederativa"
Private cAlias1 := "PAC"
Private cAlias2 := "PAD"
Private aRotina := {}

aAdd( aRotina ,{"Pesquisar" ,"AxPesqui"    ,0,1})
aAdd( aRotina ,{"Visualizar","u_ConfAtual",0,2})
aAdd( aRotina ,{"Incluir"   ,"u_ConfAtual",0,3})
aAdd( aRotina ,{"Alterar"   ,"u_ConfAtual",0,4})
aAdd( aRotina ,{"Excluir"   ,"u_ConfAtual",0,5})

dbSelectArea(cAlias2)
dbSetOrder(1)
cFilSZD := xFilial(cAlias2)

dbSelectArea(cAlias1)
dbSetOrder(2)
cFilSZC := xFilial(cAlias1)

mBrowse(,,,,cAlias1)

Return

User Function ConfAtual( cAlias, nRec, nOpc )
Local i := 0
Local cCliente 
Local oCliente
Local nValor := 0
Local oValor
Local nOpcA := 0
Local oGet
Local oDlg 
LOCAL NCOLS := 0

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

If nOpc == 3  //INCLUSAO
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
   aCOLS[ 1, aScan( aHeader, {|x| Trim( x[ 2 ] ) == "PAD_ITEM" } ) ] := StrZero(1,TamSX3("PAD_ITEM")[1],0)
Else
   dbSelectArea( cAlias2 )
   dbSetOrder( 1 )
   dbSeek( cFilSZD + PAC->PAC_CODIGO )

   While !Eof() .And. cFilSZD == PAD_FILIAL .And. PAD_CODIGO == PAC_CODIGO
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

oGet := MSGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpc, "u_ConfLinOk()","u_ConfTudOk()","+PAD_ITEM",.T.)

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpcA:=1,If(u_ConfTudok().And.Obrigatorio(aGETS,aTELA),oDlg:End(),nOpca:=0)},{||nOpca:=0,oDlg:End()})


If nOpcA == 1 .And. nOpc >= 3

	Begin Transaction
	If ConfGrv( nOpc )
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

Static Function ConfGrv( nOpc )
Local nP_Item
Local i := 0
Local y := 0
local lret := .T.

IF NOPC == 5 //EXCLUSAO

    /* ITENS */
	(cAlias2)->(dbsetorder(1)) //CODIGOITEM
	For i := 1 To Len( aCOLS )
  		nP_Item := GdFieldPos("PAD_ITEM")

   		If !aCOLS[ i, nUsado+1 ]	
			If (cAlias2)->(dbSeek( cFilSZD + M->PAC_CODIGO + aCOLS[ i, nP_Item ]))	
		    	RecLock( cAlias2, .F. )
		        	dbDelete()
		      	MsUnLock( cAlias2 )
		     ENDIF
		 ENDIF
	NEXT I
	
	/* CABECALHO */
	(cAlias1)->(dbsetorder(2)) 
	IF (cAlias1)->(dbSeek( cFilSZC + M->PAC_CODIGO))
	   	RecLock( cAlias1, .F. )
	     	dbDelete()
	  	MsUnLock( cAlias1 )	
	ENDIF
	       
ELSE // INCLUSAO OU ALTERACAO  

  //	IF u_ConfTudOk()

	    /* ITENS */
		(cAlias2)->(dbsetorder(1)) //CODIGOITEM
		For i := 1 To Len( aCOLS )
		   nP_Item := GdFieldPos("PAD_ITEM")
		
		   If !aCOLS[ i, nUsado+1 ]
		      If (cAlias2)->(dbSeek( cFilSZD + M->PAC_CODIGO + aCOLS[ i, nP_Item ]))
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
		      
		      /* CABECALHO */
		      (cAlias1)->(dbsetorder(2)) //CODIGO
		      If (cAlias1)->(dbSeek( cFilSZD + M->PAC_CODIGO))
		         RecLock(cAlias1,.F.)
		      Else
		         RecLock(cAlias1,.T.)
		      Endif      
		
		      PAC->PAC_FILIAL 	:= cFilSZC
		      PAC->PAC_CODIGO 	:= M->PAC_CODIGO
		      PAC->PAC_ANO  	:= M->PAC_ANO
		      PAC->PAC_PARCEL	:= M->PAC_PARCEL
		      PAC->PAC_MESFOL	:= M->PAC_MESFOL
		      PAC->PAC_VLMIN	:= M->PAC_VLMIN
		      PAC->PAC_VENORI	:= M->PAC_VENORI
		      PAC->PAC_MULTA	:= M->PAC_MULTA
		      PAC->PAC_JURO		:= M->PAC_JURO
		      PAC->PAC_APLACR	:= M->PAC_APLACR
		      PAC->PAC_DTPAGT	:= M->PAC_DTPAGT
		      PAC->PAC_MENS01   := M->PAC_MENS01
		      PAC->PAC_MENS02   := M->PAC_MENS02
		      PAC->PAC_MENS03   := M->PAC_MENS03
		      PAC->PAC_MENS04   := M->PAC_MENS04
		      PAC->PAC_MENS05   := M->PAC_MENS05
		      PAC->PAC_MENS06   := M->PAC_MENS06
		      PAC->PAC_MENS07   := M->PAC_MENS07
		      PAC->PAC_STATUS   := M->PAC_STATUS
		      
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
	//ENDIF    
ENDIF

Return( lRet )                                                                                     


/**********************************/
USER FUNCTION ConfLinOk()

LOCAL LVALID := .T.

RETURN LVALID
                                    

/**********************************/
USER FUNCTION ConfTudok()

LOCAL LVALID	:= .T.
LOCAL NX		:= 0
LOCAL NY		:= 0
LOCAL NZ		:= 0 
LOCAL NAUX		:= 0
LOCAL AUXITEM	:= ''   
LOCAL CMSG 		:= ''

                      
/** VERIFICA SE JA EXISTE REGISTRO COM OS MESMOS DADOS **/
//ZC_FILIAL+ZC_ANO+ZC_PARCELA
PAC->(DBORDERNICKNAME("ANOPARCELA"))
IF (PAC->( dbSeek( XFILIAL("PAC") + M->PAC_ANO + M->PAC_PARCEL)))
	IF PAC->PAC_CODIGO <> M->PAC_CODIGO
		CMSG 	:= 'Ano/Parcela Já Definidos'
		LVALID 	:= .F.
	ENDIF
ENDIF


/** VERIFICA ITENS **/
FOR NX := 1 TO LEN(ACOLS)
	NY := aScan( aHeader, {|x| Trim( x[ 2 ] ) == "PAD_CODSIN" } ) 
	IF NY > 0 .AND. !ACOLS[NX,5]
		AUXITEM := ACOLS[NX,NY]
		FOR NZ := 1 TO LEN(ACOLS)
			IF NZ <> NX
				IF ACOLS[NX,NY] == ACOLS[NZ,NY] .AND. !ACOLS[NZ,5]
					CMSG := "Sindicatos Repetidos"
					LVALID := .F.
				ENDIF
		    ENDIF 
		NEXT NZ
	ENDIF
NEXT NX

IIF (!LVALID,ALERT(CMSG),)

RETURN LVALID


