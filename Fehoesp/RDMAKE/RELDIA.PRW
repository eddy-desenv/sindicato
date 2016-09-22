#include "rwmake.ch"
#include "topconn.ch"
User Function RELDIA()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ RELDIA   ³ Autor ³ Luis Mattos Duarte Jr.³ Data ³ 12.01.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao relatorio de cONTRIBUINTES EM DIA                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico SINDHOSP                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

//Private aArea 	 GetArea()
//Private aAreaSA1 := SA1->( GetArea() )
//Private aAreaSE1 := SE1->( GetArea() )

SetPrvt("_CALIAS,CBCONT,CBTXT,WNREL,CDESC1,CDESC2")
SetPrvt("CDESC3,CSTRING,TAMANHO,TIPO,LIMITE,TITULO")
SetPrvt("CABEC2,CABEC1,ARETURN,NOMEPROG,NLASTKEY,CPERG")
SetPrvt("M_PAG,LI,_AESTR,C_ARQIMP,CARQIND,CINDSA1")
SetPrvt("NLINHA,")

cbcont := 0
cbtxt := ""
wnrel := ""
cDesc1 := "Este programa irá imprimir a relatorio de sócios em dia."
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "P"
tipo := 15
limite := 220
Titulo := "Socios em dia"
cabec2 := ""
cabec1 := ""
aReturn := { "Zebrado", 1,"Administração", 4, 2, 1, "",1 }
nomeprog := "RELDIA"
nLastkey := 0
cPerg := "RELDIA"
m_pag := 1
li := 0



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ 01       ¦ Qual Cidade                    ¦ C       ¦         25³
//³ 02       ¦ Quais Categorias               ¦ C       ¦         50³
//³ 03       ¦ Categoria de                   ¦ C       ¦          5³
//³ 04       ¦ Categoria Ate                  ¦ C       ¦          5³
//³ 05       ¦ Filantropico                   ¦ N       ¦          1³
//³ 06       ¦ Valor de                       ¦ N       ¦         17³
//³ 07       ¦ Valor ate                      ¦ N       ¦         17³
//³ 08       ¦ Sindical Ano de  (aaaa)        ¦ C       ¦          4³
//³ 09       ¦ Sindical Ano Ate (aaaa)        ¦ C       ¦          4³
//³ 10       ¦ Assistencial de (p/aaaa)       ¦ C       ¦          6³
//³ 11       ¦ Assistencial Ate (p/aaaa)      ¦ C       ¦          6³
//³ 12       ¦ Confederativa de (p/aaaa)      ¦ C       ¦          6³
//| 13       ¦ Confederativa Ate (p/aaaa)     ¦ C       ¦          6³
//³ 14       ¦ Assoc.Confederat. de (pp/aaaa) ¦ C       ¦          7³
//³ 15       ¦ Assoc.Confederat. de (pp/aaaa) ¦ C       ¦          7³
//³ 16       ¦ Associativa de (pp/aaaa)       ¦ C       ¦          7³
//³ 17       ¦ Associativa Ate (pp/aaaa)      ¦ C       ¦          7³
//| 18       ¦ QUAIS  Sindicato            ¦ C       ¦          2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

pergunte(cPerg,.f.)
wnrel := "RELDIA"
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)
if nLastkey == 27
	return
endif
SetDefault(aReturn,cString)
if nLastkey == 27
	return
