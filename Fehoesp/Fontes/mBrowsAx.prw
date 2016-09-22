///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | MBrowse_Ax.prw       | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - mBrowsAx()                                             |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Demonstracao da utilizacao das funcoes Ax e mBrowse             |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

/*
+------------------------------------------------------------------------------
| Parâmetros dos Ax...()
+------------------------------------------------------------------------------
| AxVisual(cAlias,nReg,nOpc,aAcho,nColMens,cMensagem,cFunc,aButtons)
| AxAltera(cAlias,nReg,nOpc,aAcho,aCpos,nColMens,cMensagem,cTudoOk,cTransact,cFunc,aButtons)
| AxInclui(cAlias,nReg,nOpc,aAcho,cFunc,aCpos,cTudoOk,lF3,cTransact,aButtons)
| AxDeleta(cAlias,nReg,nOpc,cTransact,aCpos,aButtons)
+------------------------------------------------------------------------------
| Func      - Função chamado antes de montar a tela - nenhum retorno esperado
| cTudoOk   - Ao clicar no Ok, esperado .T. ou .F.
| cTransact - Função chamado depois da gravação dos dados - nenhum retorno esperado
| aAcho     - Campos visiveis
| aCpos     - Campos alteraveis
| aButtons  - {{"BMP",{||UserFunc()},"LegendaMouse"}}
| nColMens  - Parametro invalido
| cMensagem - Parametro invalido
| lF3       - Parametro invalido
+------------------------------------------------------------------------------

+------------------------------------------------------------------------------
| Parâmetros do mBrowse()
+------------------------------------------------------------------------------
| mBrowse( uPar1, uPar2, uPar3, uPar4, cAlias, aFixos, cCpo, uPar5, cFunc, ;
|          nPadrao, aCores, cExpIni, cExpFim, nCongela )
+------------------------------------------------------------------------------
| uPar1....: Não obrigatório, parâmetros reservado
| uPar2....: Não obrigatório, parâmetros reservado
| uPar3....: Não obrigatório, parâmetros reservado
| uPar4....: Não obrigatório, parâmetros reservado
| cAlias...: Alias do arquivo a ser visualizado no browse
| aFixos...: Contendo os nomes dos campos fixos pré-definidos pelo programador,
|            obrigando a exibição de uma ou mais colunas
|            Ex.: aFixos := {{ "??_COD",  Space(6) },;
|                            { "??_LOJA", Space(2) },;
|                            { "??_NOME", Space(30) }}
| cCpo.....: Campo a ser validado se está vazio ou não para exibição do bitmap de status
| uPar5....: Não obrigatório, parâmetros reservado
| cFunc....: Função que retornará um valor lógico para exibição do bitmap de status
| nPadrao..: Número da rotina a ser executada quando for efetuado um duplo clique 
|            em um registros do browse. Caso não seja informado o padrão será executada 
|            visualização ou pesquisa
| aCores...: Este vetor possui duas dimensões, a primeira é a função de validação 
|            para exibição do bitmap de status, e a segunda o bitmap a ser exibido
|            Ex.: aCores := {{ "??_STATUS == ' ', "BR_VERMELHO" },;
|                            { "??_STATUS == 'S', "BR_VERDE"    },;
|                            { "??_STATUS == 'N', "BR_AMARELO"  }}
| cExpIni..: Função que retorna o conteúdo inicial do filtro baseada na chave de índice selecionada
| cExpFim..: Função que retorna o conteúdo final do filtro baseada na chave de índice selecionada
| nCongela.: Coluna a ser congelado no browse
+------------------------------------------------------------------------------
*/

#include "protheus.ch"

User Function mBrowsAx()

Private cAlias := "SZ8"
Private aRotina   := {}
Private aSubRotina := {}
Private lRefresh  := .T.
Private cCadastro := "Manutenção - Cadastro de Empresas"
Private aButtons := {}
Private oMenu

aAdd(aButtons,{"PESQUISA"  ,{||AtivaMenu()},"Confirma Alterações"})
aAdd(aButtons,{"PARAMETROS",{||AtivaMenu()},"Cancela Alterações"})


aAdd( aRotina, {"Incluir"   ,'AxInclui(cAlias,RecNo(),3,,,,,,,aButtons)',0,1} )
aAdd( aRotina, {"Alterar"   ,'AxAltera(cAlias,RecNo(),4)',0,2} )

dbSelectArea(cAlias)
dbSetOrder(1)

mBrowse(,,,,cAlias)

Return

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | MBrowse_Ax.prw       | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - mBrowDel()                                             |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Exclui o registro em questao                                    |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
User Function mBrowDel(cAlias,nReg,nOpc)
Local nOpcA := 0
Local lDelSE5 := .F.
Local lDelSEF := .F.

nOpcA := AxVisual(cAlias,nReg,2)

If nOpcA == 1
   dbSelectArea("SE5")
   dbSetOrder(3)
   lDelSE5 := dbSeek(xFilial("SE5")+SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON)

   dbSelectArea("SEF")
   dbSetOrder(1)
   lDelSEF := dbSeek(xFilial("SEF")+SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON)
   
   If ! lDelSE5 .And. ! lDelSEF
      Begin Transaction
      DbSelectArea(cAlias)
      RecLock(cAlias,.F.)
      dbDelete()
      MsUnLock()
      End Transaction
   Else
      Help("",1,"","mBrowDel","Não é possível a exclusão, este banco já foi movimentado",1,0)
   Endif
Endif

Return

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | MBrowse_Ax.prw       | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - AtivaMenu()                                            |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Ativa o menu no botão                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
Static Function AtivaMenu()
Local oWnd
oWnd := GetWndDefault()
oMenu:Activate(395,41,oWnd)
//oMenu:Activate(270,25,oWnd)
Return

