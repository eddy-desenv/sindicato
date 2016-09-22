#Include "RWMAKE.CH"

User Function Rfina100()

Private aRotina := {}
Private cCadastro := "Sindicato x Cidades"
Private cAlias1 := "SZQ"                    // Alias da Enchoice.
Private cAlias2 := "SZR"                    // Alias da GetDados.
Private aMemo    := { 'ZQ_CODMEM', 'ZQ_OBS' }

AAdd(aRotina, {"Pesquisar" , "AxPesqui"  , 0, 1})
AAdd(aRotina, {"Visualizar", "u_RfinaM", 0, 2})
AAdd(aRotina, {"Incluir"   , "u_RfinaM", 0, 3})
AAdd(aRotina, {"Alterar"   , "u_RfinaM", 0, 4})
AAdd(aRotina, {"Excluir"   , "u_RfinaM", 0, 5})
                                               
/*
SZO - ZO_FILIAL + ZO_NUM
SZQ - ZQ_FILIAL + ZQ_COD - 1
SZQ - ZQ_FILIAL + ZQ_CGC - 2
SZQ - ZQ_FILIAL + ZQ_MUN - 3
SZR - ZR_FILIAL + ZR_SINDICA + ZR_MUN - 1
*/

dbSelectArea(cAlias1)
DBSETORDER(1)
dbGoTop()

mBrowse(,,,,cAlias1)

Return Nil

//----------------------------------------------------------------------------------------------------------------//
// Modelo 3.
//----------------------------------------------------------------------------------------------------------------//

User Function RfinaM(cAlias, nRecno, nOpc)

Local i        := 0
Local cLinOK   := "u_TM3LinOK"
Local cTudoOK  := "u_TM3TudOK"
Local nOpcE    := nOpc
Local nOpcG    := nOpc
Local cFieldOK := "AllwaysTrue"
Local lVirtual := .T.
Local nLinhas  := 999
Local nFreeze  := 0
Local lRet     := .T.

Private aCols        := {}
Private aHeader      := {}
Private aCpoEnchoice := {}
Private aAltEnchoice := {}
Private aAlt         := {}

// Cria variaveis de memoria dos campos da tabela Pai.
// 1o. parametro: Alias do arquivo --> é case-sensitive, ou seja precisa ser como está no Dic.Dados.
// 2o. parametro: .T.              --> cria variaveis em branco, preenchendo com o inicializador-padrao.
//                .F.              --> preenche com o conteudo dos campos.
RegToMemory(cAlias1, (nOpc==3))

// Cria variaveis de memoria dos campos da tabela Filho.
RegToMemory(cAlias2, (nOpc==3))

CriaHeader()

CriaCols(nOpc)

// Function Modelo3(cTitulo,cAlias1,cAlias2,aMyEncho,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze,aButtons,aCordW,nSizeHeader)
// Default aCordW := {135,000,nDlgHeight,632}
// Default nSizeHeader := 110
lRet := Modelo3(cCadastro, cAlias1, cAlias2, aCpoEnchoice, cLinOK, cTudoOK, nOpcE, nOpcG, cFieldOK, lVirtual, nLinhas, aAltEnchoice, ;
									nFreeze,, {000,000,4000,4000}, 4000 )

If lRet
   If      nOpc == 3
           If MsgYesNo("Confirma a gravação dos dados?", cCadastro)
              Processa({||GrvDados()}, cCadastro, "Gravando os dados, aguarde...")
           EndIf
    ElseIf nOpc == 4
           If MsgYesNo("Confirma a alteração dos dados?", cCadastro)
              Processa({||AltDados()}, cCadastro, "Alterando os dados, aguarde...")
           EndIf
    ElseIf nOpc == 5
           If MsgYesNo("Confirma a exclusão dos dados?", cCadastro)
              Processa({||ExcDados()}, cCadastro, "Excluindo os dados, aguarde...")
           EndIf

   EndIf
 Else
   RollBackSX8()
EndIf

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function CriaHeader()

aHeader      := {}
aCpoEnchoice := {}
aAltEnchoice := {}

// aHeader é igual ao do Modelo2.

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(cAlias2)

