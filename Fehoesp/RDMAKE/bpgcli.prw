#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �bpGCli     � Autor � LUICIL FERNANDES  � Data �  02/07/07   ���
�������������������������������������������������������������������������͹��
���Descricao �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Grava pre-cadastro para emissao da GRCS                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function bpGCli(cnpj,capsoc,dtinic,razao,ender,bairro,mun,cep,uf,email,fone,fax,esccont,altcad,sindica,codigo)
//luicil
//conout("marcio")
//msginfo("navarro")


	_oldArea  := alias()
	_oldOrder := indexord()
//	"53818175000177",1000,"01/01/2006","WALLY WAURUS","RUA WAURUS, 1","VILA WALLY",
//"SAO WAURUS","04805110","SP","luicil@singera.com","11 56675987","","","N"
//	cnpj:="53818175000177"
//	capsoc:=1000
//	dtinic:="01/01/2006"
//	razao:="WALLY WAURUS"
//	ender:="RUA WAURUS, 1"
//	bairro:="VILA WALLY"
//	mun:="SAO WAURUS"
//	cep:="04805110"
//	uf:="SP"
//	email:="luicil@singera.com"
//	fone:="11 56675987"
//	fax:=""
//	esccont:=""
//	altcad:="N"
//	sindica:="01"
//	codigo:="999998"
	cnpj=STRZERO(VAL(cnpj),14)

	dbSelectArea("SA1")
	dbSetOrder(3)
	dbSeek(XFILIAL("SA1")+cnpj)
	IF !FOUND()
		RECLOCK("SA1",.T.)
//		SA1->A1_COD := GETSX8NUM("SA1","A1_CODIGO")
		SA1->A1_COD := "W"+ SUBSTR( codigo, 2 )
		SA1->A1_LOJA := "01"
		SA1->A1_TPCADAS := "W"
		SA1->A1_INAT := "X"
		SA1->A1_CGC := cnpj
//		SA1->A1_FILIAL := XFILIAL()
		SA1->A1_NOME := razao
		SA1->A1_END := ender
		SA1->A1_BAIRRO := bairro
		SA1->A1_MUN := mun
		SA1->A1_CEP := cep
		SA1->A1_EST := uf
		SA1->A1_EMAIL := email
		SA1->A1_TEL := fone
		SA1->A1_FAX := fax
		SA1->A1_CAPITAL := capsoc
		SA1->A1_DTINIC := CTOD(dtinic)
		SA1->A1_DTCADAS := Date() 
		
		SA1->A1_NATUREZ := "002"
		SA1->A1_SCONTAT := "A/C DIRETOR ADMINISTRATIVO"
		SA1->A1_NOMPRES := "A/C PRESIDENTE"
		SA1->A1_ADMPROV := "A/C ADM PROVEDOR"
		SA1->A1_SUPERIN := "A/C SUPERINTENDENTE"
		SA1->A1_DIRCLIN := "A/C DIRETOR CLINICO"
		SA1->A1_DIRFIN  := "A/C DIRETOR FINANCEIRO"
		SA1->A1_DIRRH   := "A/C DIRETOR RH"  
		SA1->A1_DIRADM  := "A/C DIRETOR ADMINISTRATIVO"
		SA1->A1_ADVOGA  := "A/C ADVOGADO"
		SA1->A1_ESCCONT := esccont
		SA1->A1_SINDICA :=sindica
		MSUNLOCK()
//		CONFIRMSX8()
	Else
		reclock("SA1",.F.)
		SA1->A1_DTINIC := CTOD(dtinic)
		SA1->A1_CAPITAL := capsoc
		MSUNLOCK()
//      ConOut( "Inativou codigo " + SA1->A1_COD )
	Endif
	dbSelectArea(_oldArea)
	dbSetOrder(_oldOrder) // Atencao (UPDXFUN).
Return .T.

/*
		If altcad = "S"

			SA1->A1_NOME := razao
			SA1->A1_END := ender
			SA1->A1_BAIRRO := bairro
			SA1->A1_MUN := mun
			SA1->A1_CEP := cep
			SA1->A1_EST := uf
			SA1->A1_EMAIL := email
			SA1->A1_TEL := fone
			SA1->A1_FAX := fax
		EndIf
		SA1->A1_TPCADAS := "Z"
		SA1->A1_INAT := "X"
		SA1->A1_ESCCONT := esccont		
*/
