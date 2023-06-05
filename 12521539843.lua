getgenv().settings = {
    autofarm = {
        enabled = false,
        mob = nil,
		position = nil,
		distance = 5,
		lootmob = false,
		sellcorpse = false
    },
    autoquest = {
        enabled = false,
        quest = nil
    },
    autochest = {
        enabled = false,
        chest = nil
    },
	autoore = {
		enabled = false,
		ore = nil
	},
    misc = {
        infstamina = false,
        antideathpenalty = false,
        antistun = false,
		regen = false,
		nocooldown = false,
		antiragdoll = false,
		autodepositgold = false,
		autodepositsilver = false
    }
}

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService('RunService')

local npc_table = {}

for i, npc in pairs(workspace.GameObjects.NPCs:GetChildren()) do
	table.insert(npc_table, npc.Name)
end

for i, npc in pairs(workspace.GameObjects.NPCs2:GetChildren()) do
	table.insert(npc_table, npc.Name)
end

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua'))()

local ui = library:Create{
    Name = 'Lee RPG',
    Size = UDim2.fromOffset(600, 400),
    Theme = library.Themes.Dark,
    Link = 'https://github.com/cunning-sys/voxle-hub'
}

local main_tab = ui:Tab{
	Name = 'Main',
	Icon = 'rbxassetid://8569322835'
}

local autofarm_section = main_tab:section{
	Name = 'Autofarm'
}

autofarm_section:Toggle{
	Name = 'Enabled',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.autofarm.enabled = state
    end
}

local autofarm_dropdown = autofarm_section:Dropdown{
	Name = 'Mob',
	StartingText = 'Select...',
	Description = nil,
	Items = {
		'Giant Sand Kip',
		'Sand Kip',
		'Turtling',
		'Goblin',
		'TheFirstDesire',
		'Maxwell',
		'Giant Evil Leech',
		'Abyssal Watcher',
		'Snow Dweller',
		'Rock Pig',
		'Purple Goblin',
		'Rat Kin',
		'Water Turtle',
		'Fire Bird',
		'Cyclops',
		'Sand Onion',
		'Stone Slicer',
		'Goblin Archer',
		'Cave Goblin',
		'Abyssal Giant',
		'Cave Sha',
		'Abyssal Skinner',
		'Bandit Gunner',
		'Electro Raptor',
		'Abyssal Puppet',
		'Abyssal Archer',
		'Demon Grunt',
		'Cyclops Bot',
		'Darkling',
		'Cave Rex',
		'Evil Leech',
		'Stone Golem',
		'Sand Golem',
		'Mouse Kin',
		'Sand Warrior',
		'Lightning Entity',
		'Bandit',
		'Bandit Commander',
		'Goblin Commander',
		'Goblin Commando',
		'Deer'
	},
	Callback = function(mob)
        settings.autofarm.mob = mob
    end
}

local autofarm_position_dropdown = autofarm_section:Dropdown{
	Name = 'Position',
	StartingText = 'Select...',
	Description = nil,
	Items = {
		'Above', 		-- {name, value}
	    'Below',
		'Behind',
		'Infront'
	},
	Callback = function(position)
        settings.autofarm.position = position
    end
}

autofarm_section:Slider{
	Name = 'Distance',
	Default = 5,
	Min = -10,
	Max = 10,
	Callback = function(value)
		settings.autofarm.distance = value
    end
}

autofarm_section:Toggle{
	Name = 'Loot Mob',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.autofarm.lootmob = state
    end
}

autofarm_section:Toggle{
	Name = 'Auto Sell Corpse',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.autofarm.sellcorpse = state
    end
}

local auto_quest_section = main_tab:section{
	Name = 'Auto Quest'
}

auto_quest_section:Toggle{
	Name = 'Enabled',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.autoquest.enabled = state
    end
}

local auto_quest_dropdown = auto_quest_section:Dropdown{
	Name = 'Quest',
	StartingText = 'Select...',
	Description = nil,
	Items = {
		'Kippy',
		'Zoe The Farmer',
		'Falic The Farmer',
		'Goblin Slayer',
		'Kasper',
		'Isaac, Towns Keep',
		'James, Shell Smith',
		'Mranimebar, Collector',
		'Remi, White Whistle',
		'Shell Collector',
		'Sick Farmer Boy',
		'Tina, Shaman Doctor',
	},
	Callback = function(quest)
        settings.autoquest.quest = quest
    end
}

local ore_autofarm_section = main_tab:section{
	Name = 'Ore Autofarm'
}

