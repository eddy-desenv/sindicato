#INCLUDE "protheus.ch"
#DEFINE _nFTamLin 32  // Tamanho inicial do buffer de leitura do arquivo texto.
Static _aUse    := {} // Arquivos que estao em uso.
Static _nFUse   := 0  // Numero do arquivo aberto.
Static _nRecNo  := 1  // Numero da linha onde o ponteiro se encontra.
Static _nPosAtu := 0  // Posicao do arquivo onde o ponteiro se encontra.
Static _nPosFim := 0  // Posicao final do arquivo.

Static _nPosPro := 0  // Posicao da proxima quebra do buffer.
Static _cBuffer := "" // Buffer de leitura do arquivo texto.

// Variaveis para otimizar o tamanho da linha que o sistema deve ler por vez.
Static _nTamUlt := 0  // Tamanho da ultima linha lida.
Static _nTamQtd := 0  // Quantidade de linhas lidas.
Static _nTamMed := 0  // Tamanho medio das linhas lidas.
Static _nTamQdp := 0  // Quantidade de itens utilizados para o calculo do desvio padrao.
Static _nTamDsp := 0  // Desvio padrao do tamanho das linhas.
Static _nTamOtm := 0  // Tamanho otimizado do buffer de leitura.

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FUse     � Autor � Felipe Raposo      � Data �  02/10/03   ���
�������������������������������������������������������������������������͹��
���Descricao � Abre o arquivo passado por parametro.                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function FUse(_cArquivo)

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis.                                            �
//�����������������������������������������������������������������������
Local _nLenUse

// Testa se eh para fechar o arquivo texto.
If empty(_cArquivo) .and. (_nLenUse := len(_aUse)) > 0
	fClose(_nFUse)
	aDel(_aUse, _nLenUse)
	aSize(_aUse, _nLenUse - 1)
	_nLenUse--
	If _nLenUse > 0
		_nFUse   := _aUse[_nLenUse, 1]
		_nRecNo  := _aUse[_nLenUse, 2]
		_nPosAtu := _aUse[_nLenUse, 3]
		_nPosFim := _aUse[_nLenUse, 4]
		_nPosPro := _aUse[_nLenUse, 5]
		_cBuffer := _aUse[_nLenUse, 6]
	Endif
Endif

// Testa se eh para abrir o arquivo texto.
If !empty(_cArquivo)
	// ConOut("Abrindo arquivo " + _cArquivo)
	If (_nFUse := fOpen(_cArquivo, 68)) > 0
		_nPosFim := fSeek(_nFUse, 0, 2)  // Conta quantos caracteres o arquivo tem.
		U_FGoTop()  // Move para o inicio do arquivo.
		aAdd(_aUse, {_nFUse, _nRecNo, _nPosAtu, _nPosFim, _nPosPro, _cBuffer, _cArquivo})
		
		// Variaveis para calcular melhor tamanho de buffer de leitura.
		_nTamUlt := 0  // Tamanho da ultima linha lida.
		_nTamQtd := 0  // Quantidade de linhas lidas.
		_nTamMed := 0  // Tamanho medio das linhas lidas.
		_nTamQdp := 0  // Quantidade de itens utilizados para o calculo do desvio padrao.
		_nTamDsp := 0  // Desvio padrao do tamanho das linhas.
		_nTamOtm := _nFTamLin  // Tamanho otimizado do buffer de leitura.
	Else
		_nPosFim := _nFUse
		MsgAlert("O arquivo " + _cArquivo + " n�o p�de ser aberto.", "Aten��o")
	Endif
Endif

