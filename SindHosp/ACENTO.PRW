/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNoAccent  บAutor  ณ       Nava         บ Data ณ  03/Nov/07  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para transformar texto acentuado em NAO acentuado    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณGenerico                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NoAccent( cText )

cText := STRTRAN( cText, CHR(198 ), "aa" )
cText := STRTRAN( cText, CHR(228 ), "o" )
cText := STRTRAN( cText, CHR(160 ), "a" )
cText := STRTRAN( cText, CHR(130 ), "e" )
cText := STRTRAN( cText, CHR(161 ), "i" )
cText := STRTRAN( cText, CHR(162 ), "o" )
cText := STRTRAN( cText, CHR(163 ), "u" )
cText := STRTRAN( cText, CHR(133 ), "a" )
cText := STRTRAN( cText, CHR(138 ), "e" )
cText := STRTRAN( cText, CHR(141 ), "i" )
cText := STRTRAN( cText, CHR(149 ), "o" )
cText := STRTRAN( cText, CHR(151 ), "u" )
cText := STRTRAN( cText, CHR(131 ), "a" )
cText := STRTRAN( cText, CHR(136 ), "e" )
cText := STRTRAN( cText, CHR(140 ), "i" )
cText := STRTRAN( cText, CHR(147 ), "o" )
cText := STRTRAN( cText, CHR(150 ), "u" )
cText := STRTRAN( cText, CHR(199 ), "A" )
cText := STRTRAN( cText, CHR(229 ), "O" )
cText := STRTRAN( cText, CHR(181 ), "A" )
cText := STRTRAN( cText, CHR(144 ), "E" )
cText := STRTRAN( cText, CHR(214 ), "I" )
cText := STRTRAN( cText, CHR(224 ), "O" )
cText := STRTRAN( cText, CHR(233 ), "U" )
cText := STRTRAN( cText, CHR(183 ), "A" )
cText := STRTRAN( cText, CHR(212 ), "E" )
cText := STRTRAN( cText, CHR(222 ), "I" )
cText := STRTRAN( cText, CHR(227 ), "O" )
cText := STRTRAN( cText, CHR(235 ), "U" )
cText := STRTRAN( cText, CHR(182 ), "A" )
cText := STRTRAN( cText, CHR(210 ), "E" )
cText := STRTRAN( cText, CHR(215 ), "I" )
cText := STRTRAN( cText, CHR(226 ), "O" )
cText := STRTRAN( cText, CHR(128 ), "C" )
cText := STRTRAN( cText, CHR(135 ), "c" )

Return cText

