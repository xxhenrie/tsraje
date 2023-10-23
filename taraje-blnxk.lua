apikey = "c21c375e9b8b03d02a070cfc6430c6b60381038dbf4162939034875f4130c6076242ffe53a042f7558208af2980c310b"
mirror = "stake.jp"
cookie = "__cf_bm=mcV6cWfhK4mTDjhcY3Yb_GJxMEMMMOyXdQvByD7nHJc-1698041290-0-AYL6rE2Nfs1LMZbxxuuiGpZuIXnEKSOp6vG7wy6aD2Vi8XFtPHNsUY8BRvuAIC8VZjqai/tniNNyJPfBxytkPqU="
--cookie = "cf_clearance=gQLN1QpkyV9MJXh5CgZDiGPc1O_94WwH1Z52JSSy0IE-1697984232-0-1-5cba7b86.d3495197.bbb2466-160.0.0"
user_agent = "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Mobile Safari/537.36"
currency = "shib"

-----------------DONT TOUCH ME--------------------
function chance_to_target(chance)
    if broker:lower() == "stake" then
        div = 99
    elseif broker:lower() == "pasino" then
        div = 97
    end
    return tonumber(string.format("%.2f", (div/chance)))
end
-- call this function with chance_to_target(your_chance). e.g:

---------------------------------------------------


-- user-defined settings  
basebet = math.random(15, 45)/10
basechance = math.random(95, 98)  
increasebetEveryLosts = 4
increasebetBy = 1.08
  
-- internal variables  
chance = basechance  
target = chance_to_target(chance)
nextbet = math.random(2,4)
lc1 = 0  
lc2 = 0  
sbr = balance  
negs = 0  
lvl = 1  
lvl2 = lvl  
bethigh = true  
stopwin = false  
  
function calc_bet()  
    local co = (1 / chance) * 99  target = chance_to_target(chance)
    local cco = co + (lc2 / increasebetEveryLosts)  
    local pp = basebet * lc1 * (co - 1)  
    local nb = (negs + pp) / (cco - 1)  
    return math.max(nb, basebet)  
end  
  
function dobet()  
    -- handle win/lose  
    if win then  
        if stopwin then stop() end  
        nextbet = math.random(2, 4)
        chance = basechance  
        target = chance_to_target(chance)
        lc1 = 0  
        lc2 = 0  
        lvl = 1  
        sbr = balance  
    else  
        -- update variables for lost bet  
        negs = sbr - balance  
        lc1 = lc1 + 1  
        lc2 = lc2 + 1  
  
        -- calculate new bet size  
        if lc2 >= increasebetEveryLosts then  
            lvl = lvl + 1  
            nextbet = nextbet * increasebetBy  
            lc2 = 0  
        end  
        nextbet = calc_bet()  
  
        -- calculate new chance  
        chance = (1 / ((negs + (nextbet * lc1)) / nextbet)) * 99  
        target = chance_to_target(chance)
    end  
  
    -- check for minimum chance  
    if chance < 5 then chance = 4.8 end  target = chance_to_target(chance)
  
    -- update maximum level reached  
    if lvl > lvl2 then lvl2 = lvl end

    if currentstreak > -221 then resetseed() end  
end