endif
RptStatus({|| impREL() },titulo)
Return
**********
Static function ImpREL()
_aEstr := {}
AADD(_aEstr,{"CODIGO"    , "C" , 06 , 0})
AADD(_aEstr,{"NOME"      , "C" , 50 , 0})
AADD(_aEstr,{"ENDERECO"  , "C" , 50 , 0})
AADD(_aEstr,{"BAIRRO"    , "C" , 50 , 0})
AADD(_aEstr,{"CEP"       , "C" , 09 , 0})
AADD(_aEstr,{"CIDADE"    , "C" , 30 , 0})
AADD(_aEstr,{"UF"        , "C" , 02 , 0})
AADD(_aEstr,{"CNPJ"      , "C" , 14 , 0})
AADD(_aEstr,{"DTCADAS"   , "D" , 08 , 0})
AADD(_aEstr,{"DTASSOC"   , "D" , 08 , 0})
AADD(_aEstr,{"DDD"       , "C" , 02 , 0})
AADD(_aEstr,{"TELEFONE"  , "C" , 25 , 0})
AADD(_aEstr,{"CODASSO"   , "C" , 06 , 0})
AADD(_aEstr,{"SITUACAO"  , "C" , 02 , 0})
AADD(_aEstr,{"ERSIN"     , "C" , 02 , 0})
AADD(_aEstr,{"CATEGORIA" , "C" , 05 , 0})
AADD(_aEstr,{"BASE"      , "C" , 04 , 0})
AADD(_aEstr,{"NATUREZA"  , "C" , 10 , 0})
AADD(_aEstr,{"PARCELA"   , "C" , 07 , 0})
AADD(_aEstr,{"VALOR"     , "N" , 15 , 2})
AADD(_aEstr,{"DATAPAGTO" , "D" , 08 , 0})
AADD(_aEstr,{"DATAVENCTO", "D" , 08 , 0})
AADD(_aEstr,{"HISTORICO" , "C" , 50 , 0})
AADD(_aEstr,{"inativo"   , "C" , 01 , 0})
AADD(_aEstr,{"SINDICATO" , "C" , 02 , 0})
c_ArqImp := CriaTrab(_aEstr,.t.)
dbusearea(.t.,,c_ArqImp,"TMP",.T.)
dbselectarea("TMP")
IndRegua("TMP",c_ARQIMP,"ERSIN+CODIGO+NATUREZA+PARCELA",,,"Selecionando Registros...")
_aEstr := {}
AADD(_aEstr,{"ERSIN"     , "C" , 02 , 0})
AADD(_aEstr,{"NATUREZA"  , "C" , 10 , 0})
AADD(_aEstr,{"TITULOS"   , "N" , 15 , 0})
AADD(_aEstr,{"VALOR"     , "N" , 15 , 2})
c_Arqres := CriaTrab(_aEstr,.t.)
dbusearea(.t.,,c_Arqres,"RES",.T.)
dbselectarea("RES")
IndRegua("RES",c_ARQRES,"ERSIN+NATUREZA",,,"Selecionando Registros...")
*************** arq. para mala direta word
_aEstr := {}
AADD(_aEstr,{"CODIGO"    , "C" , 06 , 0})
AADD(_aEstr,{"NOME"      , "C" , 50 , 0})
AADD(_aEstr,{"ENDERECO"  , "C" , 50 , 0})
AADD(_aEstr,{"BAIRRO"    , "C" , 50 , 0})
AADD(_aEstr,{"CEP"       , "C" , 09 , 0})
AADD(_aEstr,{"CIDADE"    , "C" , 30 , 0})
AADD(_aEstr,{"UF"        , "C" , 02 , 0})
AADD(_aEstr,{"CNPJ"      , "C" , 14 , 0})
AADD(_aEstr,{"DTCADAS"   , "D" , 08 , 0})
AADD(_aEstr,{"DTASSOC"   , "D" , 08 , 0})
AADD(_aEstr,{"DDD"       , "C" , 02 , 0})
AADD(_aEstr,{"TELEFONE"  , "C" , 25 , 0})
AADD(_aEstr,{"CODASSO"   , "C" , 06 , 0})
AADD(_aEstr,{"SITUACAO"  , "C" , 02 , 0})
AADD(_aEstr,{"ERSIN"     , "C" , 02 , 0})
AADD(_aEstr,{"CATEGORIA" , "C" , 05 , 0})
AADD(_aEstr,{"BASE"      , "C" , 04 , 0})
AADD(_aEstr,{"PARCELA"   , "C" , 255, 0})
AADD(_aEstr,{"INATIVO"   , "C" , 001, 0})
AADD(_aEstr,{"NATUREZA"  , "C" , 009, 0})
AADD(_aEstr,{"DTABERT"   , "D" , 008, 0})
AADD(_aEstr,{"DTINASS"   , "D" , 008, 0})
AADD(_aEstr,{"DTFIMASS"  , "D" , 008, 0})
AADD(_aEstr,{"VALASSOC"  , "N" , 017, 2})
AADD(_aEstr,{"FOLHA"     , "N" , 017, 2})
AADD(_aEstr,{"CAPITAL"   , "N" , 017, 2})
AADD(_aEstr,{"CAPCENT"   , "C" , 001, 0})
AADD(_aEstr,{"FOLHA_CENT", "C" , 001, 0})
AADD(_aEstr,{"LEITOS"    , "N" , 017, 0})
AADD(_aEstr,{"FUNCION"   , "N" , 017, 0})
AADD(_aEstr,{"ESCR_CONT" , "C" , 014, 0})
AADD(_aEstr,{"FILANT"    , "C" , 001, 0})
AADD(_aEstr,{"HISTORICO" , "C" , 255, 0})
AADD(_aEstr,{"HISTORICO2", "C" , 255, 0})
AADD(_aEstr,{"HISTASS"   , "C" , 080, 0})
AADD(_aEstr,{"INISIND"   , "D" , 008, 0})
AADD(_aEstr,{"SINDICATO" , "C" , 002, 0})
AADD(_aEstr,{"TPCADASTRO", "C" , 001, 0})

c_ArqImp := CriaTrab(_aEstr,.t.)
dbusearea(.t.,,c_ArqImp,"WORD",.T.)
dbselectarea("WORD")
*********************
CQUERY := " SELECT * FROM "+RETSQLNAME("SA1")+" SA1 "
CQUERY += " WHERE D_E_L_E_T_=''  AND "
CQUERY += " A1_CATEG1 BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "
IF !EMPTY(MV_PAR01)
	CQUERY += " AND  A1_MUN ='"+MV_PAR01+"' "
ENDIF
IF MV_PAR05 == 2
	CQUERY += " AND  A1_FILANT IN ('X','S') "
ELSEIF MV_PAR05 == 3
	CQUERY += " AND  A1_FILANT NOT IN ('X','S') "
ENDIF
IF !EMPTY(mv_par14)
	CQUERY += " AND  A1_SINDICA IN "+FORMATIN(alltrim(mv_par14),"/")
