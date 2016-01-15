module(..., package.seeall)

require("pin")
require("globalconfig")
require("tube")

function BCDtoNumber(data)
    local bcd,numh,numl    
    if type(data) == "string" then
        bcd = string.byte(data)
    else
        bcd = data
    end
    numh = math.floor(bcd/16)
    numl = bcd%16
    return numh*10 + numl
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
        
    