ore_autofarm_section:Toggle{
	Name = 'Enabled',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		if not LocalPlayer.Data.Items:FindFirstChild('Pickaxe') then
			settings.autoore.enabled = false
			game:GetService('StarterGui'):SetCore("SendNotification", {
				Title = "WARNING";
				Text = "You don't have a pickaxe. Feature was disabled";
				Duration = 5;
			})
		else
			if not LocalPlayer.Backpack:FindFirstChild('Pickaxe') then
				game:GetService("ReplicatedStorage").RepStorage.Remotes.EquipItem:FireServer(LocalPlayer.Data.Items.Pickaxe)
			end

			settings.autoore.enabled = state
		end
    end
}

local ore_autofarm_dropdown = ore_autofarm_section:Dropdown{
	Name = 'Ore',
	StartingText = 'Select...',
	Description = nil,
	Items = {
		'Stone',
		'Coal',
		'Copper',
	    'Tin',
		'Iron',
		'Amethyst'
	},
	Callback = function(ore)
        settings.autoore.ore = ore
    end
}
--[[
local item_autofarm_section = main_tab:section{
	Name = 'Item Autofarm'
}

item_autofarm_section:Toggle{
	Name = 'Enabled',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		
    end
}

local item_autofarm_dropdown = item_autofarm_section:Dropdown{
	Name = 'Item',
	StartingText = 'Select...',
	Description = nil,
	Items = {
		'Basic Chest', 		-- {name, value}
	    'Iron Chest',
	},
	Callback = function(item)
        return
    end
}
]]
local auto_chest_section = main_tab:section{
	Name = 'Auto Chest'
}

auto_chest_section:Toggle{
	Name = 'Enabled',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.autochest.enabled = state
    end
}
--[[
local visuals_tab = ui:Tab{
	Name = 'Visuals',
	Icon = 'rbxassetid://8569322835'
}

visuals_tab:Toggle{
	Name = 'Enabled',
	StartingState = false,
	Description = nil,
	Callback = function(state)

    end
}

local visuals_ores_section = visuals_tab:section{
	Name = 'Ores'
}

visuals_ores_section:Toggle{
	Name = 'Sand Ore',
	StartingState = false,
	Description = nil,
	Callback = function(state)

    end
}

visuals_ores_section:Toggle{
	Name = 'Iron Ore',
	StartingState = false,
	Description = nil,
	Callback = function(state)

    end
}

visuals_ores_section:Toggle{
	Name = 'Coal Ore',
	StartingState = false,
	Description = nil,
	Callback = function(state)

    end
}

visuals_ores_section:Toggle{
	Name = 'Amethyst Ore',
	StartingState = false,
	Description = nil,
	Callback = function(state)

    end
}

visuals_ores_section:Toggle{
	Name = 'Tin Ore',
	StartingState = false,
	Description = nil,
	Callback = function(state)

    end
}

visuals_ores_section:Toggle{
	Name = 'Copper Ore',
	StartingState = false,
	Description = nil,
	Callback = function(state)

    end
}

visuals_ores_section:Toggle{
	Name = 'Stone Ore',
	StartingState = false,
	Description = nil,
	Callback = function(state)

    end
}
]]
local misc_tab = ui:Tab{
	Name = 'Misc',
	Icon = 'rbxassetid://8569322835'
}

misc_tab:Toggle{
	Name = 'Inf Stamina',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.misc.infstamina = state
    end
}

misc_tab:Toggle{
	Name = 'Anti Stun',
	StartingState = false,
	Description = nil,
	Callback = function(state)
        settings.misc.antistun = state
    end
}

misc_tab:Toggle{
	Name = 'Anti Death Penalty (idk if it works)',
	StartingState = false,
	Description = nil,
	Callback = function(state)
        settings.misc.antideathpenalty = state
    end
}

misc_tab:Toggle{
	Name = 'Anti Ragdoll',
	StartingState = false,
	Description = nil,
	Callback = function(state)
        settings.misc.antiragdoll = state
        
    end
}

misc_tab:Toggle{
	Name = 'No Cooldown',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.misc.nocooldown = state
    end
}

misc_tab:Toggle{
	Name = 'Regen',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.misc.regen = state
    end
}

local misc_teleports_section = misc_tab:section{
	Name = 'Teleports'
}

local misc_area_teleports_dropdown = misc_teleports_section:Dropdown{
	Name = 'Area',
	StartingText = 'Select...',
	Description = nil,
	Items = {
		'Tundra',
	    'Beach Port',
		'Charged Plains',
		'Riza Cave',
		'Riza Deep Cave',
		'Riza Deep Forest',
		'Riza Forest',
		"Zoe's Farm"
	},
	Callback = function(area)
		if area == 'Tundra' then
			LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Main.Areas.Tundra.Tundra.CFrame
		else
        	LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Main.Areas[area].CFrame
		end
    end
}

