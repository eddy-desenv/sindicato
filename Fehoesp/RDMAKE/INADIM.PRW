#include "rwmake.ch"
#include "topconn.ch"
User Function INADIM()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ RELINAD  ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 12.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao relatorio de Inadimplencias                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

@ 096,042 TO 405,505 DIALOG oDlg1 TITLE "Transferencia de Status de Associados"
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa ira transferir automaticamente os Status AS e SS dos clientes"
@ 086,014 SAY "CONFIRME PARA INICIAR A ATUALIZACAO DOS DADOS."
@ 110,168 BMPBUTTON TYPE 1 ACTION Iniciar()
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)
//@ 110,228 BMPBUTTON TYPE 3 ACTION Pergunte("RELINA", .T.)
ACTIVATE DIALOG oDlg1 CENTERED
Return
**************************
Static Function Iniciar()
Close(oDlg1)

//Pergunte("RELINA", .F. )
Processa( {|| ATUALIZA() })
Return
**************************
Static Function ATUALIZA()

LOCAL aArea 			:= GetArea()
LOCAL aAreaSA1			:= SA1->( GetArea() )
LOCAL cQuery
LOCAL nNumtitssas := 0
LOCAL nNumtitasss := 0

cQUERY := " SELECT A1_COD,A1_NOME,A1_END,A1_BAIRRO,A1_CEP,A1_MUN,A1_EST,A1_CGC,A1_DTCADAS,A1_DTINASS,A1_TEL, "
cquery += " A1_CODASSO,E1_NATUREZ,E1_PREFIXO,E1_NUM,E1_PARCELA, E1_VENCTO,E1_EMISSAO,E1_VALOR,A1_ERSIN, "
cQUERY += " A1_SITUAC,E1_HIST,A1_FILANT,A1_CATEG1, A1_SINDICA, E1_BAIXA, E1_SALDO "
cQUERY += " FROM SE1010 SE1 INNER JOIN SA1010 SA1 ON E1_CLIENTE=A1_COD AND E1_LOJA=A1_LOJA "
cQUERY += " WHERE E1_EMISSAO >= '20070101' AND  E1_NATUREZ IN "+FORMATIN("001/1000", "/") "
cQUERY += " AND  SA1.D_E_L_E_T_='' AND SE1.D_E_L_E_T_='' " //AND E1_BAIXA='' AND E1_SALDO<>0 "
cQUERY += " ORDER BY A1_CODASSO, E1_VENCTO "

PadSql( cQuery, 80 )

SA1->( dbOrderNickName('8')  ) // DBSETORDER(8) // Alterado (UPDXFUN).

TCQUERY cQuery NEW ALIAS "TRB"

PROCREGUA(RECC())
DbGoTop()

DO WHILE TRB->( !EOF() )

	CODTITVENC := CODNUMTIT := 0                                     
	XCODASSO := TRB->A1_CODASSO

	DO WHILE TRB->( !EOF() ) .AND. TRB->A1_CODASSO == XCODASSO
		INCPROC()
		IF EMPTY( TRB->E1_BAIXA ) .AND. TRB->E1_SALDO <> 0 //  SOMENTE CONSIDERA BAIXADOS // .AND. ALLTRIM(TRB->E1_NATUREZ)$"001/1000"
			CODNUMTIT ++
			IF STOD(TRB->E1_VENCTO)<DDATABASE 
				CODTITVENC ++                   
			ENDIF
		ENDIF
		TRB->( DBSKIP() )
	ENDDO

	IF CODNUMTIT < 6 .OR. CODTITVENC >= 6

		SA1->( DbSeek(xfilial()+xcodasso) )

		if codnumtit <6
			if sa1->a1_situac=="SS"
				nNumtitssas++
				reclock("SA1",.F.)
				SA1->a1_SITUAC := "AS"
				msunlock()
			endif
		elseif codTITVENC >=6
			if sa1->a1_situac=="AS"                                        
				nNumtitasss++
				reclock("SA1",.F.)
				SA1->a1_SITUAC := "SS"
				msunlock()
			endif
		endif

	ENDIF
		
	TRB->( DBSKIP() )

ENDDO

TRB->( DbCloseArea() )

SA1->( RestArea( aAreaSA1 ) )
SA1->( RestArea( aArea ) )

msginfo( "Titulos que migraram de SS para AS " + STRZERO( nNumTitSSAS, 4 ) + CHR( 10 ) + CHR( 13 ) + "Titulos que migraram de AS para SS " + STRZERO( nNumTitASSS, 4 ) ) 

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
STATIC FUNCTION PadSql( cQuery, nCol, nTab )

LOCAL nPos      := 0
LOCAL cNewQuery := ""

cQuery := AllTrim( cQuery )

nTab := IIF( nTab == NIL, 7, nTab )

DO While Len( cLine := Upper( Left( cQuery, nCol ) ) ) == nCol

   IF ( nPos := AT( 'FROM ' ,    cLine ) ) > 0 .OR. ;
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

IF ( nPos := AT( 'ORDER ', cLine ) ) > 0
   cLine := LEFT( cLine,  nPos - 1 ) + chr(13) + chr(10) + chr(13) + chr(10)+ SUBST( cLine, nPos )
	cNewQuery += cLine
ENDIF

MEMOWRIT( "INADIM" + ".SQL", cNewQuery, 1000 )

RETURN



