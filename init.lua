require("pin")
--require("globalconfig")

gpio.mode(pin.CVH, gpio.OUTPUT)
gpio.write(pin.CVH, gpio.HIGH)