local misc_npc_teleports_dropdown = misc_teleports_section:Dropdown{
	Name = 'NPC',
	StartingText = 'Select...',
	Description = nil,
	Items = npc_table,
	Callback = function(npc)
        if npc == 'Jeff, Sparring Partner' then
			LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.GameObjects.NPCs2[npc].PrimaryPart.CFrame
		else
			LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.GameObjects.NPCs[npc].PrimaryPart.CFrame
		end
    end
}

local misc_banking_section = misc_tab:section{
	Name = 'Banking'
}

local banking_gold_label = misc_banking_section:Label{
	Text = 'Gold:',
	Description = LocalPlayer.Data.ExtraStats.GoldBank.Value
}

LocalPlayer.Data.ExtraStats.GoldBank.Changed:Connect(function(value)
	banking_gold_label:SetDescription(value)
end)

local banking_silver_label = misc_banking_section:Label{
	Text = 'Silver:',
    Description = LocalPlayer.Data.ExtraStats.SilverBank.Value
}

LocalPlayer.Data.ExtraStats.SilverBank.Changed:Connect(function(value)
	banking_silver_label:SetDescription(value)
end)

misc_banking_section:Button{
	Name = 'Withdraw All Gold',
	Callback = function()
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Withdraw', 'Gold', LocalPlayer.Data.ExtraStats.GoldBank.Value)
	end
}

misc_banking_section:Textbox{
	Name = 'Withdraw Gold',
	Placeholder = 'Amount...',
	Callback = function(text)
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Withdraw', 'Gold', tonumber(text))
	end
}

misc_banking_section:Button{
	Name = 'Deposit All Gold',
	Callback = function()
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Deposit', 'Gold', LocalPlayer.Data.Stats.Gold.Value)
	end
}

misc_banking_section:Textbox{
	Name = 'Deposit Gold',
	Placeholder = 'Amount...',
	Callback = function(text)
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Deposit', 'Gold', tonumber(text))
	end
}

misc_banking_section:Toggle{
	Name = 'Auto Deposit Gold',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.misc.autodepositgold = state
		if state then
			game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Deposit', 'Gold', LocalPlayer.Data.Stats.Gold.Value)
		end
    end
}

LocalPlayer.Data.Stats.Gold.Changed:Connect(function(value)
	if settings.misc.autodepositgold then
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Deposit', 'Gold', value)
	end
end)

misc_banking_section:Button{
	Name = 'Withdraw All Silver',
	Callback = function()
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Withdraw', 'Silver', LocalPlayer.Data.ExtraStats.SilverBank.Value)
	end
}

misc_banking_section:Textbox{
	Name = 'Withdraw Silver',
	Placeholder = 'Amount...',
	Callback = function(text)
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Withdraw', 'Silver', tonumber(text))
	end
}

misc_banking_section:Button{
	Name = 'Deposit All Silver',
	Callback = function()
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Deposit', 'Silver', LocalPlayer.Data.Stats.Silver.Value)
	end
}

misc_banking_section:Textbox{
	Name = 'Deposit Silver',
	Placeholder = 'Amount...',
	Callback = function(text)
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Deposit', 'Silver', tonumber(text))
	end
}

misc_banking_section:Toggle{
	Name = 'Auto Deposit Silver',
	StartingState = false,
	Description = nil,
	Callback = function(state)
		settings.misc.autodepositsilver = state
		if state then
			game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Deposit', 'Silver', LocalPlayer.Data.Stats.Silver.Value)
		end
    end
}

LocalPlayer.Data.Stats.Silver.Changed:Connect(function(value)
	if settings.misc.autodepositsilver then
		game:GetService('ReplicatedStorage').RepStorage.Remotes.BankFunction:FireServer('Deposit', 'Silver', value)
	end
end)

function farm_chests()
	if settings.autochest.enabled then
		for i, chest in pairs(workspace:GetChildren()) do
			if table.find({''}, chest.Name) and chest.PrimaryPart then
				LocalPlayer.Character.HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame
				fireproximityprompt(chest:FindFirstChild('Open'), 1, true)
			end
		end
	end
end

function farm_ore()
	if settings.autoore.enabled then
		if LocalPlayer.Backpack:FindFirstChild('Pickaxe') then
			LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild('Pickaxe'))
		end

		for i, v in pairs(workspace:GetChildren()) do
			if table.find({'Ore', 'Amethyst'}, v.Name) then
				for i, ore in pairs(v:GetDescendants()) do
					if ore:IsA('StringValue') and ore.Name == settings.autoore.ore then
						LocalPlayer.Character.HumanoidRootPart.CFrame = ore.Parent.CFrame
						LocalPlayer.Character.Pickaxe:Activate()
					end
				end
			end
		end
	end
