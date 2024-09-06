local QBCore = exports['qb-core']:GetCoreObject()

-- Function to handle Fake ID creation
RegisterServerEvent("fakeid:forgeid", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Raw DOB Timestamp: ", dob)
    end
    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("Converted DOB: ", humandate)
    end

    if Kodek.Debug then
        print("Fake ID event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeIDPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        -- Check if the player has the required items
        local hasAllItems = true
        for _, itemData in ipairs(Kodek.RequiredItems) do
            local item = itemData.item
            local amount = itemData.amount
            local itemDataInInventory = exports.ox_inventory:GetItem(player.PlayerData.source, item)

            if not itemDataInInventory or itemDataInInventory.count < amount then
                hasAllItems = false
                break
            end
        end

        -- Proceed only if the player has all required items
        if hasAllItems then
            -- Check if the player has enough inventory space
            if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealID, 1) then
                if Kodek.Debug then
                    print(player.PlayerData.source, " has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print(player.PlayerData.source, " has entered the following data:")
                print("First Name: ", firstname)
                print("Last Name: ", lastname)
                print("Sex: ", sex)
                print("DOB: ", humandate)
                print("Nationality: ", nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeIDPrice)
                if Kodek.Debug then
                    print("Removed $", Kodek.FakeIDPrice, "from: ", player.PlayerData.source)
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("Removed " .. itemData.amount .. "x " .. itemData.item .. " from: " .. player.PlayerData.source)
                    end
                end

                -- Create the fake ID
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealID, fakeinfo)
                if Kodek.Debug then
                    print(player.PlayerData.source, "received a fake identification")
                end

                exports.qbx_core:Notify("Success", "Fake ID created successfully!", 5000, 'top')
            else
                exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
            end
        else
            exports.qbx_core:Notify("Error", "You do not have the required items to create a fake ID.", 5000, 'top')
        end
    else
        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end
    end
end)


-- Function to handle Fake Driver's License creation
RegisterServerEvent("fakeid:forgedl", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Raw DOB Timestamp: ", dob)
    end
    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("Converted DOB: ", humandate)
    end

    if Kodek.Debug then
        print("Fake DL event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeDLPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        -- Check if the player has the required items
        local hasAllItems = true
        for _, itemData in ipairs(Kodek.RequiredItems) do
            local item = itemData.item
            local amount = itemData.amount
            local itemDataInInventory = exports.ox_inventory:GetItem(player.PlayerData.source, item)

            if not itemDataInInventory or itemDataInInventory.count < amount then
                hasAllItems = false
                break
            end
        end

        -- Proceed only if the player has all required items
        if hasAllItems then
            -- Check if the player has enough inventory space
            if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealDL, 1) then
                if Kodek.Debug then
                    print(player.PlayerData.source, " has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print(player.PlayerData.source, " has entered the following data:")
                print("First Name: ", firstname)
                print("Last Name: ", lastname)
                print("Sex: ", sex)
                print("DOB: ", humandate)
                print("Nationality: ", nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeDLPrice)
                if Kodek.Debug then
                    print("Removed $", Kodek.FakeDLPrice, "from: ", player.PlayerData.source)
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("Removed " .. itemData.amount .. "x " .. itemData.item .. " from: " .. player.PlayerData.source)
                    end
                end

                -- Create the fake ID
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealDL, fakeinfo)
                if Kodek.Debug then
                    print(player.PlayerData.source, "received a fake drivers license")
                end

                exports.qbx_core:Notify("Success", "Fake DL created successfully!", 5000, 'top')
            else
                exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
            end
        else
            exports.qbx_core:Notify("Error", "You do not have the required items to create a fake DL.", 5000, 'top')
        end
    else
        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end
    end
end)


-- Function to handle Fake Weapon License creation
RegisterServerEvent("fakeid:forgewl", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Raw DOB Timestamp: ", dob)
    end
    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("Converted DOB: ", humandate)
    end

    if Kodek.Debug then
        print("Fake WL event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeWLPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        -- Check if the player has the required items
        local hasAllItems = true
        for _, itemData in ipairs(Kodek.RequiredItems) do
            local item = itemData.item
            local amount = itemData.amount
            local itemDataInInventory = exports.ox_inventory:GetItem(player.PlayerData.source, item)

            if not itemDataInInventory or itemDataInInventory.count < amount then
                hasAllItems = false
                break
            end
        end

        -- Proceed only if the player has all required items
        if hasAllItems then
            -- Check if the player has enough inventory space
            if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealWL, 1) then
                if Kodek.Debug then
                    print(player.PlayerData.source, " has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print(player.PlayerData.source, " has entered the following data:")
                print("First Name: ", firstname)
                print("Last Name: ", lastname)
                print("Sex: ", sex)
                print("DOB: ", humandate)
                print("Nationality: ", nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeWLPrice)
                if Kodek.Debug then
                    print("Removed $", Kodek.FakeWLPrice, "from: ", player.PlayerData.source)
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("Removed " .. itemData.amount .. "x " .. itemData.item .. " from: " .. player.PlayerData.source)
                    end
                end

                -- Create the fake ID
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealWL, fakeinfo)
                if Kodek.Debug then
                    print(player.PlayerData.source, "received a fake weapons license")
                end

                exports.qbx_core:Notify("Success", "Fake WL created successfully!", 5000, 'top')
            else
                exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
            end
        else
            exports.qbx_core:Notify("Error", "You do not have the required items to create a fake WL.", 5000, 'top')
        end
    else
        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end
    end
end)


