
#include "topconn.ch"
User Function ETIQmail()
SetPrvt("_CALIAS,CBCONT,CBTXT,WNREL,CDESC1,CDESC2")
SetPrvt("CDESC3,CSTRING,TAMANHO,TIPO,LIMITE,TITULO")
SetPrvt("CABEC1,CABEC2,ARETURN,NOMEPROG,NLASTKEY,CPERG")
SetPrvt("M_PAG,LI,_AESTR,C_ARQIMP,CARQIND,CINDSA1")
SetPrvt("XNOME1,XNOME2,XNOME3,XNOME4,XEND1,XEND2")
SetPrvt("XEND3,XEND4,XBAIRRO1,XBAIRRO2,XBAIRRO3,XBAIRRO4")
SetPrvt("XCEP1,XCEP2,XCEP3,XCEP4,XCIDADE1,XCIDADE2")
SetPrvt("XCIDADE3,XCIDADE4,XESTADO1,XESTADO2,XESTADO3,XESTADO4")
SetPrvt("NVEZ,LIMPRIME,VEZ,")                                      
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � etiqmail � Autor � Luiz M. Duarte Junior � Data � 02.02.10 ���
�������������������������������������������������������������������������Ĵ��
���Descri�ao � Impressao de etiquetas  mailing                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico FEHOESP                                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/    
_cAlias := alias()
cbcont := 0
cbtxt := ""
wnrel := ""
cDesc1 := "Este programa ir� imprimir as etiquetas"
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "G"
tipo := 15
limite := 220
titulo := "Etiquetas de Mailing"
cabec1 := ""
cabec2 := ""
//	     1	       2	 3	   4	     5	       6	 7	   8	     9	      10	11	  12	    13	      14	15	  16	    17
// 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
// 123456 123456789012345678901234567890123456789012345  12.345.678/9012-34    12   1234 999,99 999,99 999,99 999,99 999,99 999,99 999,99 999,99 999,99 999,99 999,99 999,99 99.999,99
// XXXXXXXXXXXXXXXXXX(40)XXXXXXXXXXXXXXXXXX XXXXX(15)XXXXXX XXXXXXX(15)XXXX
//
cPerg := "ETIQMAIL"
PERGUNTE(CPERG,.T.)
nMargem :=0
LI := 0
oFont36N	:= TFont():New("Courier New",36,36,,.T.,,,,.T.,.F.)
oFont32 	:= TFont():New("Courier New",36,36,,.f.,,,,.T.,.F.)
oFont18N	:= TFont():New("Courier New",18,18,,.T.,,,,.T.,.F.)
oFont18 	:= TFont():New("Courier New",18,18,,.F.,,,,.T.,.F.)
oFont16N	:= TFont():New("Courier New",16,16,,.T.,,,,.T.,.F.)
oFont16 	:= TFont():New("Courier New",16,16,,.F.,,,,.T.,.F.)
oFont14N	:= TFont():New("Courier New",14,14,,.T.,,,,.T.,.F.)
oFont14 	:= TFont():New("Courier New",14,14,,.F.,,,,.T.,.F.)
oFont12N	:= TFont():New("Courier New",12,12,,.T.,,,,.T.,.F.)
oFont12		:= TFont():New("Courier New",12,12,,.T.,,,,.T.,.F.)
oFont10		:= TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
oFont10N	:= TFont():New("Courier New",10,10,,.T.,,,,.T.,.F.)
oFont08		:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)
oFont08N	:= TFont():New("Courier New",08,08,,.T.,,,,.T.,.F.)

lPreview:=.T.
oPrint := TMSPrinter():New(" Etiquetas do cadastro ")
if lPreview
   oPrint:setup()
endif   


RptStatus({|| CriaEtiq() },titulo) // Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==>     RptStatus({|| Execute(impETIQ) },titulo)

RETURN

*------------------------------------------------------------------------*
// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function ImpETIQ
Static Function CriaEtiq()
*------------------------------------------------------------------------*

