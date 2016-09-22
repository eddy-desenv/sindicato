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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FUse     บ Autor ณ Felipe Raposo      บ Data ณ  02/10/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Abre o arquivo passado por parametro.                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FUse(_cArquivo)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
		MsgAlert("O arquivo " + _cArquivo + " nใo p๔de ser aberto.", "Aten็ใo")
	Endif
Endif

Return(_nPosFim)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGoTop    บ Autor ณ Felipe Raposo      บ Data ณ  02/10/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Vai para o inicio do arquivo.                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FGoTop()
_nRecNo  := 1  // Linha 1.
_nPosAtu := 0  // Caracter 0.
_nPosPro := 0  // Proxima linha.
_cBuffer := "" // Buffer de leitura.
fSeek(_nFUse, 0, 0)  // Move para o inicio do arquivo.
Return(nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FEOF     บ Autor ณ Felipe Raposo      บ Data ณ  02/10/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retorna .T. se o arquivo estiver no final.                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FEOF()
Return(_nPosAtu >= _nPosFim .and. empty(_cBuffer))


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FRecNo   บ Autor ณ Felipe Raposo      บ Data ณ  02/10/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retona a linha em que o ponteiro do arquivo texto esta.    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FRecNo()
Return(_nRecNo)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FReadLN  บ Autor ณ Felipe Raposo      บ Data ณ  02/10/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Efetua a leitura da linha corrente do arquivo. Dependendo  บฑฑ
ฑฑบ          ณ do parametro, tambem posiciona na linha posterior.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ _lSkip - vai para a proxima linha ao efetuar a leitura da  บฑฑ
ฑฑบ          ณ          linha corrente (padrao .T.)                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ String com o conteudo da linha corrente do arquivo texto.  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FReadLN(_lSkip)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FSkip    บ Autor ณ Felipe Raposo      บ Data ณ  22/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Pula para a proxima linha do arquivo texto.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ LeArq    บ Autor ณ Felipe Raposo      บ Data ณ  18/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Le o arquivo texto ate encontrar uma quebra de linha, ou   บฑฑ
ฑฑบ          ณ chegar ao fim do arquivo.                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function LeArq()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuTamLin บ Autor ณ Felipe Raposo      บ Data ณ  22/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Calcula o tamanho otimizado do buffer de leitura, de acordoบฑฑ
ฑฑบ          ณ com o historico do arquivo, utilizando a media do tamanho  บฑฑ
ฑฑบ          ณ das linhas e o desvio padrao.                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TiraAct  บ Autor ณ Felipe Raposo      บ Data ณ  04/12/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Tira os acentos do texto passado por parametro.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function TiraAct(_cTexto)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local _cRet
Local _nAux1, _nAux2, _cAux1, _cAux2, _cAux3, _aAux1

// Trata os acentos do texto que sera exibido no console.
_aAux1 := {;
{"แเใโไ", "a"},;
{"็",     "c"},;
{"้่๊๋",  "e"},;
{"ํ์๎๏",  "i"},;
{"๑",     "n"},;
{"๓๒๕๔๖", "o"},;
{"๚๙๛ü",  "u"},;
{"มภรยฤ", "A"},;
{"ว",     "C"},;
{"ษศสห",  "E"},;
{"อฬฮฯ",  "I"},;
{"ั",     "N"},;
{"ำาีิึ", "O"},;
{"ฺูÛÜ",  "U"}}

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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ MsgTela  บ Autor ณ Felipe Raposo      บ Data ณ  18/11/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Exibe a mensagem passada por parametro na tela, no console บฑฑ
ฑฑบ          ณ e grava no log.                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ _cMsg     - Mensagem a ser exibida.                        บฑฑ
ฑฑบ          ณ _cTitle   - Titulo da mensagem.                            บฑฑ
ฑฑบ          ณ _cTipo    - Tipo da mensagem.                              บฑฑ
ฑฑบ          ณ _nHdPar   - Numero do arquivo de log aberto com fOpen().   บฑฑ
ฑฑบ          ณ _cProgPar - Nome do programa.                              บฑฑ
ฑฑบ          ณ _lScrPar  - Exibe a mensagem na tela (padrao .T.)          บฑฑ
ฑฑบ          ณ _lSrvPar  - Exibe a mensagem no console (padrao .T.)       บฑฑ
ฑฑบ          ณ _lLogPar  - Grava a mensagem no arquivo log (padrao .T.)   บฑฑ
ฑฑบ          ณ _lIncPar  - Exibe a mensagem na regua de progressao        บฑฑ
ฑฑบ          ณ             (padrao .T.)                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ A mensagem e o tipo da mensagem sao os unicos parametros   บฑฑ
ฑฑบ          ณ obrigatorios.                                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบObservacaoณ A variavel _lTela podera ser criada como Private ou Public,บฑฑ
ฑฑบ          ณ pela funcao chamadora, para informar `a funcao se as mensa-บฑฑ
ฑฑบ          ณ gens devem aparecer na tela (.T.) ou somente em logs e     บฑฑ
ฑฑบ          ณ console (.F.).                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function MsgTela(_cMsg, _cTitle, _cTipo, _nHdPar, _cProgPar, _lScrPar, _lSrvPar, _lLogPar, _lIncPar)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GetcBox  บ Autor ณ Felipe Raposo      บ Data ณ  12/08/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retorna o texto correspondente a letra ou numero de um     บฑฑ
ฑฑบ          ณ campo combo-box, de acordo com as configuracoes no dicio-  บฑฑ
ฑฑบ          ณ nario de dados (SX3->X3_CBOX).                             บฑฑ
ฑฑบ          ณ Exemplos:                                                  บฑฑ
ฑฑบ          ณ U_GetcBox("A1_TIPO", "R")  -> Retorno: "Revendedor"        บฑฑ
ฑฑบ          ณ U_GetcBox("F1_TIPO", "B")  -> Retorno: "Beneficiamento"    บฑฑ
ฑฑบ          ณ X3Combo("A1_TIPO", "R")    -> Retorno: "Revendedor"        บฑฑ
ฑฑบ          ณ X3Combo("F1_TIPO", "B")    -> Retorno: "Beneficiamento"    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ณ _cCampo - campo que contem o combo de opcoes.              บฑฑ
ฑฑบ          ณ _cOpc   - opcao selecionada.                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Retorna a descricao da opcao passada por parametro.        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบObservacaoณ Descobri no sistema a funcao X3Combo(_cCampo, _cOpc) com a บฑฑ
ฑฑบ          ณ mesma sintaxe da funcao U_GetcBox(_cCampo, _cOpc).         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function GetcBox(_cCampo, _cOpc)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CtoA     บ Autor ณ Felipe Raposo      บ Data ณ  17/09/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Transforma texto, formado por itens separados por algum    บฑฑ
ฑฑบ          ณ delimitador qualquer, em uma matriz.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ O limitador de palavras podera ser definido pelo usuario e บฑฑ
ฑฑบ          ณ passado por parametro. O padrao eh uma virgula e ponto e   บฑฑ
ฑฑบ          ณ virgula.                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ณ _cTexto - texto que sera convertido em matriz.             บฑฑ
ฑฑบ          ณ _cDelim - caracter delimitador de campos. Se nao passado,  บฑฑ
ฑฑบ          ณ           o sistema assumira virgula ou ponto-virgula.     บฑฑ
ฑฑบ          ณ _lRetAspas - informe ao sistema se devera retirar as aspas บฑฑ
ฑฑบ          ณ              do caracter. Se nao for para retirar, o sis-  บฑฑ
ฑฑบ          ณ              tema retornara os item com as aspas juntas. O บฑฑ
ฑฑบ          ณ              padrao eh .T. (verdadeiro).                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Uma matriz contendo itens do tipo caracter, onde cada item บฑฑ
ฑฑบ          ณ eh um trecho do texto passado, separado pelo delimitador.  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CtoA(_cTexto, _cDelim, _lRetAspas)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ TxtFrm   บ Autor ณ Felipe Raposo      บ Data ณ  25/01/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Preenche o valor passado por parametro, com caracteres,    บฑฑ
ฑฑบ          ณ ate que se atinja o tamanho desejado. O caracter padrao de บฑฑ
ฑฑบ          ณ preenchimento eh espaco em branco. O alinhamento padrao do บฑฑ
ฑฑบ          ณ valor eh a esquerda (com caracteres a direita).            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ _uValor - valor a receber os caracteres de preenchimento.  บฑฑ
ฑฑบ          ณ _nTam   - tamanho da cadeia de strings que devera ser re-  บฑฑ
ฑฑบ          ณ           tornada (valor + preenchimento).                 บฑฑ
ฑฑบ          ณ Paramentros opcionais:                                     บฑฑ
ฑฑบ          ณ _cRech  - caracter de preenchimento. O padrao sao caracte- บฑฑ
ฑฑบ          ณ           res em branco.                                   บฑฑ
ฑฑบ          ณ _cPos   - alinhamento do valor (D=direito / E=esquerdo). O บฑฑ
ฑฑบ          ณ           padrao eh alinhamento a esquerda.                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ A cadeia de caracteres, de acordo com os parametros passa- บฑฑ
ฑฑบ          ณ dos.                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function TxtFrm(_uValor, _nTam, _cRech, _cPos)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis.                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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