#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

User Function INTERN()        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP6 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("AFILES,NX,_NI,AITENS,CFILE,CTEXTO")
SetPrvt("J,CLINE,CCODCLI,CLOJACLI,CNOMECLI,CENDCLI")
SetPrvt("CMUNCLI,CESTCLI,CCEPCLI,CTELCLI,CFAXCLI,CMAILCLI")
SetPrvt("CCONTCLI,CCGCCLI,CVENDEDO,CPRODUTO,NQUANT,CUM")
SetPrvt("NPRUNIT,NPRTOT,CPEDIDO,I,")

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿔NTERNET  � Autor � Wagner Xavier         � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o 쿏emostracao de comunicacao com a internet                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      쿝DMake <Programa.Ext> -w                                    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Exemplo  쿝DMake RDDemo.prw -w                                        낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
@0,0 TO 380,520 DIALOG oDlg TITLE "Comunica뇙o com INTERNET"
@10,10 BITMAP SIZE 110,40 FILE "RDDEMO.BMP"
@60,5 TO 165,255
@075,010 Say "Este Programa Exemplo serve como demonstra뇙o do SIGA ADVANCED conectado a"
@085,010 Say "INTERNET, sendo que este tem por objetivo buscar os E-MAILS vinculados ao usu쟲io"
@095,010 Say "que deve ser configurado nos parametros a serem passados na fun뇙o RXMESSAGE que est�"
@105,010 Say "dispon죞el para uso em programas RDMAKE. O Exemplo aqui a ser mostrado � de gera뇙o de "
@115,010 Say "Pedidos de Venda a partir de alguns E-MAILS j� colocados previamente em nosso Site SNET,"
@125,010 Say "� importante salientar que dever꼘 ser customizadas as p쟥inas tanto no SITE de acesso,"
@135,010 Say "como no Rdmake, afinal estas devem ser personalizadas de acordo com a necessidade de "
@145,010 Say "cada um dos usu쟲ios."
@172,190 BMPBUTTON TYPE 2 ACTION Close(oDlg)
@172,218 BMPBUTTON TYPE 1 ACTION GeraPed()// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> @172,218 BMPBUTTON TYPE 1 ACTION Execute(GeraPed)
ACTIVATE DIALOG oDlg CENTERED
Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿒eraPed   � Autor �                       � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o 쿝otina para gera뇙o do pedido de vendas com a InterNet      낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      쿝DMake <Programa.Ext> -w                                    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Exemplo  쿝DMake RDDemo.prw -w                                        낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

// Substituido pelo assistente de conversao do AP6 IDE em 22/12/04 ==> Function GeraPed
Static Function GeraPed()

aFiles := RxMessage("\SIGAADV\EMAIL","advanced","siga0000","snet.com.br")
nx:=0

SetRegua(Len(aFiles))

