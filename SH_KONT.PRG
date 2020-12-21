PROCEDURE KONTTLO1
     if kolor=0  
	   set color to n/w
     else
	   set color to (coldef)
	 endif  
	   for i=9 to 23
         @ i,24 say replicate(chr(178),55)
       next
       set color to (coldef)
       @ 10,26 say "     D A N E    K O N T R A H E N T A    nr        "

       @ 11,26 say " ------------------------------------------------- "
       set color to n/w
	   
       @ 24,0 say space(80)
       @ 12,26 say " NAZWA............                              .  "
       @ 13,26 say " CD NAZWY.........                              .  "
       @ 14,26 say " NIP....             .     KOD POCZTOWY...  -   .  "
       @ 15,26 say " MIASTO...........                              .  "
       @ 16,26 say " ULICA / NR.......                              .  "	   
       @ 17,26 say " GRUPA..     .............TEL....               .  "
       @ 18,26 say " PAGER..               .  FAX....               .  "      
       @ 19,26 say " KONTO..                                        .  "
       @ 20,26 say " KONTO (CD).................                    .  "
       @ 21,26 say " SKROT ...........               .   RABAT      %  "
       set color to
RETURN	   


*******************************************************************************
* Procedura wprowadza zmienne kontrahenta i generuje skroty nazwy i adresu    *
*******************************************************************************
PROCEDURE KONTRAHGET
set color to n/w     
  @ 20,54 say substr(zkkonto,41,20)
set color to 
       set cursor on
       @ 12,44 get znaz1 picture "@!"
       @ 13,44 get znaz2 picture "@!"
       @ 14,34 get znip picture "@!" 
	   @ 14,67 get zkod picture "@!" 	   	   
       @ 15,44 get zmiasto picture "@!"
       @ 16,44 get zulica picture "@!" 
	   @ 17,34 get zgrupa picture "@!" 
       @ 17,59 get ztel picture "@!" 
       @ 18,34 get zpager picture "@!" 
       @ 18,59 get zfax picture "@!" 
       @ 19,34 get zkkonto picture "@S40"
       @ 21,44 get znskrot picture "@!" 
	   @ 21,69 get zrabat picture "99.9"
       read
       if znskrot=space(15)
	     if znip#space(13)
		   znskrot=znip
		 else
		   znskrot=substr(zulica,1,15)
		 endif
       *  znskrot=substr(znaz1,1,15)
         set color to n/w  
         @ 21,44 say znskrot 
         set color to 
       endif
       set color to n/w
	   @ 20,54 say substr(zkkonto,41,20)
	   set color to
RETURN	   