ENDIF
CQUERY += " AND  A1_SITUAC ='AS' "
CQUERY += " ORDER BY A1_SINDICA,A1_NOME "
TCQUERY cQuery NEW ALIAS "TRB"
dbselectarea("trb")
SetRegua(RecCount())
while !eof()
	IncRegua()
	// sindical
	IF !EMPTY(MV_PAR08)
		dbSelectArea("SE1")
		dbOrderNickName('20')  // E1_FILIAL+E1_CGC+E1_PREFIXO+E1_PARCELA+E1_TIPO
		DbSeek( xFilial("SE1")+TRB->A1_CGC+SUBS(mv_par08,3,2)+"S", .T. )
		
		DO WHILE !EOF() .AND. SE1->E1_CGC+SUBS(SE1->E1_PREFIXO,1,2) <= TRB->A1_CGC+SUBS(MV_PAR09,3,2)+"S"
			IF SE1->E1_VALOR < MV_PAR06 .OR. SE1->E1_VALOR > MV_PAR07 .OR. TRB->A1_DTINIC > "20" + SUBS(SE1->E1_PREFIXO,1,2) + "1214"  // NAO PAGANTES
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			IF subs(SE1->E1_NATUREZ,1,5)  == "003  "
				dbSelectArea("TMP")
				RECLOCK("TMP",.T.)
				TMP->CODIGO    := TRB->A1_COD
				TMP->NOME      := TRB->A1_NOME
				TMP->ENDERECO  := trb->a1_end
				TMP->BAIRRO    := trb->a1_bairro
				tmp->CEP       := trb->a1_cep
				TMP->CIDADE    := TRB->A1_MUN
				TMP->UF        := TRB->A1_EST
				tmp->cnpj      := trb->A1_CGC
				TMP->DTCADAS   := STOD(TRB->A1_DTCADAS)
				TMP->DTASSOC   := STOD(TRB->A1_DTINASS)
				tmp->ddd       := trb->a1_ddd
				TMP->TELEFONE  := TRB->A1_TEL
				TMP->CODASSO   := TRB->A1_CODASSO
				TMP->SITUACAO  := TRB->A1_SITUAC
				TMP->ERSIN     := TRB->A1_ERSIN
				TMP->CATEGORIA := TRB->A1_CATEG1
				TMP->BASE      := TRB->A1_BASE
				TMP->NATUREZA  := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
				TMP->HISTORICO := SE1->E1_HIST
				tmp->parcela   := if(subs(se1->e1_prefixo,1,2)>"90","19","20")+subs(se1->e1_prefixo,1,2)
				tmp->valor     := se1->e1_valOR*.6+SE1->E1_JUROS
				tmp->datapagto := se1->e1_baixa
				tmp->dataVENCTO:= se1->e1_VENCTO
				tmp->inativo   := TRB->a1_inat
				TMP->SINDICATO := TRB->A1_SINDICA
				msunlock()
			endif
			dbselectarea("se1")
			dbskip()
		enddo
	ENDIF
	
	// assistencial
	
	IF !EMPTY(MV_PAR10)
		dbSelectArea("SE1")
		Dbsetorder(2)
		//			dbseek( xFilial()+TRB->A1_COD+TRB->A1_LOJA+SUBS(mv_par12,5,2),.T.)
		Dbseek( xFilial("SE1")+TRB->A1_COD+TRB->A1_LOJA+SUBS(mv_par10,5,2),.T.)
		DO WHILE !EOF() .AND. SE1->E1_CLIENTE+SE1->E1_LOJA+SUBS(SE1->E1_PREFIXO,1,2) <= TRB->A1_COD+TRB->A1_LOJA+SUBS(MV_PAR11,5,2)
			if SUBS(SE1->E1_PREFIXO,3,1) == "T"
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			IF subs(SE1->E1_NATUREZ,1,5)  == "0301 "
				IF SUBS(mv_par12,1,1)>"1"
					IF SE1->E1_PARCELA=="1" .AND. subs(SE1->E1_PREFIXO,1,2)==SUBS(mv_par10,5,2)
						DBSELECTAREA("SE1")
						DBSKIP()
						LOOP
					ENDIF
				ENDIF
				IF SE1->E1_PARCELA>subs(mv_par13,1,1) .AND. subs(SE1->E1_PREFIXO,1,2)==SUBS(mv_par11,5,2)
					DBSELECTAREA("SE1")
					DBSKIP()
					LOOP
				ENDIF
				dbSelectArea("TMP")
				RECLOCK("TMP",.T.)
				TMP->CODIGO   := TRB->A1_COD
				TMP->NOME     := TRB->A1_NOME
				TMP->ENDERECO  := trb->a1_end
				TMP->BAIRRO    := trb->a1_bairro
				tmp->CEP       := trb->a1_cep
				TMP->CIDADE    := TRB->A1_MUN
				TMP->UF        := TRB->A1_EST
				tmp->cnpj      := trb->A1_CGC
				TMP->DTCADAS   := STOD(TRB->A1_DTCADAS)
				TMP->DTASSOC   := STOD(TRB->A1_DTINASS)
				tmp->ddd       := trb->a1_ddd
				TMP->TELEFONE  := TRB->A1_TEL
				TMP->CODASSO   := TRB->A1_CODASSO
				TMP->SITUACAO  := TRB->A1_SITUAC
				TMP->ERSIN    := TRB->A1_ERSIN
				TMP->BASE      := TRB->A1_BASE
				TMP->CATEGORIA := TRB->A1_CATEG1
				TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
				TMP->HISTORICO:= SE1->E1_HIST
				tmp->parcela  := if(subs(se1->e1_prefixo,1,2)>"90","19","20")+subs(se1->e1_prefixo,1,2)+"/"+SE1->E1_PARCELA
				tmp->valor    := se1->e1_valor
				tmp->datapagto:= se1->e1_baixa
				tmp->dataVENCTO:= se1->e1_VENCTO
				tmp->inativo   := sa1->a1_inat
				TMP->SINDICATO := TRB->A1_SINDICA
				
				msunlock()
			endif
			dbselectarea("se1")
			dbskip()
		enddo
	ENDIF
	
	// CONFEDERATIVA - PAGANTES
	IF !EMPTY(MV_PAR10)
		dbSelectArea("SE1")
		dbOrderNickName('20')  // E1_FILIAL+E1_CGC+E1_PREFIXO+E1_PARCELA+E1_TIPO
		DbSeek( xFilial("SE1")+TRB->A1_CGC+SUBS(mv_par10,5,2), .T. )
		
		DO WHILE !EOF() .AND. SE1->E1_CGC+SUBS(SE1->E1_PREFIXO,1,2) <= TRB->A1_CGC+SUBS(MV_PAR11,5,2)
			IF SE1->E1_VALOR < MV_PAR06 .OR. SE1->E1_VALOR > MV_PAR07 .OR. SUBS(SE1->E1_PREFIXO,3,1) == "T" //.OR. ;
				//					( SE1->E1_PARCELA =="1" .AND. TRB->A1_DTCADAS > '20' + SUBS(SE1->E1_PREFIXO,1,2) + '0131' ) .OR. ;
				//					( SE1->E1_PARCELA =="2" .AND. TRB->A1_DTCADAS > '20' + SUBS(SE1->E1_PREFIXO,1,2) + '0731' )
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			IF subs(SE1->E1_NATUREZ,1,5)  $ "002  /0301 /"
				
				cAnoIni := SUBS( MV_PAR10,5,2 )
				cAnoFim := SUBS( MV_PAR11,5,2 )
				
				cPreParc := subs(SE1->E1_PREFIXO,1,2) + SE1->E1_PARCELA
				
				IF cPreParc < cAnoIni + SUBS(MV_PAR10,1,1) .OR. cPreParc > cAnoFim + SUBS(MV_PAR11,1,1)
					DBSELECTAREA("SE1")
					DBSKIP()
					LOOP
				ENDIF
				
				
				IF SUBS(MV_PAR10,1,1)>"1"
					IF SE1->E1_PARCELA=="1" .AND. subs(SE1->E1_PREFIXO,1,2)==SUBS(MV_PAR10,5,2)
						DBSELECTAREA("SE1")
						DBSKIP()
						LOOP
					ENDIF
				ENDIF
				IF SE1->E1_PARCELA>subs(MV_PAR11,1,1) .AND. subs(SE1->E1_PREFIXO,1,2)==SUBS(MV_PAR11,5,2)
					DBSELECTAREA("SE1")
					DBSKIP()
					LOOP
				ENDIF
				
				dbSelectArea("TMP")
				RECLOCK("TMP",.T.)
				TMP->CODIGO   := TRB->A1_COD
				TMP->NOME     := TRB->A1_NOME
				TMP->ENDERECO  := trb->a1_end
				TMP->BAIRRO    := trb->a1_bairro
				tmp->CEP       := trb->a1_cep
				TMP->CIDADE    := TRB->A1_MUN
				TMP->UF        := TRB->A1_EST
				tmp->cnpj      := trb->A1_CGC
				TMP->DTCADAS   := STOD(TRB->A1_DTCADAS)
				TMP->DTASSOC   := STOD(TRB->A1_DTINASS)
				tmp->ddd       := trb->a1_ddd
				TMP->TELEFONE  := TRB->A1_TEL
				TMP->CODASSO   := TRB->A1_CODASSO
				TMP->SITUACAO  := TRB->A1_SITUAC
				TMP->BASE      := TRB->A1_BASE
				TMP->ERSIN    := TRB->A1_ERSIN
				TMP->CATEGORIA := TRB->A1_CATEG1
				TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
				TMP->HISTORICO:= SE1->E1_HIST
				tmp->parcela  := if(subs(se1->e1_prefixo,1,2)>"90","19","20")+subs(se1->e1_prefixo,1,2)+"/"+SE1->E1_PARCELA
				tmp->valor    := se1->e1_valor
				tmp->datapagto:= se1->e1_baixa
				tmp->dataVENCTO:= se1->e1_VENCTO
				tmp->inativo   := sa1->a1_inat
				TMP->SINDICATO := TRB->A1_SINDICA
				msunlock()
			endif
			dbselectarea("se1")
			dbskip()
		enddo
	ENDIF
	
	// ASSOCIATIVA CONFEDERATIVA
	IF !EMPTY(mv_par12)
		dbSelectArea("SE1")
		Dbsetorder(2)
		dbseek( xFilial()+TRB->A1_COD+TRB->A1_LOJA,.T.)
		DO WHILE !EOF() .AND. SE1->E1_CLIENTE+SE1->E1_LOJA <= TRB->A1_COD+TRB->A1_LOJA
			IF SE1->E1_VALOR < MV_PAR06 .OR. SE1->E1_VALOR > MV_PAR07
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			if SUBS(SE1->E1_PREFIXO,3,1) == "T"
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			//			if empty(se1->e1_baixa)
			//				DBSELECTAREA("SE1")
			//				DBSKIP()
			//				LOOP
			//			ENDIF
			
			IF subs(SE1->E1_PREFIXO,1,2)<SUBS(mv_par12,6,2)
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			IF subs(SE1->E1_PREFIXO,1,2)>SUBS(mv_par13,6,2)
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			IF subs(SE1->E1_NATUREZ,1,5)  == "1000 "
				IF SUBS(SE1->E1_NUM,1,2)<subs(mv_par12,1,2) .AND. subs(SE1->E1_PREFIXO,1,2)==SUBS(mv_par12,6,2)
					DBSELECTAREA("SE1")
					DBSKIP()
					LOOP
				ENDIF
				IF SUBS(SE1->E1_NUM,1,2)>subs(mv_par13,1,2) .AND. subs(SE1->E1_PREFIXO,1,2)==SUBS(mv_par13,6,2)
					DBSELECTAREA("SE1")
					DBSKIP()
					LOOP
				ENDIF
				dbSelectArea("TMP")
				RECLOCK("TMP",.T.)
				TMP->CODIGO   := TRB->A1_COD
				TMP->NOME     := TRB->A1_NOME
				TMP->ENDERECO  := trb->a1_end
				TMP->BAIRRO    := trb->a1_bairro
				tmp->CEP       := trb->a1_cep
				TMP->CIDADE    := TRB->A1_MUN
				TMP->UF        := TRB->A1_EST
				tmp->cnpj      := trb->A1_CGC
				TMP->DTCADAS   := STOD(TRB->A1_DTCADAS)
				TMP->DTASSOC   := STOD(TRB->A1_DTINASS)
				tmp->ddd       := trb->a1_ddd
				TMP->TELEFONE  := TRB->A1_TEL
				TMP->CODASSO   := TRB->A1_CODASSO
				TMP->SITUACAO  := TRB->A1_SITUAC
				TMP->ERSIN    := TRB->A1_ERSIN
				TMP->BASE      := TRB->A1_BASE
				TMP->CATEGORIA := TRB->A1_CATEG1
				TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
				TMP->HISTORICO:= SE1->E1_HIST
				tmp->parcela  := if(subs(se1->e1_prefixo,1,2)>"90","19","20")+subs(se1->e1_prefixo,1,2)+"/"+SUBS(SE1->E1_NUM,1,2)
				tmp->valor    := se1->e1_valor
				tmp->datapagto:= se1->e1_baixa
				tmp->dataVENCTO:= se1->e1_VENCTO
				tmp->inativo   := sa1->a1_inat
				TMP->SINDICATO := TRB->A1_SINDICA
				
				msunlock()
			endif
			dbselectarea("se1")
			dbskip()
		enddo
	ENDIF
	// ASSOCIATIVA
	IF !EMPTY(mv_par12)
		dbSelectArea("SE1")
		Dbsetorder(2)
		dbseek( xFilial()+TRB->A1_COD+TRB->A1_LOJA,.T.)
		DO WHILE !EOF() .AND. SE1->E1_CLIENTE+SE1->E1_LOJA<= TRB->A1_COD+TRB->A1_LOJA
			IF SE1->E1_VALOR < MV_PAR06 .OR. SE1->E1_VALOR > MV_PAR07
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			//			if empty(se1->e1_baixa)
			//				DBSELECTAREA("SE1")
			//				DBSKIP()
			//				LOOP
			//			ENDIF
			if SUBS(SE1->E1_PREFIXO,3,1) == "T"
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			IF subs(SE1->E1_PREFIXO,1,2)<SUBS(mv_par12,6,2)
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			IF subs(SE1->E1_PREFIXO,1,2)>SUBS(mv_par13,6,2)
				DBSELECTAREA("SE1")
				DBSKIP()
				LOOP
			ENDIF
			
			IF subs(SE1->E1_NATUREZ,1,5)  == "001  "
				IF SUBS(SE1->E1_NUM,1,2)<subs(mv_par12,1,2) .AND. subs(SE1->E1_PREFIXO,1,2)==SUBS(mv_par12,6,2)
					DBSELECTAREA("SE1")
					DBSKIP()
					LOOP
				ENDIF
				IF SUBS(SE1->E1_NUM,1,2)>subs(mv_par13,1,2) .AND. subs(SE1->E1_PREFIXO,1,2)==SUBS(mv_par13,6,2)
					DBSELECTAREA("SE1")
					DBSKIP()
					LOOP
				ENDIF
				dbSelectArea("TMP")
				RECLOCK("TMP",.T.)
				TMP->CODIGO   := TRB->A1_COD
				TMP->NOME     := TRB->A1_NOME
				TMP->ENDERECO  := trb->a1_end
				TMP->BAIRRO    := trb->a1_bairro
				tmp->CEP       := trb->a1_cep
				TMP->CIDADE    := TRB->A1_MUN
				TMP->UF        := TRB->A1_EST
				tmp->cnpj      := trb->A1_CGC
				TMP->DTCADAS   := STOD(TRB->A1_DTCADAS)
				TMP->DTASSOC   := STOD(TRB->A1_DTINASS)
				tmp->ddd       := trb->a1_ddd
				TMP->TELEFONE  := TRB->A1_TEL
				TMP->CODASSO   := TRB->A1_CODASSO
				TMP->SITUACAO  := TRB->A1_SITUAC
				TMP->ERSIN    := TRB->A1_ERSIN
				TMP->BASE      := TRB->A1_BASE
				TMP->CATEGORIA := TRB->A1_CATEG1
				TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
				TMP->HISTORICO:= SE1->E1_HIST
				tmp->parcela  := if(subs(se1->e1_prefixo,1,2)>"90","19","20")+subs(se1->e1_prefixo,1,2)+"/"+SUBS(SE1->E1_NUM,1,2)
				tmp->valor    := se1->e1_valor
				tmp->datapagto:= se1->e1_baixa
				tmp->dataVENCTO:= se1->e1_VENCTO
				tmp->inativo   := sa1->a1_inat
				TMP->SINDICATO := TRB->A1_SINDICA
				msunlock()
			endif
			dbselectarea("se1")
			dbskip()
		enddo
	ENDIF
	dbselectarea("trb")
	dbskip()
