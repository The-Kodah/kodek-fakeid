local QBCore = exports['qb-core']:GetCoreObject()


--Function to handle Fake ID creation
RegisterServerEvent("fakeid:forgeid", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake ID event started by:  " ..  "( ^5" .. player.PlayerData.citizenid .. " ^7)")
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Raw DOB Timestamp: " .. dob)
    end

    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Converted DOB: " .. humandate)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeIDPrice then
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough money! Cash: $" .. player.Functions.GetMoney("cash"))
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
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has entered the following data:")
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "First Name: " .. firstname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Last Name: " .. lastname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Sex: " .. sex)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "DOB: " .. humandate)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Nationality: " .. nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeIDPrice)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed $" .. Kodek.FakeIDPrice .. " from Player")
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed " .. itemData.amount .. "x " .. itemData.item .. " from Player")
                    end
                end

                -- Create the fake ID
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealID, fakeinfo)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player received a fake identification")
                end
                exports.qbx_core:Notify(src, "Success!", "Success", 5000, "Successfully created Fake ID!", 'top')
            else
                exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough Inventory Space", 'top')
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough inventory space")
                end
            end
        else
            exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have the required items to create a fake ID.", 'top')
        end
    else
        exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough cash! You need $" .. Kodek.FakeIDPrice, 'top')
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough money - Cash: $" .. player.Functions.GetMoney("cash"))
        end
    end
end)

-- Function to handle Fake Driver's License creation
RegisterServerEvent("fakeid:forgedl", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake DL event started by:  " ..  "( ^5" .. player.PlayerData.citizenid .. " ^7)")
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Raw DOB Timestamp: " .. dob)
    end

    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Converted DOB: " .. humandate)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeDLPrice then
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough money! Cash: $" .. player.Functions.GetMoney("cash"))
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
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has entered the following data:")
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "First Name: " .. firstname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Last Name: " .. lastname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Sex: " .. sex)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "DOB: " .. humandate)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Nationality: " .. nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeDLPrice)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed $" .. Kodek.FakeDLPrice .. " from Player")
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed " .. itemData.amount .. "x " .. itemData.item .. " from Player")
                    end
                end

                -- Create the fake DL
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealDL, fakeinfo)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player received a fake driver license")
                end
                exports.qbx_core:Notify(src, "Success!", "Success", 5000, "Successfully created Fake DL!", 'top')
            else
                exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough Inventory Space", 'top')
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough inventory space")
                end
            end
        else
            exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have the required items to create a fake DL.", 'top')
        end
    else
        exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough cash! You need $" .. Kodek.FakeDLPrice, 'top')
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough money - Cash: $" .. player.Functions.GetMoney("cash"))
        end
    end
end)

-- Function to handle Fake Weapon License creation
RegisterServerEvent("fakeid:forgewl", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake WL event started by:  " ..  "( ^5" .. player.PlayerData.citizenid .. " ^7)")
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Raw DOB Timestamp: " .. dob)
    end

    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Converted DOB: " .. humandate)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeWLPrice then
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough money! Cash: $" .. player.Functions.GetMoney("cash"))
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
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has entered the following data:")
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "First Name: " .. firstname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Last Name: " .. lastname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Sex: " .. sex)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "DOB: " .. humandate)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Nationality: " .. nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeWLPrice)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed $" .. Kodek.FakeWLPrice .. " from Player")
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed " .. itemData.amount .. "x " .. itemData.item .. " from Player")
                    end
                end

                -- Create the fake WL
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealWL, fakeinfo)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player received a fake weapon license")
                end
                exports.qbx_core:Notify(src, "Success!", "Success", 5000, "Successfully created Fake WL!", 'top')
            else
                exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough Inventory Space", 'top')
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough inventory space")
                end
            end
        else
            exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have the required items to create a fake WL.", 'top')
        end
    else
        exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough cash! You need $" .. Kodek.FakeWLPrice, 'top')
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough money - Cash: $" .. player.Functions.GetMoney("cash"))
        end
    end
end)

