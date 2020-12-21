*******************************************************************************
* ANALIZA PRZESUNIEC   pwydano=.t. - towar wydany  =.f. - towar przyjety      *
*******************************************************************************
parameters pwydano
local t[18],g[4],dk[3],wd[2],typ[2],zbiorczy[2],szczegolowy[2],magazyn[100]
local lms:=month(daf)         &&numer miesiaca do wydruku
local lmiesiac:=space(12)
local ls:=1                   &&numer pozycji menu wyboru okresu raportu
local ld1:=daf                &&raport za dzien lub poczatek przedzialu czasowego
local ld2:=daf                &&koniec przedzialu czasowego
local lzakup:=.t.           &&wydruk faktur
local lsprzedaz:=.t.          &&wydruk rachunkow 
local lrazem:=.t.          &&wydruk paragonow
local lzbiorczy:=.t.          &&wydruk raportu zbiorczego      
local ek:=savescreen(0,0,24,79)
local lfiltr:=""
local ldruk:=.t.
local ekran,ektyp,lmagazyn:=0,lpusty:=.f.
local lnazwa:=space(15),lkwotowy:=.t.,ltowarowy:=.f.,lwybrany:=.f.,lwszystkie_end:=.f.
private fnum1:=space(15),fnum2:=space(15),fd1:=date(),fd2:=date()
private rnum1:=space(15),rnum2:=space(15),rd1:=date(),rd2:=date()
private pnum1:=space(15),pnum2:=space(15),pd1:=date(),pd2:=date()
private dokument:=0,text1:=space(80),text2:=space(80),text3:=space(80)
public fdat1:=date()
public fdat2:=date()
public fmies:=month(date())
public zmagazyn:=1
drukar=.t.
hzakup=.f.       && rozgraniczenie wydruku dla zakupu i sprzedazy
w=0
t[1]:= "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
t[2]:= "°    R A P O R T :   TOWAR WYDANY Z MAGAZYNU  GLOWNEGO     °"
t[3]:= "°==========================================================°"
t[4]:= "°   PARAMETRY   ²    OKRES :                               °"
t[5]:= "°²²²²²²²²²²²²²²²²                                          °"
t[6]:= "° ZATWIERDZENIE ²                                          °"
t[7]:= "° 1. OKRES      ²                                          °"
t[8]:= "° 2. TYP        ²                                          °"
t[9]:= "° 3. WYDRUK     ²                                          °"
t[10]:="°²²²²²²²²²²²²²²²²                                          °"
t[11]:="°               ²        TYP :          WYDRUK :           °"
t[12]:="°               ²                                          °"
t[13]:="°               ²                                          °"
t[14]:="°               ²                                          °"
t[15]:="°               ²                                          °"
t[16]:="°               ²                                          °"
t[17]:="°               ²                                          °"
t[18]:="°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
if.not.pwydano
  t[2]:= "°   R A P O R T :   TOWAR PRZYJETY DO MAGAZYNU  GLOWNEGO    °"
endif
g[1]:=" ZATWIERDZENIE "
g[2]:=" 1. OKRES      "
g[3]:=" 2. TYP        "
g[4]:=" 3. WYDRUK     "
DK[1]:="    ZBIORCZY   "
DK[2]:="---------------"
DK[3]:="    KWOTOWY    "
WD[1]:="ûÞ DRUKARKA  "
WD[2]:=" Þ EKRAN     "
typ[1]:=" ZBIORCZY    "
typ[2]:=" SZCZEGOLOWY "
zbiorczy[1]:=" KWOTOWY  "
zbiorczy[2]:=" TOWAROWY "
szczegolowy[1]:=" WYBRANY MAGAZYN    "
szczegolowy[2]:=" WSZYSTKIE MAGAZYNY "
text2=space(70)
text3=space(70)
for i=1 to 100
  magazyn[i]:=space(15)
next
for i=2 to wmagil
  magazyn[i-1]=nm[i]
next
save screen to ek
@ 0,0,24,79 box tlo
set color to n/w,w/n
@ 0,0 say " P A R A M E T R Y     R A P O R T U                                            "
for i=1 to 18
  @ i+2,10 say t[i]
