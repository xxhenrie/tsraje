--Sc created by @alejandro35_CR
--Donations: Trx  TPogatXdfcu6CV3Lg1VHxstBBn8L1tM5mt
--********** Doge D5SnhogLZa2iecWG4MJWXsYGnE35Jdqa3V
--SC HIGH RISK!

namesc = "WAGER MULTI RECOVER"
user   = "Alejandro CR" --user so they don't steal your screenshot.
bot    = "rumble" --wdb

resetstats() resetseed()
if (string.lower(bot) == "wdb") then resetall() else resetchart() end

maxbalance  = balance
maxprofit   = 0
maxprofit_p = 0
maxdrop     = 0
pmprof      = 0

wager   = {ch = 98, maxdrop = 90, fast_restore = 30}
recover = {
    { risk = "01-med",  ch = {7,10},   iflose = 12,  consecutive = true,  entrance = {20,30}},
    { risk = "02-low",  ch = {7,14},   iflose = 17,  consecutive = true,  entrance = {20,30}},
    { risk = "03-low",  ch = {1,25},   iflose = 15,  consecutive = false, entrance = {20,30}},
    { risk = "04-high", ch = {3,21},   iflose = 33,  consecutive = false, entrance = {20,30}},
    { risk = "05-med",  ch = {9,13},   iflose = 15,  consecutive = true,  entrance = {20,30}},
    { risk = "06-high", ch = {2,16},   iflose = 11,  consecutive = false, entrance = {10,15}},
    { risk = "07-high", ch = {15,40},  iflose = 50,  consecutive = true,  entrance = {20,30}},
    { risk = "08-med",  ch = {20,30},  iflose = 65,  consecutive = false, entrance = {10,10}},
    { risk = "09-high", ch = {60,70},  iflose = 250, consecutive = false, entrance = {20,30}}
}
startch       = wager.ch
minbet        = 1e-8
div           = 1e3
base_wager_x  = maxbalance/div
base_wager_y  = base_wager_x/100
base_recover  = base_wager_y
nextbet       = base_wager_x
tempbet       = base_recover
chance        = wager.ch 
super_inc     = 0
maxsuper_inc  = 3
super_multi   = 20
x             = 1
attempts      = 0
count         = 0
metode        = 0
maxrep_metode = 0
passr         = 0
recovering    = false

stop_profit        = 100 --%
target_stop_profit = (balance * (stop_profit/100))

