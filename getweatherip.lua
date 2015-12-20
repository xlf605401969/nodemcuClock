cf = require("clockconfig")
sk=net.createConnection(net.TCP,0)
sk:dns("api.openweathermap.org",function(conn,ip) cf.config.WeatherIP=ip;print(ip) end)
sk=nil