Return(_nPosFim)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FGoTop    � Autor � Felipe Raposo      � Data �  02/10/03   ���
�������������������������������������������������������������������������͹��
���Descricao � Vai para o inicio do arquivo.                              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function FGoTop()
_nRecNo  := 1  // Linha 1.
_nPosAtu := 0  // Caracter 0.
_nPosPro := 0  // Proxima linha.
_cBuffer := "" // Buffer de leitura.
fSeek(_nFUse, 0, 0)  // Move para o inicio do arquivo.
Return(nil)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FEOF     � Autor � Felipe Raposo      � Data �  02/10/03   ���
�������������������������������������������������������������������������͹��
���Descricao � Retorna .T. se o arquivo estiver no final.                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function FEOF()
Return(_nPosAtu >= _nPosFim .and. empty(_cBuffer))


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FRecNo   � Autor � Felipe Raposo      � Data �  02/10/03   ���
�������������������������������������������������������������������������͹��
���Descricao � Retona a linha em que o ponteiro do arquivo texto esta.    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function FRecNo()
Return(_nRecNo)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FReadLN  � Autor � Felipe Raposo      � Data �  02/10/03   ���
�������������������������������������������������������������������������͹��
���Descricao � Efetua a leitura da linha corrente do arquivo. Dependendo  ���
���          � do parametro, tambem posiciona na linha posterior.         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Parametros� _lSkip - vai para a proxima linha ao efetuar a leitura da  ���
���          �          linha corrente (padrao .T.)                       ���
�������������������������������������������������������������������������͹��
���Retorno   � String com o conteudo da linha corrente do arquivo texto.  ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function FReadLN(_lSkip)

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis.                                            �
//�����������������������������������������������������������������������
Local _cRet := ""

// Procura pela quebra da linha, se ela nao estiver no buffer.
If _nPosPro == 0
	LeArq()
Endif

// Se nao encontrou mais nenhuma quebra.
If _nPosPro == 0
	_cRet := _cBuffer
Else
	// Retorna o valor da linha corrente.
	_cRet := left(_cBuffer, _nPosPro - 1)
Endif

// Se era para pular linha...
If ValType(_lSkip) == "L" .and. _lSkip
	U_FSkip()
Endif

Return(_cRet)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FSkip    � Autor � Felipe Raposo      � Data �  22/01/08   ���
�������������������������������������������������������������������������͹��
���Descricao � Pula para a proxima linha do arquivo texto.                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function FSkip()

// Verifica antes se ja nao esta no final do arquivo.
If !U_FEOF()
	// Procura pela quebra da linha, se ela nao estiver no buffer.
	If _nPosPro == 0
		LeArq()
	Endif
	
	// Calcula o melhor tamanho de buffer para a proxima leitura.
	AtuTamLin(_nPosPro)
	
	// Atualiza o buffer.
	_cBuffer := right(_cBuffer, max(0, len(_cBuffer) - _nPosPro - 1))
	
	// Busca a posicao da proxima linha.
	_nPosPro := at(CRLF, _cBuffer)
	
	// Incrementa o numero do registro do arquivo.
	_nRecNo ++
Endif

Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � LeArq    � Autor � Felipe Raposo      � Data �  18/01/08   ���
�������������������������������������������������������������������������͹��
���Descricao � Le o arquivo texto ate encontrar uma quebra de linha, ou   ���
���          � chegar ao fim do arquivo.                                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function LeArq()

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis.                                            �
//�����������������������������������������������������������������������
Local _nAt, _cBufTmp, _nLer, _nLido

// Le o arquivo ate encontrar a quebra de linha ou ate acabar o arquivo.
_cBufTmp := space(_nTamOtm)
_nLer    := _nTamOtm
_nLido   := _nLer
Do While (_nAt := at(CRLF, _cBuffer)) == 0 .and. _nPosAtu < _nPosFim
	_nLido := fRead(_nFUse, @_cBufTmp, _nLer)  // Leitura do arquivo.
	_cBuffer += _cBufTmp
	_nPosAtu += _nLido
	If _nLido == _nLer .and. int(_nTamDsp) > _nLer * 0.05
		_nLer  := int(_nTamDsp)
		_nLido := _nLer
	Endif
EndDo

// Atualiza ate que posicao do buffer vai a linha corrente.
If _nAt > 0
	_nPosPro := _nAt
Else
	_nPosPro := len(_cBuffer) + 1
Endif

Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AtuTamLin � Autor � Felipe Raposo      � Data �  22/01/08   ���
�������������������������������������������������������������������������͹��
���Descricao � Calcula o tamanho otimizado do buffer de leitura, de acordo���
���          � com o historico do arquivo, utilizando a media do tamanho  ���
���          � das linhas e o desvio padrao.                              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function AtuTamLin(_nTamLin)

