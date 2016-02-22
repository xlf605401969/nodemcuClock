tmr.alarm(3,3000,0,function() dofile("inittest.lua") print("Clock Boot, Memory:"..node.heap().." Byte") end)
 