_aEstr := {}
AADD(_aEstr,{"CODIGO"    , "C" , 06 , 0})
AADD(_aEstr,{"MATRICULA" , "C" , 12 , 0})
AADD(_aEstr,{"NOME    "  , "C" , 50 , 0})
AADD(_aEstr,{"ENDERECO"  , "C" , 50 , 0})
AADD(_aEstr,{"CEP"       , "C" , 08 , 0})
AADD(_aEstr,{"CIDADE"    , "C" , 30 , 0})
AADD(_aEstr,{"ESTADO"    , "C" , 02 , 0})
AADD(_aEstr,{"BAIRRO "   , "C" , 30 , 0})

c_ArqImp := CriaTrab(_aEstr,.t.)
dbusearea(.t.,,c_ArqImp,"ETIQ",.T.)
dbselectarea("ETIQ")
cArqIND := criatrab("",.f.)
IndRegua("ETIQ",cArqIND,"CEP+NOME",,,"Selecionando Registros...")
CQUERY := " SELECT * FROM "+RETSQLNAME("SZV")+" SZV "
CQUERY += " WHERE D_E_L_E_T_='' "
CQUERY += " AND ZV_NOME BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "
CQUERY += " AND ZV_MUN BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "
CQUERY += " AND ZV_CEP BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "
CQUERY += " AND ZV_CATEG BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"' "
CQUERY += " AND ZV_TPHOSP BETWEEN '"+MV_PAR11+"' AND '"+MV_PAR12+"' "   
IF !EMPTY(MV_PAR05)
	CQUERY += " AND  ZV_EST NOT IN " + FORMATIN(alltrim(MV_PAR05),"/")
ENDIF
IF !EMPTY(MV_PAR06)
	CQUERY += " AND  ZV_EST IN " + FORMATIN(alltrim(MV_PAR06),"/")
ENDIF
if MV_PAR15 == 1
	CQUERY += "  AND ZV_INATIVO<>'S' 
ELSEIF MV_PAR15 == 2
	CQUERY += "  AND ZV_INATIVO='S' 
ENDIF
CQUERY += " ORDER BY ZV_NOME "
///PadSql( cQuery, 80 )
TCQUERY cQuery NEW ALIAS "TRB"
dbselectarea("trb")
SetRegua(RecCount())
while !eof()
	IncRegua()
	dbselectarea("ETIQ")
	RECLOCK("ETIQ",.t.)
		ETIQ->CODIGO    := TRB->ZV_COD
		ETIQ->MATRICULA := TRB->ZV_MAT		
		ETIQ->NOME      := TRB->ZV_nome
		ETIQ->ENDERECO  := TRB->ZV_END
		ETIQ->BAIRRO    := TRB->ZV_BAIRRO
		ETIQ->CEP       := TRB->ZV_CEP
		ETIQ->CIDADE    := TRB->ZV_MUN
		ETIQ->ESTADO    := TRB->ZV_EST
		ETIQ->BAIRRO    := TRB->ZV_BAIRRO 
			MSUNLOCK()                          
	DBSELECTAREA("TRB")
	DBSKIP()
ENDDO

ImprimeEtiq()

/*-----------------------------*/
  STATIC FUNCTION ImprimeEtiq()
/*-----------------------------*/
lin:= 125    

oPrint:SetPortrait()
oPrint:StartPage()

DBSELECTAREA("eTIQ")
dbgotop()
SetRegua(RecCount())
Xnome1 := Xnome2 := Xnome3 := Xnome4 := ""
XEND1 := XEND2 := XEND3:= XEND4 :=""
XBAIRRO1 := XBAIRRO2 := XBAIRRO3 := XBAIRRO4 := ""
Xcep1 := Xcep2 := Xcep3 := Xcep4 := ""
Xcidade1 := Xcidade2 := Xcidade3 := Xcidade4 := ""
Xestado1 := Xestado2 := Xestado3 := Xestado4 := ""
XCONTATO1 := XCONTATO2 := XCONTATO3 := XCONTATO4 := ""
XcGC1 := XcGC2 := XcGC3 := XcGC4 := ""
Nvez := 1
ETIQIMP := 0
limprime := .t.
NUMETIQ := 0
DO WHILE !eof()
	INCREGUA()

	if Nvez == 1
