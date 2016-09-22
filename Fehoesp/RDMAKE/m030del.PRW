#include "rwmake.ch"  

User Function m030del()  
retorno := .f.   				
IF MSGYESNO("Exclui  Cadastro ? "," ATENCAO ! ")
   retorno := .t.

ENDIF   
return(retorno)