While !SX3->(EOF()) .And. SX3->X3_Arquivo == cAlias2

   If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo é usado.
      cNivel >= SX3->X3_Nivel .And.;                  // Nivel do Usuario é maior que o Nivel do Campo.
      Trim(SX3->X3_Campo) $ "ZR_MUN"

      AAdd(aHeader, {Trim(SX3->X3_Titulo),;
                     SX3->X3_Campo       ,;
                     SX3->X3_Picture     ,;
                     SX3->X3_Tamanho     ,;
                     SX3->X3_Decimal     ,;
                     SX3->X3_Valid       ,;
                     SX3->X3_Usado       ,;
                     SX3->X3_Tipo        ,;
                     SX3->X3_Arquivo     ,;
                     SX3->X3_Context})

   EndIf

   SX3->(dbSkip())

End

// Campos da Enchoice.

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(cAlias1)

While !SX3->(EOF()) .And. SX3->X3_Arquivo == cAlias1

   If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo é usado.
      cNivel >= SX3->X3_Nivel                         // Nivel do Usuario é maior que o Nivel do Campo.

      // Campos da Enchoice.
      AAdd(aCpoEnchoice, X3_Campo)

      // Campos da Enchoice que podem ser editadas.
      // Se tiver algum campo que nao deve ser editado, nao incluir aqui.
      AAdd(aAltEnchoice, X3_Campo)

   EndIf

   SX3->(dbSkip())

End

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function CriaCols(nOpc)

Local nQtdCpo := 0
Local i       := 0
Local nCols   := 0

nQtdCpo := Len(aHeader)
aCols   := {}
aAlt    := {}

If nOpc == 3       // Inclusao.

   AAdd(aCols, Array(nQtdCpo+1))

   For i := 1 To nQtdCpo
       aCols[1][i] := CriaVar(aHeader[i][2])
   Next

   aCols[1][nQtdCpo+1] := .F.

 Else

   dbSelectArea(cAlias2)
   DBSETORDER(1)  // Ordem de Sindicato
   dbSeek(xFilial(cAlias2) + (cAlias1)->ZQ_COD)

   While !EOF() .And. (cAlias2)->ZR_Filial == xFilial(cAlias2) .And. (cAlias2)->ZR_SINDICA == (cAlias1)->ZQ_COD

      AAdd(aCols, Array(nQtdCpo+1))
      nCols++

      For i := 1 To nQtdCpo
          If aHeader[i][10] <> "V"
             aCols[nCols][i] := FieldGet(FieldPos(aHeader[i][2]))
           Else
             aCols[nCols][i] := CriaVar(aHeader[i][2], .T.)
          EndIf
      Next

      aCols[nCols][nQtdCpo+1] := .F.

      AAdd(aAlt, Recno())

      dbSelectArea(cAlias2)
      dbSkip()

   End

	IF Len( aCols ) = 0
	   AAdd(aCols, Array(nQtdCpo+1))

	   For i := 1 To nQtdCpo
	       aCols[1][i] := CriaVar(aHeader[i][2])
	   Next
	
	   aCols[1][nQtdCpo+1] := .F.

	ENDIF

EndIf
 
Return Nil
 
//----------------------------------------------------------------------------------------------------------------//
Static Function GrvDados()

Local cMemo  
Local bCampo := {|nField| Field(nField)}
Local i      := 0
Local y      := 0
Local nItem  := 0

ProcRegua(Len(aCols) + FCount())

// Grava o registro da tabela Pai, obtendo o valor de cada campo
// a partir da var. de memoria correspondente.

dbSelectArea(cAlias1)
RecLock(cAlias1, .T.)
For i := 1 To FCount()
    IncProc()
    If "FILIAL" $ FieldName(i)
       FieldPut(i, xFilial(cAlias1))
     Else
       FieldPut(i, M->&(Eval(bCampo,i)))
    EndIf
Next

	//-- Grava campos memo.
	If Type('aMemo') == 'A'
			cMemo := AMEMO[ 2 ]
			MSMM(,TamSx3( AMEMO[ 2 ] )[ 1 ],, &cMemo, 1,,, 'SZQ', AMEMO[ 1 ] )
	EndIf

MSUnlock()

// Grava os registros da tabela Filho.

dbSelectArea(cAlias2)
DBSETORDER(1)

For i := 1 To Len(aCols)

    IncProc()

    If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.

       RecLock(cAlias2, .T.)

       SZR->ZR_FILIAL := xFilial("SZR")
       SZR->ZR_SINDICA := SZQ->ZQ_COD

       For y := 1 To Len(aHeader)
           FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
       Next

       MSUnlock()

    EndIf

Next

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function AltDados()

Local i      := 0
Local y      := 0
Local nItem  := 0