//		xcgc1     := etiq->CNPJ
		Xnome1    := etiq->nome
		Xend1     := etiq->endereco
		Xbairro1  := etiq->bairro
		Xcep1     := etiq->cep
		Xcidade1  := etiq->cidade
		Xestado1  := etiq->estado


		Nvez := NVEZ +1
		limprime := .t.

	elseif Nvez == 2

///		xcgc2     := etiq->CNPJ
		Xnome2    := etiq->nome
		Xend2     := etiq->endereco
		Xbairro2  := etiq->bairro
		Xcep2     := etiq->cep
		Xcidade2  := etiq->cidade
		Xestado2  := etiq->estado
		Nvez := NVEZ +1
		limprime := .t.

	elseif Nvez == 3

//		xcgc3     := etiq->CNPJ
		Xnome3    := etiq->nome
		Xend3     := etiq->endereco
		Xbairro3  := etiq->bairro
		Xcep3     := etiq->cep
		Xcidade3  := etiq->cidade
		Xestado3  := etiq->estado



		Nvez := NVEZ +1
		limprime := .t.

	endif
	
	if Nvez == 4 .and. limprime
		ETIQIMP ++
		
		IF !EMPTY(XNOME1)
			NUMETIQ ++
		ENDIF
		IF !EMPTY(XNOME2)
			NUMETIQ ++
		ENDIF
		IF !EMPTY(XNOME3)
			NUMETIQ ++
		ENDIF
		oPrint:Say(lin,nMargem,mv_par13,oFont08)
		oPrint:Say(lin,850+nMargem,mv_par13,oFont08)
		oPrint:Say(lin,1650+nMargem,mv_paR13,oFont08)
		LIN+=50
		OPrint:Say(lin,nMargem,SUBS(xNOME1,1,50),oFont08)
		oPrint:Say(lin,850+nMargem,SUBS(xNOME2,1,50),oFont08)
		oPrint:Say(lin,1650+nMargem,SUBS(xNOME3,1,50),oFont08)
		LIN+=50      
		OPrint:Say(lin,nMargem,"A/C: "+SUBS(mv_par14,1,45),oFont08)
		oPrint:Say(lin,850+nMargem,"A/C: "+SUBS(mv_par14,1,45),oFont08)
		oPrint:Say(lin,1650+nMargem,"A/C: "+SUBS(mv_par14,1,45),oFont08)
		LIN+=50


		OPrint:Say(lin,nMargem,Xend1,oFont08)
		oPrint:Say(lin,850+nMargem,Xend2,oFont08)
		oPrint:Say(lin,1650+nMargem,Xend3,oFont08)
		lin+=50
		OPrint:Say(lin,nMargem,SUBS(Xcep1,1,5)+"-"+SUBS(Xcep1,6,3),oFont08)
		OPrint:Say(lin,200+nMargem,alltrim(Xcidade1)+"/"+xestado1,oFont08)
		oPrint:Say(lin,850+nMargem,SUBS(Xcep2,1,5)+"-"+SUBS(Xcep2,6,3),oFont08)                         
		OPrint:Say(lin,1050+nMargem,alltrim(Xcidade2)+"/"+xestado2,oFont08)
		oPrint:Say(lin,1650+nMargem,SUBS(Xcep3,1,5)+"-"+SUBS(Xcep3,6,3),oFont08)                              
		OPrint:Say(lin,1850+nMargem,alltrim(Xcidade3)+"/"+xestado3,oFont08)
		lin +=100
		Nvez := 1
		Xnome1 := Xnome2 := Xnome3 := Xnome4 := ""
		XEND1 := XEND2 := XEND3:= XEND4 :=""
		XBAIRRO1 := XBAIRRO2 := XBAIRRO3 := XBAIRRO4 := ""
		Xcep1 := Xcep2 := Xcep3 := Xcep4 := ""
		Xcidade1 := Xcidade2 := Xcidade3 := Xcidade4 := ""
		Xestado1 := Xestado2 := Xestado3 := Xestado4 := ""
		XcGC1 := XcGC2 := XcGC3 := XcGC4 := ""
		limprime := .F.
		IF ETIQIMP == 10
			oPrint:EndPage()
			oPrint:STARTPage()
         ETIQIMP := 0
         LIN := 125
		endif                
	ENDIF
	dbselectAREA("ETIQ")
	DBSKIP()