next
do skom with "STRZALKI - przemieszczanie kursora   ENTER -  zatwierdzenie    ESC - rezygnacja"
set color to (coldef)
*@ 3,10,20,69 box chr(205)
@ 3,10 to 20,69 double
@ 14,32 to 18,48 double  
@ 14,51 to 17,65 double  
@ 15,33 say dk[1]
@ 16,33 say dk[2]
@ 17,33 say dk[3]
@ 15,52 say wd[1]
@ 16,52 say wd[2]
do anokres with 7,32,ls,lms,ld1,ld2,.t.
do while .t.
  do case
    case lkwotowy
      DK[1]:="    ZBIORCZY   "
      DK[3]:="    KWOTOWY    "
	case ltowarowy
      DK[1]:="    ZBIORCZY   "
      DK[3]:="    TOWAROWY   "			  	  			  
	case lwybrany
      dk[1]="  SZCZEGOLOWY  "
      dk[3]=lnazwa
	case lwszystkie
      DK[1]:="  SZCZEGOLOWY  "
      DK[3]:="   WSZYSTKIE   "			  	  
  endcase
  @ 15,33 say dk[1]
  @ 16,33 say dk[2]
  @ 17,33 say dk[3]
  setprc(0,0)
  w=prow()
  s=achoice(8,11,12,25,g)
  keyboard chr(205)

  do case
    case s=1
      do while.t.	   
        if lwszystkie
		  zmagazyn=zmagazyn+1
          lnazwa=nm[zmagazyn]			
		endif
        save screen to ekran
	    fdat1=ld1          &&przygotowanie zmiennych typu public do filtru
        fdat2=ld2
        fmies=lms
        clear typeahead	
        @ 16,11 say "   Czekaj !    "
        if drukar
          @ 17,11 say "Trwa drukowanne" 
        else
          @ 17,11 say " Trwa analiza. " 
        endif	
************definiowanie filtra czasowego
        if lzbiorczy
          do case
            case ls=1                       &&raport za dzien
	          lfiltr="tdat=fdat1"
		      text2="ZA DZIEN  :                             ZESTAWIENIE ZBIORCZE                                 "          
              text2=stuff(text2,15,8,dtoc(ld1))          		  
	        case ls=2                       &&raport  za miesiac
	          lfiltr="month(tdat)=fmies"
              do miesiac with lms,lmiesiac
		      text2="ZA MIESIAC :                            ZESTAWIENIE ZBIORCZE                                 "          
              text2=stuff(text2,15,12,lmiesiac)          		
            case ls=3                       &&za okres od do
	          lfiltr="max(fdat1,tdat)=tdat.and.min(fdat2,tdat)=tdat"
		      text2="ZA OKRES OD DNIA :                      ZESTAWIENIE ZBIORCZE                                 "          
		      text3="         DO DNIA :                                                                           "          		  
              text2=stuff(text2,19,8,dtoc(ld1))          		  
              text3=stuff(text3,19,8,dtoc(ld2))          		  		  
          endcase
	    else
          do case
            case ls=1                       &&raport za dzien
	          lfiltr="tdat=fdat1.and.tnkon=zmagazyn"
		      text2="ZA DZIEN  :                            MAGAZYN :                                             "          
              text2=stuff(text2,50,15,lnazwa)
              text2=stuff(text2,15,8,dtoc(ld1))          		  
	        case ls=2                       &&raport  za miesiac
	          lfiltr="month(tdat)=fmies.and.tnkon=zmagazyn"
              do miesiac with lms,lmiesiac
		      text2="ZA MIESIAC :                           MAGAZYN :                                             "          
              text2=stuff(text2,50,15,lnazwa)
              text2=stuff(text2,15,12,lmiesiac)          		
            case ls=3                       &&za okres od do
	          lfiltr="max(fdat1,tdat)=tdat.and.min(fdat2,tdat)=tdat.and.tnkon=zmagazyn"
		      text2="ZA OKRES OD DNIA :                     MAGAZYN :                                             "          
              text2=stuff(text2,50,15,lnazwa)
		      text3="         DO DNIA :                                                                           "          		  
              text2=stuff(text2,19,8,dtoc(ld1))          		  
              text3=stuff(text3,19,8,dtoc(ld2))          		  		  
          endcase	
	    endif  
