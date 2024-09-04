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
                label = "Forge Menu",
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

-- Events
RegisterNetEvent('fakeid:enter', function(source)
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
    exports['ps-ui']:Scrambler(function(success)
        if not success then
            exports.qbx_core:Notify("Failed!", 'error', 5000, 'Incorrect Login!')
        else
            Wait(2500)
            lib.showContext('fakeid_menu')
            exports.qbx_core:Notify("Success!", 'success', 5000, 'You have logged into the system!')
        end
    end, 'alphanumeric', 30, 0)  -- Adjust the type, time, and mirrored options as needed
end)


RegisterNetEvent('fakeid:idinfo', function(source)
    local input = lib.inputDialog('Forge ID Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })
    if not input then return end
    local firstname = input [1]
    local lastname = input [2]
    local sex = input [3]
    local dob = input [4]
    local nationality = input [5]

    lib.progressCircle({
        duration = Kodek.ComputerTime*1000,
        position = 'top',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            comabt = true,
            mouse = false,
        },

    },{}, function () 
        end, function()
    end)
        TriggerServerEvent("fakeid:forgeid", firstname, lastname, sex, dob, nationality)
end)

RegisterNetEvent('fakeid:dlinfo', function(source)
    local input = lib.inputDialog('Forge ID Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    if not input then return end
    local firstname = input [1]
    local lastname = input [2]
    local sex = input [3]
    local dob = input [4]
    local nationality = input [5]
    lib.progressCircle({
        duration = Kodek.ComputerTime*1000,
        position = 'top',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            comabt = true,
            mouse = false,
        },
        anim = {
            dict = 'mp_fbi_heist',
            clip = 'type4'
        },

    }, {}, function ()

    end, function()
        TriggerServerEvent("fakeid:forgedl", firstname, lastname, sex, dob, nationality)
    end)
end)

RegisterNetEvent('fakeid:wlinfo', function(source)
    local input = lib.inputDialog('Forge ID Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    if not input then return end
    local firstname = input [1]
    local lastname = input [2]
    local sex = input [3]
    local dob = input [4]
    local nationality = input [5]
    lib.progressCircle({
        duration = Kodek.ComputerTime*1000,
        position = 'top',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            comabt = true,
            mouse = false,
        },
        anim = {
            dict = 'mp_fbi_heist',
            clip = 'type4'
        },

    }, {}, function ()

    end, function()
        TriggerServerEvent("fakeid:forgewl", firstname, lastname, sex, dob, nationality)
    end)
end)

RegisterNetEvent('fakeid:lpinfo', function(source)
    local input = lib.inputDialog('Forge ID Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    if not input then return end
    local firstname = input [1]
    local lastname = input [2]
    local sex = input [3]
    local dob = input [4]
    local nationality = input [5]
    lib.progressCircle({
        duration = Kodek.ComputerTime*1000,
        position = 'top',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            comabt = true,
            mouse = false,
        },
        anim = {
            dict = 'mp_fbi_heist',
            clip = 'type4'
        },

    }, {}, function ()

    end, function()
        TriggerServerEvent("fakeid:forgelp", firstname, lastname, sex, dob, nationality)
    end)
end)

RegisterNetEvent('fakeid:hlinfo', function(source)
    local input = lib.inputDialog('Forge ID Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    if not input then return end
    local firstname = input [1]
    local lastname = input [2]
    local sex = input [3]
    local dob = input [4]
    local nationality = input [5]
    lib.progressCircle({
        duration = Kodek.ComputerTime*1000,
        position = 'top',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            comabt = true,
            mouse = false,
        },
        anim = {
            dict = 'mp_fbi_heist',
            clip = 'type4'
        },

    }, {}, function ()

    end, function()
        TriggerServerEvent("fakeid:forgehl", firstname, lastname, sex, dob, nationality)
    end)
end)

RegisterNetEvent('fakeid:flinfo', function(source)
    local input = lib.inputDialog('Forge ID Card', {
        {type = 'input', label = 'First Name', description = 'Enter the First Name', required = true, },
        {type = 'input', label = 'Last Name', description = 'Enter the Last Name', required = true, },
        {type = 'select', label = 'Sex', description = 'Female or Male', required = true, options = {{ value = 'female', label = 'Female',}, { value = 'male', label = 'Male',}} },
        {type = 'date', label = 'DOB', icon = {'far', 'calendar'}, default = true, format = "MM/DD/YYYY"},
        {type = 'input', label = 'Nationality', description = 'Enter the Nationality', required = true, }
    })

    if not input then return end
    local firstname = input [1]
    local lastname = input [2]
    local sex = input [3]
    local dob = input [4]
    local nationality = input [5]
    lib.progressCircle({
        duration = Kodek.ComputerTime*1000,
        position = 'top',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            comabt = true,
            mouse = false,
        },
        anim = {
            dict = 'mp_fbi_heist',
            clip = 'type4'
        },

    }, {}, function ()

    end, function()
        TriggerServerEvent("fakeid:forgefl", firstname, lastname, sex, dob, nationality)
    end)
end)