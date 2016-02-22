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
    if tonumber(config.QuietHourStart) == nil then
        config.QuietHourStart = "22"
    end
    if tonumber(config.QuietHourEnd) == nil then
        config.QuietHourEnd = "7"
    end
    w('config = {}')
    w('config.Connect = '..'"'..config.Connect..'"')
    w('config.SSID = '..'"'..config.SSID..'"')
    w('config.Password = '..'"'..config.Password..'"')
    w('config.Time = '..'""')
    w('config.NotifySpan = '..'"'..config.NotifySpan..'"')
    w('config.NotifyLast = '..'"'..config.NotifyLast..'"')
    w('config.QuietHourStart = '..'"'..config.QuietHourStart..'"')
    w('config.QuietHourEnd = '..'"'..config.QuietHourEnd..'"')
    w('config.City = '..'"'..config.City..'"')
    w('config.EnableWeather = '..'"'..config.EnableWeather..'"')
    w('config.WeatherIP = '..'"'..config.WeatherIP..'"')
    w('config.WeatherID = '..'"'..config.WeatherID..'"')
    w('config.ConfigMode = '..'"'..config.ConfigMode..'"')
    w('return config')
    file.close()
end

loadConfig()
