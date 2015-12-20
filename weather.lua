module(..., package.seeall)

gc = require("globalconfig")

function solveWeatherDomain()
    sk=net.createConnection(net.TCP,0)
    sk:dns("api.openweathermap.org",function(conn,ip) gc.config.WeatherIP=ip;print(ip) end)
    sk=nil
end

function getWeather()
    if gc.config.WeatherIP ~= nil then
        conn=net.createConnection(net.TCP, 0)
        conn:on("receive", function(conn, weatherraw)     
            local i,j
            i,j = string.find(weatherraw,"{.*}")
            if i~=nil then
                local weatherjson = string.sub(weatherraw,i,j)
                weatherdata=cjson.decode(weatherjson)
            end
            conn:close()
            conn=nil
            print("done\r\n")
            end)
        conn:connect(80, gc.config.WeatherIP)
        conn:on("connection", function(sck,c)
            conn:send("GET /data/2.5/weather?units=metric&APPID="..gc.config.WeatherID.."&q=London HTTP/1.1\r\nHost: "..gc.config.WeatherIP.."\r\n"
                .. "Connection: keep-alive\r\nAccept: */*\r\n\r\n")
            end)
     end
end

function clean()
    weatherdata = nil
end
    
    

