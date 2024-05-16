net.Receive("LWGCC_DefaultMessage", function(len)
    newtbl = net.ReadTable()
    chat.AddText(unpack(newtbl))
end)

print("[LWG Chat Cosmetics] Client initialized")