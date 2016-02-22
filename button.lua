module(..., package.seeall)

require("globalconfig")
require("pin")
require("clock")

gpio.mode(pin.MODE, gpio.INT)
function ModeISR(level)
    clock.mode = clock.mode + 1
    if clock.mode > 3 then
        clock.mode = -1
        clock.countDown = 10
    end
    if clock.mode == 0 then
        clock.countDown = 10
    end
end
gpio.trig(pin.MODE, "down", ModeISR)

function ConfigEvent()
    tmr.alarm(3,6000,0,function() dofile("gotoconfigmode.lua") node.restart() end)
end

clock.countDownEvent = ConfigEvent




