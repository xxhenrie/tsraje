--Sc created by @alejandro35_CR
--Donations: Trx  TPogatXdfcu6CV3Lg1VHxstBBn8L1tM5mt
--********** Doge D5SnhogLZa2iecWG4MJWXsYGnE35Jdqa3V
--High risk and high return script, stay cautious
 
namesc = "FURIOUS WAGER"
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
maxdrop   = 0
pmaxdrop  = 0

stop_profit        = 100 --%
target_stop_profit = (maxbalance * (stop_profit/100))

base_wagger   = balance * 1e-3
base_recov    = base_wagger/500
chance_wagger = 97
chance_recov  = 10
reduce        = 0

nextbet      = base_wagger
chance       = chance_wagger

constant_update = {basewager = true, baserecov = false}

line1 = string.rep("═", #namesc + 12)
line2 = string.rep("═", #namesc + 23)
line3 = string.rep("═", 15)
  
function dobet()
    if win then
        if (constant_update.basewager) then
            base_wagger = balance * 1e-3
        end
        if (profit >= maxprofit) then
            maxbalance  = balance
            maxprofit   = profit
            maxprofit_p = maxprofit/(maxbalance-maxprofit)*100
            if (profit >= target_stop_profit and stop_profit > 0) then
                log("\nStop Target Profit..!")
                stop()
            end
        end
        nextbet = base_wagger
        chance  = math.random(87,97)
    else
        if (currentstreak == -1) then
            if (constant_update.baserecov) then
                base_recov = base_wagger/500
            end
            chance  = chance_recov
            nextbet = base_recov
        end
        if (currentstreak%-2 == 0) then
            if (chance < 5) then chance = chance_recov + reduce end
            reduce = math.random(1*100,2*100)/100
            chance = chance - reduce
        end
        if (currentstreak%-5 == 0) then
            chance = math.random(0.1*100,3*100)/100
        end
        if (currentstreak%-6 == 0) then
            nextbet = nextbet * 1.8
        else
            if (currentstreak < 0) then
                nextbet = nextbet + (nextbet * (11.5 / 100))
            end
        end
        if (currentstreak== -35) then
            nextbet = nextbet/2
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
    log("╚"..line3.."[ By: RumbleDice Group ]"..line3.."╝")
end