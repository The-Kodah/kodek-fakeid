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

    if player.Functions.GetMoney("cash") >= Kodek.FakeIDPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

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

            player.Functions.RemoveMoney("cash", Kodek.FakeIDPrice)
                if Kodek.Debug then
                    print("Removed $", Kodek.FakeIDPrice, "from: ", player.PlayerData.source)
                end

            exports['qbx_idcard']:CreateFakeMetaLicense(src, Kodek.RealID, fakeinfo)
                if Kodek.Debug then
                    print(player.PlayerData.source, "received a fake identification")
                end

            exports.qbx_core:Notify("Success", "Fake ID created successfully!", 5000, 'top')
        else
            exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
        end
    else
        exports.qbx_core:Notify("Error!", 'error' .. Kodek.FakeIDPrice, 5000, "You do not have enough cash. Need $" .. Kodek.FakeIDPrice)
            if Kodek.Debug then
                print(player.PlayerData.source, "does not have enough money!")
            end
    end

end)

-- Function to handle Fake Driver's License creation
RegisterServerEvent("fakeid:forgedl", function(firstname, lastname, sex, dob, nationality)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake DL event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    if player.Functions.GetMoney("cash") >= Kodek.FakeIDPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealID, 1) then
            if Kodek.Debug then
                print(player.PlayerData.source, " has enough inventory space")
            end

            local info = {
                firstname = firstname,
                lastname = lastname,
                sex = sex,
                dob = dob,
                nationality = nationality,
                header = 'Identity'
            }
            if Kodek.Debug then
                print(player.PlayerData.source, " has entered the following data:")
                print("First Name: ", firstname)
                print("Last Name: ", lastname)
                print("Sex: ", sex)
                print("DOB: ", dob)
                print("Nationality: ", nationality)
            end

            player.Functions.RemoveMoney("cash", Kodek.FakeIDPrice)

            if Kodek.Debug then
                print("Removed $", Kodek.FakeIDPrice, "from: ", player.PlayerData.source)
            end
            exports['qbx_idcard']:CreateMetaLicense(src, Kodek.RealID, info)
            if Kodek.Debug then
                print(player.PlayerData.source, "received a fake drivers license")
            end

            exports.qbx_core:Notify("Success", "Fake ID created successfully!", 5000, 'top')
        else
            exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
        end
    else
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end

        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
    end

end)

-- Function to handle Fake Weapon License creation
RegisterServerEvent("fakeid:forgewl", function(firstname, lastname, sex, dob, nationality)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake WL event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    if player.Functions.GetMoney("cash") >= Kodek.FakeIDPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealID, 1) then
            if Kodek.Debug then
                print(player.PlayerData.source, " has enough inventory space")
            end

            local info = {
                firstname = firstname,
                lastname = lastname,
                sex = sex,
                dob = dob,
                nationality = nationality,
                header = 'Weapon License'
            }
            print(player.PlayerData.source, " has entered the following data:")
            print("First Name: ", firstname)
            print("Last Name: ", lastname)
            print("Sex: ", sex)
            print("DOB: ", dob)
            print("Nationality: ", nationality)

            player.Functions.RemoveMoney("cash", Kodek.FakeIDPrice)

            if Kodek.Debug then
                print("Removed $", Kodek.FakeIDPrice, "from: ", player.PlayerData.source)
            end
            exports.ox_inventory:AddItem(player.PlayerData.source, Kodek.RealID, 1, info)
            if Kodek.Debug then
                print(player.PlayerData.source, "received a fake weapons license")
            end

            exports.qbx_core:Notify("Success", "Fake ID created successfully!", 5000, 'top')
        else
            exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
        end
    else
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end

        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
    end

end)

