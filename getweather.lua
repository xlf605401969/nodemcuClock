cf = require("clockconfig")
conn=net.createConnection(net.TCP, 0)
conn:on("receive", function(conn, weatherraw)     
    local i,j
    i,j = string.find(weatherraw,"{.*}")
    if i~=nil then
        local weatherjson = string.sub(weatherraw,i,j)
        weather=cjson.decode(weatherjson)
    end
    conn:close()
    conn=nil
    print("done\r\n")
    end)
conn:connect(80, cf.config.WeatherIP)
conn:on("connection", function(sck,c)
    conn:send("GET /data/2.5/weather?units=metric&APPID="..cf.config.WeatherID.."&q=London HTTP/1.1\r\nHost: "..cf.config.WeatherIP.."\r\n"
        .. "Connection: keep-alive\r\nAccept: */*\r\n\r\n")
        end)

