# FakeID Script for FiveM [QBox]
### Overview
This script allows players to create fake IDs with custom data.


### Dependencies
+ [QBox](https://github.com/Qbox-Project/qbx_core)
+ [qbx-idcard](https://github.com/Qbox-project/qbx_idcard) or [um-idcard](https://github.com/alp1x/um-idcard)
+ [ox_target](https://github.com/overextended/ox_target)


### Installation
Download or clone this repository to your FiveM server resource folder.

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

add the following code to `ox_inventory/data/items.lua`
```
	["hacker_access_card"] = {
		label = "Access Card",
		weight = 100,
		stack = false,
		close = true,
		description = "Access Card to an unknown room",
		client = {
			image = "hacker_access_card.png",
		}
	},

	["hacker_usb"] = {
		label = "Black USB Stick",
		weight = 100,
		stack = false,
		close = true,
		description = "Black USB Stick with Hacker written on it",
		client = {
			image = "hacker_usb.png",
		}
	},

	["blank_card"] = {
		label = "Blank Card",
		weight = 100,
		stack = true,
		close = true,
		description = "Plain, smooth, and white plastic cards ready for custom printing, ideal for creating personalized IDs or access cards.",
		client = {
			image = "blank_card.png",
		}
	},

	["special_ink"] = {
		label = "Special Ink",
		weight = 100,
		stack = false,
		close = true,
		description = "High-quality, iridescent ink that ensures a professional-grade print, suitable for sensitive documents and special purposes.",
		client = {
			image = "special_ink.png",
		}
	},

	["laminating_sheet"] = {
		label = "Laminating Sheet",
		weight = 100,
		stack = true,
		close = true,
		description = "Clear, durable sheets designed for protecting and preserving documents or ID cards by creating a professional, laminated finish.",
		client = {
			image = "laminating_sheet.png",
		}
	},
```

Add all the images from `kodek-fakeid/install` to `ox_inventory/web/images`


### Usage
+ Access Control: Players must possess a hacker access card in their inventory to enter the location.
+ Computer Interaction: Players will interact with a computer to access the Fake ID creation menu.
+ Login Requirement: To log in to the computer, players must have a hacker USB in their inventory.
+ Crafting Requirements: Players must have all the necessary items in their inventory to successfully create a Fake ID.
+ Fake ID Creation Process: Upon meeting the requirements and completing the process, players will input details such as name and date of birth. After a brief delay, the Fake ID will be added to their inventory.

### Future Enhancements
+ Notifications for phone
+ More customization for ID types and validation.
+ Improved NPC interactions with dynamic dialogues.

### License
This project is licensed under the MIT License - see the LICENSE file for details.
