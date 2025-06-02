local data = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Time)
        local Players = GetPlayers()
        for _, playerId in ipairs(Players) do
            local ping = GetPlayerPing(playerId)

            if ping and tonumber(ping) > tonumber(Config.MaxPing) then
                if not data[playerId] then
                    data[playerId] = { count = 1 }
                else
                    data[playerId].count = data[playerId].count + 1
                end

                if data[playerId].count >= Config.MaxWarn then
                    local reason = Config.Messages['Kick']
                    SendLog({
                        name = GetPlayerName(playerId),
                        ping = ping,
                        status = "Kicked"
                    })
                    DropPlayer(playerId, string.format(reason, ping))
                else
                    TriggerClientEvent('chat:addMessage', playerId, {
                        color = {255, 0, 0},
                        args = {"[SYSTEM]", string.format(Config.Messages['Warn'], ping, Config.MaxPing)}
                    })
                    SendLog({
                        name = GetPlayerName(playerId),
                        ping = ping,
                        status = "Warn " .. data[playerId].count
                    })
                end
            else
                -- Ping is okay, reset warning
                data[playerId] = nil
            end
        end
    end
end)

function SendLog(data)
    if Config.Discord['Webhook'] and Config.Discord['Webhook'] ~= '' then
        PerformHttpRequest(Config.Discord['Webhook'], function(err, text, headers) end, "POST", json.encode({
            embeds = {{
                author = {
                    name = Config.Discord['Server Name'],
                    url = Config.Discord['Discord URL'],
                    icon_url = Config.Discord['Logo']
                },
                footer = {
                    text = Config.Discord['Server Name'].." | "..os.date("%Y/%m/%d | %X"),
                    icon_url = Config.Discord['Logo']
                },
                description = "**Player:** "..data.name.."\n**Ping:** "..data.ping.." ms\n**Status:** "..data.status,
                color = 16711680
            }}
        }), {
            ["Content-Type"] = "application/json"
        })
    end
end
