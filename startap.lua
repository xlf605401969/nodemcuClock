wifi.setmode(wifi.SOFTAP)
cfg={}
cfg.ssid="Clock"
wifi.ap.config(cfg)

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
        print("GetRequest")
        setstate="..."
        k=string.find(payload,"ssid")
        if k then
            str=string.sub(payload,k)
            m=string.find(str,"&")
            strssid='config.ssid='..'"'..string.sub(str,6,(m-1))..'"'
            print(strssid)
            strpass='config.password="'..string.sub(str,(m+10))..'"'
            print(strpass)

            file.open("config.lua","w+")
            file.writeline("config={}")
            file.writeline(strssid)
            file.writeline(strpass)
            file.close()
            
            setstate="OK"
            print("store ok")

        end
        conn:send("HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nServer: ESP8266\r\n\n"..
                "<html><head></head><body>"..
                "Served from ESP8266-".. node.chipid().." - NODE.HEAP: ".. node.heap().." "..
                "<font color=\"red\">"..
                "<h1> connect your router "..setstate.."</h1></font>"..
                "<FORM action=\"\" method=\"POST\">"..
                "SSID:<input type=\"text\" name=\"ssid\">"..
                "<br></br>"..
                "Password<input type=\"text\" name=\"password\">"..
                "<br></br>"..
                "<input type=\"submit\" value=\"Submit\">"..
                "</form>"..
                "</body>"..
                "</html>")
        print("Send OK")
    end)
    conn:on("sent",function(conn) 
        if setstate=="OK" then
            srv:close()
            dofile("config.lua")
            wifi.setmode(wifi.STATION)
            wifi.sta.config(config.ssid,config.password)
            wifi.sta.autoconnect(1)
            wifi.sta.connect()
            setstate="OVER"
            tmr.alarm(1,10000,0,function() print(wifi.sta.getip()) end)
        end
    end)
end)