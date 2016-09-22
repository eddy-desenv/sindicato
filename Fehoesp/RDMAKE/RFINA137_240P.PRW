#include "rwmake.ch"

User Function RFINA137A()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RFINA137  ºAutor  ³       Nava         º Data ³   22/07/08  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Envio/Preparacao de Contribuicoes Confederativa CEF         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Especifico SINDHOSP                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

LOCAL aArea 	:= GetArea()
LOCAL cTitulo  := "Cobranca Confederativa"
LOCAL nOpc     := 0

PRIVATE cPerg := "FINA37"
PRIVATE cConta, cAgenc, oDlg1

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                                       ³
³ mv_par01   // ano para envio   N2                                          ³
³ mv_par02   // Parcela          C1                                          ³
³ mv_par03   // Data de vencimento                                           ³
³ mv_par04   // Data de Emissao                                              ³
³ mv_par05   // Sequencia                                                    ³
³ mv_par06   // arquivo de saida 					     								  ³
³ mv_par07   // Codigo do Banco                                              ³
³ mv_par08   // codigo da agencia                                            ³
³ mv_par09   // Codigo da conta                                              ³
³ mv_par10   // codigo da subconta                                           ³
³ mv_par11   // destinatario - Entidades, Escritorios , Reenvio 	           ³
³            // destinatario - Reenvio Entidades, Reenvio Escritorios 	     ³
³ mv_par12   // 1A. msg	     c12				                    	              ³
³ mv_par13   // 2A. msg	- PARTE 1   c30				 	                       ³
³ mv_par14   // 2A. msg	- PARTE 2   c30				 	                       ³
³ mv_par15   // Base Territorial para envio			 	                       ³
³ mv_par16   // Prefixo/Ano da parcela a considerar baixa	                 ³
³ mv_par17   // Parcela a considerar baixa			 	                       ³
³ mv_par18   // Arq. para Mala Direta			 	                             ³
³ mv_par19   // Prefixo/Ano da 2a. parcela a considerar baixa	              ³
³ mv_par20   // 2a. Parcela a considerar baixa			 	                    ³
³ mv_par21   // Data de Cadastro                                             ³
³ mv_par22   // Codigo Sindicato                                             ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Pergunte(cPerg,.T.)

@ 096,042 TO 375,505 DIALOG oDlg1 TITLE cTitulo
@ 008,010 TO 100,222
@ 023,014 SAY "Este programa fara a geracao de Arquivo para cobranca da "
@ 033,014 SAY "Contribuicao Confederativa DA CEF"
@ 063,014 SAY "CONFIRME PARA INICIAR A GERACAO DE DADOS         "
@ 110,138 BMPBUTTON TYPE 1 ACTION Iniciar()
@ 110,168 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)
@ 110,198 BMPBUTTON TYPE 2 ACTION Close(oDlg1)

RestArea( aArea )

ACTIVATE DIALOG oDlg1 CENTERED



Return
*************************
Static Function Iniciar()

Close(oDlg1)
Processa( {|| Gerar() })

Return
*************************

Static Function Gerar()

LOCAL aStru
LOCAL cAgenc 	:= Strzero( Val( mv_par08 ), 5 )	
LOCAL cConta 	:= SUBSTR( Rtrim( mv_par09 ), 1, Len( Rtrim ( mv_par09 ) ) - 2 ) + RIGHT( Rtrim( mv_par09 ), 1 )
LOCAL dVenc 	:= strzero(day(mv_par03),2)+strzero(month(mv_par03),2)+strzero(year(mv_par03),4)
LOCAL dEmis 	:= strzero(day(mv_par04),2)+strzero(month(mv_par04),2)+strzero(year(mv_par04),4)

PRIVATE cArqTmp0, cArqTmp1, cArqTmp2, cArqTmp3, cArqTmp4, cArqTmp5, cArqTmp6, cArqTmp7, cArqTmp8, cArqTmp9

/*

N. SINDICATO 									BANCO AGÊNCIA OPERAÇÃO C/C 
1 	SINDHOSPRU - PRESIDENTE PRUDENTE 	104 		0242 	003 		00000973-4 
2 	SINDHORP - RIBEIRÃO PRETO 				104 		0242 	003 		AINDA NÃO TEMOS 
3 	SINDHOSCLAB-MOGI - MOGI DAS CRUZES 	104 		0242 	003 		00000974-2 
4 	SINDHOSPCLAB-JUNDIAI - JUNDIAI 		104 		0242 	003 		AINDA NÃO TEMOS 
5 	SINDHOSCLAB-SUZANO - SUZANO 			104 		0242 	003 		AINDA NÃO TEMOS 

========================== 

Registro Header de Arquivo
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.0 Codigo do Banco na Compensação |  1|  3|  3| - |   Num | '104'   |  G001
02.0 Lote de Serviço                   4   7   4  - |   Num | '0000'  | *G002
03.0 Tipo de Registro                  8   8   1  - |   Num | '0'     | *G003
04.0 Uso Exclusivo FEBRABAN/CNAB       9  17   9  - |  Alfa | Brancos |  G004
05.0 Tipo de Inscrição da Empresa     18  18   1  - |   Num | '2'     | *G005 // CNPJ
06.0 Numero de Inscrição da Empresa   19  32  14  - |   Num |         | *G006 // Numero CNPJ
07.0 Uso Exclusivo CAIXA              33  52  20 -  |   Num | '0'     | 
08.0 Código Agênciada Conta           53  57   5 -      Num |         | *G008
09.0 Dígito Verificador da Agência    58  58   1 -     Alfa |         | *G009
10.0 Código do Convênio no Banco      59  64   6 -      Num |         | *G007
11.0 Uso Exclusivo CAIXA 				  65  71   7 -      Num | '0'     |
12.0 Uso Exclusivo CAIXA 				  72  72   1 -      Num | '0'     |
13.0 Nome da Empresa                  73 102  30 -     Alfa              G013
14.0 Nome do Banco                   103 132  30 -     Alfa              G014
15.0 CNAB Uso Exclusivo FEBRABAN     133 142  10 -     Alfa   Brancos    G004
16.0 Código Remessa / Retorno        143 143   1 -      Num              G015
17.0 Data de Geração do Arquivo      144 151   8 -      Num              G016
18.0 Hora de Geração do Arquivo      152 157   6 -      Num              G017
19.0 Numero Seqüencial do Arquivo    158 163   6 -      Num             *G018
20.0 No da Versão Layout do Arquivo  164 166   3 -      Num   '050'     *G019
21.0 Densidade de Gravação Arquivo   167 171   5 -      Num   '0'        G020
22.0 Para Uso Reservado do Banco     172 191  20 -     Alfa              G021
23.0 Para Uso Reservado da Empresa   192 211  20 -     Alfa              G022
24.0 Versão Aplicativo CAIXA         212 215   4 -     Alfa              C077
25.0 Uso Exclusivo FEBRABAN / CNAB   216 240  25 -     Alfa Brancos      G004
*/

aStru 	:= {} // Registro Header de Arquivo

AADD( aStru, { "COD_BANCO"  	, "C" , 003 , 0 } ) // 01
AADD( aStru, { "LOTE"  			, "C" , 004 , 0 } ) // 02
AADD( aStru, { "TIPO_REGI" 	, "C" , 001 , 0 } ) // 03
AADD( aStru, { "BRANCO1" 		, "C" , 009 , 0 } ) // 04
AADD( aStru, { "TIPO_INSC"  	, "C" , 001 , 0 } ) // 05
AADD( aStru, { "NUM_INSC"  	, "C" , 014 , 0 } ) // 06
AADD( aStru, { "ZERO1" 			, "C" , 020 , 0 } ) // 07
AADD( aStru, { "COD_AGENC"		, "C" , 005 , 0 } ) // 08
AADD( aStru, { "DAC_AGENC"		, "C" , 001 , 0 } ) // 09
AADD( aStru, { "CONVENIO"   	, "C" , 006 , 0 } ) // 10
AADD( aStru, { "ZERO2"    		, "C" , 007 , 0 } ) // 11
AADD( aStru, { "ZERO3"     	, "C" , 001 , 0 } ) // 12
AADD( aStru, { "NOME_EMP"  	, "C" , 030 , 0 } ) // 13
AADD( aStru, { "NOME_BAN"  	, "C" , 030 , 0 } ) // 14
AADD( aStru, { "BRANCO2"    	, "C" , 010 , 0 } ) // 15
AADD( aStru, { "COD_REMRET" 	, "C" , 001 , 0 } ) // 16
AADD( aStru, { "DATA_GERA" 	, "C" , 008 , 0 } ) // 17
AADD( aStru, { "HORA_GERA" 	, "C" , 006 , 0 } ) // 18
AADD( aStru, { "NUM_SEQUEN" 	, "C" , 006 , 0 } ) // 19
AADD( aStru, { "NUM_VERSAO" 	, "C" , 003 , 0 } ) // 20
AADD( aStru, { "DENSIDADE" 	, "C" , 005 , 0 } ) // 21
AADD( aStru, { "RESERVA_1" 	, "C" , 020 , 0 } ) // 22
AADD( aStru, { "RESERVA_2" 	, "C" , 020 , 0 } ) // 23
AADD( aStru, { "VERSAO_APL" 	, "C" , 004 , 0 } ) // 24
AADD( aStru, { "BRANCO3" 		, "C" , 025 , 0 } ) // 25

cArqTmp1	:= CriaTrab( aStru, .T. )
dbUseArea( .T.,, cArqTmp1, "HEAD_FILE")

