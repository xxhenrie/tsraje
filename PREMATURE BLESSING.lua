--Sc created by @alejandro35_CR
--Donations: Trx  TPogatXdfcu6CV3Lg1VHxstBBn8L1tM5mt
--********** Doge D5SnhogLZa2iecWG4MJWXsYGnE35Jdqa3V
--High risk and high return script, stay cautious
 
namesc = "PREMATURE BLESSING"
user   = "Alejandro35_CR" --user so they don't steal your screenshot.
bot    = "rumble" --wdb

if (string.lower(bot) == "wdb") then
    resetall()
else 
    resetstats() resetchart() resetseed()
end

maxbalance  = balance
maxprofit   = 0
maxprofit_p = 0
maxdrop     = 0
pmaxdrop    = 0

stop_profit        = 100 --%
target_stop_profit = (maxbalance * (stop_profit/100))

nextbet  = balance/1e6
chance   = math.random(0.05*100,1.5*100)/100
reduce   = 0
ct_loses = 0
bethigh  = false

line1 = string.rep("═", #namesc + 13)
line2 = string.rep("═", #namesc + 24)
line3 = string.rep("═", 25)
  
function dobet()
    if win then
        if (profit >= maxprofit) then
            nextbet     = balance/1e6
            maxbalance  = balance
            maxprofit   = profit
            maxprofit_p = maxprofit/(maxbalance-maxprofit)*100
            if (profit >= target_stop_profit and stop_profit > 0) then
                log("\nStop Target Profit..!")
                stop()
            end
        else
            nextbet = nextbet/1e3
            if (nextbet < maxbalance/1e6) then nextbet = maxbalance/1e6 end
        end
        chance   = math.random(0.01*100,1.5*100)/100
        ct_loses = 0
    else
        ct_loses = ct_loses + 1
        reduce   = math.random(0.1*100,0.70*100)/100
        if (ct_loses%90 == 0) then
            nextbet = nextbet * 1.8
        end
        if (ct_loses%150 == 0) then
            nextbet = nextbet * 2.24
        end
        if (ct_loses%200 == 0) then
            nextbet = nextbet/2
        else
            nextbet = nextbet + (nextbet * (0.40/100))
        end
        if (ct_loses%10 == 0) then
            chance  = chance - reduce
        end
        if (ct_loses%50 == 0) then
            chance = chance + reduce
        end
        if (chance < 0.01 or chance > 1.5) then
            chance = math.random(0.01*100,1.5*100)/100
        end
    end
    current_drop  = maxbalance - balance
    if (current_drop >= maxdrop) then maxdrop = current_drop end
    pprof         = profit/(balance-profit)*100
    pcurrent_drop = current_drop/maxbalance*100
    pmaxdrop      = maxdrop/maxbalance*100
    log("\n\n\t        "..line1.."╗\n  >_ SCRIPT      [   ¤  "..namesc.."  ¤   ]  ║\n╔"..line2.."╝")
    log("║-=¦ Running by: ( "..user.." )\n║")
    log("║    Target       Profit        MaxProfit      Drop       MaxDrop")
    log(string.format("║   [ %.2d%% ]    [ %.2f%% ]    [ %.2f%% ]    [ %.2f%% ]    [ %.2f%% ]\n║", stop_profit, pprof, maxprofit_p, pcurrent_drop, pmaxdrop))
    log("╚"..line3.."[ By: RumbleDice Group ]")
end