For _ni:= 1 to Len(aFiles)

    aItens := {}
    IncRegua()

    cFile := aFiles[_ni]
    cTexto := MemoRead(cFile)
    For j:=1 To MlCount(cTexto,200)             // 200 Maior Linha ??
        cLine:=MemoLine(cTexto,200,j)
        If Upper(SubStr(cLine,1,6)) == "CODIGO"
            cCodCli := UPPER(Alltrim(SubStr(cLine,9,6)))
        Elseif Upper(SubStr(cLine,1,4)) == "LOJA"
            cLojaCli:= Alltrim(SubStr(cLine,7,2))
        Elseif Upper(SubStr(cLine,1,4)) == "NOME"
            cNomeCli := Alltrim(SubStr(cLine,7,40))
        Elseif Upper(SubStr(cLine,1,8)) == "ENDERECO"
            cEndCli := Alltrim(SubStr(cLine,12,40))
		Elseif Upper(SubStr(cLine,1,9)) == "MUNICIPIO"
			cMunCli := Alltrim(SubStr(cLine,12,20))
		Elseif Upper(SubStr(cLine,1,6)) == "ESTADO"
			cEstCli := Alltrim(SubStr(cLine,1,2))
		Elseif Upper(SubStr(cLine,1,3)) == "CEP"
			cCepCli := Alltrim(SubStr(cLine,6,9))
		Elseif Upper(SubStr(cLine,1,3)) == "TEL"
			cTelCli := Alltrim(SubStr(cLine,6,9))
		Elseif Upper(SubStr(cLine,1,3)) == "FAX"
			cFaxCli := Alltrim(SubStr(cLine,6,15))
		Elseif Upper(SubStr(cLine,1,6)) == "E-MAIL"
			cMailCli := Alltrim(SubStr(cLine,9,15))
		Elseif Upper(SubStr(cLine,1,7)) == "CONTATO"
			cContCli := Alltrim(SubStr(cLine,10,20))
		Elseif Upper(SubStr(cLine,1,7)) == "CGC/CPF"
			cCgcCli := Alltrim(SubStr(cLine,10,20))
		Elseif Upper(SubStr(cLine,1,8)) == "VENDEDOR"
			cVendedo:= UPPER(Alltrim(SubStr(cLine,11,6)))
		Elseif Upper(SubStr(cLine,1,7)) == "PRODUTO"
			cProduto:= Alltrim(SubStr(cLine,10,15))
			Aadd(aItens,{ cProduto,0," ",0,0} )
			nX:=nX+1
		Elseif Upper(SubStr(cLine,1,10)) == "QUANTIDADE"
			nQuant := Val(SubStr(cLine,13,6))
			aItens[nX][2] := nQuant
		Elseif Upper(SubStr(cLine,1,2)) == "UN"
			cUM := SubStr(cLine,5,2)
			aItens[nX][3] := UPPER(cUM)
		Elseif Upper(SubStr(cLine,1,14)) == "PRECO UNITARIO"
			nPrUnit := Val(SubStr(cLine,17,6))
			aItens[nX][4] := nPrUnit
		Elseif Upper(SubStr(cLine,1,11)) == "PRECO TOTAL"
			nPrTot := Val(SubStr(cLine,14,6))
			aItens[nX][5] := nPrTot
		EndIf
	Next j

// se n꼘 ler nenhum produto, vou fixar 1 para que se possa 
// verificar o pedido gerado para efeito de demonstracao

	If Len(aItens) == 0
		Aadd(aItens,{ "PROD TESTE",1,"PC",1000,1000} )
	End

	If Len(aItens) > 0		//  se ha'produto
   	dbSelectArea("SB1")
		dbSetOrder(1)
		cPedido:=GetSX8Num("SC5")
		dbSelectArea("SC5")
		RecLock("SC5",.T.)
		Replace C5_FILIAL 	With xFilial()
		Replace C5_NUM    	With cPedido     
		Replace C5_TIPO   	With "N"
		Replace C5_CLIENTE	With cCodCli
		Replace C5_LOJAENT 	With cLojaCli
		Replace C5_LOJACLI 	With cLojaCli
      Replace C5_VEND1    With cVendedo
		MsUnlock()
		For i:=1 to Len(aItens)
			dbSelectArea("SB1")
			dbSeek(xFilial()+aItens[i,1])
			RecLock("SC6",.T.)
			Replace C6_FILIAL 	With xFilial()
			Replace C6_ITEM    	With StrZero(i,2)     
            Replace C6_PRODUTO  With aItens[i,1]
				Replace C6_QTDVEN 	With aItens[i,2]
            Replace C6_UM       With aItens[i,3]
				Replace C6_PRCVEN 	With aItens[i,4]
            Replace C6_VALOR    With aItens[i,5]
            Replace C6_CLI      With cCodCli
            Replace C6_NUM      With cPedido
            Replace C6_TES      With SB1->B1_TS
			MsUnlock()
		Next i
		nx:=0
		aItens:={}
    End
Next _ni	


Return(nil)        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

