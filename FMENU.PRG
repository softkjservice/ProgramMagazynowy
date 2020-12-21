*******************************************************************************
* MENU PROGRAMU "FIRMA"                                                       *
****************************************************************************** 
local t1[2],t2[2],t3[4],T4[2],t5[6],t10[4],t11[3],T6[3],T7[2],T8[4],t9[3],t12[5],t13[3],T14[2]
local s:=1
local last:=lastkey()
local em,em1,em2,em3,em4
local lmnaz:=space(32)
*local pozm:=1
declare t[5]
hel="firma"
t14[1]:="W CENACH NETTO " 
t14[2]:="W CENACH BRUTTO" 
t6[1]:="WYDANO DO MAG."
t6[2]:="PRZYJETO Z MAG"
t6[3]:="ROZLICZENIE   "
t10[1]:="1. RACHUNKI  "
t10[2]:="2. PARAGONY   "
t10[3]:="4. Z A K U P. "
t10[4]:="5.PRZESUNIECIE"
t11[1]:="1. FAKTURY   "
t11[2]:="2. RACHUNKI  "
t11[3]:="3. PARAGONY   "
t1[1]:=" PRZESUNIECIE "
t1[2]:=" WYDANIE ZEWN."
t2[1]:=" PRZESUNIECIE  "
t2[2]:="PRZYJECIE ZEWN."
t3[1]:=" MM -  WYDANO "
t3[2]:=" MM - PRZYJETO"
t3[3]:=" WZ -  WYDANO "
t3[4]:=" PZ - PRZYJETO"
*t3[4]:="4.BIL.OTWARCIA"
t4[1]:="1. MAGAZYNY   "
t4[2]:="2. KONTRAHENT "
t5[1]:=" A N A L I Z A"
t5[2]:=" OPER..DYSKOWE"
t5[3]:=" PARAMETRY    "
t5[4]:=" INDEKSACJA   "
*t5[5]:=" REDUKCJA     "
t5[5]:=" ZEROWANIE BAZ"
t5[6]:=" NOWY ROK     "

t[1]:="    WYDANO   "
t[2]:="   PRZYJETO  "
t[3]:="   MAGAZYN   "
t[4]:="  KONTRAHENT "
t[5]:="   I N N E  "
t7[1]:=" R A P O R T  "
t7[2]:=" R E J E S T R"
t12[1]:=" Z A K U P    "
t12[2]:=" SPRZEDAZ     "
t12[3]:=" FAKTURY - SP."
t12[4]:=" RZCHUNKI- SP."
t12[5]:=" UTARGI -  SP."
t13[1]:="SPRZEDAZ-ZEST."
t13[2]:="TOWAR - ZYSK  "
t13[3]:="DOKUMENT-ZYSK "
t8[1]:="    RAPORT    "
t8[2]:="   DOKUMENTY  "
t8[3]:="     TOWAR    "
t8[4]:=" BIL. OTWARCIA"
t9[1]:="FAKTURA NETTO"
t9[2]:="FAKTURA BRUTT"
t9[3]:="RACHUNEK     "
aspozyc=10
set color to
set cursor off
@ 4,0 clear to 6,79
@ 4,0 to 6,79 double
@ 5,2 say t[1]
@ 5,17 say t[2]
@ 5,33 say t[3]
@ 5,49 say t[4]
@ 5,65 say t[5]
do kreska with 4,15
do kreska with 4,31
do kreska with 4,47
do kreska with 4,63
@ 4,0 say chr(204)
@ 6,0 say chr(204)
@ 4,79 say chr(185)
@ 6,79 say chr(185)
*@ 4,16 say chr(207)
*@ 4,63 say chr(216)
@ 0,60 say chr(205)
@ 0,61 say chr(205)
@ 0,62 say chr(205)

do pole2 with pozm

do while .t.
  close databases
  do while .t.
    last=inkey(0)
    if last=27.or.last=13.or.last=19.or.last=4.or.last=1.or.last=6.or.last=68.or.last=100.or.last=77.or.last=109.or.last=75.or.last=107.or.last=87.or.last=119.or.last=73.or.last=105.or.last=-1 
      exit
    endif
    if last=-9
	  do robak
	endif
  enddo
	  do case
        case last=-1
          do gmag 
	    case last=19     &&strzalka w lewo
	      if pozm>1
		    pozm=pozm-1
		  else
		    pozm=5
		  endif
	    case last=4
	      if pozm<5
		    pozm=pozm+1
		  else
		    pozm=1
		  endif
	    case last=80.or.last=112   &&Przyjeto
	      pozm=1
	    case last=87.or.last=119   &&Wydano 
	      pozm=2
		case last=77.or.last=109   &&Magazyn
		  pozm=3		  
        case last=75.or.last=107   &&Kontrahent
		  pozm=4
        case last=73.or.last=105   &&Inne    
		  pozm=5		  
	    case last=27
          @ 21,1 clear to 23,78
          zm=.t.
          set cursor on
          @ 21,27 to 23,48 double
          set color to w/n*
          @ 22,29 say "K O N I E C  ?  "get zm
          read
          set cursor off
          set color to
          if zm
            return
          endif	
          return

	    case last=13
          do pole2 with pozm	  
		  exit			    	    
	 endcase
     do pole2 with pozm
  enddo