-- Function to handle Fake Lawyer Pass creation
RegisterServerEvent("fakeid:forgelp", function(firstname, lastname, sex, dob, nationality)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake ID event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    if player.Functions.GetMoney("cash") >= Kodek.FakeIDPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealID, 1) then
            if Kodek.Debug then
                print(player.PlayerData.source, " has enough inventory space")
            end

            local info = {
                firstname = firstname,
                lastname = lastname,
                sex = sex,
                dob = dob,
                nationality = nationality,
                header = 'Lawyer Pass'
            }
            print(player.PlayerData.source, " has entered the following data:")
            print("First Name: ", firstname)
            print("Last Name: ", lastname)
            print("Sex: ", sex)
            print("DOB: ", dob)
            print("Nationality: ", nationality)

            player.Functions.RemoveMoney("cash", Kodek.FakeIDPrice)

            if Kodek.Debug then
                print("Removed $", Kodek.FakeIDPrice, "from: ", player.PlayerData.source)
            end
            exports.ox_inventory:AddItem(player.PlayerData.source, Kodek.RealID, 1, info)
            if Kodek.Debug then
                print(player.PlayerData.source, "received a fake lawyer pass")
            end

            exports.qbx_core:Notify("Success", "Fake ID created successfully!", 5000, 'top')
        else
            exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
        end
    else
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end

        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
    end

end)

-- Function to handle Fake Hunting License creation
RegisterServerEvent("fakeid:forgehl", function(firstname, lastname, sex, dob, nationality)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake ID event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    if player.Functions.GetMoney("cash") >= Kodek.FakeIDPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealID, 1) then
            if Kodek.Debug then
                print(player.PlayerData.source, " has enough inventory space")
            end

            local info = {
                firstname = firstname,
                lastname = lastname,
                sex = sex,
                dob = dob,
                nationality = nationality,
                header = 'Hunting License'
            }
            print(player.PlayerData.source, " has entered the following data:")
            print("First Name: ", firstname)
            print("Last Name: ", lastname)
            print("Sex: ", sex)
            print("DOB: ", dob)
            print("Nationality: ", nationality)

            player.Functions.RemoveMoney("cash", Kodek.FakeIDPrice)

            if Kodek.Debug then
                print("Removed $", Kodek.FakeIDPrice, "from: ", player.PlayerData.source)
            end
            exports.ox_inventory:AddItem(player.PlayerData.source, Kodek.RealID, 1, info)
            if Kodek.Debug then
                print(player.PlayerData.source, "received a fake hunting license")
            end

            exports.qbx_core:Notify("Success", "Fake ID created successfully!", 5000, 'top')
        else
            exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
        end
    else
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end

        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
    end

end)

-- Function to handle Fake Fishing License creation
RegisterServerEvent("fakeid:forgefl", function(firstname, lastname, sex, dob, nationality)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)

    if Kodek.Debug then
        print("Fake ID event started by:")
        print("Player ID: ", player.PlayerData.source)
    end

    if player.Functions.GetMoney("cash") >= Kodek.FakeIDPrice then
        if Kodek.Debug then
            print(player.PlayerData.source, "has enough money: ", player.Functions.GetMoney("cash"))
        end

        if exports.ox_inventory:CanCarryItem(player.PlayerData.source, Kodek.RealID, 1) then
            if Kodek.Debug then
                print(player.PlayerData.source, " has enough inventory space")
            end

            local info = {
                firstname = firstname,
                lastname = lastname,
                sex = sex,
                dob = dob,
                nationality = nationality,
                header = 'Fishing License'
            }
            print(player.PlayerData.source, " has entered the following data:")
            print("First Name: ", firstname)
            print("Last Name: ", lastname)
            print("Sex: ", sex)
            print("DOB: ", dob)
            print("Nationality: ", nationality)

            player.Functions.RemoveMoney("cash", Kodek.FakeIDPrice)

            if Kodek.Debug then
                print("Removed $", Kodek.FakeIDPrice, "from: ", player.PlayerData.source)
            end
            exports.ox_inventory:AddItem(player.PlayerData.source, Kodek.RealID, 1, info)
            if Kodek.Debug then
                print(player.PlayerData.source, "received a fake fishing license")
            end

            exports.qbx_core:Notify("Success", "Fake ID created successfully!", 5000, 'top')
        else
            exports.qbx_core:Notify("Error", "You do not have enough Inventory Space", 5000, 'top')
        end
    else
        if Kodek.Debug then
            print(player.PlayerData.source, "does not have enough money!")
        end

        exports.qbx_core:Notify("Error", "You do not have enough cash. Need $" .. Kodek.FakeIDPrice, 5000, 'top')
    end

end)
