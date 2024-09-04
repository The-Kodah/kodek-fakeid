# FakeID Script for GTA V
### Overview
This script allows players to create fake IDs with custom data.

### Features
Interactive fake ID creation using ps-ui Scrambler minigame.
Flexible pricing system.
Different ID types: regular ID, driver's license (DL), firearms license (FL), etc.

### Dependencies
[QBox](https://github.com/Qbox-Project/qbx_core)
[ox_target](https://github.com/overextended/ox_target)
[ps-ui](https://github.com/Project-Sloth/ps-ui)

### Installation
Download or clone this repository to your FiveM server resource folder.
Ensure ox_target and ps-ui are installed and configured on your server.

add the following code to `qbx_idcard/bridge/framework/qbox.lua`
```
local function CreateFakeMetaLicense(src, itemTable, fakeinfo)
    local player = exports.qbx_core:GetPlayer(src)

    if type(itemTable) == "string" then
        itemTable = {itemTable}
    end

    if type(itemTable) == "table" then
        for _, v in pairs(itemTable) do
            metadata = {
                cardtype = v,
                firstname = fakeinfo.firstname,
                lastname = fakeinfo.lastname,
                birthdate = fakeinfo.dob,
                sex = fakeinfo.sex,
                nationality = fakeinfo.nationality,
                mugShot = 'none',
            }


            exports.ox_inventory:AddItem(src, v, 1, metadata)
        end
    else
        print("Invalid parameter type")
    end
end

exports('CreateFakeMetaLicense', CreateFakeMetaLicense)
```

### Usage
Players will interact with a computer to access the fake ID menu.
A ps-ui Scrambler minigame will start.
Upon successful completion, players will enter the necessary details (e.g., name, date of birth).
After a short delay, they will receive the fakeid in their inventory.

### Future Enhancements
+ Door key/access code
+ Notifications for phone
+ More customization for ID types and validation.
+ Additional minigame options for more variety.
+ Improved NPC interactions with dynamic dialogues.

### License
This project is licensed under the MIT License - see the LICENSE file for details.
