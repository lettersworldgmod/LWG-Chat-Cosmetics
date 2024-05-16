net.Receive("LWGCC_DefaultMessage", function(len)
    message = net.ReadTable()
    chat.AddText(unpack(message))
end)

hook.Add("ChatText", "LWGCC_JoinLeaveMessage", function(plyidx, plyname, text, type)
    if (type == "joinleave") then
        return true
    end
end)

print("[LWG Chat Cosmetics] Client initialized")