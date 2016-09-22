		// confederativa
		If EMPTY(trb->A1_INAT) .and. empty(trb->a1_filant) .and. TRB->A1_CATEG1<"12000"
			IF !EMPTY(MV_PAR16)
				dbSelectArea("SE1")
				dbOrderNickName('22')  // Dbsetorder(22) // Alterado (UPDXFUN).
				for n:= val(SUBS(mv_par16,6,2)) to VAL(SUBS(mv_par17,6,2))
					for nx := 1 to 2
						dbSelectArea("SE1")
						dbseek( xFilial()+TRB->A1_COD+strzero(nx,1)+"002       "+Strzero(n,2),.T.)
						grava := .t.
						IF !FOUND()
							dbselectarea("tmp")
							dbseek(TRB->a1_ERSIN+TRB->a1_COD+"002       "+if(N>90,"19","20")+Strzero(n,2)+"/"+STRZERO(NX,2))
							IF !FOUND()
								IF SUBS(MV_PAR16,1,1)>"1"
									IF NX==1 .AND. strzero(N,2) ==SUBS(mv_par16,5,2)  .OR. (NX==1 .AND. strzero(N,2) ==SUBS(mv_par16,5,2) .AND. SUBS(MV_PAR17,1,1)<"2" .AND. VAL(SUBS(mv_par17,5,2))==N)
										GRAVA := .F.
									else
										dbSelectArea("TMP")
										dbseek(sa1->A1_ERSIN+sa1->a1_COD+"002      "+if(N>90,"19","20")+Strzero(n,2)+"/"+STRZERO(NX,2))
										if found()
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
											TMP->TELEFONE  := TRB->A1_TEL
											TMP->CODASSO   := TRB->A1_CODASSO
											TMP->SITUACAO  := TRB->A1_SITUAC
											TMP->ERSIN    := TRB->A1_ERSIN
											TMP->BASE      := TRB->A1_BASE
											TMP->CATEGORIA := TRB->A1_CATEG1
											TMP->NATUREZA := "002"
											//									TMP->HISTORICO:= SE1->E1_HIST
											tmp->parcela  := if(N>90,"19","20")+Strzero(n,2)+"/"+STRZERO(NX,2)
											msunlock()
											GRAVA := .F.
										endif
									endif
								ENDIF
								IF strzero(NX,1)>subs(mv_par17,1,1) .AND. strzero(n,2)==SUBS(mv_par17,5,2) .AND. SUBS(MV_PAR17,1,1)<"2" .AND. VAL(SUBS(mv_par17,5,2))==N
									GRAVA := .F.
								else
									IF GRAVA
										dbSelectArea("TMP")
										dbseek(sa1->A1_ERSIN+sa1->a1_COD+"002      "+if(N>90,"19","20")+Strzero(n,2)+"/"+STRZERO(NX,2))
										if found()
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
											TMP->TELEFONE  := TRB->A1_TEL
											TMP->CODASSO   := TRB->A1_CODASSO
											TMP->SITUACAO  := TRB->A1_SITUAC
											TMP->ERSIN    := TRB->A1_ERSIN
											TMP->BASE      := TRB->A1_BASE
											TMP->CATEGORIA := TRB->A1_CATEG1
											TMP->NATUREZA := "002"
											//								TMP->HISTORICO:= SE1->E1_HIST
											tmp->parcela  := if(N>90,"19","20")+Strzero(n,2)+"/"+STRZERO(NX,2)
											msunlock()
											GRAVA := .F.
										ENDIF
									endif
								endif
								IF GRAVA
									dbSelectArea("TMP")
									dbseek(sa1->A1_ERSIN+sa1->a1_COD+"002      "+if(N>90,"19","20")+Strzero(n,2)+"/"+STRZERO(NX,2))
									if found()
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
										TMP->TELEFONE  := TRB->A1_TEL
										TMP->CODASSO   := TRB->A1_CODASSO
										TMP->SITUACAO  := TRB->A1_SITUAC
										TMP->ERSIN    := TRB->A1_ERSIN
										TMP->BASE      := TRB->A1_BASE
										TMP->CATEGORIA := TRB->A1_CATEG1
										TMP->NATUREZA := "002"
										//							TMP->HISTORICO:= SE1->E1_HIST
										tmp->parcela  := if(N>90,"19","20")+Strzero(n,2)+"/"+STRZERO(NX,2)
										msunlock()
									ENDIF
								ENDIF
							ENDIF
						else
							dbselectarea("tmp")
							dbseek(TRB->a1_ERSIN+TRB->a1_COD+"002       "+if(N>90,"19","20")+Strzero(n,2)+"/"+STRZERO(NX,2))
							if found()
								reclock("TMP",.F.)
								DBDELETE()
								MSUNLOCK()
							ENDIF
						ENDIF
					NEXT
				NEXT
			ENDIF
		ENDIF
		// Associativa confederativa
		IF !EMPTY(MV_PAR18) .AND. TRB->A1_CODASSO<>'' .AND. ALLTRIM(TRB->A1_NATUREZ)=="1000"
			dbSelectArea("SE1")
			dbOrderNickName('17')  // Dbsetorder(17) // Alterado (UPDXFUN).
			for n:= val(SUBS(mv_par18,4,4)) to VAL(SUBS(mv_par19,4,4))
				for nx := 1 to 12
					DBSELECTAREA("SE1")
					dbOrderNickName('17')  // Dbsetorder(17) // Alterado (UPDXFUN).
					dbseek( xFilial("SE1")+SUBS(Strzero(n,4),3,2)+" "+Strzero(nX,2)+subs(TRB->A1_CODasso,3,4)+" 1000")
					grava := .t.
					if SUBS(Strzero(n,4),3,2)+" "+Strzero(nX,2) > mv_par19
						DBSELECTAREA("SE1")
						DBSKIP()
						LOOP
					ENDIF

					if SUBS(SE1->E1_PREFIXO,3,1) == "T"
						DBSELECTAREA("SE1")
						DBSKIP()
						LOOP
					ENDIF
					IF FOUND() .AND. EMPTY(SE1->E1_BAIXA) .and. se1->e1_vencrea<ddatabase
						IF SUBS(MV_PAR18,1,2)>"01"
							IF NX==1 .AND. strzero(N,4) ==SUBS(mv_par18,4,2)
							else
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
								TMP->TELEFONE  := TRB->A1_TEL
								TMP->CODASSO   := TRB->A1_CODASSO
								TMP->SITUACAO  := TRB->A1_SITUAC
								TMP->ERSIN    := TRB->A1_ERSIN
								TMP->BASE      := TRB->A1_BASE
								TMP->CATEGORIA := TRB->A1_CATEG1
								TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
								tmp->parcela  := Strzero(n,4)+"/"+STRZERO(NX,2)
								TMP->HISTORICO:= SE1->E1_HIST
								tmp->valor    := se1->e1_valor
								tmp->dataVENCTO:= se1->e1_VENCTO
								msunlock()
								GRAVA := .F.
							endif
						ENDIF
						IF strzero(NX,2)>subs(mv_par19,1,2) .AND. strzero(n,4)==SUBS(mv_par19,4,4)
						else
							IF GRAVA
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
								TMP->TELEFONE  := TRB->A1_TEL
								TMP->CODASSO   := TRB->A1_CODASSO
								TMP->SITUACAO  := TRB->A1_SITUAC
								TMP->ERSIN    := TRB->A1_ERSIN
								TMP->BASE      := TRB->A1_BASE
								TMP->CATEGORIA := TRB->A1_CATEG1
								TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
								tmp->parcela  := Strzero(n,4)+"/"+STRZERO(NX,2)
								TMP->HISTORICO:= SE1->E1_HIST
								tmp->valor    := se1->e1_valor
								tmp->dataVENCTO:= se1->e1_VENCTO
								msunlock()
								GRAVA := .F.
							ENDIF
						endif
						IF GRAVA
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
							TMP->TELEFONE  := TRB->A1_TEL
							TMP->CODASSO   := TRB->A1_CODASSO
							TMP->SITUACAO  := TRB->A1_SITUAC
							TMP->ERSIN    := TRB->A1_ERSIN
							TMP->BASE      := TRB->A1_BASE
							TMP->CATEGORIA := TRB->A1_CATEG1
							TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
							tmp->parcela  := Strzero(n,4)+"/"+STRZERO(NX,2)
							TMP->HISTORICO:= SE1->E1_HIST
							tmp->valor    := se1->e1_valor
							tmp->dataVENCTO:= se1->e1_VENCTO
							msunlock()
						ENDIF
					ENDIF
				NEXT
			NEXT
		ENDIF
		// Associativa
		IF !EMPTY(MV_PAR20) .AND. TRB->A1_CODASSO<>'' .AND. ALLTRIM(TRB->A1_NATUREZ)=="001"
			dbSelectArea("SE1")
			dbOrderNickName('17')  // Dbsetorder(17) // Alterado (UPDXFUN).
			for n:= val(SUBS(mv_par20,4,4)) to VAL(SUBS(mv_par21,4,4))
				for nx := 1 to 12
					DBSELECTAREA("SE1")
					dbOrderNickName('17')  // DBSETORDER(17) // Alterado (UPDXFUN).
					dbseek( xFilial()+SUBS(Strzero(n,4),3,2)+" "+Strzero(nX,2)+subs(TRB->A1_CODasso,3,4)+" 001")
					grava := .t.
					if SUBS(Strzero(n,4),3,2)+" "+Strzero(nX,2) > mv_par19
						DBSELECTAREA("SE1")
						DBSKIP()
						LOOP
					ENDIF
					if SUBS(SE1->E1_PREFIXO,3,1) == "T"
						DBSELECTAREA("SE1")
						DBSKIP()
						LOOP
					ENDIF
					IF FOUND() .AND. EMPTY(SE1->E1_BAIXA).and. se1->e1_vencrea<ddatabase
						IF SUBS(MV_PAR20,1,2)>"01"
							IF NX==1 .AND. strzero(N,4) ==SUBS(mv_par20,4,4)
							else
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
								TMP->TELEFONE  := TRB->A1_TEL
								TMP->CODASSO   := TRB->A1_CODASSO
								TMP->SITUACAO  := TRB->A1_SITUAC
								TMP->ERSIN    := TRB->A1_ERSIN
								TMP->BASE      := TRB->A1_BASE
								TMP->CATEGORIA := TRB->A1_CATEG1
								TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
								tmp->parcela  := Strzero(n,4)+"/"+STRZERO(NX,2)
								TMP->HISTORICO:= SE1->E1_HIST
								tmp->valor    := se1->e1_valor
								tmp->dataVENCTO:= se1->e1_VENCTO
								msunlock()
								GRAVA := .F.
							endif
						ENDIF
						IF strzero(NX,1)>subs(mv_par21,1,2) .AND. strzero(n,4)==SUBS(mv_par21,4,4)
						else
							IF GRAVA
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
								TMP->TELEFONE  := TRB->A1_TEL
								TMP->CODASSO   := TRB->A1_CODASSO
								TMP->SITUACAO  := TRB->A1_SITUAC
								TMP->ERSIN    := TRB->A1_ERSIN
								TMP->BASE      := TRB->A1_BASE
								TMP->CATEGORIA := TRB->A1_CATEG1
								TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
								tmp->parcela  := Strzero(n,4)+"/"+STRZERO(NX,2)
								TMP->HISTORICO:= SE1->E1_HIST
								tmp->valor    := se1->e1_valor
								tmp->dataVENCTO:= se1->e1_VENCTO
								msunlock()
								GRAVA := .F.
							ENDIF
						endif
						IF GRAVA
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
							TMP->TELEFONE  := TRB->A1_TEL
							TMP->CODASSO   := TRB->A1_CODASSO
							TMP->SITUACAO  := TRB->A1_SITUAC
							TMP->ERSIN    := TRB->A1_ERSIN
							TMP->BASE      := TRB->A1_BASE
							TMP->CATEGORIA := TRB->A1_CATEG1
							TMP->NATUREZA := alltrim(se1->e1_naturez)+if(subs(se1->E1_PREFIXO,3,1)=="T","T","")
							tmp->parcela  := Strzero(n,4)+"/"+STRZERO(NX,2)
							TMP->HISTORICO:= SE1->E1_HIST
							tmp->valor    := se1->e1_valor
							tmp->dataVENCTO:= se1->e1_VENCTO
							msunlock()
						ENDIF
					ENDIF
				NEXT
			NEXT
		ENDIF
		// CONTRATOS
		IF TRB->A1_SITUAC == "CT"
			IF !EMPTY(MV_PAR22)
				dbSelectArea("SE1")
				dbOrderNickName('21')  // Dbsetorder(21) // Alterado (UPDXFUN).
				dbseek( xFilial()+TRB->A1_COD+DTOS(MV_PAR22),.T.)
				DO WHILE !EOF() .AND. SE1->E1_CLIENTE == TRB->A1_COD .AND. SE1->E1_VENCREA<=MV_PAR23
					IF SE1->E1_VALOR < MV_PAR10 .OR. SE1->E1_VALOR > MV_PAR11
						DBSELECTAREA("SE1")
						DBSKIP()
						LOOP
					ENDIF
					if SUBS(SE1->E1_PREFIXO,3,1) == "T"
						DBSELECTAREA("SE1")
						DBSKIP()
						LOOP
					ENDIF
					if alltrim(se1->e1_naturez)<>"0327"
						DBSELECTAREA("SE1")
						DBSKIP()
						LOOP
					ENDIF
					if empty(se1->e1_saldo)
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
					tmp->dataVENCTO:= se1->e1_VENCTO
					msunlock()
					dbselectarea("se1")
					dbskip()
				enddo
			ENDIF
		endif
		// termos
		IF !EMPTY(MV_PAR27)
			dbSelectArea("SE1")
			dbOrderNickName('21')  // Dbsetorder(21) // Alterado (UPDXFUN).
			dbseek( xFilial()+TRB->A1_COD+DTOS(MV_PAR27),.T.)
			DO WHILE !EOF() .AND. SE1->E1_CLIENTE == TRB->A1_COD .AND. SE1->E1_VENCREA<=MV_PAR28
				IF SE1->E1_VALOR < MV_PAR10 .OR. SE1->E1_VALOR > MV_PAR11
					DBSELECTAREA("SE1")
					DBSKIP()
					LOOP
				ENDIF
				if SUBS(SE1->E1_PREFIXO,3,1) <> "T"
					DBSELECTAREA("SE1")
					DBSKIP()
					LOOP
				ENDIF
				if empty(se1->e1_saldo)
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
				tmp->dataVENCTO:= se1->e1_VENCTO
				msunlock()
				dbselectarea("se1")
				dbskip()
			enddo
		ENDIF
	ENDIF
	dbselectarea("trb")
	dbskip()