enddo
LI := 80
DBCLOSEAREA("TRB")
dbclosearea("trb")
if mv_par15 == 5
	DBSELECTAREA("TMP")
	c_ArqIND := CriaTrab("",.F.)
	IndRegua("TMP",c_ARQIND,"ERSIN+NOME+CNPJ+NATUREZA+PARCELA",,,"Selecionando Registros...")
	dbgotop()
	REGS := 0
	SETREGUA(RECCOUNT())
	
	IF RECCOUNT() >0
		TOTGER := TITGER := 0
		DO WHILE !EOF()
			/*
			IF TMP->CODIGO == "033699"
			XT := ""
			ENDIF
			*/
			if Li >= 60
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
			endif
			XERSIN   := Tmp->ERSIN
			TOTERSIN := TITERSIN := 0
			dbselectarea("sx5")
			dbsetorder(1)
			dbseek(xfilial()+"96"+Tmp->ERSIN)
			@ LI,000 PSAY "Ersin: "+tmp->ersin+"-"+sx5->x5_descri
			LI += 2
			dbselectarea("tmp")
			DO WHILE !EOF() .AND. xERSIN==Tmp->ERSIN
				if Li >= 60
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
				endif
				dbselectarea("sa1")
				dbsetorder(1)
				dbseek(xfilial()+tmp->codigo)
				@ li,000 psay "NOME: "
				@ li,006 psay subs(sa1->a1_nome,1,50)
				@ li,057 psay "CNPJ:"
				@ li,062 psay sa1->a1_cgc picture "@r 99.999.999/9999-99"
				LI++
				@ li,000 psay "Cod.Assoc.:"
				@ li,012 psay sa1->a1_codasso
				@ li,019 psay "Situacao: "
				@ li,030 psay sa1->a1_situac
				@ LI,034 PSAY "Dt.Cadastro: "
				@ li,047 psay SA1->A1_DTCADAS
				@ LI,057 PSAY "Dt.Associacao:"
				@ li,072 psay sa1->A1_dtinass
				LI++
				@ li,000 psay "End.:"
				@ li,006 psay subs(sa1->a1_end,1,50)
				@ LI,060 PSAY "CEP:"
				@ li,065 psay sa1->a1_cep picture "@r 99999-999"
				LI++
				@ li,000 psay "Ersin:"
				@ li,007 psay sa1->a1_ersin
				@ li,010 psay "Cidade: "+subs(sa1->a1_mun,1,25)
				@ li,050 psay "Tel: "+SA1->a1_ddd+" "+sa1->a1_tel
				LI++
				@ li,000 psay "Cod.Siga:"+sa1->a1_cod
				if !empty(tmp->inativo)
					@ li,040 psay "Cliente Inativo"
				endif
				@ LI,060 PSAY "Sindicato :"	+tmp->sindicato
				li += 2
				DBSELECTAREA("SA1")
				DBSETORDER(1)
				DBSEEK(XFILIAL()+TMP->CODIGO)
				dbSelectArea("WORD")
				RECLOCK("WORD",.T.)
				WORD->CODIGO    := TMP->CODIGO
				WORD->NOME      := TMP->NOME
				WORD->ENDERECO  := tmp->endereco
				WORD->BAIRRO    := tmP->bairro
				WORD->CEP       := tmP->cep
				WORD->CIDADE    := Tmp->cidade
				WORD->UF        := Tmp->uf
				WORD->cnpj      := tmp->cnpj
				WORD->DTCADAS   := tmp->dtcadas
				WORD->DTASSOC   := tmp->dtassoc
				word->ddd       := tmp->ddd
				WORD->TELEFONE  := Tmp->telefone
				WORD->CODASSO   := Tmp->codasso
				WORD->SITUACAO  := Tmp->SITUACao
				WORD->BASE      := Tmp->BASE
				WORD->ERSIN     := Tmp->ERSIN
				WORD->CATEGORIA := Tmp->CATEGoria
				WORD->INATIVO   := SA1->A1_INAT
				word->NATUREZA  := SA1->A1_NATUREZ
				WORD->DTABERT   := SA1->A1_DTINIC
				WORD->DTINASS   := SA1->A1_DTINASS
				WORD->DTFIMASS  := SA1->A1_DTFIMAS
				WORD->VALASSOC  := SA1->A1_VALASSO
				word->FOLHA     := SA1->A1_FOLHA
				WORD->CAPITAL   := SA1->A1_CAPITAL
				WORD->CAPCENT   := sa1->a1_capcent
				word->FOLHA_CENT:= sa1->a1_folcent
				word->LEITOS    := sa1->a1_leitos
				word->FUNCION   := SA1->A1_NUMFUN
				WORD->ESCR_CONT := SA1->A1_ESCCONT
				WORD->FILANT    := SA1->A1_FILANT
				WORD->HISTORICO := SA1->A1_HIST
				WORD->HISTORICO2:= SA1->A1_HIST2
				WORD->HISTASS   := SA1->A1_HISTASS
				WORD->INISIND   := SA1->A1_INISIND
				WORD->SINDICATO := SA1->A1_SINDICA
				word->tpcadastro:= sa1->a1_tpcadas
				msunlock()
				xcliente := tmp->codigo
				TOTCLI := TITCLI := 0
				DBSELECTAREA("TMP")
				do while !eof() .and. xcliente==Tmp->codigo
					if Li >= 60
						cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
					endif
					XNATUREZA := TMP->NATUREZA
					charnat := len(alltrim(TMP->natureza))
					IF SUBS(TMP->NATUREZA,CHARNAT,1) == "T"
						DBSELECTAREA("SED")
						DBSETORDER(1)
						DBSEEK(XFILIAL()+SUBS(TMP->NATUREZA,1,CHARNAT-1))
					ELSE
						DBSELECTAREA("SED")
						DBSETORDER(1)
						DBSEEK(XFILIAL()+TMP->NATUREZA)
					ENDIF
					@ li,000 psay SUBS(SED->ED_DESCRIC,1,30)+IF(SUBS(TMP->NATUREZA,CHARNAT,1) == "T","TERMO","     ")+SPACE(15)+" Parcela Dt Pagto        Valor"
					LI++
					DBSELECTAREA("Tmp")
					TOTNAT := TITNAT := 0
					do while !eof() .and. xcliente+XNATUREZA==TMP->codigO+TMP->NATUREZA
						if Li >= 60
							cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
						endif
						INCREGUA()
						// XXXXXXXXXXXXXXXXXXXXXXXXXDDDDDFFFFFFFFFFYYYYYYYYYY 22/9999 99/99/99 9,999,999.99
						//           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
						// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
						@ LI,000 PSAY TMP->historico
						
						@ li,051 psay if(!empty(subs(TMP->PARCELA,5,3)),alltrim(subs(TMP->parcela,6,2))+"/"+subs(TMP->parcela,1,4),TMP->parcela)
						@ LI,059 PSAY TMP->DATAPAGTO
						@ LI,068 PSAY TMP->VALOR PICTURE "@E 99999,999.99"
						LI ++
						dbselectarea("word")
						reclock("word",.f.)
						//					if !empty(word->DTCADAS) .and. subs(dtos(word->dtcadas),1,4)>subs(tmp->parcela,1,4)
						//					else
						if empty(WORD->PARCELA)
							WORD->PARCELA := SUBS(TMP->PARCELA,6,2)+"a. "+SUBS(TMP->PARCELA,1,4)
						ELSE
							WORD->PARCELA :=  ALLTRIM(WORD->PARCELA)+" - "+SUBS(TMP->PARCELA,6,2)+"a. "+SUBS(TMP->PARCELA,1,4)
						ENDIF
						MSUNLOCK()
						//					endif
						TOTNAT += TMP->VALOR
						TITNAT ++
						DBSELECTAREA("RES")
						DBSEEK(TMP->ERSIN+TMP->NATUREZA)
						IF !FOUND()
							RECLOCK("RES",.T.)
							RES->ERSIN     := TMP->ERSIN
							RES->NATUREZA  := TMP->NATUREZA
							MSUNLOCK()
						ENDIF
						RECLOCK("RES",.F.)
						RES->VALOR += TMP->VALOR
						RES->TITULOS ++
						MSUNLOCK()
						DBSELECTAREA("Tmp")
						DBSKIP()
					ENDDO
					@ LI,059 PSAY "Total:"
					@ LI,067 PSAY Totnat PICTURE "@E 99,999,999.99"
					LI+=2
					TOTCLI+= TOTNAT
					TITCLI+= TITNAT
				ENDDO
				TOTERSIN += TOTCLI
				TITERSIN += TITCLI
				@ LI,000 PSAY "Total do Cliente:"+subs(sa1->a1_NOME,1,40)
				@ LI,067 PSAY Totcli PICTURE "@E 99,999,999.99"
				LI++
				@ LI,000 PSAY REPLICATE("-",80)
				LI+=2
			ENDDO
			TOTGER  += totersin
			TITGER  += TITERSIN
			DBSELECTAREA("RES")
			DBSEEK(XERSIN)
			DO WHILE !EOF() .AND. XERSIN == RES->ERSIN
				if Li >= 60
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
				endif
				charnat := len(alltrim(res->natureza))
				IF SUBS(res->NATUREZA,CHARNAT,1) == "T"
					DBSELECTAREA("SED")
					DBSETORDER(1)
					DBSEEK(XFILIAL()+SUBS(res->NATUREZA,1,CHARNAT-1))
				ELSE
					DBSELECTAREA("SED")
					DBSETORDER(1)
					DBSEEK(XFILIAL()+res->NATUREZA)
				ENDIF
				@ li,000 psay "TOTAL "+SUBS(SED->ED_DESCRIC,1,30)+IF(SUBS(RES->NATUREZA,CHARNAT,1) == "T","TERMO","")
				@ LI,058 PSAY RES->TITULOS PICTURE "@E 9999,999"
				@ LI,067 PSAY RES->VALOR PICTURE "@E 99,999,999.99"
				li++
				RESNAT := RES->NATUREZA
				RESVAL := RES->VALOR
				RESTIT := RES->TITULOS
				DBSELECTAREA("RES")
				RESREG := RECNO()
				DBSEEK("  "+RESNAT)
				IF !FOUND()
					RECLOCK("RES",.T.)
					RES->NATUREZA  := RESNAT
					MSUNLOCK()
				ENDIF
				RECLOCK("RES",.F.)
				RES->VALOR   += RESVAL
				RES->TITULOS += RESTIT
				MSUNLOCK()
				DBGOTO(RESREG)
				DBSKIP()
			ENDDO
			DBSELECTAREA("Tmp")
			@ LI,058 PSAY "--------"
			@ LI,067 PSAY "-------------"
			LI++
			@ LI,000 PSAY "Total do Ersin:"+xersin+"-"+alltrim(sx5->x5_descri)
			@ LI,058 PSAY TITERSIN PICTURE "@E 9999,999"
			@ LI,067 PSAY Totersin PICTURE "@E 99,999,999.99"
			LI++
			@ LI,000 PSAY REPLICATE("-",80)
			LI+=2
		enddo
		DBSELECTAREA("RES")
		DBSEEK("")
		@ LI,000 PSAY PADC("T O T A L  G E R A L",80)
		DO WHILE !EOF() .AND. EMPTY(RES->ERSIN)
			if Li >= 60
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
			endif
			charnat := len(alltrim(res->natureza))
			IF SUBS(res->NATUREZA,CHARNAT,1) == "T"
				DBSELECTAREA("SED")
				DBSETORDER(1)
				DBSEEK(XFILIAL()+SUBS(res->NATUREZA,1,CHARNAT-1))
			ELSE
				DBSELECTAREA("SED")
				DBSETORDER(1)
				DBSEEK(XFILIAL()+res->NATUREZA)
			ENDIF
			@ li,000 psay "TOTAL "+SUBS(SED->ED_DESCRIC,1,30)+IF(SUBS(RES->NATUREZA,CHARNAT,1) == "T","TERMO","")
			@ LI,058 PSAY RES->TITULOS PICTURE "@E 9999,999"
			@ LI,067 PSAY RES->VALOR PICTURE "@E 99,999,999.99"
			li++
			DBSELECTAREA("RES")
			DBSKIP()
		ENDDO
		if Li >= 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		endif
		@ LI,058 PSAY "--------"
		@ LI,067 PSAY "-------------"
		LI++
		@ LI,000 PSAY "Total Geral:"
		@ LI,058 PSAY TITGER PICTURE "@E 9999,999"
		@ LI,067 PSAY Totger PICTURE "@E 99,999,999.99"
	ENDIF
