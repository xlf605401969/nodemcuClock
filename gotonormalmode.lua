require("globalconfig")

globalconfig.config.ConfigMode = "0"
globalconfig.saveConfig()

wifi.setmode(wifi.STATION)
wifi.sta.config(globalconfig.config.SSID, globalconfig.config.Password)
wifi.sta.autoconnect(1)

print("Enter normal mode")