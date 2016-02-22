require("globalconfig")

globalconfig.config.ConfigMode = "1"
globalconfig.saveConfig()

wifi.setmode(wifi.SOFTAP)
cfg = {}
cfg.ssid = "CLOCK"
cfg.pwd = "12345678"
wifi.ap.config(cfg)

print("Enter config mode")
