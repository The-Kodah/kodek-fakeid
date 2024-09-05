local QBCore = exports['qb-core']:GetCoreObject()

-- ox_target Zones
CreateThread(function()
    exports.ox_target:addSphereZone({
        coords = Kodek.FakeIDEntrance,
        radius = Kodek.Radius,
        options = {
            {
                type = "client",
                event = "fakeid:enter",
                icon = "fa fa-sign-in",
                label = "Enter",
                canInteract = function(entity, distance, coords, firstname)
                    return distance < 1
                end
            }
        }
    })

    exports.ox_target:addSphereZone({
        coords = Kodek.FakeIDExit,
        radius = Kodek.Radius,
        options = {
            {
                type = "client",
                event = "fakeid:exit",
                icon = "fa fa-sign-in",
                label = "Leave",
                canInteract = function(entity, distance, coords, firstname)
                    return distance < 1
                end
            }
        }
    })

    exports.ox_target:addSphereZone({
        coords = Kodek.ForgeStart,
        radius = Kodek.Radius,
        options = {
            {
                type = "client",
                event = "fakeid:menu",
                icon = "fa fa-sign-in",
                label = "Log-in to Computer",
                canInteract = function(entity, distance, coords, firstname)
                    return distance < 1
                end
            }
        }
    })
end)


-- Menu
lib.registerContext({
    id = 'fakeid_menu',
    title = 'Document Forgery',
    options = {
        {
            title = 'Forge ID Card',
            disabled = Kodek.DisableFakeID,
            description = 'Manufacture Fake ID Card',
            arrow = true,
            event = 'fakeid:idinfo',
            metadata = {
                {label = 'Cost', value = '$' ..Kodek.FakeIDPrice},
            }
        },
        
        {
            title = 'Forge Driver License',
            disabled = Kodek.DisableFakeDL,
            description = 'Manufacture Fake Driver License',
            arrow = true,
            event = 'fakeid:dlinfo',
            metadata = {
                {label = 'Cost', value = '$' ..Kodek.FakeDLPrice},
            }
        },
        
        {
            title = 'Forge Weapon License',
            disabled = Kodek.DisableFakeWL,
            description = 'Manufacture Fake Weapon License',
            arrow = true,
            event = 'fakeid:wlinfo',
            metadata = {
                {label = 'Cost', value = '$' ..Kodek.FakeWLPrice},
            }
        },
        
        {
            title = 'Forge Lawyer Pass',
            disabled = Kodek.DisableFakeLP,
            description = 'Manufacture Fake Lawyer Pass',
            arrow = true,
            event = 'fakeid:lpinfo',
            metadata = {
                {label = 'Cost', value = '$' ..Kodek.FakeLPPrice},
            }
        },
        
        {
            title = 'Forge Hunting License',
            disabled = Kodek.DisableFakeHL,
            description = 'Manufacture Fake Hunting License',
            arrow = true,
            event = 'fakeid:hlinfo',
            metadata = {
                {label = 'Cost', value = '$' ..Kodek.FakeHLPrice},
            }
        },
        
        {

            title = 'Forge Fishing License',
            disabled = Kodek.DisableFakeFL,
            description = 'Manufacture Fake Fishing License',
            arrow = true,
            event = 'fakeid:flinfo',
            metadata = {
                {label = 'Cost', value = '$' ..Kodek.FakeFLPrice},
            }
        },
    },
})

-- Functions
function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

local function enterdoor()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "anim@heists@keycard@" )
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(PlayerPedId())
end

local function hasRequiredItems()
    local hasAllItems = true
    for _, itemData in ipairs(Kodek.RequiredItems) do
        local item = itemData.item
        local amount = itemData.amount

        if not QBCore.Functions.HasItem(item, amount) then
            hasAllItems = false
            break
        end
    end
    return hasAllItems
end

