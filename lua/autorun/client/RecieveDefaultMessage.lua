net.Receive("LWGCC_DefaultMessage", function(len)
    newtbl = unpack(net.ReadTable())
    chat.AddText(unpack(newtbl)) -- double unpack mcfuck you i guess?
end)

print("[LWG Chat Cosmetics] Client initialized")