// Calcula o tamanho otimizado do buffer de leitura.
_nTamUlt := _nTamLin  // Tamanho da ultima linha lida.
_nTamMed := ((_nTamMed * _nTamQtd) + _nTamUlt) / (_nTamQtd + 1)  // Calcula a media.
_nTamQtd ++  // Quantidade de linhas lidas.
If (_nDesvio := _nTamUlt - _nTamMed) > 0  // Desvio positivo.
	_nTamDsp := ((_nTamDsp * _nTamQdp) + _nDesvio) / (_nTamQdp + 1)  // Calcula o desvio padrao positivo.
	_nTamQdp ++  // Quantidade de itens utilizados para o calculo do desvio padrao.
Endif
_nTamOtm := round(_nTamMed + (_nTamDsp * 1.1), 0)  // Le 10% a mais do que o necessario, para garantir encontrar a quebra.

Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TiraAct  � Autor � Felipe Raposo      � Data �  04/12/03   ���
�������������������������������������������������������������������������͹��
���Descricao � Tira os acentos do texto passado por parametro.            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function TiraAct(_cTexto)

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis.                                            �
//�����������������������������������������������������������������������
Local _cRet
Local _nAux1, _nAux2, _cAux1, _cAux2, _cAux3, _aAux1

// Trata os acentos do texto que sera exibido no console.
_aAux1 := {;
{"�����", "a"},;
{"�",     "c"},;
{"����",  "e"},;
{"����",  "i"},;
{"�",     "n"},;
{"�����", "o"},;
{"����",  "u"},;
{"�����", "A"},;
{"�",     "C"},;
{"����",  "E"},;
{"����",  "I"},;
{"�",     "N"},;
{"�����", "O"},;
{"����",  "U"}}

_cRet := _cTexto
For _nAux1 := 1 to len(_aAux1)
	_cAux1 := _aAux1[_nAux1, 1]  // Caracteres as serem substituidos.
	_cAux2 := _aAux1[_nAux1, 2]  // Caracter substituto.
	For _nAux2 := 1 to len(_cAux1)
		_cAux3 := SubStr(_cAux1, _nAux2, 1)    // Caracter a ser excluido (da vez).
		_cRet  := StrTran(_cRet, _cAux3, _cAux2)
	Next _nAux2
Next _nAux1