*************
        if.not.drukar
          @ 16,11 say "   Czekaj !    "
          @ 17,11 say " Trwa analiza. " 
          if.not.lwszystkie
		    delete file "\kj.txt"
		  endif	
          set printer to "\kj.txt"
        else
          do startrap with 1,ldruk
	      if.not.ldruk
            restore screen from ek
	        return
	      endif
          @ 16,11 say "   Czekaj !    "
          @ 17,11 say "Trwa drukowanne"   
        endif  
  
        set device to printer
        if drukar
          @ prow(),pcol() say &zdr_kond
        else
	      clear typeahead 
        endif	
        text1="ANALIZA PRZESUNIEC                                                              "  

        select 1
          if pwydano
		    use przes1
		    index on tnaz + tkod to pm_naz
		    use przes1 index pm_naz
		  else
		    use przes2
		    index on tnaz + tkod to pm_naz
		    use przes2 index pm_naz
		  endif  
		  set filter to &lfiltr
	      go top
          do case
            case lkwotowy
	         text1="TOWAR WYDANY Z MAGAZYNU GLOWNEGO - PODSUMOWANIE KWOTOWE                         "  
			 if substr(ztyp,4,1)$"Xx"
               text1="TOWAR PRZYJETT DO MAGAZYNU GLOWNEGO - PODSUMOWANIE KWOTOWE                         "  			 
			 endif
			  do rap_kwotowy
            case lwszystkie
			  do pusty with lpusty
			  if.not.lpusty
			    do przesdruk
              else
			    if.not.drukar
    	  	      clear typeahead 
				  @ 0,0 say ""
				  @ 1,0 say ""
				  @ 2,0 say ""
				  @ 3,0 say ""
				  @ 4,0 say ""
				  @ 5,0 say ""	
   				  @ 6,24say "MAGAZYN  "
				  @ 6,40 say nm[zmagazyn]
                  @ 7,24 say  "================================"
				  @ 12,24 say "Brak zarejestrowanych przesuniec."
				  @ 14,24 say "     Esc - nastepny magazyn      "
				endif  
			  endif
		    case lwybrany.or.ltowarowy
		      do przesdruk
	      endcase		  
          close
        set printer to

        if.not.drukar
	      naz:="\kj.txt"
          do medit with naz
        endif  
        set device to screen	  
        if.not.lwszystkie
          restore screen from ekran
		endif  
        @ 16,11 say "Koniec raportu!"
        @ 17,11 say "Esc->rezygnacja" 
	    if lkwotowy.or.ltowarowy.or.lwybrany.or.(lwszystkie.and.zmagazyn=wmagil)
          if lwszystkie
		    zmagazyn=1
            lnazwa=nm[2]
			restore screen from ektyp
		  endif
	      exit
        endif
	  enddo
    case s=2
      do anokres with 7,32,ls,lms,ld1,ld2,.F.
    case s=3
	  save screen to ektyp
      @ 6,27 clear to 19,68
	  @ 7,10 to 12,26 double
	  @ 10,25 to 13,39 double
      s_typ=achoice(11,26,12,38,TYP)
      do case
	    case s_typ=1
		  lzbiorczy=.t.
		  @ 11,38 to 14,49 double
		  s_zbior=achoice(12,39,13,48,ZBIORCZY)
          do case
		    case s_zbior=1
			  lkwotowy=.t.
			  ltowarowy=.f.
			  lwybrany=.f.
			  lwszystkie=.f.

		    case s_zbior=2
			  lkwotowy=.f.
			  ltowarowy=.t.
			  lwybrany=.f.
			  lwszystkie=.f.		

		  endcase
	    case s_typ=2
		  lzbiorczy=.f.
		  @ 11,38 to 14,59 double
		  s_szcz=achoice(12,39,13,58,SZCZEGOLOWY)		  
          do case
            case s_szcz=1
			  lkwotowy=.f.
			  ltowarowy=.f.
			  lwybrany=.t.
			  lwszystkie=.f.			
			  @ 6,11 clear to 19,68
			  @ 6,49 to 19,65 double
              @ 3,10 to 20,69 double			  
			  @ 9,20 say "WYBIERZ MAGAZYN"
			  @ 10,20 say"  DO ANALIZY  "			  
			  @ 14,11 to 18,47 
              if pwydano
			    @ 15,12 say "     Raport  obejmie  zestawienie "
			    @ 16,12 say " towarow przesunietych z magazynu "
			    @ 17,12 say " glownego  do  magazynu wybranego."
			  else
			    @ 15,12 say "     Raport  obejmie  zestawienie "
			    @ 16,12 say " towarow przesunietych z magazynu "
			    @ 17,12 say " wybranego  do  magazynu glownego."			  
			  endif	
			    s_mag=achoice(7,50,18,64,magazyn)		                  
                zmagazyn=s_mag+1
                if s_mag#0
				  lnazwa=magazyn[s_mag]
                else
			      lkwotowy=.t.
			      ltowarowy=.f.
			      lwybrany=.f.
			      lwszystkie=.f.				
				endif  

            case s_szcz=2
			  lkwotowy=.f.
			  ltowarowy=.f.
			  lwybrany=.f.
			  lwszystkie=.t.		
              zmagazyn=1
              lnazwa=nm[2]			  
		  endcase
	  endcase
	  restore screen from ektyp

    case s=4
      ws=achoice(15,52,16,64,wd)
      do case
	    case ws=1
		  drukar=.t.
		  wd[1]=stuff(wd[1],1,1,"û")
		  wd[2]=stuff(wd[2],1,1," ")
	    case ws=2
		  drukar=.f.
		  wd[1]=stuff(wd[1],1,1," ")		  
		  wd[2]=stuff(wd[2],1,1,"û")
	  endcase
      @ 15,52 say wd[1]
      @ 16,52 say wd[2]	  
	case s=0
	  exit  
  endcase
