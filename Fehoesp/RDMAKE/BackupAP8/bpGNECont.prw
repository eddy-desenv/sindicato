#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �bpGNECont  � Autor � LUICIL FERNANDES  � Data �  24/03/06   ���
�������������������������������������������������������������������������͹��
���Descricao �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Grava codigo do escr contabil no cadastro do cliente       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������

/*/

User Function bpGCNECont(cnpj,esccont)

	_oldArea  := alias()
	_oldOrder := indexord()
	cnpj=STRZERO(VAL(cnpj),14)

	dbSelectArea("SA1")
	dbSetOrder(3)
	dbSeek(XFILIAL()+cnpj)
	IF FOUND()
		reclock("SA1",.F.)
		SA1->A1_ESCCONT := esccont		
		MSUNLOCK()
	Endif
	dbSelectArea(_oldArea)
	dbSetOrder(_oldOrder) // Atencao (UPDXFUN).
Return .T.
