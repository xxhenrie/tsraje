--#Cenglay

chance  = 98
basebet = 0.001
nextbet = basebet
wcount  = 0
lcount  = 0
btarget = balance * 2
profitc = 0
 
function dobet()

    if btarget <= balance then
        stop()
    end
 
    if win then
   
        wcount  = wcount + 1
  lcount  = 0
    else
  if bets%2==0 then nextbet = previousbet + (previousbet * (50/ 100)) end
        lcount = lcount + 1  
    end  

 if wcount == 2 then
     chance = 66--math.random(22,33)
    wcount = 0
 end
 
 if lcount == 1 then
    chance  = 12.38
 end
 
 if lcount ==  2 then
     chance = 80
 end
 
 if lcount ==   3 then
     chance = 90
 end
 
 if lcount ==   4 then
     chance = 91
 end
 
 if lcount ==   5 then
     chance = math.random(90,91)
 end
  profitc = profitc + lastBet.profit 
  if profitc > 0 and win then 
  profitc = 0 
  nextbet = basebet 
  chance  = math.random(90,91)
 end 
end