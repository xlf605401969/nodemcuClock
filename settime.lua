require("clock")

local bcd,h,l
h = math.floor(clock.seconds / 10)
l = clock.seconds % 10
bcd = h * 16 + l
clock.write_reg(clock.address, 0x00, bcd)

h = math.floor(clock.minutes / 10)
l = clock.minutes % 10
bcd = h * 16 + l
clock.write_reg(clock.address, 0x01, bcd)

h = math.floor(clock.hours / 10)
l = clock.hours % 10
bcd = h * 16 + l
clock.write_reg(clock.address, 0x02, bcd)

h = math.floor(clock.days / 10)
l = clock.days % 10
bcd = h * 16 + l
clock.write_reg(clock.address, 0x04, bcd)

h = math.floor(clock.months / 10)
l = clock.months % 10
bcd = h * 16 + l
clock.write_reg(clock.address, 0x05, bcd)

h = math.floor(clock.years / 10)
l = clock.years % 10
bcd = h * 16 + l
clock.write_reg(clock.address, 0x06, bcd)