ENDDO
if  limprime
	IF !EMPTY(XNOME1)
		NUMETIQ ++
	ENDIF
	IF !EMPTY(XNOME2)
		NUMETIQ ++
	ENDIF
	IF !EMPTY(XNOME3)
		NUMETIQ ++
	ENDIF

		oPrint:Say(lin,nMargem,mv_par13,oFont08)
		oPrint:Say(lin,850+nMargem,mv_par13,oFont08)
		oPrint:Say(lin,1650+nMargem,mv_par13,oFont08)
		LIN+=50
		OPrint:Say(lin,nMargem,SUBS(xNOME1,1,50),oFont08)
		oPrint:Say(lin,850+nMargem,SUBS(xNOME2,1,50),oFont08)
		oPrint:Say(lin,1650+nMargem,SUBS(xNOME3,1,50),oFont08)

		lin+=50		
		OPrint:Say(lin,nMargem,"A/C: "+SUBS(mv_par14,1,45),oFont08)
		oPrint:Say(lin,850+nMargem,"A/C: "+SUBS(mv_par14,1,45),oFont08)
		oPrint:Say(lin,1650+nMargem,"A/C: "+SUBS(mv_par14,1,45),oFont08)
		LIN+=50

		OPrint:Say(lin,nMargem,Xend1,oFont08)
		oPrint:Say(lin,850+nMargem,Xend2,oFont08)
		oPrint:Say(lin,1650+nMargem,Xend3,oFont08)
		lin+=50
		OPrint:Say(lin,nMargem,SUBS(Xcep1,1,5)+"-"+SUBS(Xcep1,6,3),oFont08)
		OPrint:Say(lin,200+nMargem,alltrim(Xcidade1)+"/"+xestado1,oFont08)
		oPrint:Say(lin,850+nMargem,SUBS(Xcep2,1,5)+"-"+SUBS(Xcep2,6,3),oFont08)                         
		OPrint:Say(lin,1050+nMargem,alltrim(Xcidade2)+"/"+xestado2,oFont08)
		oPrint:Say(lin,1650+nMargem,SUBS(Xcep3,1,5)+"-"+SUBS(Xcep3,6,3),oFont08)                              
		OPrint:Say(lin,1850+nMargem,alltrim(Xcidade3)+"/"+xestado3,oFont08)
		lin +=100
	vez := 1
	limprime := .F.
endif
OPrint:Say(lin,nMargem,"Numero de etiquetas ",oFont08)
LIN +=50
oPrint:Say(lin,nMargem,"Impressas: "+strzero(numetiq,6),oFont08)

dbselectarea("ETIQ")
CARQ := "\arquivos\"+ALLTRIM(SUBS(CUSUARIO,7,15))
COPY TO &CARQ
dbclosearea()

IF Select("TRB")>0
	dbselectarea("TRB")
	dbclosearea()
ENDIF

DBSELECTAREA("SA1")
RETINDEX("SA1")

oPrint:EndPage()

If lPreview
   oPrint:Preview()
Else
   oPrint:Print()
Endif

