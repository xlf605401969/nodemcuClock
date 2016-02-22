module(..., package.seeall)

require("globalconfig")
require("pin")
require("clock")

gpio.mode(pin.MODE, gpio.INT)
function ModeISR(level)
    clock.mode = clock.mode + 1
    if clock.mode > 3 then
        clock.mode = -1
        clock.countDown = 9
    end
end
gpio.trig(pin.MODE, "down", ModeISR)

function ConfigEvent()
    dofile("gotoconfigmode.lua")
end

clock.countDownEvent = ConfigEvent