end


function get_closest_mob()
	local dist = math.huge
	local closest_mob = nil

	for i, mob in pairs(workspace.Main.Players:GetChildren()) do
		if table.find({settings.autofarm.mob}, mob.Name) and mob:FindFirstChild('HumanoidRootPart') then
			local mag = (LocalPlayer.Character.HumanoidRootPart.Position - mob:FindFirstChild('HumanoidRootPart').Position).Magnitude
			if mag < dist then
                dist = mag
                closest_mob = mob
            end
        end
    end
    return closest_mob
end

function autofarm_mob()
	if settings.autofarm.enabled then
		local mob = get_closest_mob()

		if not LocalPlayer.Character.States.Equipped.Value then
			LocalPlayer.Character.ClientStateReplication.Equip:FireServer()
		end

    	if not mob:FindFirstChild('Torso'):FindFirstChild('ProximityPrompt') then
			if settings.autofarm.position == 'Above' then
    	    	LocalPlayer.Character.HumanoidRootPart.CFrame = mob.PrimaryPart.CFrame * CFrame.new(0, settings.autofarm.distance, 0) * CFrame.Angles(math.rad(-90),0,0)
			elseif settings.autofarm.position == 'Below' then
				LocalPlayer.Character.HumanoidRootPart.CFrame = mob.PrimaryPart.CFrame * CFrame.new(0, -settings.autofarm.distance, 0) * CFrame.Angles(math.rad(90),0,0)
			elseif settings.autofarm.position == 'Behind' then
				LocalPlayer.Character.HumanoidRootPart.CFrame = mob.PrimaryPart.CFrame * CFrame.new(0, 0, settings.autofarm.distance)
			elseif settings.autofarm.position == 'Infront' then
				LocalPlayer.Character.HumanoidRootPart.CFrame = mob.PrimaryPart.CFrame * CFrame.new(0, 0, -settings.autofarm.distance)
			end
    	    game:GetService('Players').LocalPlayer.Character.ClientStateReplication.M1:FireServer(true)
    	elseif settings.autofarm.lootmob and mob:FindFirstChild('Torso'):FindFirstChild('ProximityPrompt') then
    	    LocalPlayer.Character.HumanoidRootPart.CFrame = mob.PrimaryPart.CFrame * CFrame.new(0, 3, 0)
    	    if mob:FindFirstChild('Torso'):FindFirstChild('ProximityPrompt').ObjectText == 'Loot' then
    	        fireproximityprompt(mob:FindFirstChild('Torso'):FindFirstChild('ProximityPrompt'), 1, true)
    	    elseif settings.autofarm.sellcorpse and mob:FindFirstChild('Torso'):FindFirstChild('ProximityPrompt').ObjectText == 'Drag' then
    	        fireproximityprompt(mob:FindFirstChild('Torso'):FindFirstChild('ProximityPrompt'), 1, true)
    	        game:GetService('ReplicatedStorage'):WaitForChild('RepStorage'):WaitForChild('Remotes'):WaitForChild('TalkToNPC'):FireServer('Scarlet Scarifice', '')
        	end
    	end
	end
end



RunService.PostSimulation:Connect(function()
	if settings.misc.antideathpenalty then
		LocalPlayer.Character.States.InCombat.Value = false
        LocalPlayer.Character.States.InDanger.Value = false
	end

	if settings.misc.regen then
		LocalPlayer.Character.States.Regen.Value = true
	end

	if settings.misc.antistun then
		LocalPlayer.Character.States.Stunned.Value = false
	end

	if settings.misc.nocooldown then
		LocalPlayer.Character.States.GCD.Value = false
		LocalPlayer.Character.States.M1ing.Value = false
		LocalPlayer.Character.States.Swinging.Value = false
	end

	if settings.misc.antiragdoll then
		LocalPlayer.Character.States.Ragdolled.Value = false
	end

	if settings.autoquest.enabled and settings.autoquest.quest ~= nil then
		game:GetService("ReplicatedStorage").RepStorage.Remotes.TalkToNPC:FireServer(settings.autoquest.quest, '')
	end

	autofarm_mob()
	farm_chests()
	farm_ore()
end)

local __namecall
__namecall = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
    local args, method = {...}, getnamecallmethod()
        
    if settings.misc.infstamina and table.find({'Running', 'Dashing', 'Flying'}, self.Name) and tostring(method):match('FireServer') then
        return
    end

    return __namecall(self, ...)
end))

--[[
	
Deep Forest Twine
Abyssal Shell
Beach Shell
Birch
BlueBows
Bober Bloom

]]--
