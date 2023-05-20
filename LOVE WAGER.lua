--Sc created by @alejandro35_CR
--Donations: Trx  TPogatXdfcu6CV3Lg1VHxstBBn8L1tM5mt
--********** Doge D5SnhogLZa2iecWG4MJWXsYGnE35Jdqa3V

namesc = "LOVE WAGER"
user   = "Alejandro CR" --user so they don't steal your screenshot. 
bot    = "rumble" --wdb

if (string.lower(bot) == "wdb") then resetall() else resetchart() end
ñ

resetstats()
resetseed() 

payouts     = {p_min = 1.01,p_max = 9900} 
ch_wager     = {ch = 98, maxdrop = 83}
--ch_index     = {40,4,30,3,20,2,10,1}
ch_index     = {20,1,20,3,20,5,20,7,20,9}
index        = 1
random_index = false

maxbalance  = balance
maxprofit   = 0
maxprofit_p = 0

minbet     = 1e-8
divisor    = {1e3,1e4,1e5,1e6}
div        = divisor[1]
base_wager = maxbalance/div
nextbet    = base_wager
chance     = ch_wager.ch
ct_loses   = 0
ct_wins    = 0

stop_profit        = 100 --%
target_stop_profit = (balance * (stop_profit/100))

bethigh   = true

function print_consolse(l)
    for i=1,#l do if (string.lower(bot) == "wdb") then log(l[i]) else print(l[i]) end end
end

function dobet()
    if (win) then
        ct_wins = ct_wins + 1
        if (ct_wins == 1) then
            chance = ch_wager.ch
        else
            if (ct_wins%10 == 0) then
                ch_wager.ch = ch_wager.ch - 1
                if (ch_wager.ch < ch_wager.maxdrop) then ch_wager.ch = 98 end
                chance = ch_wager.ch
            end
        end
        if (profit >= maxprofit) then
            maxbalance  = balance
            maxprofit   = profit
            maxprofit_p = maxprofit/(maxbalance-maxprofit)*100
            if (profit >= target_stop_profit and stop_profit > 0) then
                if (string.lower(bot) == "wdb") then
                    log("\nStop Target Profit..!")
                else
                    print("\nStop Target Profit..!")
                end
                stop()
            end
            div        = divisor[math.random(1,#divisor)]
            base_wager = maxbalance/div
            nextbet    = base_wager
            index      = 1
            if (random_index) then index = math.random(1,#ch_index) end
        end 
        ct_loses = 0
    else
        ct_loses = ct_loses + 1
        ct_wins  = 0
        if (ct_loses == 1) then
            bethigh = math.random(100) > 50
            chance  = ch_index[index]
            payout  = ((payouts.p_max/ chance)/100) - 2
            if (payout < payouts.p_min) then payout = payouts.p_min end
            if (payout > payouts.p_max) then payout = payouts.p_max end
            nextbet = ((maxbalance - balance) / payout) + (previousbet/2)
            index   = index + 1
            if (index > #ch_index) then index = 1 end
        else
            chance   = ch_wager.ch
            nextbet  = base_wager
            ct_loses = 0
        end
    end
    if (nextbet < minbet) then nextbet = minbet  end
    l1 = "\n\n\t        ══════════════════════╗"
    l2 = "  >_ SCRIPT      [   ¤  "..namesc.."  ¤   ]  ║\n╔═════════════════════════════════╝"
    l3 = "║-=¦ Running by: ( "..user.." )\n║"
    l4 = "║-=¦ Target Profit: "..stop_profit.."%\n║"
    l5 = "║-=¦ Profit: \t[ "..string.format("%.2f",profit/(balance-profit)*100).."% ]"
    l6 = "║-=¦ MaxProfit:  \t[ "..string.format("%.2f",maxprofit_p).."% ]"
    l7 = "╚══════════════════════════════════════════════════\n\t\tBy: Rumble Dice Group"
    l8 = "-------------------------------------------------------------------------------------------------------"
    l  = {l1,l2,l3,l4,l5,l6,l7,l8}
    print_console(l)
end
