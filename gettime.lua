require("clock")

local bcd,h,l
bcd=string.byte(clock.read_reg(clock.address,0x00))
h = math.floor(bcd/16)
l = bcd%16
clock.seconds=h*10 + l

bcd=string.byte(clock.read_reg(clock.address,0x01))
h = math.floor(bcd/16)
l = bcd%16
clock.minutes=h*10 + l

bcd=string.byte(clock.read_reg(clock.address,0x02))
h = math.floor(bcd/16)
l = bcd%16
clock.hours=h*10 + l

bcd=string.byte(clock.read_reg(clock.address,0x04))
h = math.floor(bcd/16)
l = bcd%16
clock.days=h*10 + l

bcd=string.byte(clock.read_reg(clock.address,0x05))
h = math.floor(bcd/16)
l = bcd%16
if h >=8 then h = h-8 end
clock.months=h*10 + l

bcd=string.byte(clock.read_reg(clock.address,0x06))
h = math.floor(bcd/16)
l = bcd%16
clock.years=h*10 + l