/*
======================================================================================
G - Campos Genéricos
======================================================================================
G001 - Código do Banco na Compensação	- '104'
G002 - Lote de Serviço - Se Header '0'
G003 - Tipo de Registro - Se Header '0'
G004 Uso Exclusivo FEBRABAN / CNAB  - Brancos
G005 Tipo de Inscrição da Empresa ou Pessoa Física = Se CNPJ '2'
G006 Numero de Inscrição da Empresa ou Pessoa Física
G007 Código do Convênio no Banco (Código do Cedente)
G008 Agência Mantenedora da Conta Tamanho 5 posições. Preencher com zero a esquerda.
G009 Dígito Verificador da Agência(Calculado pelo módulo 11)
G010 Número da Conta Corrente - Preencher com zeros à esquerda.
G011 Dígito Verificador da Conta. Deverá ser Calculado através do módulo 11.
		Exemplo de como calcular o DV da Conta Corrente:
		Conta Corrente:: 000000109990
		0 0 0 0 0 0 1 0  9  9  9 0
		5 4 3 2 9 8 7 6  5  4  3 2
		0 0 0 0 0 0 7 0 45 36 27 0
		1ª linha – Conta Corrente (12 posições – preencher com zeros à esquerda)
		2ª linha – Índice Multiplicação (preencher seqüencialmente de 2 a 9 da direita p/a esquerda)
		3ª linha – Multiplicação Coluna por Coluna
		Soma-se os valores da 3ª linha: 0+0+0+0+0+0+7+0+45+36+27+0 = 115
		Dividir o resultado da soma por onze: 115/11 = 10 (RESTO 5)
		Subtrair onze pelo resto da divisão: 11 – 5 = 6
		O dígito calculado é 6
		Obs.: Se o resultado da subtração for maior que 9 (nove) o dígito será 0 (zero)
G012  Dígito Verificador da Agência / Conta Corrente. Deverá ser calculado através do módulo 11.
		Exemplo de como calcular o DV da Agência/Conta Corrente:
		Agência/Conta Corrente: 0161.000000109990
		Agência (sem DV): 0161
		Conta Corrente (sem operação e sem DV): 000000109990 (tamanho 12 – preencher com zeros à esquerda)
		0 1 6 1 0 0 0 0 0 0 1 0 9 9 9 0
		9 8 7 6 5 4 3 2 9 8 7 6 5 4 3 2
		0 8 42 6 0 0 0 0 0 0 7 0 45 36 27 0
		1ª linha – Agência/Conta Corrente
		2ª linha – Índice Multiplicação (preencher seqüencialmente de 2 a 9 da direita p/a esquerda)
		3ª linha – Multiplicação Coluna por Coluna
		Soma-se os valores da 3ª linha: 0+8+42+6+0+0+0+0+0+0+7+0+45+36+27+0 = 171
		Dividir o resultado da soma por onze: 171/11 = 15 (RESTO 6)
		Subtrair onze pelo resto da divisão: 11 – 6 = 5
		O dígito calculado é 5
		Obs.: Se o resultado da subtração for maior que 9 (nove) o dígito será 0 (zero)
G013 Nome da Empresa (cliente)
		Nome que identifica a pessoa, física ou jurídica, a qual se quer fazer referência.
G014 Nome do Banco - Informar: CAIXA ECONOMICA FEDERAL
G015 Código Remessa / Retorno
		Código adotado pela FEBRABAN para qualificar o envio ou devolução de arquivo entre a Empresa Cliente
		e o Banco prestador dos Serviços. Informar:
		'1' = Remessa (Cliente .. Banco)
		'2' = Retorno (Banco .. Cliente)
		'3' = Remessa Processada (Banco .. Cliente - Pré-crítica)
		'4' = Remessa Processada Parcial (Banco .. Cliente - Pré-crítica)
		'5' = Remessa Rejeitada (Banco .. Cliente - Pré-crítica)
G016 Data de Geração do Arquivo
		Data da criação do arquivo. Utilizar o formato DDMMAAAA, onde :
		DD = dia
		MM = mês
		AAAA = ano
G017 Hora de Geração do Arquivo
		Hora da criação do arquivo. Utilizar o formato HHMMSS, onde:
		HH = hora
		MM = minuto
		SS = segundo
		G017
G018  Número Seqüencial do Arquivo
		Número seqüencial adotado e controlado pelo responsável pela geração do arquivo para ordenar a
		disposição dos arquivos encaminhados.
		Evoluir um número seqüencial a cada header de arquivo.
G019  Nmero da Versão do Layout do Arquivo
		Código adotado pela FEBRABAN para identificar qual a versão de layout do arquivo encaminhado. O código
		é composto de:
		Versão = 2 dígitos
		Release = 1 dígito
		G019
G020 Densidade de Gravação do Arquivo
		Densidade de gravação (BPI), do arquivo encaminhado.
		Não utilizado na cobrança eletrônica, informar fixo '0'.
G021 Para Uso Reservado do Banco
		Texto de observações destinado para uso exclusivo da CAIXA ECONÔMICA FEDERAL, para informar o
		status do cedente no arquivo retorno:
		- Durante a fase de testes (simulado) conterá a literal ‘RETORNO-TESTE’
		- Estando em produção conterá a literal ‘RETORNO-PRODUÇÃO’
		Para arquivo Retorno Pré-Crítica conterá:
		- Durante a fase de testes (simulado): brancos
		- Remessa em Produção Processada Total: literal ‘REMESSA PROCESSADA‘
		- Remessa em Produção Processada Parcial: literal ‘REMESSA PROCESSADA P’
		- Remessa em Produção Rejeitada: literal ‘REMESSA REJEITADA’
		Obs.: após a alteração da situação do cedente de TESTE para PRODUÇÃO não haverá a possibilidade de
		retorno ao status de simulação.
G022 Para Uso Reservado da Empresa
		Campo a ser utilizado pelo cliente/cedente, para informação da situação da remessa que está sendo
		enviada à CAIXA:
		- Na fase de testes (simulado), conterá a literal ‘REMESSA-TESTE’
		- Estando em produção conterá a literal ‘REMESSA-PRODUÇÃO’
		Obs.: após a alteração da situação do cedente de TESTE para PRODUÇÃO não haverá a possibilidade de
		retorno ao status de simulação.
G025  Tipo de Serviço
		Código adotado pela FEBRABAN para indicar o tipo de serviço / produto (processo) contido no arquivo /
		lote. Domínio:
		'01' = Cobrança
		'02' = Cobrança Sem Registro / Serviços
		'03' = Desconto de Títulos
		'04' = Caução de Títulos
		G025
G028  Tipo de Operação
		Código adotado pela FEBRABAN para identificar a transação que será realizada com os registros detalhe
		do lote. Domínio:
		'R' = Arquivo Remessa
		'T' = Arquivo Retorno
G030	Número da Versão do Layout do Lote
		Identifica qual a versão de layout do lote de arquivo encaminhado. O código é composto de: Versão = 2 dígitos Release = 1 dígito
G032 	Endereço - Texto referente a localização da rua / avenida, número, complemento e bairro utilizado para entrega de correspondência.
		Utilizado também para endereço de e-mail para entrega eletrônica da informação e para número de celular para envio de mensagem SMS.
		Utilizar também quando o código de movimento for igual a 35, 36, 37 ou 38 (Banco de Sacados)
G033 	Cidade - Texto referente ao nome do município componente do endereço utilizado para entrega de correspondência.
G034 	CEP - Código adotado pelos CORREIOS para identificação de logradouros.
G035 	Sufixo do CEP - Código adotado pelos CORREIOS para complementação do código de CEP.
G036 	Estado / Unidade da Federação - Código do estado, unidade da federação componente do endereço utilizado para entrega de correspondência.
G038	Número Seqüencial do Registro no Lote - Número para identificar a seqüência de registros encaminhados no lote. - Deve ser inicializado sempre em ‘1’, em cada novo lote.
G039 	Código de Segmento do Registro Detalhe - Código adotado pela FEBRABAN para identificar o segmento do registro. Informar de acordo com que solicita a coluna default de cada segmento.
G045 	Valor do Abatimento - Valor do abatimento (redução do valor do documento, devido a algum problema), expresso em moeda corrente.
G049 	Quantidade de Lotes do Arquivo - Número obtido pela contagem dos lotes enviados no arquivo. Somatória dos registros de tipo 1, incluindo header e trailer.
G056 	Quantidade de Registros do Arquivo - Número obtido pela contagem dos registros enviados no arquivo. Somatória dos registros de tipo 0, 1, 3, 5 e 9.
G057 	Quantidade de Registros do Lote - Número obtido pela contagem dos registros enviados no lote do arquivo. Somatória dos registros de tipo 1, 3, e 5.
G065	Código da Moeda - Código adotado pela FEBRABAN para identificar a moeda referenciada no Título. Informar fixo: '09' = REAL
G067 Identificação de Registro Opcional - Código adotado pela FEBRABAN para identificação de registros opcionais.
		'01' = Informação de dados do Sacador/Avalista
		'03' = Informação de dados do Sacado
		'08' = Serviços
		'50' = Informação de Dados para Rateio de Crédito
G067A	Identificação de Registro Opcional (Código do Bloqueto Personalizado)
		Id Modelo do Bloqueto
		Código de Modelo do Bloqueto Tipo de Registro
		02 - Modelo Padrão CAIXA
		10 - Genérico Modelo 01 1
		11 - Genérico Modelo 02 1
		12 - Condomínios 1,
		13 - Nota Fiscal 1, 2(*)
		14 - Consórcios 1, 2, 3, 4, 5
		18 - Similiar a Nota Fiscal 1, 2(*)
		19 - Seguradoras 1, 2(*), 3(*)
		21 - Escolas 1
		22 - Imobiliárias 1
		30 - Carnê 1
		(*) Indica que o registro pode ocorrer N vezes
G068 	Data de Gravação Remessa / Retorno
		Data da gravação do arquivo de remessa ou retorno. Utilizar o formato DDMMAAAA, onde :
		DD = dia
		MM = mês
		AAAA = ano
G069	Identificação do Título no Banco
		Número adotado pelo Banco Cedente para identificar o Título.
		Para código de movimento igual a '01' (Entrada de Títulos).
		1) Se a CAIXA for responsável pela emissão do bloqueto, o Nosso Número poderá ser preenchido com
		zeros (‘0’), nesse caso, a numeração será feita pelo Banco.
		2) Quando informado pelo cliente/cedente, o Nosso Número deverá obedecer o seguinte formato:
		CCNNNNNNNNNNNNNNN, onde:
		CC = 14 (para Modalidade Nosso Número Cobrança Registrada)
		CC = 24 (para Modalidade Nosso Número Cobrança Sem Registro)
		NNNNNNNNNNNNNNN = Número livre do cliente / cedente
		Obs.: O número livre do cliente / cedente NÃO poderá se repetir (deverá ser único), independente da
		modalidade;
		3) No caso de carnês, a numeração do Nosso Número deverá obedecer o seguinte formato:
		CCNNNNNNNNNNNNNSS, onde:
		CC = 14 (para Modalidade Nosso Número Cobrança Registrada)
		CC = 24 (para Modalidade Nosso Número Cobrança Sem Registro)
		NNNNNNNNNNNNNNN = Número sequencial
		SS = Seqüência da parcela (gerada pelo Sistema)
		Obs1: O cliente / cedente deverá informar somente o número seqüencial;
		Obs2: A seqüência das parcelas será gerada conforme a quantidade informada no segmento Y-08.
*/


/*
Registro Header de Lote
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.1 Código do Banco na Compensacao    1   3   3  -    Num      '104'       G001
02.1 Lote de Servico 						4 	 7   4  -    Num 						*G002
03.1 Tipo de Registro 						8 	 8   1  - 	 Num 		   '1'		*G003
04.1 Tipo de Operacao 						9 	 9   1  - 	Alfa 						*G028
05.1 Tipo de Serviço 					  10  11   2  -    Num                 *G025
06.1 CNAB Uso Exclusivo FEBRABAN/CNAB 12  13   2  -    Num       '00' 		 G004
07.1 Versão do Layout do Lote 		  14  16   3  - 	 Num 		 '030'      *G030
08.1 CNAB Uso Exclusivo FEBRABAN/CNAB 17  17   1  -   Alfa    Brancos       G004
09.1 Tipo de Inscrição da Empresa 	  18  18   1  -    Num                 *G005
10.1 Inscricao da Empresa 				  19  33  15  -    Num                 *G006
11.1 Código do Convênio no Banco 	  34  39   6  -    Num 						*G007
12.1 Uso Exclusivo CAIXA 				  40  53  14  -    Num        '0'
13.1 Código Agência da Conta 			  54  58   5  -    Num                 *G008
14.1 Dígito Verificador da Conta 	  59  59   1  -   Alfa 						*G011
15.1 Código do Convênio no Banco 	  60  65   6  -    Num 						*G007
16.1 Código do Modelo Personalizado   66  72   7  - 	 Num 						 C078
17.1 Uso Exclusivo CAIXA 				  73  73   1  -    Num 			'0'
18.1 Nome da Empresa 					  74 103  30  -   Alfa 						 G013
19.1 Mensagem 1 							 104 143  40  -   Alfa 						 C073
20.1 Mensagem 2 							 144 183  40  -   Alfa 						 C073
21.1 Numero Remessa/Retorno 			 184 191   8  -    Num 						 G079
22.1 Data Gravação Remessa/Retorno   192 199   8  -    Num 						 G068
23.1 Data do Crédito 					 200 207   8  -    Num 						 C003
24.1 Uso Exclusivo FEBRABAN/CNAB 	 208 240  33  -   Alfa    Brancos 		 G004
*/

aStru := {}  // Registro Header de Lote

AADD( aStru, { "COD_BANCO"		, "C" , 003 , 0 } ) // 01
AADD( aStru, { "COD_LOTE"		, "C" , 004 , 0 } ) // 02
AADD( aStru, { "TIPO_REGIS"	, "C" , 001 , 0 } ) // 03
AADD( aStru, { "TIPO_OPERA"	, "C" , 001 , 0 } ) // 04
AADD( aStru, { "TIPO_SERVI"	, "C" , 002 , 0 } ) // 05
AADD( aStru, { "ZERO1"			, "C" , 002 , 0 } ) // 06
AADD( aStru, { "LAYOUT"			, "C" , 003 , 0 } ) // 07
AADD( aStru, { "BRANCO1"		, "C" , 001 , 0 } ) // 08
AADD( aStru, { "TIPO_INSC"  	, "C" , 001 , 0 } ) // 09
AADD( aStru, { "NUM_INSC"  	, "C" , 015 , 0 } ) // 10
AADD( aStru, { "CONVENIO1"   	, "C" , 006 , 0 } ) // 11
AADD( aStru, { "ZERO2" 			, "C" , 014 , 0 } ) // 12
AADD( aStru, { "COD_AGENC"		, "C" , 005 , 0 } ) // 13
AADD( aStru, { "DAC_AGENC"		, "C" , 001 , 0 } ) // 14
AADD( aStru, { "CONVENIO2"   	, "C" , 006 , 0 } ) // 15
AADD( aStru, { "MODEL_PERS"  	, "C" , 007 , 0 } ) // 16
AADD( aStru, { "ZERO3"    		, "C" , 001 , 0 } ) // 17
AADD( aStru, { "NOME_EMP"  	, "C" , 030 , 0 } ) // 18
AADD( aStru, { "MENSA_1" 	 	, "C" , 040 , 0 } ) // 19
AADD( aStru, { "MENSA_2"  		, "C" , 040 , 0 } ) // 20
AADD( aStru, { "NUM_REMRET"	, "C" , 008 , 0 } ) // 21
AADD( aStru, { "DATA_GRAVA"	, "C" , 008 , 0 } ) // 22
AADD( aStru, { "DATA_CREDI"	, "C" , 008 , 0 } ) // 23
AADD( aStru, { "BRANCO2" 	 	, "C" , 033 , 0 } ) // 24

cArqTmp2 := CriaTrab( aStru, .T. )
dbUseArea(.t.,, cArqTmp2, "HEAD_LOTE")

