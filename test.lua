for j=11,12,1 do
    local pin=j
    gpio.mode(pin,gpio.OUTPUT)
    gpio.write(pin,gpio.HIGH)
    gpio.write(pin,gpio.LOW)
    tmr.delay(1000000)
    gpio.write(pin,gpio.HIGH)
end