module(..., package.seeall)

require("pin")

cc = {{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
cd = {{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
step = 1/30
count = 0

mode = 9
status = 0

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

function rd255()
    return math.floor(math.random()*256)
end

function rdc()
    local r = rd255()
    return {r,(rd255()+100) % 256,(rd255()+200) % 256}
end

function led_server()
    if count > 0 then
        count = count - 1
        for i = 1,4,1 do
            ColorAdd(cc[i],cd[i])
        end
        ws2812.writergb(pin.DO, CCtoString())
    elseif count == 0 then
        local seed = rd255()
        if mode == 9 then
            transit({rdc(),rdc(),rdc(),rdc()},5)
        end
        if status == 0 then
            tmr.stop(0)
        end
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

function on()
    mode = 9
    if status == 0 then
        status = 1
        tmr.start(0)
    end
    --tmr.start(0)
end

function off()
    mode = 1
    if status == 1 then
        transit({{0,0,0},{0,0,0},{0,0,0},{0,0,0}},5)
        status = 0
    end
end
    

tmr.alarm(0,1000*step,1,led_server)
tmr.stop(0)
        