/*
Registro Detalhe - Segmento P
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.3P Código do Banco na Compensação   1   3   3  -     Num     '104'    G001
02.3P Lote Lote de Serviço 				4   7   4  -     Num 				*G002
03.3P Tipo de Registro 						8 	 8   1  -     Num 		'3' 	*G003
04.3P Sequencial do Registro no Lote 	9  13   5  -     Num 				*G038
05.3P Segmento do Registro Detalhe 	  14  14   1  -    Alfa       'P' 	*G039
06.3P Uso Exclusivo FEBRABAN/CNAB 	  15  15   1  -  	 Alfa   Brancos 	 G004
07.3P Código de Movimento Remessa 	  16  17   2  - 	  Num 				*C004
08.3P Agência Mantenedora da Conta 	  18  22   5  - 	  Num 				*G008
09.3P Dígito Verificador da Agência   23  23   1  - 	 Alfa 				*G009
10.3P Código do Convênio no Banco 	  24  29   6  - 	  Num 				*G007
11.3P Uso Exclusivo da CAIXA 			  30  40  11  -	  Num     	'0'
12.3P Modalidade da Carteira 			  41  42   2  - 	  Num 				*G069
13.3P Nosso Número Título no Banco 	  43  57  15  - 	  Num 				*G069
14.3P Carteira Código da Carteira 	  58  58   1  - 	  Num 				*C006
15.3P Forma de Cadastr. do Título 	  59  59   1  - 	  Num 				*C007
16.3P Tipo de Documento 				  60  60   1  - 	 Alfa 		'2' 	 C008
17.3P Emissão do Bloqueto 				  61  61   1  - 	  Num 				*C009
18.3P Entrega do Bloqueto 				  62  62   1  - 	 Alfa 				 C010
19.3P Numero do Documento de Cobrança 63  73  11  -    Alfa 				*C011
20.3P Uso Exclusivo CAIXA 				  74  77   4  - 	 Alfa    Brancos
21.3P Data de Vencimento do Título 	  78  85   8  -    Num 					*C012
22.3P Valor Nominal do Título 			 86 100 13  2 	Num 					*G070
23.3P Agência Encarregada da Cobrança 	101 105  5  - 	Num 					*C014
24.3P Dígito Verificador da Agencia	  	106 106  1  - 	Alfa 					*C014
25.3P Espécie do Título 					107 108  2  -	Num 					*C015
26.3P Título Aceito/Não Aceito 			109 109  1  - 	Alfa 					 C016
27.3P Data da Emissão do Título 			110 117  8  - 	 Num 					 G071
28.3P Código do Juros de Mora 			118 118  1  - 	 Num 					*C018
29.3P Data do Juros de Mora 				119 126 	8 	- 	 Num 					*C019
30.3P Juros de Mora por Dia/Taxa 		127 141 13  2 	 Num 					 C020
31.3P Código do Desconto 1 				142 142  1  - 	 Num 					*C021
32.3P Data do Desconto 1 					143 150  8  - 	 Num					 C022
33.3P Desconto 1 Valor/Percentual 		151 165 13  2 	 Num					 C023
34.3P Valor do IOF a ser Recolhido 		166 180 13  2 	 Num 					 C024
35.3P Valor do Abatimento 					181 195 13 	2 	 Num 					 G045
36.3P Identificação Título na Empresa 	196 220 25  - 	Alfa					 G072
37.3P Código para Protesto 				221 221 	1 	- 	 Num					 C026
38.3P Número de Dias para Protesto 		222 223 	2 	- 	 Num 					 C027
39.3P Código p/ Baixa/Devolução 			224 224 	1 	- 	 Num 					 C028
40.3P Prazo p/ Baixa/Devolução 			225 227 	3 	- 	Alfa 					 C029
41.3P Código da Moeda 						228 229  2	- 	 Num 					*G065
42.3P Uso Exclusivo CAIXA 					230 239 10 - 	 Num 		'0'
43.3P Uso Exclusivo FEBRABAN/CNAB 		240 240 1 - 	Alfa Brancos 		 G004
*/

aStru := {}  //REGISTRO DETALHE P

AADD( aStru, { "COD_BANCO"		, "C" , 003 , 0 } ) // 01
AADD( aStru, { "COD_LOTE"		, "C" , 004 , 0 } ) // 02
AADD( aStru, { "TIPO_REGIS"	, "C" , 001 , 0 } ) // 03
AADD( aStru, { "SEQUENCIAL"	, "C" , 005 , 0 } ) // 04
AADD( aStru, { "SEGMENTO"		, "C" , 001 , 0 } ) // 05
AADD( aStru, { "BRANCO1"   	, "C" , 001 , 0 } ) // 06
AADD( aStru, { "COD_MOVI"  	, "C" , 002 , 0 } ) // 07
AADD( aStru, { "COD_AGENC"		, "C" , 005 , 0 } ) // 08
AADD( aStru, { "DAC_AGENC"		, "C" , 001 , 0 } ) // 09
AADD( aStru, { "CONVENIO1"   	, "C" , 006 , 0 } ) // 10
AADD( aStru, { "ZERO1" 			, "C" , 011 , 0 } ) // 11
AADD( aStru, { "MODALIDADE"	, "C" , 002 , 0 } ) // 12
AADD( aStru, { "NOSSO_NUM"		, "C" , 015 , 0 } ) // 13
AADD( aStru, { "CARTEIRA"   	, "C" , 001 , 0 } ) // 14
AADD( aStru, { "FORMA_CAD"  	, "C" , 001 , 0 } ) // 15
AADD( aStru, { "TIPO_DOC" 		, "C" , 001 , 0 } ) // 16
AADD( aStru, { "EMISSAO_BL"	, "C" , 001 , 0 } ) // 17
AADD( aStru, { "ENTREGA_BL"	, "C" , 001 , 0 } ) // 18
AADD( aStru, { "NUM_DOC"  		, "C" , 011 , 0 } ) // 19
AADD( aStru, { "BRANCO2"		, "C" , 004 , 0 } ) // 20
AADD( aStru, { "DATA_VENCI"	, "C" , 008 , 0 } ) // 21
AADD( aStru, { "VALOR_NOMI"	, "C" , 013 , 0 } ) // 22
AADD( aStru, { "COD_AG_COB"	, "C" , 005 , 0 } ) // 23
AADD( aStru, { "DAC_AG_COB"	, "C" , 001 , 0 } ) // 24
AADD( aStru, { "ESPECIE"		, "C" , 002 , 0 } ) // 25
AADD( aStru, { "TITULO_ACE"	, "C" , 001 , 0 } ) // 26
AADD( aStru, { "DATA_EMISS"	, "C" , 008 , 0 } ) // 27
AADD( aStru, { "COD_JUROS"		, "C" , 001 , 0 } ) // 28
AADD( aStru, { "DATA_JUROS"	, "C" , 008 , 0 } ) // 29
AADD( aStru, { "JUROS_MORA"	, "C" , 013 , 0 } ) // 30
AADD( aStru, { "CODI_DESC1"	, "C" , 001 , 0 } ) // 31
AADD( aStru, { "DATA_DESC1"	, "C" , 008 , 0 } ) // 32
AADD( aStru, { "DESCONTO_1"	, "C" , 013 , 0 } ) // 33
AADD( aStru, { "VALOR_IOF"		, "C" , 013 , 0 } ) // 34
AADD( aStru, { "VALOR_ABAT"	, "C" , 013 , 0 } ) // 35
AADD( aStru, { "NUM_TITULO"	, "C" , 025 , 0 } ) // 36
AADD( aStru, { "COD_PROTES"	, "C" , 001 , 0 } ) // 37
AADD( aStru, { "DIA_PROTES"	, "C" , 002 , 0 } ) // 38
AADD( aStru, { "COD_BX_DEV"	, "C" , 001 , 0 } ) // 39
AADD( aStru, { "PRA_BX_DEV"	, "C" , 003 , 0 } ) // 40
AADD( aStru, { "COD_MOEDA"		, "C" , 002 , 0 } ) // 41
AADD( aStru, { "ZERO2"			, "C" , 010 , 0 } ) // 42
AADD( aStru, { "BRANCO3"		, "C" , 001 , 0 } ) // 43

cArqTmp3 := CriaTrab(aStru,.t.)
dbUseArea(.t.,, cArqTmp3, "DETA_P")

/*
Registro Detalhe - Segmento Q
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.3Q Código do Banco na Compensação 	1	 3	 3 	- 	Num 		'104'			 G001
02.3Q Lote de Serviço 						4 	 7  4 	- 	Num 						*G002
03.3Q	Tipo de Registro 						8 	 8  1 	- 	Num 		'3'			*G003
04.3Q Nº Sequencial Registro no Lote 	9  13  5 	- 	Num 						*G038
05.3Q Segmento do Registro Detalhe 	  14  14  1 	- 	Alfa 		'Q'			*G039
06.3Q Uso Exclusivo FEBRABAN/CNAB 	  15  15  1 	- 	Alfa 		Brancos 		 G004
07.3Q Código de Movimento Remessa 	  16  17  2 	- 	Num 						*C004
08.3Q Tipo de Inscrição 				  18  18  1 	-  Num 						*G005
09.3Q Número de Inscrição 				  19  33 15 	- 	Num 						*G006
10.3Q Nome 									  34  73 40 	- Alfa
11.3Q Endereço 							  74 113	40 	- Alfa 						 G032
12.3Q Bairro 								 114 128 15 	- Alfa 						 G032
13.3Q CEP 									 129 133  5 	- Num 						 G034
14.3Q Sufixo do CEP 						 134 136  3 	- Num 						 G035
15.3Q Cidade 								 137 151 15 	- Alfa 						 G033
16.3Q Unidade da Federação 			 152 153  2 	- Alfa 						 G036
17.3Q Tipo de Inscrição 				 154 154  1 	- Num 						*G005
18.3Q  Número de Inscrição 			 155 169 15 	- Num 						*G006
19.3Q Nome do Sacador/Avalista 		 170 209 40 	- Alfa 						 C060
20.3Q Banco Correspondente 			 210 212 3 		- Num 						*C031
21.3Q Nosso Nº no Banco 				 213 232 20 	- Alfa 						*C032
22.3Q Uso Exclusivo FEBRABAN/CNAB 	 233 240 8 		- Alfa 		Brancos 		 G004
*/

aStru := {}  //REGISTRO DETALHE Q

AADD( aStru, { "COD_BANCO"		, "C" , 003 , 0 } ) // 01
AADD( aStru, { "COD_LOTE"		, "C" , 004 , 0 } ) // 02
AADD( aStru, { "TIPO_REGIS"	, "C" , 001 , 0 } ) // 03
AADD( aStru, { "SEQUENCIAL"	, "C" , 005 , 0 } ) // 04
AADD( aStru, { "SEGMENTO"		, "C" , 001 , 0 } ) // 05
AADD( aStru, { "BRANCO1"   	, "C" , 001 , 0 } ) // 06
AADD( aStru, { "COD_MOVI"  	, "C" , 002 , 0 } ) // 07
AADD( aStru, { "TIPO_INSC"		, "C" , 001 , 0 } ) // 08
AADD( aStru, { "NUM_INSC"		, "C" , 015 , 0 } ) // 09
AADD( aStru, { "NOME" 		  	, "C" , 040 , 0 } ) // 10
AADD( aStru, { "ENDERECO"		, "C" , 040 , 0 } ) // 11
AADD( aStru, { "BAIRRO"			, "C" , 015 , 0 } ) // 12
AADD( aStru, { "CEP"				, "C" , 005 , 0 } ) // 13
AADD( aStru, { "SUFIXO_CEP"	, "C" , 003 , 0 } ) // 14
AADD( aStru, { "CIDADE"	   	, "C" , 015 , 0 } ) // 15
AADD( aStru, { "ESTADO"		  	, "C" , 002 , 0 } ) // 16
AADD( aStru, { "AVAL_TIPIN"	, "C" , 001 , 0 } ) // 17
AADD( aStru, { "AVAL_NUMIN"	, "C" , 015 , 0 } ) // 18
AADD( aStru, { "AVAL_NOME"		, "C" , 040 , 0 } ) // 19
AADD( aStru, { "CODIGO_BAN"	, "C" , 003 , 0 } ) // 20
AADD( aStru, { "NOSSO_NUM"		, "C" , 020 , 0 } ) // 21
AADD( aStru, { "BRANCO2"		, "C" , 008 , 0 } ) // 22

cArqTmp4 := CriaTrab(aStru,.t.)
dbUseArea(.t.,,cArqTmp4,"DETA_Q")

/*
Registro Detalhe - Segmento R
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.3R Código do Banco na Compensação 	1 	 3   3 	- 	Num 		'104'			 G001
02.3R Lote de Serviço 						4 	 7   4 	- 	Num 						*G002
03.3R Tipo de Registro 						8 	 8   1 	- 	Num 		'3'			*G003
04.3R Nº Sequencial Registro no Lote 	9 	13   5 	- 	Num 						*G038
05.3R Segmento do Registro Detalhe 		14 14   1 	- Alfa 		'R'			*G039
06.3R Uso Exclusivo FEBRABAN/CNAB 		15 15   1 	- Alfa 		Brancos 		 G004
07.3R Código de Movimento Remessa 		16 17   2 	- Num 						*C004
08.3R Código do Desconto 2 				18 18   1 	- Num 						*C021
09.3R Data do Desconto 2 					19 26   8 	- Num 						 C022
10.3R Desconto 2 								27 41  13 	2 Num 						 C023
11.3R Cód. Desc. 3 							42 42   1 	- Num 						*C021
12.3R Data do Desconto 3 					43 50   8 	- Num 						 C022
13.3R Desconto 3 								51 65  13 	2 Num 						 C023
14.3R Código da Multa 						66 66   1 	- Alfa 						 G073
15.3R Data da Multa 							67 74   8 	- Num 						 G074
16.3R Multa a Ser Aplicado 				75 89  13 	2 Num 						 G075
17.3R Informação ao Sacado 				90 99  10 	- Alfa 						*C036
18.3R Informação 3 Mensagem 3 		  100 139 40 	- Alfa 						*C037
19.3R Informação 4 Mensagem 4 		  140 179 40 	- Alfa 						*C037
20.3R E-mail sacado						  180 229 50 	- Alfa 						 G032
21.3R Uso Exclusivo FEBRABAN/CNAB 	  230 240 11 	- Alfa 		Brancos 		 G004
*/

aStru := {}  //REGISTRO DETALHE R

