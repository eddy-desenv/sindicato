#include "rwmake.ch"
user function cartao()
use contrib alias con new shared
do while !eof()
	if empty(con->n_cartao)
		dbskip()
		loop
	endif
	DBSELECTAREA("SA1")
	DBSETORDER(3)
	DBSEEK(XFILIAL()+CON->pcc_cgc)
	if found()
		reclock("sa1",.f.)
		sa1->a1_cartao := con->n_cartao+con->d_cartao
		msunlock()
	endif
	dbselectarea("con")
	dbskiP()
enddo		