-- Function to handle Fake Lawyer Pass creation
RegisterServerEvent("fakeid:forgelp", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Raw DOB Timestamp: ", dob)
    end
    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("Converted DOB: ", humandate)
    end

    if Kodek.Debug then
        print("Fake LP event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeLPPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        -- Check if the player has the required items
        local hasAllItems = true
        for _, itemData in ipairs(Kodek.RequiredItems) do
            local item = itemData.item
            local amount = itemData.amount
            local itemDataInInventory = exports.ox_inventory:GetItem(player.PlayerData.source, item)

            if not itemDataInInventory or itemDataInInventory.count < amount then
                hasAllItems = false
                break
            end
        end

        -- Proceed only if the player has all required items
        if hasAllItems then
            -- Check if the player has enough inventory space
            if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealLP, 1) then
                if Kodek.Debug then
                    print(player.PlayerData.source, " has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print(player.PlayerData.source, " has entered the following data:")
                print("First Name: ", firstname)
                print("Last Name: ", lastname)
                print("Sex: ", sex)
                print("DOB: ", humandate)
                print("Nationality: ", nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeLPPrice)
                if Kodek.Debug then
                    print("Removed $", Kodek.FakeLPPrice, "from: ", player.PlayerData.source)
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("Removed " .. itemData.amount .. "x " .. itemData.item .. " from: " .. player.PlayerData.source)
                    end
                end

                -- Create the fake ID
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealLP, fakeinfo)
                if Kodek.Debug then
                    print(player.PlayerData.source, "received a fake lawyer pass")
                end

                exports.qbx_core:Notify("Success", "Fake LP created successfully!", 5000, 'top')
            else
                exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
            end
        else
            exports.qbx_core:Notify("Error", "You do not have the required items to create a fake LP.", 5000, 'top')
        end
    else
        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end
    end
end)


-- Function to handle Fake Hunting License creation
RegisterServerEvent("fakeid:forgehl", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Raw DOB Timestamp: ", dob)
    end
    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("Converted DOB: ", humandate)
    end

    if Kodek.Debug then
        print("Fake HL event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeHLPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        -- Check if the player has the required items
        local hasAllItems = true
        for _, itemData in ipairs(Kodek.RequiredItems) do
            local item = itemData.item
            local amount = itemData.amount
            local itemDataInInventory = exports.ox_inventory:GetItem(player.PlayerData.source, item)

            if not itemDataInInventory or itemDataInInventory.count < amount then
                hasAllItems = false
                break
            end
        end

        -- Proceed only if the player has all required items
        if hasAllItems then
            -- Check if the player has enough inventory space
            if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealHL, 1) then
                if Kodek.Debug then
                    print(player.PlayerData.source, " has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print(player.PlayerData.source, " has entered the following data:")
                print("First Name: ", firstname)
                print("Last Name: ", lastname)
                print("Sex: ", sex)
                print("DOB: ", humandate)
                print("Nationality: ", nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeHLPrice)
                if Kodek.Debug then
                    print("Removed $", Kodek.FakeHLPrice, "from: ", player.PlayerData.source)
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("Removed " .. itemData.amount .. "x " .. itemData.item .. " from: " .. player.PlayerData.source)
                    end
                end

                -- Create the fake ID
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealHL, fakeinfo)
                if Kodek.Debug then
                    print(player.PlayerData.source, "received a fake hunting license")
                end

                exports.qbx_core:Notify("Success", "Fake HL created successfully!", 5000, 'top')
            else
                exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
            end
        else
            exports.qbx_core:Notify("Error", "You do not have the required items to create a fake HL.", 5000, 'top')
        end
    else
        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end
    end
end)


-- Function to handle Fake Fishing License creation
RegisterServerEvent("fakeid:forgefl", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Raw DOB Timestamp: ", dob)
    end
    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("Converted DOB: ", humandate)
    end

    if Kodek.Debug then
        print("Fake FL event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeFLPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        -- Check if the player has the required items
        local hasAllItems = true
        for _, itemData in ipairs(Kodek.RequiredItems) do
            local item = itemData.item
            local amount = itemData.amount
            local itemDataInInventory = exports.ox_inventory:GetItem(player.PlayerData.source, item)

            if not itemDataInInventory or itemDataInInventory.count < amount then
                hasAllItems = false
                break
            end
        end

        -- Proceed only if the player has all required items
        if hasAllItems then
            -- Check if the player has enough inventory space
            if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealFL, 1) then
                if Kodek.Debug then
                    print(player.PlayerData.source, " has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print(player.PlayerData.source, " has entered the following data:")
                print("First Name: ", firstname)
                print("Last Name: ", lastname)
                print("Sex: ", sex)
                print("DOB: ", humandate)
                print("Nationality: ", nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeFLPrice)
                if Kodek.Debug then
                    print("Removed $", Kodek.FakeFLPrice, "from: ", player.PlayerData.source)
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("Removed " .. itemData.amount .. "x " .. itemData.item .. " from: " .. player.PlayerData.source)
                    end
                end

                -- Create the fake ID
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealFL, fakeinfo)
                if Kodek.Debug then
                    print(player.PlayerData.source, "received a fake fishing license")
                end

                exports.qbx_core:Notify("Success", "Fake FL created successfully!", 5000, 'top')
            else
                exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
            end
        else
            exports.qbx_core:Notify("Error", "You do not have the required items to create a fake FL.", 5000, 'top')
        end
    else
        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end
    end
end)

-- Get the local version
local localVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

-- Load and execute the kodekupdate.lua script
local kodekupdateCode = LoadResourceFile(GetCurrentResourceName(), 'server/kodekupdate.lua')

if kodekupdateCode then
    assert(load(kodekupdateCode))()
else
    print('Failed to load kodekupdate.lua')
end

-- Check for updates when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        KodekVersionCheck.checkForUpdates(localVersion)
    end
end)