AADD( aStru, { "COD_BANCO"		, "C" , 003 , 0 } ) // 01
AADD( aStru, { "COD_LOTE"		, "C" , 004 , 0 } ) // 02
AADD( aStru, { "TIPO_REGIS"	, "C" , 001 , 0 } ) // 03
AADD( aStru, { "SEQUENCIAL"	, "C" , 005 , 0 } ) // 04
AADD( aStru, { "SEGMENTO"		, "C" , 001 , 0 } ) // 05
AADD( aStru, { "BRANCO1"   	, "C" , 001 , 0 } ) // 06
AADD( aStru, { "COD_MOVI"  	, "C" , 002 , 0 } ) // 07
AADD( aStru, { "CODI_DESC2"	, "C" , 001 , 0 } ) // 08
AADD( aStru, { "DATA_DESC2"	, "C" , 008 , 0 } ) // 09
AADD( aStru, { "DESCONTO_2"  	, "C" , 013 , 0 } ) // 10
AADD( aStru, { "CODI_DESC3"	, "C" , 001 , 0 } ) // 11
AADD( aStru, { "DATA_DESC3"	, "C" , 008 , 0 } ) // 12
AADD( aStru, { "DESCONTO_3"  	, "C" , 013 , 0 } ) // 13
AADD( aStru, { "CODI_MULTA"	, "C" , 001 , 0 } ) // 14
AADD( aStru, { "DATA_MULTA"	, "C" , 008 , 0 } ) // 15
AADD( aStru, { "MULTA"	   	, "C" , 013 , 0 } ) // 16
AADD( aStru, { "INFOSACADO"	, "C" , 010 , 0 } ) // 17
AADD( aStru, { "MENSA_3"		, "C" , 040 , 0 } ) // 18
AADD( aStru, { "MENSA_4"		, "C" , 040 , 0 } ) // 19
AADD( aStru, { "EMAIL_SACA"	, "C" , 050 , 0 } ) // 20
AADD( aStru, { "BRANCO2"		, "C" , 011 , 0 } ) // 21

cArqTmp5 := CriaTrab(aStru,.t.)
dbUseArea(.t.,,cArqTmp5,"DETA_R")

/*
Registro Detalhe - Segmento S
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.3S Código do Banco na Compensação 	1 	3 	3 		- 	Num 		'104' 		 G001
02.3S Lote de Serviço 						4 	7 	4 		- 	Num 						*G002
03.3S Tipo de Registro 						8 	8 	1 		- 	Num 		'3'			*G003
04.3S Nº Sequencial do Registro Lote 	9 	13 5 		- 	Num 						*G038
05.3S Segmento do Registro Detalhe 		14 14 1 		- Alfa 		'S' 			*G039
06.3S CNAB Uso Exclusivo FEBRABAN/CNAB 15 15 1 		- Alfa 		Brancos 		G004
07.3S Código de Movimento Remessa 		16 17 2 		- Num 						*C004

Para Tipo de Impressão 3 (Mensagens a serem impressas na parte Recibo do Sacado do Bloqueto):
08.3S Identificação da Impressão 		 18  18  1 	- Num 						*C040
09.3S Mensagem 5 								 19  58 40 	- Alfa 						*C037
10.3S Mensagem 6 								 59  98 40 	- Alfa 						*C037
11.3S Mensagem 7 								 99 138 40 	- Alfa 						*C037
12.3S Mensagem 8 								139 178 40 	- Alfa 						*C037
13.3S Uso Exclusivo CAIXA 					179 218 40 	- Alfa 		Brancos
14.3S Uso Exclusivo FEBRABAN/CNAB 		219 240 22 	- Alfa 		Brancos 		 G004

Para Tipo de Impressão 1 ou 2:
08.3S Tipo de Impressão Identificação da Impressão 18 18 1 - Num *C040
09.3S Filler01 Uso Exclusivo CAIXA 19 20 2 - Num ‘0’
10.3S Mensagem Mensagem a ser Impressa 21 160 140 - Alfa *C042
11.3S Filler02 Uso Exclusivo CAIXA 161 162 2 - Num ‘0’
12.3S CNAB Uso Exclusivo FEBRABAN/CNAB 163 240 78 - Alfa Brancos G004

*/

aStru := {}  //REGISTRO DETALHE S

AADD( aStru, { "COD_BANCO"		, "C" , 003 , 0 } ) // 01
AADD( aStru, { "COD_LOTE"		, "C" , 004 , 0 } ) // 02
AADD( aStru, { "TIPO_REGIS"	, "C" , 001 , 0 } ) // 03
AADD( aStru, { "SEQUENCIAL"	, "C" , 005 , 0 } ) // 04
AADD( aStru, { "SEGMENTO"		, "C" , 001 , 0 } ) // 05
AADD( aStru, { "BRANCO1"   	, "C" , 001 , 0 } ) // 06
AADD( aStru, { "COD_MOVI"  	, "C" , 002 , 0 } ) // 07
AADD( aStru, { "IDENT_IMP"		, "C" , 001 , 0 } ) // 17
AADD( aStru, { "MENSA_5"		, "C" , 040 , 0 } ) // 18
AADD( aStru, { "MENSA_6"		, "C" , 040 , 0 } ) // 19
AADD( aStru, { "MENSA_7"		, "C" , 040 , 0 } ) // 18
AADD( aStru, { "MENSA_8"		, "C" , 040 , 0 } ) // 19
AADD( aStru, { "BRANCO2"		, "C" , 040 , 0 } ) // 21
AADD( aStru, { "BRANCO3"		, "C" , 022 , 0 } ) // 21

cArqTmp6 := CriaTrab(aStru,.t.)
dbUseArea(.t.,,cArqTmp6,"DETA_S")

/*
Registro Trailer de Lote
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.5 Código do Banco na Compensação 	1 	 3   3 	- 	Num 		'104' 		 G001
02.5 Lote de Serviço 						4 	 7	  4 	- 	Num 						*G002
03.5 Tipo de Registro 						8 	 8   1 	- 	Num 		'5' 			*G003
04.5 Uso Exclusivo FEBRABAN/CNAB 		9 	17   9 	- 	Alfa 		Brancos 		 G004
05.5 Quantidade de Registros no Lote  18  23   6 	- 	Num 						*G057
06.5 Qtde Títulos Cobrança Simples	  24  29   6 	- 	Num 						*C070
07.5 Valor Títulos Cobrança Simples	  30  46  15 	2 	Num 						*C071
08.5 Qtde Títulos Cobrança Caucao	  47  52   6 	- 	Num 						*C070
09.5 Valor Títulos Cobrança Caucao	  53  69  15 	2 	Num 						*C071
10.5 Qtde Títulos Cobrança Descontada 70  75   6 	- 	Num 						*C070
11.5 Valor Títulos Cobrança Descontad 76  92  15 	2 	Num 						*C071
12.5 Uso Exclusivo FEBRABA/CNAB  	  93 123  31 	- Alfa 		Brancos 		 G004
13.5 Uso Exclusivo FEBRABAN/CNAB 	 124 240 117 	- Alfa 		Brancos 		 G004
*/

aStru := {}  //REGISTRO Trailer de Lote

AADD( aStru, { "COD_BANCO"		, "C" , 003 , 0 } ) // 01
AADD( aStru, { "COD_LOTE"		, "C" , 004 , 0 } ) // 02
AADD( aStru, { "TIPO_REGIS"	, "C" , 001 , 0 } ) // 03
AADD( aStru, { "BRANCO1"   	, "C" , 009 , 0 } ) // 04
AADD( aStru, { "QTDE_REGI" 	, "C" , 006 , 0 } ) // 05
AADD( aStru, { "QTDE_TITS"		, "C" , 006 , 0 } ) // 06
AADD( aStru, { "VALO_TITS"		, "C" , 015 , 0 } ) // 07
AADD( aStru, { "QTDE_TITC"		, "C" , 006 , 0 } ) // 08
AADD( aStru, { "VALO_TITC"		, "C" , 015 , 0 } ) // 09
AADD( aStru, { "QTDE_TITD"		, "C" , 006 , 0 } ) // 10
AADD( aStru, { "VALO_TITD"		, "C" , 015 , 0 } ) // 11
AADD( aStru, { "BRANCO2"		, "C" , 031 , 0 } ) // 12
AADD( aStru, { "BRANCO3"		, "C" , 117 , 0 } ) // 13

cArqTmp7 := CriaTrab(aStru,.t.)
dbUseArea(.t.,,cArqTmp7,"TRAI_LOTE")

/*
Registro Trailer de Arquivo
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.9 Código do Banco na Compensação    1   3   3 -      Num   '104'       G001
02.9 Lote de Serviço 						4   7   4 -      Num   '9999'     *G002
03.9 Registro Tipo de Registro         8   8   1 -      Num   '9'        *G003
04.9 CNAB Uso Exclusivo FEBRABAN/CNAB  9  17   9 -      Alfa  Brancos     G004
05.9 Quantidade de Lotes              18  23   6 - 	  Num               G049
06.9 Totais Quantidade de Registros   24  29   6 -      Num               G056
07.9 CNAB Uso Exclusivo FEBRABAN/CNAB 30  35   6 -      Alfa  Brancos     G004
08.9 CNAB Uso Exclusivo FEBRABAN/CNAB 36 240 205 -      Alfa  Brancos     G004
*/

aStru := {}  // Registro Trailer de Arquivo

AADD( aStru, { "COD_BANCO"	, "C" , 003 , 0 } ) // 01
AADD( aStru, { "COD_LOTE"	, "C" , 004 , 0 } ) // 02
AADD( aStru, { "TIPO_REGIS", "C" , 001 , 0 } ) // 03
AADD( aStru, { "BRANCO1" 	, "C" , 009 , 0 } ) // 04
AADD( aStru, { "QTDE_LOTE"	, "C" , 006 , 0 } ) // 05
AADD( aStru, { "QTDE_REGI"	, "C" , 006 , 0 } ) // 06
AADD( aStru, { "BRANCO2"	, "C" , 006 , 0 } ) // 07
AADD( aStru, { "BRANCO3"	, "C" , 205 , 0 } ) // 08

cArqTmp8 := CriaTrab( aStru, .T. )
dbUseArea(.t.,,cArqTmp8,"TRAI_FILE")

/*
Registro Padrao Final que vai juntar todos os outros registros
======================================================================================
*/

aStru := {}  // Registro Padrao

AADD( aStru, { "REGISTRO"  , "C" , 240 , 0 } )

cArqTmp9 := CriaTrab(aStru,.t.)
dbUseArea(.t.,,cArqTmp9,"REGI")
dbSelectArea("REGI")

/*
Arquivo para Mala Direta
======================================================================================
*/

aStru := {}  // ARQUIVO PARA MALA DIRETA

AADD( aStru, { "CGC_SACADO" , "C" , 014 , 0 } )
AADD( aStru, { "NOME_SACAD" , "C" , 040 , 0 } )
AADD( aStru, { "END_SACADO" , "C" , 040 , 0 } )
AADD( aStru, { "BAI_SACADO" , "C" , 020 , 0 } )
AADD( aStru, { "CEP_SACADO" , "C" , 005 , 0 } )
AADD( aStru, { "CEPC_SACAD" , "C" , 003 , 0 } )
AADD( aStru, { "MUN_SACADO" , "C" , 015 , 0 } )
AADD( aStru, { "EST_SACADO" , "C" , 002 , 0 } )
AADD( aStru, { "NOME_ENT"   , "C" , 040 , 0 } )
AADD( aStru, { "END_ENT"    , "C" , 040 , 0 } )
AADD( aStru, { "BAI_ENT"    , "C" , 020 , 0 } )
AADD( aStru, { "CEP_ENT"    , "C" , 005 , 0 } )
AADD( aStru, { "CEPC_ENT"   , "C" , 003 , 0 } )
AADD( aStru, { "MUN_ENT"    , "C" , 015 , 0 } )
AADD( aStru, { "EST_ENT"    , "C" , 002 , 0 } )

cArqTmp0 := CriaTrab( aStru,.t.)
dbUseArea(.t.,,cArqTmp0,"MALA")
dbSelectArea("MALA")

/*
Inicio da Montagem dos Registros
======================================================================================

Registro Header de Arquivo
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.0 Codigo do Banco na Compensação |  1|  3|  3| - |   Num | '104'   |  G001
02.0 Lote de Serviço                   4   7   4  - |   Num | '0000'  | *G002
03.0 Tipo de Registro                  8   8   1  - |   Num | '0'     | *G003
04.0 Uso Exclusivo FEBRABAN/CNAB       9  17   9  - |  Alfa | Brancos |  G004
05.0 Tipo de Inscrição da Empresa     18  18   1  - |   Num | '2'     | *G005 // CNPJ
06.0 Numero de Inscrição da Empresa   19  32  14  - |   Num |         | *G006 // Numero CNPJ
07.0 Uso Exclusivo CAIXA              33  52  20 -  |   Num | '0'     | 
08.0 Código Agênciada Conta           53  57   5 -      Num |         | *G008
09.0 Dígito Verificador da Agência    58  58   1 -     Alfa |         | *G009
10.0 Código do Convênio no Banco      59  64   6 -      Num |         | *G007
11.0 Uso Exclusivo CAIXA 				  65  71   7 -      Num | '0'     |
12.0 Uso Exclusivo CAIXA 				  72  72   1 -      Num | '0'     |
13.0 Nome da Empresa                  73 102  30 -     Alfa              G013
14.0 Nome do Banco                   103 132  30 -     Alfa              G014
15.0 CNAB Uso Exclusivo FEBRABAN     133 142  10 -     Alfa   Brancos    G004
16.0 Código Remessa / Retorno        143 143   1 -      Num              G015
17.0 Data de Geração do Arquivo      144 151   8 -      Num              G016
18.0 Hora de Geração do Arquivo      152 157   6 -      Num              G017
19.0 Numero Seqüencial do Arquivo    158 163   6 -      Num             *G018
20.0 No da Versão Layout do Arquivo  164 166   3 -      Num   '050'     *G019
21.0 Densidade de Gravação Arquivo   167 171   5 -      Num   '0'        G020
22.0 Para Uso Reservado do Banco     172 191  20 -     Alfa              G021
23.0 Para Uso Reservado da Empresa   192 211  20 -     Alfa              G022
24.0 Versão Aplicativo CAIXA         212 215   4 -     Alfa              C077
25.0 Uso Exclusivo FEBRABAN / CNAB   216 240  25 -     Alfa Brancos      G004
*/

