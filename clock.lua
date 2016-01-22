module(..., package.seeall)

require("pin")
require("globalconfig")
require("tube")

seconds = 0
minutes = 0
hours = 0
days = 0
months = 0
years = 0

i2c.setup(0, pin.SDA, pin.SCL, i2c.SLOW)
id = 0
address = 0x68

--test = -1
clock.mode = -1 

function displayMS()
    tube.shiftNumber(seconds%10)
    tube.shiftNumber(math.floor(seconds/10))
    tube.shiftNumber(minutes%10)
    tube.shiftNumber(math.floor(minutes/10))
    tube.latch()
end

function displayHM()
    tube.shiftNumber(minutes%10)
    tube.shiftNumber(math.floor(minutes/10))
    tube.shiftNumber(hours%10)
    tube.shiftNumber(math.floor(hours/10))
    tube.latch()
end

function displayMD()
    tube.shiftNumber(days%10)
    tube.shiftNumber(math.floor(days/10))    
    tube.shiftNumber(months%10)
    tube.shiftNumber(math.floor(months/10))
    tube.latch()
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
    if mode == -1 then
        seconds = seconds + 1
        if (seconds >= 60) then
            seconds = 0
            minutes = minutes + 1
            if (minutes >= 60) then
                minutes = 0
                --dofile("gettime.lua")
            end
        end
        --test
        displayMS()
     elseif mode == 0 then

     end
end

--dofile("gettime.lua")




