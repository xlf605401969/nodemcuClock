module(...,package.seeall)
require("pin")

function shiftNumber(num)
    local temp
    temp = 9-num
    for i=0,9,1 do
        gpio.write(pin.SRCLK, gpio.LOW)
        if temp~= i then
            gpio.write(pin.SER, gpio.LOW)
        else
            gpio.write(pin.SER, gpio.HIGH)
        end
        --tmr.delay(1)
        gpio.write(pin.SRCLK, gpio.HIGH)
        --tmr.delay(1)
        gpio.write(pin.SRCLK, gpio.LOW)
        --tmr.delay(1)
    end
end

function init()
    gpio.mode(pin.SER, gpio.OUTPUT)
    gpio.mode(pin.SRCLK, gpio.OUTPUT)
    gpio.mode(pin.RCLK, gpio.OUTPUT)
    gpio.write(pin.SRCLK, gpio.LOW)
    gpio.write(pin.RCLK, gpio.LOW)
end

function latch()
    gpio.write(pin.RCLK, gpio.LOW)
    gpio.write(pin.RCLK, gpio.HIGH)
    --tmr.delay(1)
    gpio.write(pin.RCLK, gpio.LOW)
    --tmr.delay(1)
end
        