Return Nil      
dbselectarea(_cAlias)
Return
*************************
Static Function VerImp()
Li:= 0                // Contador de Linhas
nLinIni:=0
If aReturn[5]<>1
	nOpc       := 1
	SetPrc(0,0)
	@ li,000 PSAY chr(15)
	dbCommitAll()
	While .T.
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)                                                                            	
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li+=2
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li+=2
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li++
		@ Li ,000 PSAY replicate("*",50)
		@ Li ,060 PSAY replicate("*",50)
		@ Li ,120 PSAY replicate("*",50)
		li+=2
		IF MsgYesNo("Fomulario esta posicionado ? ")
			nOpc := 1
		ElseIF MsgYesNo("Tenta Novamente ? ")
			nOpc := 2
		Else
			nOpc := 3
		Endif
		Do Case
			Case nOpc==1
				lContinua:=.T.
				Exit
			Case nOpc==2
				Loop
			Case nOpc==3
				lContinua:=.F.
				Return
		EndCase
	End
Endif


STATIC FUNCTION GERARETIQ3()

LOCAL cArqRetiq1, cArqRetiq3

cArqRetiq1 := "\arquivos\retiq1.dbf" 
cArqRetiq2 := "\arquivos\retiq2.dbf" 

IF !FILE( cArqRetiq1 ) 
	MsgStop( "Falta Arquivo RETIQ1.DBF")
	RETURN
endif

IF !FILE( cArqRetiq2 ) 
	MsgStop( "Falta Arquivo RETIQ2.DBF")
	RETURN
endif
	                                    
FERASE( "\arquivos\RETIQ1.CDX" )
FERASE( "\arquivos\RETIQ2.CDX" )
FERASE( "\arquivos\RETIQ3.DBF" )

DbUseArea(.T.,"DBFCDX", "arquivos\RETIQ2",  "RETIQ2", if(.F. .OR. .F., !.F., NIL), .F. )
MsOpenIdx( "RETIQ2","CODIGO",,,,"arquivos\RETIQ2" )

DbUseArea(.T.,"DBFCDX", "arquivos\RETIQ1",  "RETIQ1", if(.F. .OR. .F., !.F., NIL), .F. )

RETIQ1->( DbGoTop() )

DO WHILE ! RETIQ1->( EOF() )

	IF RETIQ2->( DbSeek( RETIQ1->CODIGO ) )
		RecLock( "RETIQ2", .F. )
		RETIQ2-> ( DbDelete() )
		MsUnLock()
		RecLock( "RETIQ1", .F. )
		RETIQ1-> ( DbDelete() )
		MsUnLock()
	ENDIF
	
	RETIQ1->( DbSkip() )

ENDDO

DbSelectArea( "RETIQ2" )
COPY TO ( "arquivos\AP2.DBF" )

DbSelectArea( "RETIQ1" )
COPY TO ( "arquivos\AP1.DBF" )
COPY TO ( "arquivos\RETIQ3.DBF" ) FOR ! Deleted()

RETIQ1->( DbCloseArea() )
RETIQ2->( DbCloseArea() )

DbUseArea(.T.,"DBFCDX", "arquivos\RETIQ3",  "RETIQ3", if(.F. .OR. .F., !.F., NIL), .F. )
APPEND FROM ( "arquivos\retiq2" )  FOR ! DELETED() 

RETIQ3->( DbCloseArea() )

FERASE( "\arquivos\RETIQ1.DBF" )
FERASE( "\arquivos\RETIQ2.DBF" )
FERASE( "\arquivos\RETIQ2.CDX" )

RETURN	

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � PadSql   � Autor � 		MMN - 0990       � Data �05/12/2000���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Melhora a Visualizacao da Query no Analyzer                ���
�������������������������������������������������������������������������Ĵ��
���Uso       �VIDEOLAR                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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

//MEMOWRIT( NomeProg + ".SQL", cNewQuery, 1000 )

RETURN



