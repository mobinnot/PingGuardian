Config = {}

-- Max Ping allowed before warning
Config.MaxPing = 180

-- Time in ms between each ping check
Config.Time = 10000

-- Max warning count before kick
Config.MaxWarn = 3

-- Discord logging settings
Config.Discord = {
    ['Webhook']     = '', -- Add your webhook here
    ['Logo']        = '', -- Optional: logo URL
    ['Server Name'] = '',
    ['Discord URL'] = ''
}

-- Messages
Config.Messages = {
    ['Warn'] = "Your ping is ^1%s^0ms, which is higher than the limit of ^4%s^0ms. Please check your connection.",
    ['Kick'] = "\n⚡ Kicked\nYour ping is too high (%s ms). Please make sure you're not downloading anything!"
}
