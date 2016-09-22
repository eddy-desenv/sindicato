#include "rwmake.ch"  

User Function m030ALT()  
retorno := .t.   				
IF SA1->A1_SITUAC == "AS" .OR. SA1->A1_SITUAC=="SS"
	IF MSGYESNO("Altera Cadastro ? "," ATENCAO ! ")
   	retorno := .t.
	ELSE
		RETORNO := .F.
	ENDIF                                               
ENDIF
return(retorno)

