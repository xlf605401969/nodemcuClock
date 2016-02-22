module(..., package.seeall)

require("pin")
require("globalconfig")
require("tube")

qs = tonumber(globalconfig.config.QuietHourStart)
qe = tonumber(globalconfig.config.QuietHourEnd)
ns = tonumber(globalconfig.config.NotifySpan)
nl = tonumber(globalconfig.config.NotifyLast)

seconds = 0
minutes = 0
hours = 0
days = 0
months = 0
years = 0

displayFlag = 0
busyModeCount = 0

i2c.setup(0, pin.SDA, pin.SCL, i2c.SLOW)
id = 0
address = 0x68

--test = -1
clock.mode = 1 

function displayMS()
    tube.shiftNumber(seconds%10)
    tube.shiftNumber(math.floor(seconds/10))
    tube.shiftNumber(minutes%10)
    tube.shiftNumber(math.floor(minutes/10))
    tube.latch()
    print(minutes..":"..seconds.."\n")
end

function displayHM()
    tube.shiftNumber(minutes%10)
    tube.shiftNumber(math.floor(minutes/10))
    tube.shiftNumber(hours%10)
    tube.shiftNumber(math.floor(hours/10))
    tube.latch()
    print(minutes..":"..seconds.."\n")
end

function displayMD()
    tube.shiftNumber(days%10)
    tube.shiftNumber(math.floor(days/10))    
    tube.shiftNumber(months%10)
    tube.shiftNumber(math.floor(months/10))
    tube.latch()
end

function display(mode)
    if(mode == -1) then
    elseif (mode == 0) then
    elseif (mode == 1) then
        displayHM()
    elseif (mode == 2) then
        displayHM()
    elseif (mode == 3) then
        displayMS()
    end
end

function getTimeFromSetting()
    temp = globalconfig.config.Time
    years = tonumber(string.sub(temp,1,4))
    months = tonumber(string.sub(temp,6,7))
    days = tonumber(string.sub(temp,9,10))
    hours = tonumber(string.sub(temp,12,13))
    minutes = tonumber(string.sub(temp,15,16))
    seconds = tonumber(string.sub(temp,18,19))
    if (years == nil or months == nil or days == nil or hours == nil or minutes == nil or seconds == nil) then
        years = 1111
        months = 11
        days = 11
        hours = 11
        minutes = 11
        seconds = 11
    end
end

function read_reg(dev_addr, reg_addr)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id,reg_addr)
    i2c.stop(id)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    c=i2c.read(id,1)
    i2c.stop(id)
    return c
end

function write_reg(dev_addr, reg_addr, data)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id,reg_addr)
    i2c.write(id,data)
    return 1
end

function clock_server()
    seconds = seconds + 1
    if (seconds >= 60) then
        seconds = 0
        minutes = minutes + 1
        if (minutes >= 60) then
            minutes = 0
            hours = hours + 1
            if (hours >= 24) then
                hours = 0
            end
        end
    end
    if (seconds == 33 and minutes == 33 and hours == 1) then
        dofile("gettime.lua")
    end 
    if mode == -1 then
        --test
        displayMS()
    elseif mode == 0 then

    elseif mode == 1 then       --idle mode
        if (minutes % ns == 0) then
            displayFlag = 1
        end
        if (minutes > nl) then
            displayFlag = 0
        end
        if (qs < qe) then
            if (hours >= qs and hours <= qe) then
                displayFlag = 0
            end
        elseif (qs > qe) then
            if (hours >= qs or hours <= qe) then
                displayFlag = 0
            end
        end
    elseif mode == 2 or mode == 3 then
        displayFlag = 1
        busyModeCount = busyModeCount + 1
        if (busyModeCount >= 60) then
            mode = 1
            busyModeCount = 0
        end
    elseif mode == 4 then
        
    end
    if (displayFlag == 1) then
        display(mode)
        tube.on()
    else
        tube.off()
    end
end

dofile("gettime.lua")
tmr.alarm(1,1000,1,clock_server)





