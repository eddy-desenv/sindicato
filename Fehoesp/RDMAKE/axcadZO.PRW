#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
User Function axcadzO()        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04
//AxCadastro("SZO","Cadastro de Cidades")


Private aRotina := {	{ "Pesquisar"    ,"AxPesqui",  0 , 1},;  //"Pesquisar"
							{ "Visualizar" ,"AxVisual", 0 , 2},;  //"Visualizar"
							{ "Incluir"    ,"AxInclui", 0 , 3},;  //"Incluir"
							{ "Alterar"    ,"U_AxAltera()", 0 , 4 },;  //"Alterar"
							{ "Excluir"    ,"AxDeleta", 0 , 5 }}  //"Excluir"
                                                                                                              
Private cCadastro := "Cadastro de Cidades"

mBrowse(6, 1,22,75,"SZO",,,,,,)

Return
                       
User Function AxAltera(cAlias, nReg, nOpcx)  

cTudoOk := "u_CheckUpd()"

AxAltera("SZO",NrEG,4,,,,,cTudoOk)

RETURN                                     
                                                       
USER FUNCTION CHECKUPD()

LOCAL cQuery

IF M->ZO_ERSIN <> SZO->ZO_ERSIN .OR. M->ZO_BASE <> SZO->ZO_BASE.OR. M->ZO_BASE2 <> SZO->ZO_BASE2   .OR. M->ZO_SINDICA<>SZO->ZO_SINDICA
	cQuery := 	"UPDATE SA1010 SET A1_ERSIN = '" + M->ZO_ERSIN + "', A1_BASE = '" + M->ZO_BASE + "', A1_BASE2 = '" + M->ZO_BASE2 + "', A1_SINDICA = '" + M->ZO_SINDICA + "'  "+ ;
					"WHERE A1_FILIAL = '" + xFilial( "SA1" ) + "' AND A1_MUN = '"  + SZO->ZO_MUN + "' AND D_E_L_E_T_=' '"

	PADSQL( cQuery, 80 )

	TCSQLEXEC(cQuery)

ENDIF

RETURN .T.
                                           
STATIC FUNCTION PadSql( cQuery, nCol, nTab )

LOCAL nPos      := 0
LOCAL cNewQuery := ""

cQuery := AllTrim( cQuery )

nTab := IIF( nTab == NIL, 7, nTab )

DO While Len( cLine := Upper( Left( cQuery, nCol ) ) ) == nCol

   IF ( nPos := AT( 'FROM ' ,    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'SET '  ,    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'WHERE ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'GROUP ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'UNION ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'JOIN ' ,    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'ON '   ,    cLine ) ) > 0
      cNewQuery += LEFT( cLine, nPos - 1 ) + chr(13) + chr(10) + chr(13) + chr(10)
      nPosSpace := AT( ' ', Subst( cLine, nPos ) )
      cNewQuery += PADR( Subst( cLine, nPos, nPosSpace ), nTab )
      nPos      := nPosSpace + nPos - 1
   ELSE
      nPosSpace := RAT( ' ', cLine )
      nPosComma := RAT( ',', cLine )
      nPosAnd   := RAT( ' AND ', cLine )
      nPos      := Max( nPosSpace, nPosComma )
      nPos      := IF( nPosAnd > 0, nPosAnd, Max( nPosAnd, nPos ) )
      cNewQuery += LEFT( cLine, nPos ) + chr(13) + chr(10) + SPACE( nTab )
   ENDIF
        
   cQuery := Subst( cQuery, nPos + 1 )

ENDDO

cNewQuery += cLine

MEMOWRIT( "AXCADZO" + ".SQL", cNewQuery, 1000 )

RETURN



