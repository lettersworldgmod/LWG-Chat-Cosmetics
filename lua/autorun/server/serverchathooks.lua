include("../settings.lua")

util.AddNetworkString("LWGCC_DefaultMessage")

-- returns: What to show instead of original text. Set to "" to stop the message from displaying.
hook.Add("PlayerSay", "LWGCC_DefaultMessage", function (player, content, teamchat)
    net.Start("LWGCC_DefaultMessage")
    local message = {}

    for idx, value in ipairs(lwgcc_settings.Format) do
        table.insert(message, resolvePlaceholders(value, player, content))
    end

    net.WriteTable(message)
    net.Broadcast()
    return ""
end)

hook.Add("PlayerConnect", "LWGCC_JoinMessage", function (playername, ip)
    net.Start("LWGCC_DefaultMessage")
    local message = {}

    for idx, value in ipairs(lwgcc_settings.JoinMessageFormat) do
        table.insert(message, resolvePlaceholders(value, nil, nil, playername))
    end

    net.WriteTable(message)
    net.Broadcast()
end)

print("[LWG Chat Cosmetics] Server initialized")