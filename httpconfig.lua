module(..., package.seeall)
gc = require("globalconfig")

httpConfigDoneEvent = function() end

done = false

function findSplit(str, afternumber)
    local i = 0
    while true do
        i = string.find(str,"&",i+1)
        if i ~= nil then
            if i > afternumber then
                break
            end
        else
            break
        end
    end
    return i
end

function getParaValue(str, para)
    local i,j,s,valuestr
    i=0 j=0
    i,j = string.find(str, para)
    if j ~= nil then
        s = findSplit(str, j)
        if s ~= nil then
            valuestr = string.sub(str, j+2, s-1)
        else
            valuestr = string.sub(str, j+2)
        end
    end
    return valuestr
end

function getParaStr(str)
    local i = 0;
    local l = 0;
    local para
    while true do 
        i = string.find(content,"\n",i+1)
        if i==nil then break end
        l=i 
    end
    para = string.sub(content,l+1)
    return para
end

function decodeHttpConfig(payload, config)
    local temp,para
    para = getParaStr(payload)
    temp = getParaValue(para, "Connect")
    if temp ~= nil then
        config.Connect = temp
    end
    temp = getParaValue(para, "SSID")
    if temp ~= nil then
        config.SSID = temp
    end
    temp = getParaValue(para, "Password")
    if temp ~= nil then
        config.Password = temp
    end
    temp = getParaValue(para, "Time")
    if temp ~= nil then
        config.Time = temp
    end
    temp = getParaValue(para, "NotifySpan")
    if temp ~= nil then
        config.NotifySpan = temp
    end
    temp = getParaValue(para, "NotifyLast")
    if temp ~= nil then
        config.NotifyLast = temp
    end
    temp = getParaValue(para, "QuietHourStart")
    if temp ~= nil then
        config.QuietHourStart = temp
    end
    temp = getParaValue(para, "QuietHourEnd")
    if temp ~= nil then
        config.QuietHourEnd = temp
    end
    temp = getParaValue(para, "City")
    if temp ~= nil then
        config.City = temp
    end
    temp = getParaValue(para, "EnableWeather")
    if temp ~= nil then
        config.EnableWeather = temp
    end
end

function startConfig()
    srv=net.createServer(net.TCP)
    srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
        print("GetRequest")
        print(payload)
        content=payload
        method = string.sub(payload,1,3)
        print(method)
        if method == "GET" then
            file.open("Configuration.html","r")
            conn:send("HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: 1550\r\nServer: ESP8266\r\n\n")
        elseif method == "POS" then
            conn:send("HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: 68\r\nServer: ESP8266\r\n\n"..
            "<html>\r\n<head></head><body><h1>Configuration Done</h1></body></html>")
            decodeHttpConfig(content,gc.config)
            gc.saveConfig()
            done = true
            httpConfigDoneEvent()
            print("get post request")
        end
        end)
    conn:on("sent", function(conn)
        if method == "GET" then
            line = file.readline()
            if line ~= nil then
                conn:send(line)
            else
                print("Reply get request OK")
                file.close()
            end
        elseif method == "POS" then
            print("Reply post request OK")
        end
        end)
    end)
    return srv
end

function clean()
    content = nil
    method = nil
    line = nil
    if srv ~= nil then
        srv:close()
        srv = nil
    end
end