enddo
LI := 80
DBCLOSEAREA("TRB")
dbclosearea("trb")
DBSELECTAREA("TMP")
c_ArqIND := CriaTrab("",.F.)
IndRegua("TMP",c_ARQIND,"ERSIN+NOME+CNPJ+NATUREZA+PARCELA",,,"Selecionando Registros...")
dbgotop()
REGS := 0
SETREGUA(RECCOUNT())
IF RECCOUNT() >0
	TOTGER := TITGER := 0
	DO WHILE !EOF()
		IF TMP->CODIGO == "033699"
			XT := ""
		ENDIF
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
			IF MV_PAR26 == 1
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
				@ li,050 psay "Tel: "+sa1->a1_tel
				LI++
				@ li,000 psay "Cod.Siga:"+sa1->a1_cod
				if !empty(tmp->inativo)
					@ li,040 psay "Cliente Inativo"
				endif
				li += 2
			ENDIF
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
				IF MV_PAR26 == 1
					if mv_par01 == 1 // PAGANTES
						@ li,000 psay SUBS(SED->ED_DESCRIC,1,30)+IF(SUBS(TMP->NATUREZA,CHARNAT,1) == "T","TERMO","     ")+SPACE(15)+" Parcela Dt Pagto        Valor"
					ELSE
						@ li,000 psay SUBS(SED->ED_DESCRIC,1,30)+IF(SUBS(TMP->NATUREZA,CHARNAT,1) == "T","TERMO","     ")+SPACE(15)+" Parcela Dt Vencto       Valor"
					ENDIF
					LI++
				ENDIF
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
					IF MV_PAR26 == 1
						@ LI,000 PSAY TMP->historico

						@ li,051 psay if(!empty(subs(TMP->PARCELA,5,3)),alltrim(subs(TMP->parcela,6,2))+"/"+subs(TMP->parcela,1,4),TMP->parcela)
						@ LI,059 PSAY TMP->DATAPAGTO
						@ LI,068 PSAY TMP->VALOR PICTURE "@E 99999,999.99"
						LI ++
					ENDIF
					dbselectarea("word")
					reclock("word",.f.)
					if !empty(word->DTCADAS) .and. subs(dtos(word->dtcadas),1,4)>subs(tmp->parcela,1,4)
					else
						if empty(WORD->PARCELA)
							if mv_par01 == 1 // PAGANTES
								WORD->PARCELA := SUBS(TMP->PARCELA,6,2)+"a. "+SUBS(TMP->PARCELA,1,4)
							else
								WORD->PARCELA := SUBS(TMP->PARCELA,7,2)+"a. "+SUBS(TMP->PARCELA,1,4)
							endif
						ELSE
							if mv_par01 == 1 // PAGANTES
								WORD->PARCELA :=  ALLTRIM(WORD->PARCELA)+" - "+SUBS(TMP->PARCELA,6,2)+"a. "+SUBS(TMP->PARCELA,1,4)
							else
								WORD->PARCELA :=  ALLTRIM(WORD->PARCELA)+" - "+SUBS(TMP->PARCELA,7,2)+"a. "+SUBS(TMP->PARCELA,1,4)
							endif
						ENDIF
						MSUNLOCK()
					endif
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
				IF MV_PAR26 == 1
					@ LI,059 PSAY "Total:"
					@ LI,067 PSAY Totnat PICTURE "@E 99,999,999.99"
					LI+=2
				ENDIF
				TOTCLI+= TOTNAT
				TITCLI+= TITNAT
			ENDDO
			TOTERSIN += TOTCLI
			TITERSIN += TITCLI
			IF MV_PAR26 == 1
				@ LI,000 PSAY "Total do Cliente:"+subs(sa1->a1_NOME,1,40)
				@ LI,067 PSAY Totcli PICTURE "@E 99,999,999.99"
				LI++
				@ LI,000 PSAY REPLICATE("-",80)
				LI+=2
			ENDIF
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
dbselectarea(_cAlias)
return