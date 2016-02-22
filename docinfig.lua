require("httpconfig")
require("globalconfig")
require("pin")

clock={}

i2c.setup(0, pin.SDA, pin.SCL, i2c.SLOW)
clock.id = 0
clock.address = 0x68



function write_reg(dev_addr, reg_addr, data)
    i2c.start(clock.id)
    i2c.address(clock.id, dev_addr, i2c.TRANSMITTER)
    i2c.write(clock.id,reg_addr)
    i2c.write(clock.id,data)
    return 1
end

clock.write_reg = write_reg

function saveTimeFromSetting()
    temp = globalconfig.config.Time
    clock.years = tonumber(string.sub(temp,3,4))
    clock.months = tonumber(string.sub(temp,6,7))
    clock.days = tonumber(string.sub(temp,9,10))
    clock.hours = tonumber(string.sub(temp,12,13))
    clock.minutes = tonumber(string.sub(temp,15,16))
    clock.seconds = tonumber(string.sub(temp,18,19))
    if (clock.years == nil or clock.months == nil or clock.days == nil or clock.hours == nil or clock.minutes == nil or clock.seconds == nil) then
        clock.years = 1111
        clock.months = 11
        clock.days = 11
        clock.hours = 11
        clock.minutes = 11
        clock.seconds = 11
    end
    dofile("settime.lua")
    print("Config Done !")
    dofile("gotonormalmode.lua")
end

httpconfig.httpConfigDoneEvent = saveTimeFromSetting
httpconfig.startConfig()

