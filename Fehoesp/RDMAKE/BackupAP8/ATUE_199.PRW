#include "rwmake.ch"
User Function ATUE_199()
SetPrvt("AROTINA,CCADASTRO,")
SetPrvt("CTITU,CCLIENTE,DEMISSAO,DVENCTO,NORIG,NSALDO")
SetPrvt("NACRES,NDESC,CCHAVE,NPARC,NUSADO,AHEADER")
SetPrvt("CAMPOS,NOPCX,LBAIXOU,ACOLS,NCNT,CTITULO")
SetPrvt("LCAB,ATELA,AC,AR,ACGD,CLINHAOK")
SetPrvt("CTUDOOK,LRETMOD2,CTIT,")
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Rotina   ³ ATUE1_99 ³ Autor ³ Luis Mattos Duarte Jr ³ Data ³ 13.04.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Atualiza Titulos com o Cliente 999999                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAFIN - Financeiro                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Alterado ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
dbSelectArea("SE1")
aRotina := { { "Pesquisar"     ,'AxPesqui', 0, 1 } ,;
			 { "Visualizar"    ,'AxVisual', 0, 2 } ,;
             { "Identificar"   ,'U_ident199', 0, 3 } ,;
             { "Estornar"      ,'U_estorn199', 0, 4 }} 
cCadastro := "Titulos Não Identificados"
//DbSetFilter( { || SE1->E1_CLIENTE == '999999' }, "SE1->E1_CLIENTE == '999999'" )
mBrowse(01,01,30,70,"SE1",,,,"SE1->E1_CLIENTE = '999999'")
dbSelectArea("SE1")   
//DbClearFilter()
Return
*****************
USER FUNCTION IDENT199()
IF SE1->E1_CLIENTE <> "999999"
	ALERT("Este titulo já está Identificado!! Faça o Estorno ")
	return
else  
	DBSELECTAREA("SX1")
	DBSEEK("ATE199")
	DO WHILE !EOF() .AND. SX1->X1_GRUPO=="ATE199"
		RECLOCK("SX1",.F.)
		SX1->X1_CNT01 := ""
		MSUNLOCK()
		DBSKIP()
	ENDDO	
	IF pergunte("ATE199",.T.)  .AND. !EMPTY(MV_PAR01) .AND. !EMPTY(MV_PAR02)
		dbselectarea("sa1")
		dbsetorder(1)
		dbseek(xfilial()+mv_par01+mv_par02)
		IF MsgYesNo("Confirma a Alteração ?")
			RECLOCK("SE1",.F.)

			SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
			se1->e1_cliente := sa1->a1_cod
			se1->e1_loja    := sa1->a1_loja   
			se1->e1_nomcli  := sa1->a1_nome
			se1->e1_codasso := sa1->a1_codasso
			se1->e1_categ1  := sa1->a1_categ1
			se1->e1_ersin   := sa1->a1_ersin
			se1->e1_base    := sa1->a1_base		
			SE1->E1_CGC     := SA1->A1_CGC

			MSUNLOCK()
			CONFIRMSX8()

		endif
	endif	
endif
RETURN

*****************
USER FUNCTION ESTORN199()
IF SE1->E1_CLIENTE == "999999"
	ALERT("Este titulo não está Identificado !!")
	return
else  
	IF MsgYesNo("Confirma o estorno ?")
		IF MsgYesNo("Tem certeza que deseja estornar ?")
			reclock("SE1",.F.)
			if !empty(se1->e1_confed)
				se1->e1_num     := se1->e1_confed
			else
				se1->e1_num     := STRZERO(VAL(RIGHT(STR(RECNO()),6)),6)
			endif
			se1->e1_cliente := "999999"
			se1->e1_loja    := "01"
		 	se1->e1_nomcli  := se1->e1_confed
			se1->e1_codasso := ""
			se1->e1_categ1  := ""
			se1->e1_ersin   := ""
			se1->e1_base    := ""
			SE1->E1_CGC     := se1->e1_confed
			msunlock()
		endif
	endif
endif
RETURN