else
  		qtddia := 0

		CABEC1 := "Sindicato Nome                                               CNPJ               Cod.Socio Cidade                         Fone                      Filantropico Situacao
	cabec2 := ""
	tamanho := "G"
	DBSELECTAREA("TMP")
	c_ArqIND := CriaTrab("",.F.)
	IndRegua("TMP",c_ARQIND,"SINDICATO+NOME+CNPJ+NATUREZA+PARCELA",,,"Selecionando Registros...")
	dbgotop()
	REGS := 0
	SETREGUA(RECCOUNT())
	
	do while !eof()
		if Li >= 60
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
		endif
		XSIND := TMP->SINDICATO
		XNOME := TMP->NOME
		XCNPJ := TMP->CNPJ
		XCODSOCIO := TMP->CODASSO
		XCIDADE := TMP->CIDADE
		xddd    := tmp->ddd
		XFONE   := TMP->TELEFONE
		Xsituac := TMP->SITUACao
		devendo := .f.
		devendos := .f.
		devendoc :=.f.
		devendoa := .f.
		dbselectarea("sa1")
		dbsetorder(3)
		dbseek(XFILIAL()+XCNPJ)
		zsqtd :=0

		
		zzqtd :=0
		zzsqtd :=0
				if SUBS(dtos(sa1->a1_dTCADAS),1,4)>=subs(mv_par10,3,4)
					ZANOINI := VAL(SUBS(dtos(sa1->a1_dtCADAS),1,4))
				ELSE
					zanoini := val(subs(mv_par10,3,4))
				ENDIF
				zanofim := val(subs(mv_par11,3,4))
				zqtd := 0
				for nano:= zanoini to zanofim
					if nano == zanoini
						IF SUBS(MV_PAR10,1,1) == "2"
							ZQTD ++
						Elseif zanofim <> zanoini  .and. SUBS(MV_PAR10,1,1) == "1"
							ZQTD += 2
						Elseif zanofim == zanoini  .and. SUBS(MV_PAR10,1,1) == "2"
							ZQTD += 1                       
						else
							zqtd += 2
						ENDIF
					ELSEif nano<zanofim
						zqtd += 2
					elseif nANO== ZANOFIM
						IF SUBS(MV_PAR11,1,1) == "1"
							ZQTD ++
						Elseif SUBS(MV_PAR11,1,1) <> "1"
							ZQTD +=2
						ENDIF
					ENDIF
				NEXT

				if SUBS(dtos(sa1->a1_dtinic),1,4)>mv_par08
					IF SUBS(dtos(sa1->a1_dtinic),5,4)>"1215"
						ZANOINI := VAL(SUBS(dtos(sa1->a1_dtinic),1,4))+1
					ELSE
						ZANOINI := VAL(SUBS(dtos(sa1->a1_dtinic),1,4))
					ENDIF
				ELSE
					zanoini := val(mv_par08)
				ENDIF
				zanofim := val(mv_par09)
				zsqtd := 0
				for nano:= zanoini to zanofim
					ZsQTD ++
				NEXT

				

		dbselectarea("tmp")
		do while !eof() .and. tmp->sindicato==xsind .and. tmp->nome == xnome
			XNATUREZA := TMP->NATUREZA
			if alltrim(tmp->natureza) $"001/1000"
				do while tmp->sindicato==xsind .and. tmp->nome == xnome .and. xnatureza == tmp->natureza
					if empty(tmp->datapagto)
						devendo := .t.
					ENDIF
					DBSKIP()
				ENDDO
			endif
			if alltrim(tmp->natureza) $"002"
				do while tmp->sindicato==xsind .and. tmp->nome == xnome .and. xnatureza == tmp->natureza
					zzqtd ++
					DBSKIP()
				ENDDO
			endif
			if alltrim(tmp->natureza) $"0301"
				do while tmp->sindicato==xsind .and. tmp->nome == xnome .and. xnatureza == tmp->natureza
					zzqtd ++
					DBSKIP()
				ENDDO
			endif
			
			if alltrim(tmp->natureza) $"003"
				
				do while tmp->sindicato==xsind .and. tmp->nome == xnome .and. xnatureza == tmp->natureza
					zzsqtd ++
					DBSKIP()
				ENDDO
			endif
			
		ENDDO          
		CABEC1 := "Sindicato Nome                                               CNPJ               Cod.Socio Cidade                         Fone                      Filantropico Situacao
		cabec2 := ""
		// xx        xxxxxxxxxxccccccccccddddddddddffffffffffgggggggggg 99.999.999/9999-99 0000      555555555566666666667777777777 5555555555555555555566666 x            cc
		//           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
		// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		
		if zzqtd <> zqtd
			devendo := .t.
		endif
		if sa1->a1_simples <> "1"
			if zzsqtd <> zsqtd
				devendo := .t.
			endif
		endif
		if sa1->a1_capcent <> "S"
			if zzsqtd <> zsqtd
				devendo := .t.
			endif
		endif
		IF !DEVENDO
			qtddia ++
			@ LI,000 PSAY XSIND
			@ li,010 psay xnome
			@ li,061 psay xcnpj picture "@r 99.999.999/9999-99"
			@ li,080 psay xcodsocio
			@ LI,090 PSAY XCIDADE
			@ LI,121 PSAY xddd+" "+subs(XFONE,1,12)
			@ LI,147 PSAY SA1->A1_FILANT
			@ LI,160 PSAY XSITUAC
			LI++
			DBSELECTAREA("TMP")
		ENDIF
	enddo
Endif                
li++  
@ li,000 psay "Total Socios:"
@ li,020 psay qtddia 
DBSELECTAREA("Tmp")
CARQ := "\arquivos\"+ALLTRIM(SUBS(CUSUARIO,7,15))
COPY TO &CARQ
DBCLOSEAREA("Tmp")
DBSELECTAREA("WORD")
CARQ := "\arquivos\WORD_"+ALLTRIM(SUBS(CUSUARIO,7,15))
COPY TO &CARQ for !EMPTY(parcela)
DBCLOSEAREA("WORD")
DBSELECTAREA("RES")
CARQ := "\arquivos\sint_"+ALLTRIM(SUBS(CUSUARIO,7,15))
COPY TO &CARQ
DBCLOSEAREA("RES")
set device to screen
if aReturn[5] == 1
	set printer to
	dbcommit()
	ourspool(wnrel)
endif
MS_FLUSH()


return
