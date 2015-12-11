sk=net.createConnection(net.TCP,0)
sk:dns("api.openweathermap.org",function(conn,ip) weatherip=ip;print(ip) end)
sk=nil