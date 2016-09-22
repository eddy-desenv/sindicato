#include "rwmake.ch"          
user function indicacgc()
	retorno := .f.
	IF !CGC(M->A1_CGC)
		VALCGC := 0
		FOR n=1 TO 12
			XNUMCGC := val(SUBS(M->A1_CGC,n,1))
			IF N== 1
				VALCGC+= XNUMCGC*6
			ELSEIF N== 2
				VALCGC+= XNUMCGC*7
			ELSEIF N== 3
				VALCGC+= XNUMCGC*8
			ELSEIF N== 4
				VALCGC+= XNUMCGC*9
			ELSEIF N== 5
				VALCGC+= XNUMCGC*2
			ELSEIF N== 6
				VALCGC+= XNUMCGC*3
			ELSEIF N== 7
				VALCGC+= XNUMCGC*4
			ELSEIF N== 8
				VALCGC+= XNUMCGC*5
			ELSEIF N== 9
				VALCGC+= XNUMCGC*6
			ELSEIF N== 10
				VALCGC+= XNUMCGC*7
			ELSEIF N== 11
				VALCGC+= XNUMCGC*8
			ELSEIF N== 12
				VALCGC+= XNUMCGC*9
			ENDIF
		next
		div1 := int(valcgc/11)
		resto1:=valcgc-(div1*11)
		VALCGC := 0
		newcgc := SUBS(M->A1_CGC,1,12)+alltrim(str(resto1))
		
		FOR n=1 TO 13
			XNUMCGC := VAL(SUBS(newCGC,n,1))
			IF N== 1
				VALCGC+= XNUMCGC*5
			ELSEIF N== 2
				VALCGC+= XNUMCGC*6
			ELSEIF N== 3
				VALCGC+= XNUMCGC*7
			ELSEIF N== 4
				VALCGC+= XNUMCGC*8
			ELSEIF N== 5
				VALCGC+= XNUMCGC*9
			ELSEIF N== 6
				VALCGC+= XNUMCGC*2
			ELSEIF N== 7
				VALCGC+= XNUMCGC*3
			ELSEIF N== 8
				VALCGC+= XNUMCGC*4
			ELSEIF N== 9
				VALCGC+= XNUMCGC*5
			ELSEIF N== 10
				VALCGC+= XNUMCGC*6
			ELSEIF N== 11
				VALCGC+= XNUMCGC*7
			ELSEIF N== 12
				VALCGC+= XNUMCGC*8
			ELSEIF N== 13
				VALCGC+= XNUMCGC*9
			ENDIF
		next
		div2 := int(valcgc/11)
		resto2:=valcgc-(Div2*11)
		newcgc := SUBS(M->A1_CGC,1,12)+alltrim(str(resto1))+alltrim(str(resto2))
		
		
		alert("CNPJ correto -"+	newcgc)
		m->a1_cgc:= newcgc
		
	ELSE
		retorno := .t.
	ENDIF
RETURN(RETORNO)