save screen to em
do case
  case pozm=1
    analiza=.f.
    d=1
    do while .t.
      set color to
      @ 6,0 TO 9,15 double   
      d=achoice(7,1,8,14,t1,,,d)   
        do case
          case d=1
            ztyp="MM/B"
            do kartdok	
		  case d=2
            if.not.file("wz_dok.dbf")
			  select 1
			  use dzy1mag
			  copy structure to wz_dok
			  use wz_dok
			  index on nskrot to wz_kon
			  index on ndok to wz_num
			  use przes1
			  copy structure to wz_tow
			  use wz_tow
			  index on tndok to wz_tow
			  close
			endif
			if wztyp=1
		      ztyp="WZ/W"                && W-Zetka  liczona netto
			else
		      ztyp="WZ/w"                && W-Zetka	 liczona od brutto 					
			endif  
			do kartdok	
	      case d=0
		    exit			    
        endcase 
    enddo
  case pozm=2
    analiza=.f.
     analiza=.f.
     d=1
	 do while.t.
	   set color to
	   @ 6,15 to 9,31 double   
	   d=achoice(7,16,8,30,t2,,,d)   
         do case
		   case d=1
             ztyp="MM/C"
             do kartdok  		   
		   case d=2
  			 save screen to em1
             do while.t.
			   set color to (coldef)
			   @ 7,28 to 10,44 double
			   dtyp=achoice(8,29,9,43,t14)
			   if dtyp#0   
                 if.not.file("pz_tow.dbf")
			       select 1
			       use dzy1mag
			       copy structure to pz_dok
			       use pz_dok
			       index on nskrot to pzx_kon
			       index on ndok to pzx_num
			       use przes1
			       copy structure to pz_tow
			       use pz_tow
			       index on tndok to pz_tow
			       close
			     endif
			     do case
				   case dtyp=1
				     ztyp="PZ/X"	              && P-Zetka od cen netto
				   case dtyp=2
				   	 ztyp="PZ/x"	              && P-Zetka  od cen brutto			  
				 endcase
			     do kartdok
		       else
			   	 restore screen from em1
				 exit	 
			   endif		   
			 enddo  
		   case d=0
		     exit 
		 endcase
     enddo


   case pozm=3
     do while.t.
       if wmag
         do WyborMag
       else
	     do magdefault
       endif
           if lastkey()=27.or.lastkey()=19.or.lastkey()=4
             restore screen from em
             do dokdefault
			 exit
           endif	   
           pdok=.f.
           asmenu=.t.
           cena=" "
           do mag with lmnaz,space(7),.f.
		   lmnaz=zmnaz
           restore screen from em
     enddo 
	 restore screen from em

   case pozm=4
            pksiega=.f.
			pdok=.f.
           do kontrah with space(30) 
	 

 case pozm=5.and.in10
     dd=1
     do while .t.
	 restore screen from em
	   do tx with 0,22,"<STRZALKI> - wybor  <ENTER> - zatwierdzenie   <ESC> - rezygnacja"
       if in47
	     do txt213 with 23, "F2 - WYBOR MAGAZYNU GLOWNEGO"
	   endif
	   set color to
       @ 6,63 TO 13,79 double   
       dd=achoice(7,64,12,78,t5,,,dd)   
       do case 
         case dd=1
           do while.t.
	         do tx with 0,22,"Zatwierdz rodzaj analizy."		   
		     @ 10,48 to 15,64 double 
             z=achoice(11,49,14,63,t8)
			 save screen to em1
			   do case
			     case z=1
                   analiza=.t.
	               do while .t.
				     set color to 
        			 save screen to em4
				     @ 12,33 to 17,49 double 
                     s=achoice(13,34,16,48,t3)
				     do case
					   case s=1
			             do przehis with .t.      &&Wydano
					   case s=2
                         do przehis with .f.        &&Przyjeto 
					   case s=3
			             do wzhis with .t.      &&Wydano
					   case s=4
                         do wzhis with .f.        &&Przyjeto 						 
					   case s=0
					     exit
					 endcase  
					 restore screen from em4
				   enddo	 				 
                   
				 

                 case z=2
                   analiza=.t.
	               do while .t.
				     set color to (coldef)
				     @ 14,31 to 17,47 double 
                     s=achoice(15,32,16,46,t3)
				     do case
					   case s=1
                         ztyp="MM/B"
                         do kartdok	
					   case s=2
                         ztyp="MM/C"
                         do kartdok							 
					   case s=0
					     exit
					 endcase  
				   enddo	 
					 

			     case z=3
                   analiza=.t.
	               do while .t.
				     set color to (coldef)
				     @ 14,31 to 17,47 double 
                     s=achoice(15,32,16,46,t3)
				     do case
					   case s=1
                         do rejestr with 4
					   case s=2
                         do rejestr with 5
					   case s=0
					     exit
					 endcase  
				   enddo	 				 
				 
                  case z=4
                    save screen to em2
			        if wmag
                      do tx with 0,22,"Zatwiedz magazyn."
					  do WyborMag
                    else
	                  do magdefault
                    endif
        			do mag with "","",.f.,"BO"
					do dokdefault
		        	restore screen from em2					 
					
                  case z=0
				    restore screen from em1
				    exit
				endcase	
             restore screen from em1				 
		   enddo	 
         

         case dd=2
           do case
             case dysk="A:\"
               do tx with 0,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie A:"
             case dysk="B:\"
               do tx with 0,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie B:"	
           endcase  
           do march
	       dd=2
		   pozm=5 
         case dd=3
           do param	
		 case dd=4
           do magindex		   	   