-- Function to handle Fake Lawyer Pass creation
RegisterServerEvent("fakeid:forgelp", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake LP event started by:  " ..  "( ^5" .. player.PlayerData.citizenid .. " ^7)")
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Raw DOB Timestamp: " .. dob)
    end

    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Converted DOB: " .. humandate)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeLPPrice then
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough money! Cash: $" .. player.Functions.GetMoney("cash"))
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
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has entered the following data:")
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "First Name: " .. firstname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Last Name: " .. lastname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Sex: " .. sex)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "DOB: " .. humandate)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Nationality: " .. nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeLPPrice)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed $" .. Kodek.FakeLPPrice .. " from Player")
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed " .. itemData.amount .. "x " .. itemData.item .. " from Player")
                    end
                end

                -- Create the fake LP
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealLP, fakeinfo)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player received a fake lawyer pass")
                end
                exports.qbx_core:Notify(src, "Success!", "Success", 5000, "Successfully created Fake LP!", 'top')
            else
                exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough Inventory Space", 'top')
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough inventory space")
                end
            end
        else
            exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have the required items to create a fake LP.", 'top')
        end
    else
        exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough cash! You need $" .. Kodek.FakeLPPrice, 'top')
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough money - Cash: $" .. player.Functions.GetMoney("cash"))
        end
    end
end)

-- Function to handle Fake Hunting License creation
RegisterServerEvent("fakeid:forgehl", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake HL event started by:  " ..  "( ^5" .. player.PlayerData.citizenid .. " ^7)")
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Raw DOB Timestamp: " .. dob)
    end

    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Converted DOB: " .. humandate)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeHLPrice then
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough money! Cash: $" .. player.Functions.GetMoney("cash"))
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
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has entered the following data:")
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "First Name: " .. firstname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Last Name: " .. lastname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Sex: " .. sex)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "DOB: " .. humandate)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Nationality: " .. nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeHLPrice)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed $" .. Kodek.FakeHLPrice .. " from Player")
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed " .. itemData.amount .. "x " .. itemData.item .. " from Player")
                    end
                end

                -- Create the fake HL
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealHL, fakeinfo)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player received a fake hunter license")
                end
                exports.qbx_core:Notify(src, "Success!", "Success", 5000, "Successfully created Fake HL!", 'top')
            else
                exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough Inventory Space", 'top')
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough inventory space")
                end
            end
        else
            exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have the required items to create a fake HL.", 'top')
        end
    else
        exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough cash! You need $" .. Kodek.FakeHLPrice, 'top')
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough money - Cash: $" .. player.Functions.GetMoney("cash"))
        end
    end
end)

-- Function to handle Fake Fishing License creation
RegisterServerEvent("fakeid:forgefl", function(firstname, lastname, sex, dob, nationality, header)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake FL event started by:  " ..  "( ^5" .. player.PlayerData.citizenid .. " ^7)")
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Raw DOB Timestamp: " .. dob)
    end

    if dob > 9999999999 then
        dob = dob / 1000 -- Convert milliseconds to seconds
    end

    local humandate = os.date("%m/%d/%Y", dob)

    if Kodek.Debug then
        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Converted DOB: " .. humandate)
    end

    -- Check if the player has the required money
    if player.Functions.GetMoney("cash") >= Kodek.FakeFLPrice then
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough money! Cash: $" .. player.Functions.GetMoney("cash"))
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
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has enough inventory space")
                end

                local fakeinfo = {
                    firstname = firstname,
                    lastname = lastname,
                    sex = sex,
                    dob = humandate,
                    nationality = nationality,
                    header = header
                }
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player has entered the following data:")
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "First Name: " .. firstname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Last Name: " .. lastname)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Sex: " .. sex)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "DOB: " .. humandate)
                print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Nationality: " .. nationality)

                -- Remove the required money
                player.Functions.RemoveMoney("cash", Kodek.FakeDLPrice)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed $" .. Kodek.FakeFLPrice .. " from Player")
                end

                -- Remove the required items from the player's inventory
                for _, itemData in ipairs(Kodek.RequiredItems) do
                    exports.ox_inventory:RemoveItem(player.PlayerData.source, itemData.item, itemData.amount)
                    if Kodek.Debug then
                        print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Removed " .. itemData.amount .. "x " .. itemData.item .. " from Player")
                    end
                end

                -- Create the fake FL
                exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealFL, fakeinfo)
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player received a fake fishing license")
                end
                exports.qbx_core:Notify(src, "Success!", "Success", 5000, "Successfully created Fake FL!", 'top')
            else
                exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough Inventory Space", 'top')
                if Kodek.Debug then
                    print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough inventory space")
                end
            end
        else
            exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have the required items to create a fake FL.", 'top')
        end
    else
        exports.qbx_core:Notify(src, "Failed!", "Error", 5000, "You do not have enough cash! You need $" .. Kodek.FakeFLPrice, 'top')
        if Kodek.Debug then
            print("( ^5" .. player.PlayerData.citizenid .. " ^7)  " .. "Player does not have enough money - Cash: $" .. player.Functions.GetMoney("cash"))
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
