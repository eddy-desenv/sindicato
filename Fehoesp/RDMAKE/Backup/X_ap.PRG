#include "rwmake.ch"        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

User Function X()        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP6 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("ASTRUCT,I,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿛rograma  � Consult  � Autor � Andreia dos Santos    � Data � 15/06/98 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Consulta Cobranca                                          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Especifico SINDHOSP                                        낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

DbSelectArea("SX3")
ALERT(ALIAS())
aStruct := {Nil , Nil , Nil , Nil}
AADD(aStruct,{"ZN->SZ_FILIAL"  ,"C" ,"2"  ,""})
AADD(aStruct,{"SZN->SZ_PREFIXO","C" ,"3"  ,""})
AADD(aStruct,{"SZN->SZ_NUM"    ,"C" ,"6"  ,""})
AADD(aStruct,{"SZN->SZ_PARCELA","C" ,"1"  ,""})
AADD(aStruct,{"SZN->SZ_NATUREZ","C" ,"10" ,""})
AADD(aStruct,{"SZN->SZ_CLIENTE","C" ,"6"  ,""})
AADD(aStruct,{"SZN->SZ_LOJA"   ,"C" ,"2"  ,""})
AADD(aStruct,{"SZN->SZ_NOMCLI" ,"C" ,"45" ,""})
AADD(aStruct,{"SZN->SZ_EMISSAO","D" ,"8"  ,""})
AADD(aStruct,{"SZN->SZ_VENCTO" ,"D" ,"8"  ,""})
AADD(aStruct,{"SZN->SZ_VENCREA","D" ,"8"  ,""})
AADD(aStruct,{"SZN->SZ_VALOR"  ,"N" ,"17","2"})
AADD(aStruct,{"SZN->SZ_BAIXA"  ,"D" ,"8"  ,""})
AADD(aStruct,{"SZN->SZ_NUMBOR" ,"C" ,"6"  ,""})
AADD(aStruct,{"SZN->SZ_DATABOR","D" ,"8"  ,""})
AADD(aStruct,{"SZN->SZ_EMIS1"  ,"D" ,"8"  ,""})
AADD(aStruct,{"SZN->SZ_HIST"   ,"C" ,"25" ,""})
AADD(aStruct,{"SZN->SZ_MOVIMEN","D" ,"8"  ,""})
AADD(aStruct,{"SZN->SZ_SITUACA","C" ,"1"  ,""})
AADD(aStruct,{"SZN->SZ_DESCONT","N" ,"17","2"})
AADD(aStruct,{"SZN->SZ_MULTA"  ,"N" ,"17","2"})
AADD(aStruct,{"SZN->SZ_JUROS"  ,"N" ,"17","2"})
AADD(aStruct,{"SZN->SZ_CORREC" ,"N" ,"17","2"})
AADD(aStruct,{"SZN->SZ_VALLIQ" ,"N" ,"17","2"})
AADD(aStruct,{"SZN->SZ_VENCORI","D" ,"8"  ,""})
AADD(aStruct,{"SZN->SZ_CONTA"  ,"C" ,"10" ,""})
AADD(aStruct,{"SZN->SZ_VALJUR" ,"N" ,"14","2"})
AADD(aStruct,{"SZN->SZ_PORCJUR","N" ,"5" ,"2"})
AADD(aStruct,{"SZN->SZ_OCORREN","C" ,"2"  ,""})
AADD(aStruct,{"SZN->SZ_DTIMPOR","D" ,"8"  ,""})
AADD(aStruct,{"SZN->SZ_CRED"   ,"C" ,"15"  ,""})
AADD(aStruct,{"SZN->SZ_DEB"    ,"C" ,"15"  ,""})
AADD(aStruct,{"SZN->SZ_CGC"    ,"C" ,"14"  ,""})
AADD(aStruct,{"SZN->SZ_CODASSO","C" ,"6"  ,""})
AADD(aStruct,{"SZN->SZ_CATEG1" ,"C" ,"5"  ,""})

For I := 1 TO Len(aStruct)
DbAppend()
   SX3->X3_ARQUIVO := Substr(aStruct[I,1],1,3)
   SX3->X3_ORDEM   := strzero(I,2)
   SX3->X3_CAMPO   := Substr(aStruct[I,2],1,16)
   SX3->X3_TIPO    := aStruct[I,2]
   SX3->X3_TAMANHO := aStruct[I,3]
   SX3->X3_DECIMAL := aStruct[I,4]
DbCommit()
Next


    



//AADD(aStruct,"SZN->SZ_END"    ,"C" ,"40" ,"")
//AADD(aStruct,"SZN->SZ_BAIRRO" ,"C" ,"20" ,"")
//AADD(aStruct,"SZN->SZ_CEP"    ,"C" ,"8" ,"")
//AADD(aStruct,"SZN->SZ_MUN"    ,"C" ,"15","")
//AADD(aStruct,"SZN->SZ_EST"    ,"C" ,"2" ,"")
//AADD(aStruct,"SZN->SZ_TEL"    ,"C" ,"15","")
//AADD(aStruct,"SZN->SZ_FAX"    ,"C" ,"15","")
//AADD(aStruct,"SZN->SZ_LEITOS" ,"N" ,"5" ,"")
//AADD(aStruct,"SZN->SZ_ATIVIDA","C" ,"5" ,"")
//AADD(aStruct,"SZN->SZ_CONTATO","C" ,"15","")
//AADD(aStruct,"SZN->SZ_DTINIC" ,"D" ,"8" ,"")
//AADD(aStruct,"SZN->SZ_ERSIN"  ,"C" ,"2" ,"")
//AADD(aStruct,"SZN->SZ_NATHOSP","C" ,"2" ,"")
//AADD(aStruct,"SZN->SZ_DTINASS","D" ,"8" ,"")
//AADD(aStruct,"SZN->SZ_DTFIMAS","D" ,"8" ,"")
//AADD(aStruct,"SZN->SZ_SITUAC" ,"C" ,"2" ,"")
//AADD(aStruct,"SZN->SZ_CATLEIT","C" ,"2" ,"")
//AADD(aStruct,"SZN->SZ_DTIMPOR","D" ,"8" ,"")
//AADD(aStruct,"SZN->SZ_DTCADAS","D" ,"8" ,"")
//AADD(aStruct,"SZN->SZ_CODESCC","C" ,"3" ,"")


Return(nil)        // incluido pelo assistente de conversao do AP6 IDE em 22/12/04

