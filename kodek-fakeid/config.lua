Kodek = {}

Kodek.Debug = true

-- Locations
Kodek.FakeIDEntrance = vector3(275.512, -3015.388, 6.128174)                   -- Entrance Teleport Location
Kodek.EntranceSpawn = vector4(1172.4, -3196.642, -39.01246, 87.87402)      -- Entrance Spawn Location
Kodek.FakeIDExit = vector3(1174.0, -3196.63, -39.01)                           -- Exit Teleport Location
Kodek.ExitSpawn = vector4(274.655, -3015.376, 5.690064, 85.03936)            -- Exit Spawn Location
Kodek.ForgeStart = vector3(1162.654, -3196.364, -39.01246)                     -- Forge Menu Location

-- Door Interaction Radius
Kodek.Radius = 1                

-- Fake ID Cards Available (true = Disabled)
Kodek.DisableFakeID = false
Kodek.DisableFakeDL = false
Kodek.DisableFakeWL = false
Kodek.DisableFakeLP = false
Kodek.DisableFakeHL = true
Kodek.DisableFakeFL = true

-- FakeID Prices
Kodek.FakeIDPrice = 1000      -- Fake ID Card Price
Kodek.FakeDLPrice = 1000      -- Fake Driver License Price
Kodek.FakeWLPrice = 1000      -- Fake Weapon License Price
Kodek.FakeLPPrice = 1000      -- Fake Lawyer Pass Price
Kodek.FakeHLPrice = 1000      -- Fake Hunting License Price
Kodek.FakeFLPrice = 1000      -- Fake Fishing License Price

-- Real Items (ox_inventory)
Kodek.RealID = "id_card"              -- Real ID Card Item
Kodek.RealDL = "driver_license"       -- Real Driver License Item
Kodek.RealWL = "weapon_license"       -- Real Weapon License Item
Kodek.RealLP = "lawyer_pass"          -- Real Lawyer Pass Item
Kodek.RealHL = "hunting_license"      -- Real Hunting License Item
Kodek.RealFL = "fishing_license"      -- Real Fishing License Item

-- Required Items for Craft
Kodek.BlankCard = "blank_card"
Kodek.TonerInk = "toner"
Kodek.Scissors = "scissors"

-- Craft Time 
Kodek.ComputerTime = 10        -- Time in Seconds
--Kodek.NotifyTime = 60*5      -- Not Yet Available
--Kodek.PrintTime = 30         -- Not Yet Available

--[[
Future Updates:
    Logs
    Photos Maybe?
    Random Locations to pick up your FakeID


-- NPC Spawn Locations
Kodek.NPCLocations = {                                     -- This is where you go to pickup your FakeID
    vector4(138.6853, 270.6841, 109.9740, 73.0269),
    vector4(-1680.896, 142.8132, 62.6029, 31.1811),
    vector4(-1095.56, -1657.49, 6.34143, 121.8898),
}
]]--