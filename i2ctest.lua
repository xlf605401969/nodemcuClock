id=0
sda=1
scl=2

i2c.setup(id,sda,scl,i2c.SLOW)

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
