cf = require("clockconfig")
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
        print("GetRequest")
        print(payload)
        content=payload
        method = string.sub(payload,0,3)
        print(method)
        if method == "GET" then
            file.open("Configuration.html","r")
            conn:send("HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: 1406\r\nServer: ESP8266\r\n\n")
        elseif method == "POS" then
            conn:send("HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: 68\r\nServer: ESP8266\r\n\n"..
            "<html>\r\n<head></head><body><h1>Configuration Done</h1></body></html>")
            cf.decodeHttpConfig(content,cf.config)
            cf.saveConfig("configsave.lua",cf.config)
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
