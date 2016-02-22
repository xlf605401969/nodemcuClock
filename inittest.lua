gc = require("globalconfig")
if gc.config.ConfigMode == "1" then
    gc.config.ConfigMode = "0"
    dofile("doconfig.lua")
elseif gc.config.ConfigMode == "0" then
    require("clock")
    require("button")
end
    