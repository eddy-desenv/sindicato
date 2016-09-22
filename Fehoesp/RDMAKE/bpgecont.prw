#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �bpGECont   � Autor � LUICIL FERNANDES  � Data �  24/03/06   ���
�������������������������������������������������������������������������͹��
���Descricao �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Grava no cadastro de escritorios contabeis                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function bpGECont(cnpj,razao,ender,bairro,mun,cep,uf,email,fone,fax)

	_oldArea  := alias()
	_oldOrder := indexord()
	cnpj=STRZERO(VAL(cnpj),14)

	dbSelectArea("SZC")
	dbSetOrder(2)
	dbSeek(XFILIAL()+cnpj)
	IF !FOUND()
		RECLOCK("SZC",.T.)
		SZC->ZC_CODIGO := GETSX8NUM("SZC","ZC_CODIGO")
		SZC->ZC_CGC := cnpj
		SZC->ZC_FILIAL := XFILIAL()
		SZC->ZC_NOMESC := razao
		SZC->ZC_END := ender
		SZC->ZC_BAIRRO := bairro
		SZC->ZC_MUN := mun
		SZC->ZC_CEP := cep
		SZC->ZC_EST := uf
		SZC->ZC_EMAIL := email
		SZC->ZC_FONE := fone
		SZC->ZC_FAX := fax
		SZC->ZC_DTCADAS := Date()
		MSUNLOCK()
		CONFIRMSX8()
	Else
		reclock("SZC",.F.)
		SZC->ZC_NOMESC := razao
		SZC->ZC_END := ender
		SZC->ZC_BAIRRO := bairro
		SZC->ZC_MUN := mun
		SZC->ZC_CEP := cep
		SZC->ZC_EST := uf
		SZC->ZC_EMAIL := email
		SZC->ZC_FONE := fone
		SZC->ZC_FAX := fax
		MSUNLOCK()
	Endif
	dbSelectArea(_oldArea)
	dbSetOrder(_oldOrder) // Atencao (UPDXFUN).
Return .T.