*        case dd=5.and.in32
*          do tx with 0,21,"<ENTER> - zatwierdzenie przedzialu czasowego  <ESC> - rezygnacja."
*          do tx with 1,22,"W wyniku dzialania modulu objete zadeklarowanym przedzialem czsowym dokumenty "   
*          do tx with 1,23,"przaniesione zostana na dyskietke i dostepne  poprzez funkcje REKONSTRUKCJA   "
*	   do haslo with 15,34
*	   if magpraw.and.haslo#space(10).and.shaslo#space(10).and.lastkey()#27
*	     do dziel
*	   endif	 
*        case dd=5.and..not.in32
*	   do wersja		   
         case dd=5
           do tx with 0,21," UWAGA!  W wyniku dzialania modulu zatwierdzone do zerowania grupy baz danych "
           do tx with 1,22,"                       zostana bezpowrotnie utracone.                         "   
           do tx with 1,23,"       OPERACJE ZEROWANIA NALEZY POPRZEDZIC ARCHIWIZACJA BAZ DANYCH !!        "
		   do haslo with 15,34
		   if magpraw.and.haslo#space(10).and.shaslo#space(10).and.lastkey()#27
		     do zero
		   endif	 
         case dd=6
		   do nowyrok
		 case dd=0
            exit 
       endcase
     enddo
  case pozm=1.and..not.isprzed
    do tkom with "Funkcja dostepna w rozszerzonej wersji programu. Nacisnij dowolny klawisz."  
  case pozm=2.and..not.idost
    do tkom with "Funkcja dostepna w rozszerzonej wersji programu. Nacisnij dowolny klawisz."  
   case pozm=3.and..not.wmag	 
     do tkom with "Funkcja dostepna w wielomagazynowej wersji programu. Nacisnij dowolny klawisz!"
   case s=3.and..not.wmag
     do tkom with "Funkcja dostepna w wielomagazynowej wersji programu. Nacisnij dowolny klawisz!"
endcase
restore screen from em
RETURN

PROCEDURE POLE2
parameters ppoz
do case
  case ppoz=1
    set color to n/w
    @ 5,2 say t[1]
	set color to
    @ 5,17 say t[2]
    @ 5,33 say t[3]
    @ 5,49 say t[4]
    @ 5,65 say t[5]
  case ppoz=2
    @ 5,2 say t[1]
	set color to n/w
    @ 5,17 say t[2]
	set color to
    @ 5,33 say t[3]
    @ 5,49 say t[4]
    @ 5,65 say t[5]
  case ppoz=3
    @ 5,2 say t[1]
    @ 5,17 say t[2]
	set color to n/w
    @ 5,33 say t[3]
	set color to
    @ 5,49 say t[4]
    @ 5,65 say t[5]
  case ppoz=4
    @ 5,2 say t[1]
    @ 5,17 say t[2]
    @ 5,33 say t[3]
	set color to n/w
    @ 5,49 say t[4]
	set color to
    @ 5,65 say t[5]
  case ppoz=5
    @ 5,2 say t[1]
    @ 5,17 say t[2]
    @ 5,33 say t[3]
    @ 5,49 say t[4]
	set color to n/w
    @ 5,65 say t[5]				
	set color to
endcase  
do tx with 0,22,"<STRZALKI> - wybor  <ENTER> - zatwierdzenie   <ESC> - rezygnacja"
if in47
  do txt213 with 23, "F2 - WYBOR MAGAZYNU GLOWNEGO"
endif
RETURN