Return(_cRet)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � MsgTela  � Autor � Felipe Raposo      � Data �  18/11/03   ���
�������������������������������������������������������������������������͹��
���Descricao � Exibe a mensagem passada por parametro na tela, no console ���
���          � e grava no log.                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Parametros� _cMsg     - Mensagem a ser exibida.                        ���
���          � _cTitle   - Titulo da mensagem.                            ���
���          � _cTipo    - Tipo da mensagem.                              ���
���          � _nHdPar   - Numero do arquivo de log aberto com fOpen().   ���
���          � _cProgPar - Nome do programa.                              ���
���          � _lScrPar  - Exibe a mensagem na tela (padrao .T.)          ���
���          � _lSrvPar  - Exibe a mensagem no console (padrao .T.)       ���
���          � _lLogPar  - Grava a mensagem no arquivo log (padrao .T.)   ���
���          � _lIncPar  - Exibe a mensagem na regua de progressao        ���
���          �             (padrao .T.)                                   ���
���          �                                                            ���
���          � A mensagem e o tipo da mensagem sao os unicos parametros   ���
���          � obrigatorios.                                              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Observacao� A variavel _lTela podera ser criada como Private ou Public,���
���          � pela funcao chamadora, para informar `a funcao se as mensa-���
���          � gens devem aparecer na tela (.T.) ou somente em logs e     ���
���          � console (.F.).                                             ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MsgTela(_cMsg, _cTitle, _cTipo, _nHdPar, _cProgPar, _lScrPar, _lSrvPar, _lLogPar, _lIncPar)

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis                                             �
//�����������������������������������������������������������������������
Local _uRet, _nAux1,  _cAux1, _aAux1
Local _cMsgLog := ""  // Mensagem para o arquivo de log (fWrite).
Local _cMsgSrv := ""  // Mensagem para o servidor (ConOut).
Local _cMsgScr := ""  // Mensagem para a tela (MsgBox).
Local _cMsgInc := ""  // Mensagem para a regua de processamento (msProcTxt).
Local _lTelaL  := IIf(Type("_lTela") == "L", _lTela, .F.)
Local _cAgora  := U_Agora("C")
Local _cProg   := U_ValPad(_cProgPar, "")
Local _nHd     := U_ValPad(_nHdPar, 0)
Local _lScrImp := U_ValPad(_lScrPar, _lTelaL)
Local _lIncImp := U_ValPad(_lIncPar, _lTelaL)
Local _lSrvImp := U_ValPad(_lSrvPar, .T.)
Local _lLogImp := U_ValPad(_lLogPar, _nHd <> 0)

// Tratamento de variaveis.
_cProg += IIf(empty(_cProg), "", " ")

// Tratamento do erro.
Do Case
	Case _cTipo == "INFO"
		_cMsgScr := _cMsg
		_cMsgSrv := ""
		_cMsgLog := _cMsg
		_cMsgInc := _cMsg
		
	Case _cTipo == "ALERT"
		_cMsgScr := _cMsg
		_cMsgSrv := _cProg + '[' + _cAgora + '] * ' + _cMsg
		_cMsgLog := _cProg + '[' + _cAgora + '] * ' + _cMsg
		_cMsgInc := ""
		
	Case _cTipo == "CONSOLE"
		_cMsgScr := ""
		_cMsgSrv := _cProg + '[' + _cAgora + '] ' + _cMsg
		_cMsgLog := _cProg + '[' + _cAgora + '] ' + _cMsg
		_cMsgInc := _cMsg
		
	Case _cTipo == "LOG"
		_cMsgScr := ""
		_cMsgSrv := ""
		_cMsgLog := _cProg + '[' + _cAgora + '] ' + _cMsg
		_cMsgInc := ""
		
	Case _cTipo == "WARN"
		_cMsgScr := ""
		_cMsgSrv := _cProg + '[' + _cAgora + '] * ' + _cMsg
		_cMsgLog := _cProg + '[' + _cAgora + '] * ' + _cMsg
		_cMsgInc := ""
		
	Case _cTipo == "ERRO"
		_cMsgScr := _cMsg
		_cMsgSrv := _cProg + '[' + _cAgora + '] ** ' + _cMsg
		_cMsgLog := _cProg + '[' + _cAgora + '] ** ' + _cMsg
		_cMsgInc := ""
		
	Case _cTipo == "YESNO"
		_cMsgScr := _cMsg + CRLF + "Deseja continuar?"
		_cMsgSrv := _cProg + '[' + _cAgora + '] ' + _cMsg
		_cMsgLog := _cProg + '[' + _cAgora + '] ' + _cMsg
		_cMsgInc := ""
		
	OtherWise
		_cMsgScr := _cMsg
		_cMsgSrv := _cProg + '[' + _cAgora + '] ' + _cMsg
		_cMsgLog := _cProg + '[' + _cAgora + '] ' + _cMsg
		_cMsgInc := _cMsg
EndCase

// Exibe a mensagem no console do servidor.
If _lSrvImp .and. !empty(_cMsgSrv)
	// Trata os acentos do texto antes de exibi-lo no console.
	ConOut(U_TiraAct(_cMsgSrv))
Endif

// Grava a mensagem no arquivo de log.
If _lLogImp .and. !empty(_cMsgLog) .and. _nHd <> 0
	fWrite(_nHd, _cMsgLog + CRLF)
Endif

// Exibe a mensagem na tela.
If _lScrImp .and. !empty(_cMsgScr)
	_uRet := MsgBox(_cMsgScr, _cTitle, _cTipo)
Else
	If _cTipo == "YESNO"
		ConOut("Sim (automatico)")
	Endif
	_uRet := .T.
Endif

// Atualiza a tela de processamento.
If _lIncImp .and. !empty(_cMsgInc)
	msProcTxt(_cMsgInc)
	ProcessMessages()  // Atualiza a pintura da janela.
Endif

Return(_uRet)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GetcBox  � Autor � Felipe Raposo      � Data �  12/08/03   ���
�������������������������������������������������������������������������͹��
���Descricao � Retorna o texto correspondente a letra ou numero de um     ���
���          � campo combo-box, de acordo com as configuracoes no dicio-  ���
���          � nario de dados (SX3->X3_CBOX).                             ���
���          � Exemplos:                                                  ���
���          � U_GetcBox("A1_TIPO", "R")  -> Retorno: "Revendedor"        ���
���          � U_GetcBox("F1_TIPO", "B")  -> Retorno: "Beneficiamento"    ���
���          � X3Combo("A1_TIPO", "R")    -> Retorno: "Revendedor"        ���
���          � X3Combo("F1_TIPO", "B")    -> Retorno: "Beneficiamento"    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Parametro � _cCampo - campo que contem o combo de opcoes.              ���
���          � _cOpc   - opcao selecionada.                               ���
�������������������������������������������������������������������������͹��
���Retorno   � Retorna a descricao da opcao passada por parametro.        ���
�������������������������������������������������������������������������͹��
���Observacao� Descobri no sistema a funcao X3Combo(_cCampo, _cOpc) com a ���
���          � mesma sintaxe da funcao U_GetcBox(_cCampo, _cOpc).         ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function GetcBox(_cCampo, _cOpc)

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis                                             �
//�����������������������������������������������������������������������
Local _aAreas, _aOpcs[0], _cRet, _nAux1, _aAux1

// Salva as condicoes das areas de trabalho passadas por parametro.
_aAreas := U_GetArea({"SX3"})

// Acerta os valores padroes dos parametros.
_cCampo := U_ValPad(_cCampo, SX3->X3_CAMPO)
_cOpc   := AllTrim(U_ValPad(_cOpc, &(SX3->(X3_ARQUIVO + "->" + X3_CAMPO))))

// Posiciona a tabela.
SX3->(dbSetOrder(2))  // X3_CAMPO.
SX3->(dbSeek(_cCampo, .F.))

// Monta a lista de opcoes na matriz _aAux1.
_aAux1 := AllTrim(U_CtoA(SX3->X3_CBOX, ";"))

// Quebra o combo em duas partes.
// 1 - Opcao.
// 2 - Descricao.
aEval(_aAux1, {|x| aAdd(_aOpcs, U_CtoA(Alltrim(x), "="))})

// Busca a descricao da opcao escolhida.
If (_nAux1 := aScan(_aOpcs, {|x| AllTrim(x[1]) == _cOpc})) <> 0
	_cRet := AllTrim(_aOpcs[_nAux1, 2])
Else
	_cRet := ""
Endif

// Retorna as condicoes das areas de trabalho.
U_RestArea(_aAreas)

Return(_cRet)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CtoA     � Autor � Felipe Raposo      � Data �  17/09/03   ���
�������������������������������������������������������������������������͹��
���Descricao � Transforma texto, formado por itens separados por algum    ���
���          � delimitador qualquer, em uma matriz.                       ���
���          �                                                            ���
���          � O limitador de palavras podera ser definido pelo usuario e ���
���          � passado por parametro. O padrao eh uma virgula e ponto e   ���
���          � virgula.                                                   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Parametro � _cTexto - texto que sera convertido em matriz.             ���
���          � _cDelim - caracter delimitador de campos. Se nao passado,  ���
���          �           o sistema assumira virgula ou ponto-virgula.     ���
���          � _lRetAspas - informe ao sistema se devera retirar as aspas ���
���          �              do caracter. Se nao for para retirar, o sis-  ���
���          �              tema retornara os item com as aspas juntas. O ���
���          �              padrao eh .T. (verdadeiro).                   ���
�������������������������������������������������������������������������͹��
���Retorno   � Uma matriz contendo itens do tipo caracter, onde cada item ���
���          � eh um trecho do texto passado, separado pelo delimitador.  ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function CtoA(_cTexto, _cDelim, _lRetAspas)

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Local _aRet := {}
Local _nAux1, _cAux1 := "", _cAux2 := "", _cAbreCpo := ""
Local _lDelim, _nTamTxt, _cAspas := "'" + '"'

// Verifica os parametros passados.
_cTexto    := U_ValPad(_cTexto, "")
_cDelim    := U_ValPad(_cDelim, ";,")
_lRetAspas := U_ValPad(_lRetAspas, .F.)

// Pega o tamanho do campo.
_nTamTxt := len(_cTexto)

// Varre todo o texto passado por parametro, um caracter por vez.
For _nAux1 := 1 to _nTamTxt
	
	// Pega o caracter da posicao.
	_cAux1 := SubStr(_cTexto, _nAux1, 1)
	
	// Testa se eh um caracter delimitador.
	// Nao considera delimitadores dentro do texto (entre aspas).
	_lDelim := (_cAux1 $ _cDelim) .and. (empty(_cAbreCpo) .or. _cAbreCpo == right(AllTrim(_cAux2), 1))
	
	// Se nao for um caracter delimitador, inclui no campo.
	If !_lDelim
		// Se uma aspa for o primeiro caracter do campo...
		If empty(_cAux2) .and. _cAux1 $ _cAspas
			// ... armazena essa aspa em uma variavel auxiliar.
			_cAbreCpo := _cAux1
		Endif
		
		// Adiciona o caractere da posicao.
		_cAux2 += _cAux1
	Endif
	
	// Testa se eh fim do campo ou fim da linha.
	If _lDelim .or. (_nAux1 == _nTamTxt)
		// Verifica se abriu e fechou com aspas.
		If _lRetAspas .and. !empty(_cAbreCpo) .and. right(AllTrim(_cAux2), 1) == _cAbreCpo
			_cAux2 := AllTrim(_cAux2)
			_cAux2 := right(_cAux2, len(_cAux2) - 1)  // Retira a aspa do inicio...
			_cAux2 := left(_cAux2, len(_cAux2) - 1)   // ... e do final.
		Endif
		
		// Adiciona o campo corrente na matriz que sera retornada.
		aAdd(_aRet, _cAux2)
		
		// Zera as variaveis auxiliares.
		_cAux2    := ""
		_cAbreCpo := ""
	Endif
Next _nAux1
Return(_aRet)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � TxtFrm   � Autor � Felipe Raposo      � Data �  25/01/05   ���
�������������������������������������������������������������������������͹��
���Descricao � Preenche o valor passado por parametro, com caracteres,    ���
���          � ate que se atinja o tamanho desejado. O caracter padrao de ���
���          � preenchimento eh espaco em branco. O alinhamento padrao do ���
���          � valor eh a esquerda (com caracteres a direita).            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Parametros� _uValor - valor a receber os caracteres de preenchimento.  ���
���          � _nTam   - tamanho da cadeia de strings que devera ser re-  ���
���          �           tornada (valor + preenchimento).                 ���
���          � Paramentros opcionais:                                     ���
���          � _cRech  - caracter de preenchimento. O padrao sao caracte- ���
���          �           res em branco.                                   ���
���          � _cPos   - alinhamento do valor (D=direito / E=esquerdo). O ���
���          �           padrao eh alinhamento a esquerda.                ���
�������������������������������������������������������������������������͹��
���Retorno   � A cadeia de caracteres, de acordo com os parametros passa- ���
���          � dos.                                                       ���
�������������������������������������������������������������������������͹��
���Uso       � Generico.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function TxtFrm(_uValor, _nTam, _cRech, _cPos)

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis.                                            �
//�����������������������������������������������������������������������
Local _nAux1

// Transforma o primeiro parametro em texto.
Do Case
	Case ValType(_uValor) == "C"  // Nesse caso nao fazer nada.
	Case ValType(_uValor) == "N"; _uValor := AllTrim(str(_uValor))
	Case ValType(_uValor) == "D"; _uValor := AllTrim(dtos(_uValor))
	Case ValType(_uValor) == "U"; Return(_uValor)
	OtherWise; Return("")
EndCase

// Analista o caracter de preenchimento.
_cRech := left(U_ValPad(_cRech, " "), 1)
_nTam  := U_ValPad(_nTam, len(_uValor))

// Joga o recheio na variavel de retorno.
If upper(left(AllTrim(U_ValPad(_cPos, "E")), 1)) == "D"
	_uValor := IIf(((_nAux1 := len(_uValor)) < _nTam), Replicate(_cRech, _nTam - _nAux1) + _uValor, right(_uValor, _nTam))
Else
	_uValor := IIf(((_nAux1 := len(_uValor)) < _nTam), _uValor + Replicate(_cRech, _nTam - _nAux1), left(_uValor, _nTam))
Endif

Return(_uValor)