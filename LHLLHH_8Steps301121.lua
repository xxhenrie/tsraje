--LHLLHH 8Steps Script by Christian 
--Basis https://www.youtube.com/watch?v=XvmNB-w0hZA


multiplier = 2
chance     = 49.5
faktor     = 100000 --balance divider
base       = balance / faktor
prozent	   = 100 --Stop after Profit in percent
target     = ((balance / 100) * prozent) + balance
wincount   = 0
loosecount = 0
roundno    = 0
noofbets   = 0
Hcount     = 1
maxloose   = 0
debuging   = false
security   = false
--initialisierung

nextbet    = base
bethigh    = false

resetseed()
resetstats()
        
function dobet()
--Stoppen bei Ziel
    if balance >= target then
    print("-------------------------------------------------------")
    print("-------------------Session Beendet---------------------")
    print("Ziel erreicht nach ".. noofbets .. " Wetten, " .. prozent .. "% Gewinn")
	print("Max loose Streak: " .. maxloose)
    print("-------------------------------------------------------")
    stop()
    else

--Seedreset nach session
    if roundno == 52 then --52 oder 101
    resetseed()
    roundno    = 0
    end

--Seedreset bei 5 unterschied
    if wincount >= loosecount+5   then  --or loosecount >= wincount+5
    resetseed()
    wincount   = 0
    loosecount = 0
    end
    
--LHLHH Counter auf 1 setzen    
    if Hcount == 7 then
    Hcount     = 1
    end
    
    
--LHLHH 
    if Hcount == 1 then
    bethigh    = false
    end
        
    if Hcount == 2 then
    bethigh    = true   
    end
    
    if Hcount == 3 then
    bethigh    = false
    end
    
    if Hcount == 4 then
    bethigh    = false
    end
    
    if Hcount == 5 then
    bethigh    = true
    end
    
    if Hcount == 6 then
    bethigh    = true
    end
  
--Gewonnen  
    if win then
    nextbet    = balance / faktor   
    wincount   = wincount + 1
	--Seednr auslesen und Notabschaltung
	if security == true then
		if lastBet.Nonce  >=100 then
		print("--------------Notabschaltung wegen Seedreset--------------")
		stop()
		end
	end
    else
    nextbet    = previousbet*multiplier
    loosecount = loosecount + 1
    end

--Debugging 

if debuging == true then
print("---------------------------------------")    
print("Hcount: " .. Hcount) 
print("Wincount: " .. wincount)
print("Loosecount: " .. loosecount)
print("Nr: " .. lastBet.Nonce )
print("---------------------------------------")
end

--Maximal Loose
	if currentstreak < maxloose then
	maxloose = currentstreak
	print("Max loose Streak: " .. maxloose)
	end

roundno    = roundno + 1
Hcount     = Hcount + 1
noofbets   = noofbets + 1
end
end --dobet