DBSELECTAREA("HEAD_FILE")  // HEAD FILE
RecLock("HEAD_FILE",.T.)

HEAD_FILE->COD_BANCO		:= '104'					// 01
HEAD_FILE->LOTE	  		:= '0000'				// 02
HEAD_FILE->TIPO_REGI		:= '0'					// 03
HEAD_FILE->BRANCO1	  	:= ''						// 04
HEAD_FILE->TIPO_INSC	  	:= '2'					// 05
HEAD_FILE->NUM_INSC	  	:= '47436373000173'	// 06
HEAD_FILE->ZERO1	  		:= '0'					// 07
HEAD_FILE->COD_AGENC	  	:= cAgenc				// 08
HEAD_FILE->DAC_AGENC	  	:= Modulo11(cAgenc) 	// 09
HEAD_FILE->CONVENIO	  	:= ''						// 10
HEAD_FILE->ZERO2	  		:= '0'					// 11
HEAD_FILE->ZERO3	  		:= '0'					// 12
HEAD_FILE->NOME_EMP	  	:= 'SIND.HOSP.CLIN.CAS.S.LAB.DE SP'	// 13
HEAD_FILE->NOME_BAN	  	:= 'CAIXA ECONOMICA FEDERAL'			//  14
HEAD_FILE->BRANCO2	  	:= ''						// 15
HEAD_FILE->COD_REMRET	:= '1'					// 16
HEAD_FILE->DATA_GERA	  	:= STRZERO( DAY( DATE() ),2 ) + STRZERO( MONTH( DATE() ),2 ) +	 STR( YEAR( DATE() ), 4 )		// 17
HEAD_FILE->HORA_GERA	  	:= SUBSTR( TIME(), 1, 2 ) +	SUBSTR( TIME(), 4, 2 ) +	SUBSTR( TIME(), 7, 2 )	// 18'
HEAD_FILE->NUM_SEQUEN 	:=	STRZERO( VAL( MV_PAR05 ), 6 )		// 19
HEAD_FILE->NUM_VERSAO	:= '050'			// 20
HEAD_FILE->DENSIDADE	  	:= '0'			// 21
HEAD_FILE->RESERVA_1	  	:= ''				// 22
HEAD_FILE->RESERVA_2	  	:= ''				// 23
HEAD_FILE->VERSAO_APL	:= ''				// 24
HEAD_FILE->BRANCO3	  	:= ''				// 25

MsUnLock()

/*
Registro Header de Lote
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.1 Código do Banco na Compensacao    1   3   3  -    Num      '104'       G001
02.1 Lote de Servico 						4 	 7   4  -    Num 						*G002
03.1 Tipo de Registro 						8 	 8   1  - 	 Num 		   '1'		*G003
04.1 Tipo de Operacao 						9 	 9   1  - 	Alfa 						*G028
05.1 Tipo de Serviço 					  10  11   2  -    Num                 *G025
06.1 CNAB Uso Exclusivo FEBRABAN/CNAB 12  13   2  -    Num       '00' 		 G004
07.1 Versão do Layout do Lote 		  14  16   3  - 	 Num 		 '030'      *G030
08.1 CNAB Uso Exclusivo FEBRABAN/CNAB 17  17   1  -   Alfa    Brancos       G004
09.1 Tipo de Inscrição da Empresa 	  18  18   1  -    Num                 *G005
10.1 Inscricao da Empresa 				  19  33  15  -    Num                 *G006
11.1 Código do Convênio no Banco 	  34  39   6  -    Num 						*G007
12.1 Uso Exclusivo CAIXA 				  40  53  14  -    Num        '0'
13.1 Código Agência da Conta 			  54  58   5  -    Num                 *G008
14.1 Dígito Verificador da Conta 	  59  59   1  -   Alfa 						*G011
15.1 Código do Convênio no Banco 	  60  65   6  -    Num 						*G007
16.1 Código do Modelo Personalizado   66  72   7  - 	 Num 						 C078
17.1 Uso Exclusivo CAIXA 				  73  73   1  -    Num 			'0'
18.1 Nome da Empresa 					  74 103  30  -   Alfa 						 G013
19.1 Mensagem 1 							 104 143  40  -   Alfa 						 C073
20.1 Mensagem 2 							 144 183  40  -   Alfa 						 C073
21.1 Numero Remessa/Retorno 			 184 191   8  -    Num 						 G079
22.1 Data Gravação Remessa/Retorno   192 199   8  -    Num 						 G068
23.1 Data do Crédito 					 200 207   8  -    Num 						 C003
24.1 Uso Exclusivo FEBRABAN/CNAB 	 208 240  33  -   Alfa    Brancos 		 G004
*/

DBSELECTAREA("HEAD_LOTE")  // HEAD FILE
RecLock("HEAD_LOTE",.T.)

HEAD_LOTE->COD_BANCO		:= '104'								// 01
HEAD_LOTE->COD_LOTE		:= '0001'						 	// 02
HEAD_LOTE->TIPO_REGIS	:= '1'								// 03
HEAD_LOTE->TIPO_OPERA	:= 'R'								// 04
HEAD_LOTE->TIPO_SERVI	:= '01'								// 05
HEAD_LOTE->ZERO1			:= '00'								// 06
HEAD_LOTE->LAYOUT			:= '030'								// 07
HEAD_LOTE->BRANCO1		:= ''									// 08
HEAD_LOTE->TIPO_INSC		:= '2'								// 09
HEAD_LOTE->NUM_INSC		:= '47436373000173'				// 10
HEAD_LOTE->CONVENIO1		:= ''									// 11
HEAD_LOTE->ZERO2			:= '0'								// 12
HEAD_LOTE->COD_AGENC	  	:= cAgenc							// 13
HEAD_LOTE->DAC_AGENC	  	:= Modulo11(cAgenc) 				// 14
HEAD_LOTE->CONVENIO2		:= '' 								// 15
HEAD_LOTE->MODEL_PERS	:= ''									// 16
HEAD_LOTE->ZERO3			:= '0'								// 17
HEAD_LOTE->NOME_EMP		:= 'SIND.HOSP.CLIN.CAS.S.LAB.DE SP'  									// 18
HEAD_LOTE->MENSA_1		:= mv_par13     					// 19
HEAD_LOTE->MENSA_2		:= mv_par14      					// 20
HEAD_LOTE->NUM_REMRET	:= STRZERO( VAL( MV_PAR05 ), 8 )		// 21
HEAD_LOTE->DATA_GRAVA	:= STRZERO( DAY( DATE() ),2 ) + STRZERO( MONTH( DATE() ),2 ) +	 STR( YEAR( DATE() ), 4 )	 // 22
HEAD_LOTE->DATA_CREDI	:= ''									// 23
HEAD_LOTE->BRANCO2		:= ''									// 24

dbSelectArea("SA1")
if (mv_par11 == 2 .or. mv_par11 == 4 )
	DBSETORDER(1)
	dbgotop()
	ProcRegua(RecCount(),22,05)
	DO WHILE !EOF()
		IncProc()
		DbSelectArea("SZC")
		DbSetorder(2)
		if ! ( dbseek( xFilial() + SA1->A1_ESCCONT ) )
			DBSELECTAREA("SA1")
			reclock("SA1",.F.)
			SA1->A1_ESCCONT := ""
			MSUNLOCK()
		ENDIF
		DBSELECTAREA("SA1")
		DBSKIP()
	ENDDO
	DbOrderNickame('7')  && Ordena arq. por CNPJ escrit. contabil // Atencao (UPDXFUN).
	dbseek(xfilial()+"0",.t.)
else
	Dbsetorder(1) // Atencao (UPDXFUN).
	dbGotop()
EndIf
ProcRegua(RecCount(),22,05)

nRegistros := 0
_nIncluidos := 0
_cTitulo := "Gerando Arquivo Bancario - Confederativa - CEF"
nSeq := 0
//_nseq := "00001"
_nValTot := 0

Do While !Eof()
	IncProc("Cliente: "+sa1->a1_cod+"-"+sa1->a1_nreduz)
	IF LEN(ALLTRIM(SA1->A1_CEP))<> 8
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	ENDIF
	if !empty(mv_par15)
		If val(SA1->A1_BASE) <> val(mv_par15)
			dbSelectArea("SA1")
			dbskip()
			loop
		EndIf
	endif
	if !empty(mv_par21) .and. sa1->a1_dtcadas > mv_par21
		DBSELECTAREA("SA1")
		DBSKIP()
		LOOP
	endif	
	If ! EMPTY( MV_PAR22) .AND. SA1->A1_SINDICA <> MV_PAR22
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	If !EMPTY(SA1->A1_INAT)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	If SA1->A1_FILANT == "X"      && Envio para Todos (Geral)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	If SA1->A1_FOLCENT == "S"      && Envio para Todos (Geral)

		/*BEGINDOC
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄP¿
		//³Exclusao de emissao para as empresas que possuam folha centralizada.³
		//³Campo A1_FOLCENT ="S"                                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄPÙ
		ENDDOC*/

		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf

	IF VAL(SA1->A1_CATEG1) >= 12000
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	DbSelectArea("SZC")
	DbSetorder(2)
	if ! ( dbseek( xFilial() + SA1->A1_ESCCONT ) )
		DBSELECTAREA("SA1")
		reclock("SA1",.F.)
		SA1->A1_ESCCONT := ""
		MSUNLOCK()
	ENDIF
	DBSELECTAREA("SA1")
	If (mv_par11 == 1 .or. mv_par11 == 3 ) .and. len(alltrim(SA1->A1_ESCCONT))>0 	&& Envio para Todos (Geral)
		dbSelectArea("SA1")
		dbskip()
		loop
	EndIf
	if (mv_par11 == 2 .or. mv_par11 == 4 )
		if len(alltrim(SA1->A1_ESCCONT))==0
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	EndIf
	&& Verifica se existe titulo para parcela a ser enviada  (Normal/Escrit/Avulso)
	IF MV_PAR02 == "1"
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
		if MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" "+mv_par02+"DP") .or.;
			MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E"+mv_par02+"DP") .or.;
			MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A"+mv_par02+"DP")
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	ELSEIF MV_PAR02== "2"
		IF MV_PAR11 == 1 .OR.MV_PAR11 == 2
			dbSelectArea("SE1")
			dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
			if MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" "+mv_par02+"DP") .or.;
				MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E"+mv_par02+"DP") .or.;
				MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A"+mv_par02+"DP")
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		ENDIF
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" 1DP")
		IF FOUND()
			IF ALLTRIM(SE1->E1_NATUREZ)== "0301"
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E1DP")
		IF FOUND()
			IF ALLTRIM(SE1->E1_NATUREZ)== "0301"
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A1DP")
		IF FOUND()
			IF ALLTRIM(SE1->E1_NATUREZ)== "0301"
				dbSelectArea("SA1")
				dbskip()
				loop
			endif
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" 2DP")
		IF FOUND()
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E2DP")
		IF FOUND()
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
		dbSelectArea("SE1")
		dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
		MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A2DP")
		IF FOUND()
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	endif
	&& Verifica se ‚ isento da Confederativa e Geral Baixa da Parcela caso positivo
	dbSelectArea("SE1")
	dbOrderNickName('20')  // Dbsetorder(20) // Alterado (UPDXFUN).
	IF  SA1->A1_NATUREZ = "1000" .AND. ALLTRIM(SA1->A1_SITUAC)=="AS"
		if ! MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+" "+mv_par02+"DP") .and.;
			! MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"E"+mv_par02+"DP") .and.;
			! MsSeek( xFilial("SE1")+SA1->A1_CGC + strzero(mv_par01,2)+"A"+mv_par02+"DP")