enddo
restore screen from ek
RETURN


PROCEDURE PRZESDRUK
local lp:=1
local lt1:="|   |                                |       |               |               |               |"
local lt2:="|   |                                |       |               |               |               |"
local lt3:="----------------------------------------------------------------------------------------------"
local lnazwa:=space(32)
local lkod:=space(12)
local lcen_m:=0,lilosc:=0,lwartosc:=0,lwarsum:=0
setprc(0,0)
w=prow()
do przesglow
do przestyt		
do while.not.eof()
  lnazwa=tnaz
  lkod=tkod
  lilosc=0
  lwartosc=0
  do while tnaz=lnazwa.and.tkod=lkod
    lilosc=lilosc+til
	do case
	  case przestyp=1
	    lwartosc=lwartosc+round(til*round(tcen,2),2)
	  case przestyp=2
	    lwartosc=lwartosc+round(til*round((tcen*(1+tstawka/100)),2),2)		
	endcase	
    skip
  enddo
  skip -1
  lwarsum=lwarsum+lwartosc
    lt1=stuff(lt1,2,3,str(lp,3))
    lt1=stuff(lt1,6,32,lnazwa)
	lt1=stuff(lt1,39,7,lkod)
	lt1=stuff(lt1,47,15,str(lilosc,15,2))
	lt1=stuff(lt1,63,15,str((lwartosc/lilosc),15,2))
	lt1=stuff(lt1,78,15,str(lwartosc,15,2))	
    @ w,0 say lt1
    w=w+1
    lt1:="|   |                                |       |               |               |               |"
  skip
  if w>dlugosc-4.and..not.eof().and.drukar
    stro=.t.
    @ w,0 say lt3
	strona=strona+1
	  @ w+3,7 say "Ciag dalszy dokumentu - PATRZ STRONA :"
      @ w+3,pcol() say strona picture "999"
      eject
	  w=prow()
    do przestyt						
  endif
  lp=lp+1
enddo
  do przesstopa with lwarsum
  if drukar
    eject
  else 
    w=0
    clear typeahead  
  endif  
RETURN