ProcRegua(Len(aCols) + FCount())

dbSelectArea(cAlias1)
RecLock(cAlias1, .F.)

For i := 1 To FCount()
    IncProc()
    If "FILIAL" $ FieldName(i)
       FieldPut(i, xFilial(cAlias1))
     Else
       FieldPut(i, M->&(fieldname(i)))
    EndIf
Next

//-- Grava campos memo.
If Type('AMEMO') == 'A'
	cMemo := AMEMO[ 2 ]
	MSMM( &( AMEMO[ 1 ] ), TamSx3( AMEMO[ 2 ] )[ 1 ],, &cMemo, 1,,, 'SZQ', AMEMO[ 1 ] )
EndIf

MSUnlock()
    
dbSelectArea(cAlias2)
DBSETORDER(1)

nItem := Len(aAlt) + 1

For i := 1 To Len(aCols)

    If i <= Len(aAlt)

       dbGoTo(aAlt[i])
       RecLock(cAlias2, .F.)

       If aCols[i][Len(aHeader)+1]
          dbDelete()
        Else
          For y := 1 To Len(aHeader)
              FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
          Next
       EndIf

       MSUnlock()

     Else

       If !aCols[i][Len(aHeader)+1]
          RecLock(cAlias2, .T.)
          (cAlias2)->ZR_Filial := xFilial(cAlias2)
          (cAlias2)->ZR_SINDICA:= (cAlias1)->ZQ_COD
          For y := 1 To Len(aHeader)
              FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
          Next
          MSUnlock()
          nItem++
       EndIf

    EndIf

Next

Return Nil

//----------------------------------------------------------------------------------------------------------------//
Static Function ExcDados()

ProcRegua(Len(aCols)+1)   // +1 é por causa da exclusao do arq. de cabeçalho.

dbSelectArea(cAlias2)
DBSETORDER(1)
dbSeek(xFilial(cAlias2) + (cAlias1)->ZQ_COD)

While !EOF() .And. (cAlias2)->ZR_Filial == xFilial(cAlias2) .And. (cAlias2)->ZR_SINDICA == (cAlias1)->ZQ_COD
   IncProc()
   RecLock(cAlias2, .F.)
   dbDelete()
   MSUnlock()
   dbSkip()
End

dbSelectArea(cAlias1)
DBSETORDER(1)
IndProc()
RecLock(cAlias1, .F.)
dbDelete()
MSUnlock()

Return Nil

//----------------------------------------------------------------------------------------------------------------//
User Function TM3TudOK()

Local lRet := .T.
Local i    := 0
Local nDel := 0

IF !U_TM3LinOk()
    RETURN .F.
ENDIF    

For i := 1 To Len(aCols)
    If aCols[i][Len(aHeader)+1]
       nDel++
    EndIf
Next

If nDel == Len(aCols)
   MsgInfo("Para excluir todos os itens, utilize a opção EXCLUIR", cCadastro)
   lRet := .F.
EndIf

// Reescreva esta validaçao para nao aceitar produtos repetidos dentro da GetDados.

Return lRet

//----------------------------------------------------------------------------------------------------------------//
User Function TM3LinOK()

Local lRet := .T.
Local i    := 0
Local nDel := 0
Local aArea := SZR->( GetArea() )

IF ! aCols[n][Len(aHeader)+1]

	M->ZR_MUN := aCols[n][1]
	For i := 1 To Len(aCols)
	    If !aCols[i][Len(aHeader)+1] .AND. aCols[i][1] == M->ZR_MUN .and. n <> i
	       lRet := .F.
			 EXIT
	    EndIf
	Next
	
	DO CASE
			CASE !lRet		
					   MsgStop("Linha " + StrZero( i, 2 ) + " esta DUPLICADA neste Sindicato")
			CASE EMPTY( M->ZR_MUN )
					   MsgStop("Linha " + StrZero( N, 2 ) + " esta EM BRANCO")
						lRet := .F.
			OTHERWISE
						IF SZR->( DbSetOrder(2), MsSeek( xFilial("SZR")+ M->ZR_MUN ) ) .AND. SZR->ZR_SINDICA <> M->ZQ_COD
						   MsgStop("Linha " + StrZero( n, 2 ) + " esta Duplicada 	no Sindicato " + SZR->ZR_SINDICA )
							lRet := .F.
						ENDIF
	ENDCASE
	
ENDIF


RestArea( aArea) 

Return lRet