-- Event for creating a fake ID
RegisterNetEvent('fakeid:create', function(firstname, lastname, sex, dob, nationality)
    if hasRequiredItems() then
        -- Remove the required items from player's inventory
        for _, itemData in ipairs(Kodek.RequiredItems) do
            TriggerServerEvent('QBCore:Server:RemoveItem', itemData.item, itemData.amount)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[itemData.item], 'remove')
        end

        -- Proceed with ID creation logic (assuming server handles ID creation)
        TriggerServerEvent("fakeid:forgeid", firstname, lastname, sex, dob, nationality)
        exports.qbx_core:Notify("Fake ID created successfully!", 'success', 5000)
    else
        exports.qbx_core:Notify("You do not have the required items to create a fake ID.", 'error', 5000)
    end
end)

-- Events
RegisterNetEvent('fakeid:enter', function()
    local hasItem = QBCore.Functions.HasItem("hacker_access_card")  -- Check if player has the item

    if hasItem then
        -- Player has the item, proceed with the door entry animation and teleport
        local Ped = PlayerPedId()
        local PlayerCoords = GetEntityCoords(Ped)

        if not IsPedInAnyVehicle(Ped, false) then
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
            enterdoor()
            DoScreenFadeOut(1000)
            Wait(1500)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)

            -- Extract x, y, z, and heading from Kodek.EntranceSpawn
            local x, y, z, heading = table.unpack(Kodek.EntranceSpawn)

            -- Set the player's coordinates and heading
            SetEntityCoords(Ped, x, y, z, false, false, false, true)
            SetEntityHeading(Ped, heading)

            DoScreenFadeIn(1000)
        else
            exports.qbx_core:Notify("Access Denied", 'error', 5000, "You can not be in a vehicle")
        end
    else
        -- Player doesn't have the required item
        exports.qbx_core:Notify("Access Denied", 'error', 5000, "You need an access card!")
    end
end)

RegisterNetEvent('fakeid:exit', function(source)
    local Ped = PlayerPedId()
    local PlayerCoords = GetEntityCoords(Ped)
    if not IsPedInAnyVehicle(Ped, false) then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
        enterdoor()
        DoScreenFadeOut(1000)
        Wait(1500)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
        
        -- Extract x, y, z, and heading from Kodek.EntranceSpawn
        local x, y, z, heading = table.unpack(Kodek.ExitSpawn)
        
        -- Set the player's coordinates and heading
        SetEntityCoords(Ped, x, y, z, false, false, false, true)
        SetEntityHeading(Ped, heading)
        
        DoScreenFadeIn(1000)
    else
        exports.qbx_core:Notify("Access Denied", 'error', 5000, "You can not be in a vehicle", 'top')
    end
end)

RegisterNetEvent('fakeid:menu', function()
    local Ped = PlayerPedId()
    
    -- Check if the player has the specific USB item
    local hasUSB = QBCore.Functions.HasItem("hacker_usb")  -- Replace "special_usb" with your USB item name

    if hasUSB then
        -- If the player has the USB, play the animation
        loadAnimDict("anim@heists@prison_heiststation@cop_reactions")
        TaskPlayAnim(Ped, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 8.0, 1.0, -1, 16, 0, 0, 0, 0)

        -- Show progress bar for logging into computer
        local success = lib.progressBar({
            duration = 5000,  -- 5 seconds
            label = "Logging into computer",
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true,
            },
            anim = {
                dict = "anim@heists@prison_heiststation@cop_reactions",
                clip = "cop_b_idle",
            }
        })

        if not success then
            -- If the progress was canceled, clear the animation and return
            ClearPedTasksImmediately(Ped)
            exports.qbx_core:Notify("Login Failed", 'error', 5000, "You canceled the login process!")
            return
        end

        -- After progress bar is done, show the menu
        lib.showContext('fakeid_menu')
        exports.qbx_core:Notify("Success!", 'success', 5000, "Access Granted!")

        -- Clear the animation after showing the menu
        ClearPedTasksImmediately(Ped)
    else
        -- If the player doesn't have the USB, deny access
        exports.qbx_core:Notify("Access Denied!", 'error', 5000, "You need the correct USB!")
    end
end)