/*
			RecLock("SE1",.T.)

			SE1->E1_FILIAL   := xFilial("SE1")
			SE1->E1_PREFIXO  := strzero(MV_PAR01,2)
			SE1->E1_NUM      := GETSXENUM("SE1","E1_NUM")
			SE1->E1_PARCELA  := mv_par02
			SE1->E1_TIPO     := "DP"
			SE1->E1_NATUREZ  := "002"
			SE1->E1_CLIENTE  := SA1->A1_COD
			SE1->E1_CODASSO  := SA1->A1_CODASSO
			SE1->E1_CGC	     := SA1->A1_CGC
			SE1->E1_CATEG1   := SA1->A1_CATEG1
			SE1->E1_ERSIN	  := SA1->A1_ERSIN
			SE1->E1_BASE	  := SA1->A1_BASE
			SE1->E1_LOJA     := SA1->A1_LOJA
			SE1->E1_NOMCLI   := SA1->A1_NOME
			SE1->E1_EMISSAO  := date()
			SE1->E1_MOVIMEN  := date()
			SE1->E1_EMIS1    := date()
			SE1->E1_VENCTO   := mv_par03
			SE1->E1_VENCREA  := DataValida( mv_par03 )
			SE1->E1_VENCORI  := mv_par03
			SE1->E1_HIST     := "Isento Contr. "+ substr( dtos( mv_par03 ),5,2)+"/"+substr(dtos(mv_par03),3,2)
			SE1->E1_VALOR    := 0
			SE1->E1_SALDO    := 0
			SE1->E1_VLCRUZ   := 0
			SE1->E1_VALJUR   := 0
			SE1->E1_MOEDA    := 1
			SE1->E1_PORTADO  := "104"
			SE1->E1_AGEDEP   := ALLTRIM(MV_PAR08) //"0198"
			SE1->E1_CONTA    := cConta
			SE1->E1_SITUACA  := "1"
			SE1->E1_OCORREN  := "01"
			SE1->E1_ORIGEM   := "RFINA137"
			SE1->E1_STATUS   := "B"
			SE1->E1_JUROS    := 0
			SE1->E1_VALLIQ   := 0
			SE1->E1_BAIXA    := mv_par03
			SE1->E1_OK       := CHR(69)+CHR (120)
			SE1->E1_CONFED   := "Isento"

			MSUNLOCK()
			CONFIRMSX8()
*/			
			dbSelectArea("SA1")
			dbskip()
			loop
		endif
	endif

	_NossoNum := strzero(val(mv_par05),4) + strzero( nSeq+1, 7)
	Calc_Num()

	/*
	Registro Detalhe - Segmento P
	======================================================================================
	Campo 										 Posição|  Nº  NºFormato| Default | Descricao
	                  						|De |Ate|Dig|Dec|       |         |
	======================================================================================
	01.3P Código do Banco na Compensação   1   3   3  -     Num     '104'    G001
	02.3P Lote Lote de Serviço 				4   7   4  -     Num 				*G002
	03.3P Tipo de Registro 						8 	 8   1  -     Num 		'3' 	*G003
	04.3P Sequencial do Registro no Lote 	9  13   5  -     Num 				*G038
	05.3P Segmento do Registro Detalhe 	  14  14   1  -    Alfa       'P' 	*G039
	06.3P Uso Exclusivo FEBRABAN/CNAB 	  15  15   1  -  	 Alfa   Brancos 	 G004
	07.3P Código de Movimento Remessa 	  16  17   2  - 	  Num 				*C004
	08.3P Agência Mantenedora da Conta 	  18  22   5  - 	  Num 				*G008
	09.3P Dígito Verificador da Agência   23  23   1  - 	 Alfa 				*G009
	10.3P Código do Convênio no Banco 	  24  29   6  - 	  Num 				*G007
	11.3P Uso Exclusivo da CAIXA 			  30  40  11  -	  Num     	'0'
	12.3P Modalidade da Carteira 			  41  42   2  - 	  Num 				*G069
	13.3P Nosso Número Título no Banco 	  43  57  15  - 	  Num 				*G069
	14.3P Carteira Código da Carteira 	  58  58   1  - 	  Num 				*C006
	15.3P Forma de Cadastr. do Título 	  59  59   1  - 	  Num 				*C007
	16.3P Tipo de Documento 				  60  60   1  - 	 Alfa 		'2' 	 C008
	17.3P Emissão do Bloqueto 				  61  61   1  - 	  Num 				*C009
	18.3P Entrega do Bloqueto 				  62  62   1  - 	 Alfa 				 C010
	19.3P Numero do Documento de Cobrança 63  73  11  -    Alfa 				*C011
	20.3P Uso Exclusivo CAIXA 				  74  77   4  - 	 Alfa    Brancos
	21.3P Data de Vencimento do Título 	  78  85   8  -    Num 					*C012
	22.3P Valor Nominal do Título 			 86 100 13  2 	Num 					*G070
	23.3P Agência Encarregada da Cobrança 	101 105  5  - 	Num 					*C014
	24.3P Dígito Verificador da Agencia	  	106 106  1  - 	Alfa 					*C014
	25.3P Espécie do Título 					107 108  2  -	Num 					*C015
	26.3P Título Aceito/Não Aceito 			109 109  1  - 	Alfa 					 C016
	27.3P Data da Emissão do Título 			110 117  8  - 	 Num 					 G071
	28.3P Código do Juros de Mora 			118 118  1  - 	 Num 					*C018
	29.3P Data do Juros de Mora 				119 126 	8 	- 	 Num 					*C019
	30.3P Juros de Mora por Dia/Taxa 		127 141 13  2 	 Num 					 C020
	31.3P Código do Desconto 1 				142 142  1  - 	 Num 					*C021
	32.3P Data do Desconto 1 					143 150  8  - 	 Num					 C022
	33.3P Desconto 1 Valor/Percentual 		151 165 13  2 	 Num					 C023
	34.3P Valor do IOF a ser Recolhido 		166 180 13  2 	 Num 					 C024
	35.3P Valor do Abatimento 					181 195 13 	2 	 Num 					 G045
	36.3P Identificação Título na Empresa 	196 220 25  - 	Alfa					 G072
	37.3P Código para Protesto 				221 221 	1 	- 	 Num					 C026
	38.3P Número de Dias para Protesto 		222 223 	2 	- 	 Num 					 C027
	39.3P Código p/ Baixa/Devolução 			224 224 	1 	- 	 Num 					 C028
	40.3P Prazo p/ Baixa/Devolução 			225 227 	3 	- 	Alfa 					 C029
	41.3P Código da Moeda 						228 229  2	- 	 Num 					*G065
	42.3P Uso Exclusivo CAIXA 					230 239 10 - 	 Num 		'0'
	43.3P Uso Exclusivo FEBRABAN/CNAB 		240 240 1 - 	Alfa Brancos 		 G004
	*/
	dbSelectArea("DETA_P")  //GERANDO REGISTRO DETALHE
	RecLock("DETA_P",.T.)
	
	DETA_P->COD_BANCO		:= '104'						//01
	DETA_P->COD_LOTE		:= '0001'					//02
	DETA_P->TIPO_REGIS	:= '3'						//03
	DETA_P->SEQUENCIAL	:= StrZero( ++nSeq, 5 )//04
	DETA_P->SEGMENTO		:= 'P'						//05
	DETA_P->BRANCO1		:= ''							//06
	DETA_P->COD_MOVI		:= '01'						//07
	DETA_P->COD_AGENC		:= cAgenc					//08
	DETA_P->DAC_AGENC		:= Modulo11(cAgenc)		//09
	DETA_P->CONVENIO1		:= ''							//10
	DETA_P->ZERO1			:= '0'			//11
	DETA_P->MODALIDADE	:= '24'			//12
	DETA_P->NOSSO_NUM		:= _NossoNum 	//13
	DETA_P->CARTEIRA		:= '1'			//14
	DETA_P->FORMA_CAD		:= '2'			//15
	DETA_P->TIPO_DOC		:= '2'			//16
	DETA_P->EMISSAO_BL	:= '2'			//17
	DETA_P->ENTREGA_BL	:= '0'			//18
	
	// DETA_P->NUM_DOC		:= //19
	IF MV_PAR11 == 1  .OR. MV_PAR11 == 3 .OR. MV_PAR11 == 5
		DETA_P->NUM_DOC := strzero(mv_par01,2)+" "+SA1->A1_COD+mv_par02
	elseif mv_par11 == 2 .OR. mv_par11 == 4
		DETA_P->NUM_DOC := strzero(mv_par01,2)+"E"+SA1->A1_COD+mv_par02
	Endif
	
	DETA_P->BRANCO2		:= ''						//20
	DETA_P->DATA_VENCI	:= dVenc					//21
	DETA_P->VALOR_NOMI	:= '000000000000000'	//22
	DETA_P->COD_AG_COB	:= cAgenc				//23
	DETA_P->DAC_AG_COB	:= Modulo11(cAgenc)	//24
	DETA_P->ESPECIE		:= '02'					//25
	DETA_P->TITULO_ACE	:= 'N'					//26
	DETA_P->DATA_EMISS	:= dEmis					 //27
	DETA_P->COD_JUROS		:= '1'					//28
	DETA_P->DATA_JUROS	:= '00000000'			//29
	DETA_P->JUROS_MORA	:= '000000000000000'	//30
	DETA_P->CODI_DESC1	:= '0'					//31
	DETA_P->DATA_DESC1	:= '00000000'			//32
	DETA_P->DESCONTO_1	:= '000000000000000'	//33
	DETA_P->VALOR_IOF		:= '000000000000000'	//34
	DETA_P->VALOR_ABAT	:= '000000000000000'	//35
	DETA_P->NUM_TITULO	:= "00080" + ALLTRIM(MV_PAR08)+cConta	//36
	DETA_P->COD_PROTES	:= '3'					//37
	DETA_P->DIA_PROTES	:= '00'					//38
	DETA_P->COD_BX_DEV	:= '2'					//39
	DETA_P->PRA_BX_DEV	:= '000'					//40
	DETA_P->COD_MOEDA		:= '09'					//41
	DETA_P->ZERO2			:= '0'					//42
	DETA_P->BRANCO3		:= ''						//43
	
	MsUnLock()
	
	/*
	Registro Detalhe - Segmento Q
	======================================================================================
	Campo 										 Posição|  Nº  NºFormato| Default | Descricao
	                  						|De |Ate|Dig|Dec|       |         |
	======================================================================================
	01.3Q Código do Banco na Compensação 	1	 3	 3 	- 	Num 		'104'			 G001
	02.3Q Lote de Serviço 						4 	 7  4 	- 	Num 						*G002
	03.3Q	Tipo de Registro 						8 	 8  1 	- 	Num 		'3'			*G003
	04.3Q Nº Sequencial Registro no Lote 	9  13  5 	- 	Num 						*G038
	05.3Q Segmento do Registro Detalhe 	  14  14  1 	- 	Alfa 		'Q'			*G039
	06.3Q Uso Exclusivo FEBRABAN/CNAB 	  15  15  1 	- 	Alfa 		Brancos 		 G004
	07.3Q Código de Movimento Remessa 	  16  17  2 	- 	Num 						*C004
	08.3Q Tipo de Inscrição 				  18  18  1 	-  Num 						*G005
	09.3Q Número de Inscrição 				  19  33 15 	- 	Num 						*G006
	10.3Q Nome 									  34  73 40 	- Alfa
	11.3Q Endereço 							  74 113	40 	- Alfa 						 G032
	12.3Q Bairro 								 114 128 15 	- Alfa 						 G032
	13.3Q CEP 									 129 133  5 	- Num 						 G034
	14.3Q Sufixo do CEP 						 134 136  3 	- Num 						 G035
	15.3Q Cidade 								 137 151 15 	- Alfa 						 G033
	16.3Q Unidade da Federação 			 152 153  2 	- Alfa 						 G036
	17.3Q Tipo de Inscrição 				 154 154  1 	- Num 						*G005
	18.3Q  Número de Inscrição 			 155 169 15 	- Num 						*G006
	19.3Q Nome do Sacador/Avalista 		 170 209 40 	- Alfa 						 C060
	20.3Q Banco Correspondente 			 210 212 3 		- Num 						*C031
	21.3Q Nosso Nº no Banco 				 213 232 20 	- Alfa 						*C032
	22.3Q Uso Exclusivo FEBRABAN/CNAB 	 233 240 8 		- Alfa 		Brancos 		 G004
	*/
	
	dbSelectArea("DETA_Q")  //GERANDO REGISTRO DETALHE
	RecLock("DETA_Q",.T.)
	
	DETA_Q->COD_BANCO		:= '104' 	// 01
	DETA_Q->COD_LOTE		:= '0001'	// 02
	DETA_Q->TIPO_REGIS	:= '3'		// 03
	DETA_Q->SEQUENCIAL	:= StrZero( ++nSeq, 5 )//04
	DETA_Q->SEGMENTO		:=  'Q'		// 05
	DETA_Q->BRANCO1		:=  ''		// 06
	DETA_Q->COD_MOVI		:=  '01'		// 07
	DETA_Q->TIPO_INSC	  	:= '2'		// 08
	DETA_Q->NUM_INSC	  	:= SA1->A1_CGC						// 09
	DETA_Q->NOME			:= ValidChar( SA1->A1_NOME )	// 10
	DETA_Q->ENDERECO		:= ValidChar( SA1->A1_END )	// 11
	DETA_Q->BAIRRO			:= ValidChar( SA1->A1_BAIRRO)	// 12
	DETA_Q->CEP				:= SUBSTR(SA1->A1_CEP,1,5)	// 13
	DETA_Q->SUFIXO_CEP	:= SUBSTR(SA1->A1_CEP,6,3) 	// 14
	DETA_Q->CIDADE			:= ValidChar( SA1->A1_MUN )	// 15
	DETA_Q->ESTADO			:= ValidChar( SA1->A1_EST )	// 16
	DETA_Q->AVAL_TIPIN	:= '2'	// 18
	DETA_Q->AVAL_NUMIN	:= ''		// 19
	DETA_Q->AVAL_NOME		:= 'SINDHOSP -SIND.HOSP.CLIN.CAS.S.LAB.DE SP'		// 20
	DETA_Q->CODIGO_BAN 	:= '' 		// 21
	DETA_Q->NOSSO_NUM		:= '' 		// 22
	DETA_Q->BRANCO2		:= '' 		// 22
	
	MsUnLock()
	
	/*
	Registro Detalhe - Segmento R
	======================================================================================
	Campo 										 Posição|  Nº  NºFormato| Default | Descricao
	                  						|De |Ate|Dig|Dec|       |         |
	======================================================================================
	01.3R Código do Banco na Compensação 	1 	 3   3 	- 	Num 		'104'			 G001
	02.3R Lote de Serviço 						4 	 7   4 	- 	Num 						*G002
	03.3R Tipo de Registro 						8 	 8   1 	- 	Num 		'3'			*G003
	04.3R Nº Sequencial Registro no Lote 	9 	13   5 	- 	Num 						*G038
	05.3R Segmento do Registro Detalhe 		14 14   1 	- Alfa 		'R'			*G039
	06.3R Uso Exclusivo FEBRABAN/CNAB 		15 15   1 	- Alfa 		Brancos 		 G004
	07.3R Código de Movimento Remessa 		16 17   2 	- Num 						*C004
	08.3R Código do Desconto 2 				18 18   1 	- Num 						*C021
	09.3R Data do Desconto 2 					19 26   8 	- Num 						 C022
	10.3R Desconto 2 								27 41  13 	2 Num 						 C023
	11.3R Cód. Desc. 3 							42 42   1 	- Num 						*C021
	12.3R Data do Desconto 3 					43 50   8 	- Num 						 C022
	13.3R Desconto 3 								51 65  13 	2 Num 						 C023
	14.3R Código da Multa 						66 66   1 	- Alfa 						 G073
	15.3R Data da Multa 							67 74   8 	- Num 						 G074
	16.3R Multa a Ser Aplicado 				75 89  13 	2 Num 						 G075
	17.3R Informação ao Sacado 				90 99  10 	- Alfa 						*C036
	18.3R Informação 3 Mensagem 3 		  100 139 40 	- Alfa 						*C037
	19.3R Informação 4 Mensagem 4 		  140 179 40 	- Alfa 						*C037
	20.3R E-mail sacado						  180 229 50 	- Alfa 						 G032
	21.3R Uso Exclusivo FEBRABAN/CNAB 	  230 240 11 	- Alfa 		Brancos 		 G004
	*/
	
	dbSelectArea("DETA_R")  //GERANDO REGISTRO DETALHE
	RecLock("DETA_R",.T.)
	
	DETA_R->COD_BANCO		:= '104' 	// 01
	DETA_R->COD_LOTE		:= '0001'	// 02
	DETA_R->TIPO_REGIS	:= '3'		// 03
	DETA_R->SEQUENCIAL	:= StrZero( ++nSeq, 5 )//04
	DETA_R->SEGMENTO		:= 'R'		// 05
	DETA_R->BRANCO1		:= ''		// 06
	DETA_R->COD_MOVI		:= '01'		// 07
	DETA_R->CODI_DESC2	:= '0'					//08
	DETA_R->DATA_DESC2	:= '00000000'			//09
	DETA_R->DESCONTO_2	:= '000000000000000'	//10
	DETA_R->CODI_DESC3	:= '0'					//11
	DETA_R->DATA_DESC3	:= '00000000'			//12
	DETA_R->DESCONTO_3	:= '000000000000000'	//13
	DETA_R->CODI_MULTA	:= '2'					// 14
	DETA_R->DATA_MULTA	:= dVenc					// 15
	DETA_R->MULTA			:= '000000000001000'// 16
	DETA_R->INFOSACADO	:= ''		// 17
	DETA_R->MENSA_3		:= ''		// 18
	DETA_R->MENSA_4		:= ''		// 19
	DETA_R->EMAIL_SACA	:= ''		// 20
	DETA_R->BRANCO2		:= ''		// 21
	
	MsUnLock()

	/*
	Registro Detalhe - Segmento S
	======================================================================================
	Campo 										 Posição|  Nº  NºFormato| Default | Descricao
	                  						|De |Ate|Dig|Dec|       |         |
	======================================================================================
	01.3S Código do Banco na Compensação 	1 	3 	3 		- 	Num 		'104' 		 G001
	02.3S Lote de Serviço 						4 	7 	4 		- 	Num 						*G002
	03.3S Tipo de Registro 						8 	8 	1 		- 	Num 		'3'			*G003
	04.3S Nº Sequencial do Registro Lote 	9 	13 5 		- 	Num 						*G038
	05.3S Segmento do Registro Detalhe 		14 14 1 		- Alfa 		'S' 			*G039
	06.3S CNAB Uso Exclusivo FEBRABAN/CNAB 15 15 1 		- Alfa 		Brancos 		G004
	07.3S Código de Movimento Remessa 		16 17 2 		- Num 						*C004
	
	Tipo Impressao
	
	1 = Frente do Bloqueto
	2 = Verso do Bloqueto
	3 = Corpo de Instruções da Ficha de Compensação do Bloqueto
	
	Para Tipo de Impressão 3 (Mensagens a serem impressas na parte Recibo do Sacado do Bloqueto):
	08.3S Identificação da Impressão 		 18  18  1 	- Num 						*C040
	09.3S Mensagem 5 								 19  58 40 	- Alfa 						*C037
	10.3S Mensagem 6 								 59  98 40 	- Alfa 						*C037
	11.3S Mensagem 7 								 99 138 40 	- Alfa 						*C037
	12.3S Mensagem 8 								139 178 40 	- Alfa 						*C037
	13.3S Uso Exclusivo CAIXA 					179 218 40 	- Alfa 		Brancos
	14.3S Uso Exclusivo FEBRABAN/CNAB 		219 240 22 	- Alfa 		Brancos 		 G004
	
	Para Tipo de Impressão 1 ou 2:
	08.3S Tipo de Impressão 					 18  18  1  - Num 						*C040
	09.3S Filler01 	Uso Exclusivo CAIXA 	 19  20  2 -  Num ‘0’
	10.3S Mensagem Mensagem a ser Impressa 21 160 140 - Alfa *C042
	11.3S Filler02 Uso Exclusivo CAIXA 161 162 2 - Num ‘0’
	12.3S CNAB Uso Exclusivo FEBRABAN/CNAB 163 240 78 - Alfa Brancos G004
	
	*/
	
	dbSelectArea("DETA_S")  //GERANDO REGISTRO DETALHE
	RecLock("DETA_S",.T.)
	
	DETA_S->COD_BANCO		:= '104' 	// 01
	DETA_S->COD_LOTE		:= '0001'	// 02
	DETA_S->TIPO_REGIS	:= '3'		// 03
	DETA_S->SEQUENCIAL	:= StrZero( ++nSeq, 5 )//04
	DETA_S->SEGMENTO		:=  'S'		// 05
	DETA_S->BRANCO1		:=  ''		// 06
	DETA_S->COD_MOVI		:=  '01'		// 07
	
	DETA_S->IDENT_IMP		:=  '3'				// 17
	DETA_S->MENSA_5		:=  ''          	// 18
	DETA_S->MENSA_6		:=  ''           // 19
	DETA_S->MENSA_7		:=  ''          	// 18
	DETA_S->MENSA_8		:=  ''          	// 19
	DETA_S->BRANCO2		:=  ''		// 20
	DETA_S->BRANCO3		:=  ''		// 21