line1 = string.rep("═", #namesc + 13)
line2 = string.rep("═", #namesc + 24)
line3 = string.rep("═", 25)

function rnd_cc(a,b) return math.random(a*100,b*100)/100 end

function hi_low(result)
    hi = true
    if (result < 1 or result > 99) then
        hi = math.random(100)%2 == 0
    elseif (math.random(100) < 50) then
        hi = false
    end
    return hi
end
    
function dobet()
    bethigh = hi_low(lastBet.roll)
    if (recovering and passr > 0 and bets%passr == 0) then
        if (x > 9 or x == 6) then
            attempts = attempts + 1
            if (attempts%3 == 0) then
                tempbet = tempbet/10
                if (tempbet < base_recover) then
                    tempbet = base_recover 
                end
            end
            if (attempts%10 == 0) then
                base_recover = base_recover * 2
            end
        end
        nextbet = tempbet + (tempbet * (iflose/100))
        tempbet = nextbet
        chance  = rnd_cc(recover[x].ch[1],recover[x].ch[2])
        if (win and profit >= maxprofit) then
            nextbet     = base_wager_x
            chance      = wager.ch
            recovering  = false
            passr       = 0
            count       = 0
            attempts    = 0
            tempbet     = 0
            maxbalance  = balance
            maxprofit   = profit
            maxprofit_p = maxprofit/(maxbalance-maxprofit)*100
            if (profit >= target_stop_profit and stop_profit > 0) then
                log("\nStop Target Profit..!")
                stop()
            end
        end
    else
        if (win) then
            if (wins%10 == 0) then
                wager.ch = wager.ch - 1
                if (wager.ch < wager.maxdrop) then
                    wager.ch = math.floor(rnd_cc(wager.maxdrop,startch))
                end
            end
            if (profit >= maxprofit) then
                recovering  = false  
                passr       = 0
                super_inc   = 0
                metode      = 0
                count       = 0
                attempts    = 0
                maxbalance  = balance
                maxprofit   = profit
                maxprofit_p = maxprofit/(maxbalance-maxprofit)*100
                if (profit >= target_stop_profit and stop_profit > 0) then
                    log("\nStop Target Profit..!")
                    stop()
                end
                x      = math.random(1,#recover)
                iflose = recover[x].iflose
                if (not recover[x].consecutive) then
                    passr = math.random(recover[x].entrance[1],recover[x].entrance[2])
                end
                base_wager_x = maxbalance/div
                base_wager_y = base_wager_x/100
                base_recover = base_wager_y
                nextbet      = base_wager_x
                chance       = wager.ch
                tempbet      = base_recover
            else
                if (super_inc > 0) then
                    if (metode == 1 and count < maxrep_metode+1) then
                        count   = count + 1
                        nextbet = previousbet
                        if (count == maxrep_metode) then
                            count  = 0
                            metode = math.random(1,3)
                        end
                    else
                        count   = 0
                        nextbet = previousbet/10
                        metode  = math.random(1,3)
                    end
                    if (nextbet < minbet) then
                        nextbet = base_wager_y
                    end
                else
                    if (chance < wager.maxdrop) then
                        nextbet = base_wager_y
                    end
                end
            end
        else
            recovering = true
            count      = 0
            if (chance >= wager.maxdrop and metode == 0) then  
                nextbet   = base_recover
                tempbet   = nextbet
                iflose    = recover[x].iflose
                chance    = rnd_cc(recover[x].ch[1],recover[x].ch[2])
                metode    = math.random(1,3)
            else
                if (recover[x].consecutive) then
                    metode  = 0
                    counts  = 0
                    nextbet = previousbet + (previousbet * (iflose/100))
                    chance  = rnd_cc(recover[x].ch[1],recover[x].ch[2])
                else
                    super_inc = super_inc + 1
                    if (super_multi < 1) then super_multi = 1 end
                    if (maxsuper_inc < 1) then maxsuper_inc = 1 end
                    if (metode > 1 or metode == 1 and count == 0) then
                        nextbet = base_wager_y * (super_multi * super_inc)
                        if (nextbet >= (base_wager_y * (super_multi * maxsuper_inc))) then
                            nextbet = base_wager_y 
                        end
                    end 
                    if (super_inc >= maxsuper_inc-1) then
                        super_inc = 0
                    end
                    wager.ch = wager.ch - 1
                    if (wager.ch < wager.maxdrop) then
                        wager.ch = math.floor(rnd_cc(wager.maxdrop,startch))
                    end
                    if (metode == 1) then  
                        chance        = math.floor(rnd_cc(85,95))
                        maxrep_metode = math.random(3,5)
                    end
                    if (metode == 2) then
                        chance = math.floor(rnd_cc(wager.fast_restore,wager.maxdrop))
                    end
                    if (metode == 3) then
                        chance = math.floor(rnd_cc(rnd_cc(40,60),wager.ch))
                    end
                end
            end
        end
    end
    current_drop  = maxbalance - balance
    if (current_drop >= maxdrop) then maxdrop = current_drop end
    pprof         = profit/(balance-profit)*100
    pcurrent_drop = current_drop/maxbalance*100
    pmaxdrop      = maxdrop/maxbalance*100
    log("\n\n\t        "..line1.."╗\n  >_ SCRIPT      [   ¤  "..namesc.."  ¤   ] ║\n╔"..line2.."╝")
    log("║-=¦ Running by: ( "..user.." )\n║")
    log("║-=¦ X = "..x.." / Metode: "..metode.." / Counts: "..count.." / Attempts: "..attempts.." / Passr: " ..passr.."\n║")
    log("║    Target       Profit         MaxProfit       Drop       MaxDrop")
    log(string.format("║   [ %.2d%% ]    [ %.2f%% ]      [ %.2f%% ]    [ %.2f%% ]    [ %.2f%% ]\n║", stop_profit, pprof, maxprofit_p, pcurrent_drop, pmaxdrop))
    log("╚"..line3.."[ By: RumbleDice Group ]")
end
