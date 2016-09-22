#include "rwmake.ch"
#include "topconn.ch"
User Function TrocaCGC()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TrocaCGC ³ Autor ³ Marcello M. Navarro   ³ Data ³ 15/04/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Troca de CGC de um cliente                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß\ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

@ 096,042 TO 375,505 DIALOG oDlg1 TITLE "Alteracao de CNPJ no Cliente"
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa ira alterar o CNPJ de um determinado cliente"
@ 086,014 SAY "CONFIRME PARA INICIAR A ATUALIZACAO DOS DADOS."
@ 110,168 BMPBUTTON TYPE 1 ACTION Iniciar()
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED
Return
**************************
Static Function Iniciar()
Close(oDlg1)
Processa( {|| ATUALIZA() })
Return
**************************
Static Function ATUALIZA()

LOCAL aArea 			:= GetArea()
LOCAL aAreaSE1			:= SE1->( GetArea() )
LOCAL cQuery

/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Variaveis utilizadas para parametros                                       ³
	³ mv_par01   // do CNPJ  				                                         ³
	³ mv_par02   // para CNPJ                                                    ³
	³ mv_par03   // do CLiente                                                   ³
	³ mv_par04   // para Cliente                                                 ³
	³ mv_par05   // Natureza                                                     ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/


Pergunte( "TROCGC")

cQueryCount :=	"SELECT 	COUNT(*) NCOUNT FROM SE1010 SE1 " + ;
					"WHERE  	E1_FILIAL = '" + xFilial( "SE1" ) + "' AND " + ;
				 	"E1_CGC = '" + mv_par01 + ;
					IIF( ! EMPTY( MV_PAR03 ), "' AND E1_CLIENTE = '" + MV_PAR03 , "" ) + ;
					IIF( ! EMPTY( MV_PAR05 ), "' AND E1_NATUREZ = '" + MV_PAR05 , "" ) + ;
					"' AND SE1.D_E_L_E_T_=' ' "

TCQUERY cQueryCount NEW ALIAS "TRB"
nNumTit1 := TRB->( nCount )
TRB->( DbCloseArea() )

IF nNumTit1 == 0
	MsgStop( "Nao existem titulos com o CNPJ " + mv_par01 + ;
				IIF( ! EMPTY( MV_PAR03 ), " e 	CLIENTE  " + MV_PAR03 , "" ) )
	RETURN
ENDIF

cQueryCount := ;
"SELECT 	COUNT(*) NCOUNT FROM SE1010 SE1 " + ;
"WHERE  	E1_FILIAL = '" + xFilial( "SE1" ) + "' AND " + ;
		 	"E1_CGC = '" + mv_par02 + "' AND " + ; 
			"SE1.D_E_L_E_T_=' ' "

TCQUERY cQueryCount NEW ALIAS "TRB"
nNumTit2 := TRB->( nCount )
TRB->( DbCloseArea() )

IF nNumTit2 <> 0
	IF ! MsgYesNo( 	"Ja existem " + STRZERO( nNumTit2, 6 ) + " titulos com o CNPJ "+ mv_par02 + " !" + CHR(13) + CHR(10) + ;
							'Deseja Prosseguir ?' ) 
		RETURN
	ENDIF
ENDIF

IF ! MsgYesNo( 	"Confirma a alteracao do "  + CHR(13) + CHR(10 ) + ;
					"CNPJ "+ mv_par01 + " para o " + CHR(13) + CHR(10 ) + ;
					"CNPJ "+ mv_par02 + " ?") 
	RETURN            
ENDIF
  
IF EMPTY( MV_PAR03 )
	cQuery := 	"UPDATE SE1010 SET E1_CGC = '" + mv_par02 + "' WHERE E1_CGC = '" + MV_PAR01 + "' " +;
					IIF( ! EMPTY( MV_PAR05 ), " AND E1_NATUREZ = '" + MV_PAR05 + "' ", "" ) + ;
					 " AND D_E_L_E_T_=' ' "
ELSE                                  
	cQuery := 	"UPDATE SE1010 SET E1_CGC = '" + mv_par02 + "', E1_CLIENTE = '" + MV_PAR04  + "' " + ;
					"WHERE E1_CGC = '" + MV_PAR01 + "' AND E1_CLIENTE = '" + MV_PAR03 + "' " + ;
					IIF( ! EMPTY( MV_PAR05 ), " AND E1_NATUREZ = '" + MV_PAR05 + "' ", "" ) + ;
					" AND D_E_L_E_T_=' ' "
ENDIF

PADSQL( "TROCACGC.SQL",cQuery, 80 )

TCSQLEXEC(cQuery)

RestArea( aAreaSE1 )
RestArea( aArea )
                                                             
MsgInfo( "Foram alterados " + STRZERO( nNumTit1, 6 ) +  " Titulos para o NOVO CNPJ " + mv_par02 )

RETURN

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PadSql   ³ Autor ³ 		MMN - 0990       ³ Data ³05/12/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Melhora a Visualizacao da Query no Analyzer                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³VIDEOLAR                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION PadSql( cName, cQuery, nCol )

LOCAL cNewQuery := ""
LOCAL nTab      := 7

DO While Len( cLine := Upper( Left( cQuery, nCol ) ) ) == nCol

   IF ( nPos := AT( 'FROM ',     cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'WHERE ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'GROUP ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'JOIN ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'UNION ',    cLine ) ) > 0 .OR. ;
      ( nPos := AT( 'ORDER ', cLine ) ) > 0
      cNewQuery += LEFT( cLine, nPos - 1 ) + chr(13) + chr(10) + chr(13) + chr(10)
      nPosSpace := AT( ' ', Subst( cLine, nPos ) )
      cNewQuery += PADR( Subst( cLine, nPos, nPosSpace ), nTab )
      nPos      := nPosSpace + nPos - 1
   ELSE
      nPosSpace := RAT( ' ', cLine )
      nPosComma := RAT( ',', cLine )
      nPosAnd   := RAT( ' AND ', cLine )
      nPos      := Max( nPosSpace, nPosComma )
      nPos      := Max( nPosAnd, nPos )  
      cNewQuery += LEFT( cLine, nPos ) + chr(13) + chr(10) + SPACE( nTab )
   ENDIF
        
   cQuery := Subst( cQuery, nPos + 1 )

ENDDO

IF ( nPos := AT( 'ORDER ', cLine ) ) > 0
   cLine := LEFT( cLine,  nPos - 1 ) + chr(13) + chr(10) + chr(13) + chr(10) + SUBST( cLine, nPos )
ENDIF

MEMOWRIT( cName, cNewQuery+ cLine, 1000 )

RETURN