*******************************************************************************
* DRUKUJE NAGLOWEK RAPORTU : rodz dokumentu, okres ,od numeru do numeru       *
*******************************************************************************
PROCEDURE PRZESGLOW
  if drukar
    if grafik
      @ prow(),pcol() say &zdr_grubo+&zdr_kkond
    else
      @ prow(),pcol() say &zdr_kkond
    endif
  endif
  @ w,0 say text1
  w=w+1
  @ w,0 say "======================="
  w=w+1
  @ w,0 say text2
  w=w+1
  @ w,0 say text3
  if drukar
    if grafik
      @ prow(),pcol() say &zdr_kgrubo	
*      @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
*    else
*      @ prow(),pcol() say &zdr_kond
    endif  
  endif
  w=w+1
RETURN




PROCEDUR PRZESTYT
local lt1:="=============================================================================================="
local lt2:="|Lp.|   N A Z W A   T O W A R U      | K O D |     ILOSC     | SREDNIA  CENA | LACZNA WARTOSC|"
local lt3:="|   |                                |       |               |   N E T T O   |    N E T T O  |"
local lt4:="|===|================================|=======|===============|===============|===============|"
local lt5:="|   |                                |       |               |               |               |"
if przestyp=2
  lt3:="|   |                                |       |               |   B R U T T O |   B R U T T O |"
endif
@ prow(),pcol() say &zdr_kond
@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
w=w+1
@ w,0 say lt4
w=w+1
@ w,0 say lt5
w=w+1
RETURN


PROCEDURE PRZESSTOPA
PARAMETERS pwartosc
local lt1:="|   |                                |       |               |               |               |"
local lt2:="=============================================|===============|===============|===============|"
local lt3:="                                                             |  R A Z E M  : |               |"
local lt4:="                                                             ---------------------------------"
lt3=stuff(lt3,78,15,str(pwartosc,15,2))
@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
w=w+1
@ w,0 say lt4
w=w+1
if.not.drukar
  w=w+5
  @ w,0 say replicate(chr(42),138)
  @ w,10 say " Esc - rezygnacja "
endif
RETURN


PROCEDURE RAP_KWOTOWY
local lt1:="|   |                 |                                      |                 |"
local lkwota,lrazem:=0
fwar=dbfilter()
public rap_war:=fwar
w=prow()
do przesglow
do kwottyt
for i=2 to wmagil
  set filter to tnkon=i
  go top
  rap_war=fwar+""+".and."+dbfilter()
  set filter to &rap_war			      
  go top  
  if przestyp=1
    sum round(til*ROUND(tcen,2),2) to lkwota  
  else
   * sum round(til*brutto(ROUND(tcen,2),tstawka),2) to lkwota  
    sum round(til*brutto(tcen,tstawka),2) to lkwota  
  endif	
  lrazem=lrazem+lkwota
  lt1=stuff(lt1,2,3,str(i-1,3))
  lt1=stuff(lt1,7,15,nm[i])
  lt1=stuff(lt1,25,15,mm[i])
  lt1=stuff(lt1,44,15,um[i])
  lt1=stuff(lt1,64,15,str(lkwota,15,2))
  if lkwota#0
    w=w+1
    @ w,0 say lt1
  endif	
next
do kwotstopa with lrazem
eject
RETURN

PROCEDURE KWOTSTOPA
parameters prazem
local lt1:="-------------------------------------------|-----------------|-----------------|"
local lt2:="                                           |   R A Z E M  :  |                 |"
local lt3:="                                           -------------------------------------"
lt2=stuff(lt2,64,15,str(prazem,15,2))
w=w+1
@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
RETURN

PROCEDURE KWOTTYT
local lt1:="================================================================================"
local lt2:="|Lp.|    N A Z W A    |              A  D  R  E  S           |    K W O T A    |"
local lt3:="|   |    MAGAZYNU     |    MIASTO      /      ULICA          |    N E T T O    |"
local lt4:="|===|=================|======================================|=================="
local lt5:="|   |                 |                                      |                 |"
if przestyp=2
  lt3:="|   |    MAGAZYNU     |    MIASTO      /      ULICA          |   B R U T T O   |"
endif
*@ prow(),pcol() say &zdr_kond
@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
w=w+1
@ w,0 say lt4
w=w+1
@ w,0 say lt5
w=w+1
RETURN