RegisterNetEvent('fakeid:idinfo', function(source)
    -- Get user input for fake ID details
    local input = lib.inputDialog('Forge ID Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    -- Exit if no input is provided
    if not input then return end

    local firstname = input[1]
    local lastname = input[2]
    local sex = input[3]
    local dob = input[4]
    local nationality = input[5]

    -- Check for required items before proceeding with the progress animation
    if hasRequiredItems() then
        -- Proceed to load animation dictionary and run progress stages
        local animDict = 'mp_fbi_heist'
        local animClip = 'loop'
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(0)
        end

        -- Loop through progress stages from the config
        for _, stage in ipairs(Kodek.ProgressStages) do
            local success = lib.progressBar({
                duration = stage.duration,
                label = stage.label,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
                anim = {
                    dict = animDict,
                    clip = animClip
                },
            })

            -- Exit if the player cancels the progress
            if not success then
                ClearPedTasks(PlayerPedId())
                return
            end
        end

        -- Clear the animation after progress completion
        ClearPedTasks(PlayerPedId())

        -- Trigger the ID creation event after progress completion
        TriggerEvent('fakeid:create', firstname, lastname, sex, dob, nationality)
    else
        -- Notify if the player does not have the required items
        exports.qbx_core:Notify("You do not have the required items to create a fake ID.", 'error', 5000)
    end
end)

RegisterNetEvent('fakeid:dlinfo', function(source)
    -- Get user input for fake DL details
    local input = lib.inputDialog('Forge DL Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    -- Exit if no input is provided
    if not input then return end

    local firstname = input[1]
    local lastname = input[2]
    local sex = input[3]
    local dob = input[4]
    local nationality = input[5]

    -- Check for required items before proceeding with the progress animation
    if hasRequiredItems() then
        -- Proceed to load animation dictionary and run progress stages
        local animDict = 'mp_fbi_heist'
        local animClip = 'loop'
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(0)
        end

        -- Loop through progress stages from the config
        for _, stage in ipairs(Kodek.ProgressStages) do
            local success = lib.progressBar({
                duration = stage.duration,
                label = stage.label,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
                anim = {
                    dict = animDict,
                    clip = animClip
                },
            })

            -- Exit if the player cancels the progress
            if not success then
                ClearPedTasks(PlayerPedId())
                return
            end
        end

        -- Clear the animation after progress completion
        ClearPedTasks(PlayerPedId())

        -- Trigger the ID creation event after progress completion
        TriggerEvent('fakedl:create', firstname, lastname, sex, dob, nationality)
    else
        -- Notify if the player does not have the required items
        exports.qbx_core:Notify("You do not have the required items to create a fake DL.", 'error', 5000)
    end
end)

RegisterNetEvent('fakeid:wlinfo', function(source)
    -- Get user input for fake WL details
    local input = lib.inputDialog('Forge WL Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    -- Exit if no input is provided
    if not input then return end

    local firstname = input[1]
    local lastname = input[2]
    local sex = input[3]
    local dob = input[4]
    local nationality = input[5]

    -- Check for required items before proceeding with the progress animation
    if hasRequiredItems() then
        -- Proceed to load animation dictionary and run progress stages
        local animDict = 'mp_fbi_heist'
        local animClip = 'loop'
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(0)
        end

        -- Loop through progress stages from the config
        for _, stage in ipairs(Kodek.ProgressStages) do
            local success = lib.progressBar({
                duration = stage.duration,
                label = stage.label,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
                anim = {
                    dict = animDict,
                    clip = animClip
                },
            })

            -- Exit if the player cancels the progress
            if not success then
                ClearPedTasks(PlayerPedId())
                return
            end
        end

        -- Clear the animation after progress completion
        ClearPedTasks(PlayerPedId())

        -- Trigger the ID creation event after progress completion
        TriggerEvent('fakewl:create', firstname, lastname, sex, dob, nationality)
    else
        -- Notify if the player does not have the required items
        exports.qbx_core:Notify("You do not have the required items to create a fake WL.", 'error', 5000)
    end
end)

RegisterNetEvent('fakeid:lpinfo', function(source)
    -- Get user input for fake LP details
    local input = lib.inputDialog('Forge LP Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    -- Exit if no input is provided
    if not input then return end

    local firstname = input[1]
    local lastname = input[2]
    local sex = input[3]
    local dob = input[4]
    local nationality = input[5]

    -- Check for required items before proceeding with the progress animation
    if hasRequiredItems() then
        -- Proceed to load animation dictionary and run progress stages
        local animDict = 'mp_fbi_heist'
        local animClip = 'loop'
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(0)
        end

        -- Loop through progress stages from the config
        for _, stage in ipairs(Kodek.ProgressStages) do
            local success = lib.progressBar({
                duration = stage.duration,
                label = stage.label,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
                anim = {
                    dict = animDict,
                    clip = animClip
                },
            })

            -- Exit if the player cancels the progress
            if not success then
                ClearPedTasks(PlayerPedId())
                return
            end
        end

        -- Clear the animation after progress completion
        ClearPedTasks(PlayerPedId())

        -- Trigger the ID creation event after progress completion
        TriggerEvent('fakelp:create', firstname, lastname, sex, dob, nationality)
    else
        -- Notify if the player does not have the required items
        exports.qbx_core:Notify("You do not have the required items to create a fake LP.", 'error', 5000)
    end
end)

RegisterNetEvent('fakeid:hlinfo', function(source)
    -- Get user input for fake HL details
    local input = lib.inputDialog('Forge HL Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    -- Exit if no input is provided
    if not input then return end

    local firstname = input[1]
    local lastname = input[2]
    local sex = input[3]
    local dob = input[4]
    local nationality = input[5]

    -- Check for required items before proceeding with the progress animation
    if hasRequiredItems() then
        -- Proceed to load animation dictionary and run progress stages
        local animDict = 'mp_fbi_heist'
        local animClip = 'loop'
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(0)
        end

        -- Loop through progress stages from the config
        for _, stage in ipairs(Kodek.ProgressStages) do
            local success = lib.progressBar({
                duration = stage.duration,
                label = stage.label,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
                anim = {
                    dict = animDict,
                    clip = animClip
                },
            })

            -- Exit if the player cancels the progress
            if not success then
                ClearPedTasks(PlayerPedId())
                return
            end
        end

        -- Clear the animation after progress completion
        ClearPedTasks(PlayerPedId())

        -- Trigger the ID creation event after progress completion
        TriggerEvent('fakehl:create', firstname, lastname, sex, dob, nationality)
    else
        -- Notify if the player does not have the required items
        exports.qbx_core:Notify("You do not have the required items to create a fake HL.", 'error', 5000)
    end
end)

RegisterNetEvent('fakeid:flinfo', function(source)
    -- Get user input for fake FL details
    local input = lib.inputDialog('Forge FL Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    -- Exit if no input is provided
    if not input then return end

    local firstname = input[1]
    local lastname = input[2]
    local sex = input[3]
    local dob = input[4]
    local nationality = input[5]

    -- Check for required items before proceeding with the progress animation
    if hasRequiredItems() then
        -- Proceed to load animation dictionary and run progress stages
        local animDict = 'mp_fbi_heist'
        local animClip = 'loop'
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(0)
        end

        -- Loop through progress stages from the config
        for _, stage in ipairs(Kodek.ProgressStages) do
            local success = lib.progressBar({
                duration = stage.duration,
                label = stage.label,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
                anim = {
                    dict = animDict,
                    clip = animClip
                },
            })

            -- Exit if the player cancels the progress
            if not success then
                ClearPedTasks(PlayerPedId())
                return
            end
        end

        -- Clear the animation after progress completion
        ClearPedTasks(PlayerPedId())

        -- Trigger the ID creation event after progress completion
        TriggerEvent('fakefl:create', firstname, lastname, sex, dob, nationality)
    else
        -- Notify if the player does not have the required items
        exports.qbx_core:Notify("You do not have the required items to create a fake FL.", 'error', 5000)
    end
end)
