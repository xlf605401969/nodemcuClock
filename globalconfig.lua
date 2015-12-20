module(..., package.seeall)

config = {}

function loadConfig()
     config = dofile("configsave.lua")
     return config
end

function saveConfig()
    local path = "configsave.lua"
    local config = config
    file.open(path,"w+")
    local w=file.writeline
    w('config = {}')
    w('config.Connect = '..'"'..config.Connect..'"')
    w('config.SSID = '..'"'..config.SSID..'"')
    w('config.Password = '..'"'..config.Password..'"')
    w('config.Time = '..'"'..config.Time..'"')
    w('config.NoSpan = '..'"'..config.NoSpan..'"')
    w('config.NoLast = '..'"'..config.NoLast..'"')
    w('config.City = '..'"'..config.City..'"')
    w('config.EnableWeather = '..'"'..config.EnableWeather..'"')
    w('config.WeatherIP = '..'"'..config.WeatherIP..'"')
    w('config.WeatherID = '..'"'..config.WeatherID..'"')
    w('return config')
    file.close()
end

loadConfig()
