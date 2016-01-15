module(..., package.seeall)

require("pin")

cc = {{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
cd = {{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
step = 1/10
count = 0

White = {255,255,255}
Red = {255,0,0}
Green = {0,255,0}
Blue = {0,0,255}
Orange = {255,128,0}
Azure = {0,255,255}
Purple = {128,0,255}
Pink = {255,0,255}
Yellow = {255,255,0}

function ColorScale(c, factor)
    cs = {}
    for i=1,3,1 do
        cs[i] = math.floor(c[i] * flator)
    end
    return cs
end

function Clip(num)
    if num > 255 then
        num = 255
    elseif num < 0 then
        num = 0
    end
    return num
end               

function ColortoString(c)
    return string.char(math.floor(Clip(c[1])),math.floor(Clip(c[2])),math.floor(Clip(c[3])))
end

function ColorAdd(c1,c2)
    for i=1,3,1 do
        c1[i] = c1[i] + c2[i] 
    end
end   

function CCtoString()
    local str = ""
    for i=1,4,1 do
        str = str..ColortoString(cc[i])
    end
    return str
end

function led_server()
    if count > 0 then
        count = count - 1
        for i = 1,4,1 do
            ColorAdd(cc[i],cd[i])
        end
        ws2812.writergb(pin.DO, CCtoString())
    end
end

function transit(ct, time)
    count = time / step 
    local delta = 1 / count 
    if(time == 0) then 
        count = 1 
        delta = 1 
    end 
    for i=1,4,1 do 
        for j=1,3,1 do 
            cd[i][j] = (ct[i][j] - cc[i][j]) * delta 
        end
    end
end

tmr.alarm(0,1000*step,1,led_server)
        