/*
	dbSelectArea("DETA")  //GERANDO REGISTRO DETALHE
	RecLock("DETA",.T.)
	DETA->COD_REGIS := "1"
	DETA->AGE_DEBIT := "00000"
	DETA->DIG_AGEDB := ""
	DETA->RAZAO_CC  := "00000"
	DETA->CONTA     := "0000000"
	DETA->DIG_CC    := ""
	DETA->ID_EMPRESA:= "00060" + ALLTRIM(MV_PAR08)+cConta //00060019801621599"
	DETA->CONTR_PART:= ""
	DETA->COD_BANCO := "237"
	DETA->ZEROS     := "00000"
	_NossoNum := strzero(val(mv_par05),4) + strzero(val(_nseq),7)
	Calc_Num()     && Calcula numero conforme especif. banco
	DETA->DESC_BONIF:= "0000000000"
	DETA->COND_EMISS:= "2"
	DETA->DEB_AUTOM := "N"
	DETA->ID_OPERAC := ""
	DETA->ID_RATEIO := ""
	DETA->END_DBAUT := "2"
	DETA->ID_OCORR  := "01"
	If mv_par11 == 1  .OR. mv_par11 == 3 .OR. mv_par11 == 5
		DETA->NUM_DOCTO := strzero(mv_par01,2)+" "+SA1->A1_COD+mv_par02
	elseif mv_par11 == 2 .OR. mv_par11 == 4
		DETA->NUM_DOCTO := strzero(mv_par01,2)+"E"+SA1->A1_COD+mv_par02
	Endif
	DETA->DATA_VECTO := _DVenc
	DETA->VALOR      := "0000000000000"
	DETA->BCO_ENCARR := "237"
	DETA->AGE_DEPOSI := "01988"
	DETA->ESPECIE    := "12"
	DETA->IDENTIFICA := "N"
	DETA->DATA_EMISS := _Demis
	DETA->PRIM_INSTR := "00"
	DETA->SEGU_INSTR := "00"
	DETA->VLR_ATRASO := "0000000000000"
	DETA->DATA_DESC  := "000000"
	DETA->VALOR_DESC := "0000000000000"
	DETA->VALOR_IOF  := "0000000000000"
	DETA->VALOR_ABAT := "0000000000000"
	DETA->TIPO_IDENT := "02"
	DETA->CGC_SACADO := SA1->A1_CGC
	Ver_Ascii()
	DETA->PRIM_MSG   := mv_par12
	DETA->SEGUND_MSG := mv_par13 + mv_par14
*/  

/*
	dbSelectArea("SZ9")
	Reclock("SZ9",.T.)
	SZ9->Z9_FILIAL := xFilial("SZ9")
	SZ9->Z9_TITULO := _NossoNum		&& Numero retorno
	SZ9->Z9_CGC    := SA1->A1_CGC
	SZ9->Z9_VENCTO := mv_par03
	IF !EMPTY(SA1->A1_ESCCONT)
		SZ9->Z9_PARCELA:= strzero(mv_par01,2)+"E"+MV_PAR02   && PP AA
	ELSE
		SZ9->Z9_PARCELA:= strzero(mv_par01,2)+" "+MV_PAR02   && PP AA
	ENDIF
	msUnlock()
*/

	dbSelectArea("MALA")
	Reclock("MALA",.T.)
	MALA->CGC_SACADO := SA1->A1_CGC
	MALA->NOME_SACAD  := SA1->A1_NOME
	MALA->END_SACADO  := SA1->A1_END
	MALA->CEP_SACADO  := SUBSTR(SA1->A1_CEP,1,5)
	MALA->CEPC_SACAD  := SUBSTR(SA1->A1_CEP,6,3)
	MALA->BAI_SACADO  := SA1->A1_BAIRRO
	MALA->MUN_SACADO  := SA1->A1_MUN
	mala->est_SACADO  := sA1->A1_EST		
	IF !EMPTY(SA1->A1_ESCCONT)
		MALA->NOME_ENT    := szc->zc_nomesc
		MALA->END_ENT     := SZC->ZC_END
		MALA->CEP_ENT     := SUBSTR(SZC->ZC_CEP,1,5)
		MALA->CEPC_ENT    := SUBSTR(SZC->ZC_CEP,6,3)
		MALA->BAI_ent     := Szc->zc_BAIRRO
		MALA->MUN_ent     := Szc->zc_MUN	
		mala->est_ent     := szc->zc_EST		
	else
		MALA->NOME_ent := SA1->A1_NOME
		MALA->END_ent  := SA1->A1_END
		MALA->CEP_ent  := SUBSTR(SA1->A1_CEP,1,5)
		MALA->CEPC_ent := SUBSTR(SA1->A1_CEP,6,3)
		MALA->BAI_ent  := SA1->A1_BAIRRO
		MALA->MUN_ent  := SA1->A1_MUN
		mala->est_ent  := sA1->A1_EST		
	endif
	msUnlock()
//	_nNumSeq := val( _nseq )
//	_nNumSeq := _nNumSeq + 1
//	_nseq := strzero( _nNumSeq,5 )
	nRegistros++
	dbSelectArea("SA1")
	dbskip()

ENDDO

dbSelectArea("SEE")
if dbseek( xFilial()+MV_PAR07+MV_PAR08+MV_PAR09+MV_PAR10 )
	RecLock("SEE",.F.)
	SEE->EE_ULTDSK := strzero(val(SEE->EE_ULTDSK)+1,6)
	MsUnlock()
endif

/*
Registro Trailer de Lote
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.5 Código do Banco na Compensação 	1 	 3   3 	- 	Num 		'104' 		 G001
02.5 Lote de Serviço 						4 	 7	  4 	- 	Num 						*G002
03.5 Tipo de Registro 						8 	 8   1 	- 	Num 		'5' 			*G003
04.5 Uso Exclusivo FEBRABAN/CNAB 		9 	17   9 	- 	Alfa 		Brancos 		 G004
05.5 Quantidade de Registros no Lote  18  23   6 	- 	Num 						*G057
06.5 Qtde Títulos Cobrança Simples	  24  29   6 	- 	Num 						*C070
07.5 Valor Títulos Cobrança Simples	  30  46  15 	2 	Num 						*C071
08.5 Qtde Títulos Cobrança Caucao	  47  52   6 	- 	Num 						*C070
09.5 Valor Títulos Cobrança Caucao	  53  69  15 	2 	Num 						*C071
10.5 Qtde Títulos Cobrança Descontada 70  75   6 	- 	Num 						*C070
11.5 Valor Títulos Cobrança Descontad 76  92  15 	2 	Num 						*C071
12.5 Uso Exclusivo FEBRABA/CNAB  	  93 123  31 	- Alfa 		Brancos 		 G004
13.5 Uso Exclusivo FEBRABAN/CNAB 	 124 240 117 	- Alfa 		Brancos 		 G004
*/
dbSelectArea("TRAI_LOTE")  //GERANDO REGISTRO TRAILLER
RecLock("TRAI_LOTE",.T.)

