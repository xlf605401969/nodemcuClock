srv=net.createServer(net.TCP)
srv:listen(80, function(conn)
    conn:on("receive", function(conn,payload)
        print(payload)
    conn:send("<h1> Hello, NodeMCU.</h1>")
    end)
    conn:on("sent", function(conn) conn:close() end)
end)