TRAI_LOTE->COD_BANCO		:= '104'			// 01
TRAI_LOTE->COD_LOTE		:= '0001'		// 02
TRAI_LOTE->TIPO_REGIS	:= '5'			// 03
TRAI_LOTE->BRANCO1		:= ''				// 04
TRAI_LOTE->QTDE_REGI		:= StrZero( nSeq + 2, 6 )	 	// 05
TRAI_LOTE->QTDE_TITS		:= StrZero( nRegistros, 6 )	// 06
TRAI_LOTE->VALO_TITS		:= '00000000000000000'			// 07
TRAI_LOTE->QTDE_TITC		:= '000000'							// 08
TRAI_LOTE->VALO_TITC		:= '00000000000000000'			// 09
TRAI_LOTE->QTDE_TITD		:= '000000'							// 10
TRAI_LOTE->VALO_TITD		:= '00000000000000000'			// 11
TRAI_LOTE->BRANCO2		:= ''									// 12
TRAI_LOTE->BRANCO3		:= ''									// 13

MsUnlock()

/*
Registro Trailer de Arquivo
======================================================================================
Campo 										 Posição|  Nº  NºFormato| Default | Descricao
                  						|De |Ate|Dig|Dec|       |         |
======================================================================================
01.9 Código do Banco na Compensação    1   3   3 -      Num   '104'       G001
02.9 Lote de Serviço 						4   7   4 -      Num   '9999'     *G002
03.9 Registro Tipo de Registro         8   8   1 -      Num   '9'        *G003
04.9 CNAB Uso Exclusivo FEBRABAN/CNAB  9  17   9 -      Alfa  Brancos     G004
05.9 Quantidade de Lotes              18  23   6 - 	  Num               G049
06.9 Totais Quantidade de Registros   24  29   6 -      Num               G056
07.9 CNAB Uso Exclusivo FEBRABAN/CNAB 30  35   6 -      Alfa  Brancos     G004
08.9 CNAB Uso Exclusivo FEBRABAN/CNAB 36 240 205 -      Alfa  Brancos     G004
*/

dbSelectArea("TRAI_FILE")  //GERANDO REGISTRO TRAILLER
RecLock("TRAI_FILE",.T.)

TRAI_FILE->COD_BANCO		:= '104'			// 01
TRAI_FILE->COD_LOTE		:= '9999'		// 02
TRAI_FILE->TIPO_REGIS	:= '9'			// 03
TRAI_FILE->BRANCO1		:= ''				// 04
TRAI_FILE->QTDE_LOTE		:= '000001'		// 05
TRAI_FILE->QTDE_REGI		:= StrZero( nSeq + 4, 6 )	 	// 06
TRAI_FILE->BRANCO2		:= ''									// 07
TRAI_FILE->BRANCO3		:= ''									// 08

TotCad()

dbSelectArea("HEAD_FILE")
DbGoTop()
COPY TO HEADFILE.txt SDF

dbSelectArea("HEAD_LOTE")
DbGoTop()
COPY TO HEADLOTE.txt SDF

dbSelectArea("TRAI_LOTE")
DbGoTop()
COPY TO TRAILOTE.TXT SDF

dbSelectArea("TRAI_FILE")
DbGoTop()
COPY TO TRAIFILE.TXT SDF

dbSelectArea("DETA_P")
DbGoTop()
dbSelectArea("DETA_Q")
DbGoTop()
dbSelectArea("DETA_R")
DbGoTop()
dbSelectArea("DETA_S")
DbGoTop()
                                                 
dbSelectArea("REGI")
DbGoTop()

Append From HEADFILE.TXT SDF
Append From HEADLOTE.TXT SDF

FOR nI := 1 TO nRegistros

	dbSelectArea("DETA_P")
	COPY NEXT 1 TO DETA_P.TXT SDF
	dbSelectArea("DETA_Q")
	COPY NEXT 1 TO DETA_Q.TXT SDF
	dbSelectArea("DETA_R")
	COPY NEXT 1 TO DETA_R.TXT SDF
	dbSelectArea("DETA_S")
	COPY NEXT 1 TO DETA_S.TXT SDF
	
	dbSelectArea("REGI")

	Append From DETA_P.TXT SDF
	Append From DETA_Q.TXT SDF
	Append From DETA_R.TXT SDF
	Append From DETA_S.TXT SDF
	
NEXT nI

Append From TRAILOTE.TXT SDF
Append From TRAIFILE.TXT SDF

ARQ := "\arquivos\COnfederativa\"+MV_PAR06
COPY TO &ARQ SDF
dbSelectArea("MALA")
ARQ := "\arquivos\confederativa\"+MV_PAR18
COPY TO &ARQ 	  && Gera arquivo DBF para mala direta
dbCloseArea()

@ 96,42 TO 290,405 DIALOG oDlg1 TITLE "Termino da Geracao"
@ 8,10 TO 68,170
@ 23,22 SAY "Registros Gerados"
@ 23,95 GET nRegistros PICTURE "@E 999,999" WHEN .F.
@ 77,078 BMPBUTTON TYPE 1 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED

HEAD_FILE->( DbCloseArea() )
HEAD_LOTE->( DbCloseArea() )

DETA_P->( DbCloseArea() )
DETA_Q->( DbCloseArea() )
DETA_R->( DbCloseArea() )
DETA_S->( DbCloseArea() )

TRAI_LOTE->( DbCloseArea() )
TRAI_FILE->( DbCloseArea() )

REGI->( DbCloseArea() )

aFiles := { 'HEADFILE.TXT', 'HEADLOTE.TXT', 'DETA_P.TXT', 'DETA_Q.TXT', 'DETA_R.TXT', 'DETA_S.TXT', 'TRAILOTE.TXT', 'TRAIFILE.TXT'}

FOR nI := 0 TO 9

		cFile := &( 'cArqTmp' + STR( nI, 1 ) ) + ".DBF"
		If File( cFile )
			Ferase( cFile )
		EndIf

		If nI > 0 .and. nI < 9 .and. File( aFiles[ nI] )
			Ferase( aFiles[ nI] )
		EndIf

NEXT nI

dbSelectArea("SA1")
dbSetOrder(1)

return

************************
static Function TOTCAD()
SetPrvt("_CALIAS,CBCONT,CBTXT,WNREL,CDESC1,CDESC2")
SetPrvt("CDESC3,CSTRING,TAMANHO,TIPO,LIMITE,TITULO")
SetPrvt("CABEC2,CABEC1,ARETURN,NOMEPROG,NLASTKEY,CPERG")
SetPrvt("M_PAG,LI,_AESTR,C_ARQIMP,CARQIND,CINDSA1")
SetPrvt("NLINHA,")
_cAlias := alias()
cbcont := 0
cbtxt := ""
wnrel := ""
cDesc1 := "Este programa irá gerar o resumo da geração da contribuição CEF."
cDesc2 := ""
cDesc3 := ""
cString := "SA1"
tamanho := "P"
tipo := 15
limite := 220
Titulo := "Geração da contribuição Confederativa CEF"
cabec2 := ""
cabec1 := ""
aReturn := { "Zebrado", 1,"Administracao", 4, 2, 1, "",1 }
nomeprog := "RFINA137"
nLastkey := 0
cPerg := "FINA37"
m_pag := 1
li := 80
wnrel := "RFINA137"
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,tamanho)

if nLastkey == 27
    return
endif

SetDefault(aReturn,cString)

if nLastkey == 27
   return
endif

RptStatus({|| impREL() },titulo)

RETURN

/*=========================*/
	Static function ImpREL()
/*=========================*/

LI := 80
if Li >= 60
    cabec(titulo,cabec1,cabec2,nomeprog,tamanho,tipo)
    nLinha := prow() + 1
endif

@ li,000 PSAY "Registros gerados: "
@ li,030 psay 	nRegistros picture "@e 999,999,999"

set device to screen
if aReturn[5] == 1
   set printer to
   dbcommit()
   ourspool(wnrel)
endif

MS_FLUSH()
return


***************************
Static FUNCTION Ver_Ascii()
_cTexto := SA1->A1_NOME
DETA->NOME_SACADO := SA1->A1_NOME
DETA->END_SACADO := SA1->A1_END
DETA->CEP_SACADO := SUBSTR(SA1->A1_CEP,1,5)
DETA->CEPC_SACADO := SUBSTR(SA1->A1_CEP,6,3)
return
***************************
Static FUNCTION Calc_Num()
_vNum := "06" + substr(_NossoNum,1,11)
_m1 := val(substr(_vNum,1,1)) * 2
_m2 := val(substr(_vNum,2,1)) * 7
_m3 := val(substr(_vNum,3,1)) * 6
_m4 := val(substr(_vNum,4,1)) * 5
_m5 := val(substr(_vNum,5,1)) * 4
_m6 := val(substr(_vNum,6,1)) * 3
_m7 := val(substr(_vNum,7,1)) * 2
_m8  := val(substr(_vNum,8,1)) * 7
_m9  := val(substr(_vNum,9,1)) * 6
_m10 := val(substr(_vNum,10,1)) * 5
_m11 := val(substr(_vNum,11,1)) * 4
_m12 := val(substr(_vNum,12,1)) * 3
_m13 := val(substr(_vNum,13,1)) * 2
_S1 := _m1 + _m2 + _m3 + _m4 + _m5 + _m6 + _m7 + _m8 + _m9 + _m10 + _m11 + _m12	+ _m13
_r11 := mod (_S1,11)
if _r11 == 0
	_digito := "0"
//	DETA->NOSSO_NUM := _NossoNum + _digito
	_NossoNum := _NossoNum + _digito
	return
endif
if _r11 == 1
	_digito := "P"
//	DETA->NOSSO_NUM := _NossoNum + _digito
	_NossoNum := _NossoNum + _digito
	return
endif
_digito := str((11 - _r11),1)
//DETA->NOSSO_NUM := _NossoNum + _digito
_NossoNum := _NossoNum + _digito
return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Digito11 ³ Autor ³ Ary Medeiros			  ³ Data ³			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calculo do modulo 11 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ ExpL1 := Modulo11(ExpC1,ExpC2)									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpL1 = Valor Logico de Retorno (.T. ou .F.) 				  ³±±
±±³			 ³ ExpC1 = String para calcular o digito							  ³±±
±±³			 ³ ExpC2 = Digito de verificacao 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Digito11(cStr,cDigito)
Local i, nMult := 2,nModulo := 0, cChar

cStr := AllTrim(cStr)
For i := Len(cStr) to 1 Step -1
	cChar := Substr(cStr,i,1)
	if isAlpha(cChar)
		Help(" ", 1, "ONLYNUM")
		Return .f.
	endif
	nModulo += Val(cChar)*nMult
	nMult:= if(nMult==7,2,nMult+1)
Next
nRest := nModulo % 11
//nRest := if(nRest==0,nRest,11-nRest)
nRest := IIf(nRest==0 .or. nRest==1,0,11-nRest)
if nRest <> Val(cDigito)
	Help(" ",1,"MODULO11")
	lRet := .f.
else
	lRet := .t.
endif
Return lRet

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Modulo11 ³ Autor ³ Erick Nori Barbosa	  ³ Data ³	30/05/94³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calculo do modulo 11 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ ExpL1 := Modulo11(ExpC1,ExpN1,ExpN2)							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = String para calcular o digito							  ³±±
±±³			 ³ ExpN1 = Primeiro numero de multiplicacao do modulo 11 	  ³±±
±±³			 ³ ExpN2 = Ultimo numero de multiplicacao do modulo 11)		  ³±±
±±³			 ³ ExpC2 = Digito de verificacao (Retornado pela funcao) 	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Modulo11(cStr,nMultIni,nMultFim)
Local i, nModulo := 0, cChar, nMult

nMultIni := Iif( nMultIni==Nil,2,nMultIni )
nMultFim := Iif( nMultFim==Nil,9,nMultFim )
nMult := nMultIni
cStr := AllTrim(cStr)

For i := Len(cStr) to 1 Step -1
	cChar := Substr(cStr,i,1)
	If isAlpha( cChar )
		Help(" ", 1, "ONLYNUM")
		Return .f.
	End
	nModulo += Val(cChar)*nMult
	nMult:= IIf(nMult==nMultfim,2,nMult+1)
Next
nRest := nModulo % 11
nRest := IIf(nRest==0 .or. nRest==1,0,11-nRest)
Return(Str(nRest,1))

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Modulo11 ³ Autor ³ Erick Nori Barbosa	  ³ Data ³	30/05/94³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida Char             											  ³±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function ValidChar( cText )

LOCAL nI

FOR nI := 1 to Len(cText)
	if !(substr( cText, nI,1) >= "0" .and. substr( cText, nI,1) <= "Z") .and. ;
		!(substr( cText, nI,1) >= "a" .and. substr( cText, nI,1) <= "z") .and. ;
		! substr( cText, nI,1) == " "
		cText := strtran( cText, substr( cText,nI,1), " ")
	endif
NEXT nI

RETURN cText
