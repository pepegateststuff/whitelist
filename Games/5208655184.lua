xpcall(function()

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/pepegateststuff/whitelist/main/testinglol.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/pepegateststuff/whitelist/main/saveslol.lua'))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/pepegateststuff/whitelist/main/themeslol.lua'))()

local Window = Library:CreateWindow({
    Title = 'kold',
    Center = true, 
    AutoShow = true,
})

_G.loaded = false

-- // Ingredient ESP
_G.ingredientEsp = false
_G.ingredientFont = 3
_G.ingredientSize = 13

-- // Ore ESP
_G.oreEsp = false
_G.oreEspDistance = true
_G.oreFont = 3
_G.oreSize = 13

-- // Trinket ESP
_G.trinketEsp = false
_G.trinketNormalColor = Color3.fromRGB(255,255,255)
_G.trinketArtifactColor = Color3.fromRGB(255,0,0)
_G.trinketFont = 3
_G.trinketSize = 13

-- // Trinket Auto Pickup
_G.trinketAutoPickup = false

local currentCamera = workspace.CurrentCamera

-- // Functions
local function get_distance(part)
	return math.floor((workspace.CurrentCamera.CFrame.Position - part.Position).Magnitude)
end

local function addSpectate(v)
	local spectateButton = Instance.new("TextButton")
	spectateButton.Parent = v
	spectateButton.Size = v.Size
	spectateButton.Transparency = 1
	
	spectateButton.Activated:Connect(function()
		local name = string.gsub(v.Text, "\226\128\142", "")
		if name == game.Players.LocalPlayer.Name then return end
		if v:FindFirstChild("Spec") then
			v:FindFirstChild("Spec"):Destroy()
			workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
		else
			for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.LeaderboardGui.MainFrame.ScrollingFrame:GetDescendants()) do
				if v.Name == "Spec" then
					v:Destroy()
				end
			end
			Instance.new("Folder", v).Name = "Spec"
			if game.Players:FindFirstChild(name) ~= nil then
				workspace.CurrentCamera.CameraSubject = game.Players[name].Character
			end
		end
	end)
end

local function iesp(ingredient)
    local text = Drawing.new("Text")
    text.Center = true
    text.Size = _G.ingredientSize
    text.Font = _G.ingredientFont
    text.Outline = true
    text.OutlineColor = Color3.new(0,0,0)
    text.Color = Color3.new(1,1,1)
	
    local update
    update = game:GetService("RunService").RenderStepped:Connect(function()
        if _G.ingredientEsp and ingredient:FindFirstChild("ClickDetector") then
            local vector, onscreen = currentCamera:WorldToViewportPoint(ingredient.Position)

	    	text.Size = _G.ingredientSize
    	    text.Font = _G.ingredientFont

            if onscreen then
                text.Visible = true
                text.Text = ingredient.Name
                text.Position = Vector2.new(vector.X, vector.Y)
                text.Color = ingredient.Color
	
                if ingredient.Color == Color3.fromRGB(202, 203, 209) then
                	text.Text = "Snow Shrooms"
                end
                if ingredient.Color == Color3.fromRGB(33, 84, 185) and ingredient.Material == "Ice" then
                	text.Text = "Ice Jars"
                end
                if ingredient.Color == Color3.fromRGB(75, 151, 75) then
                	text.Text = "Moss Plant"
                end
                if ingredient.Color == Color3.fromRGB(58, 125, 21) then
                	text.Text = "Pariashroom"
                end
                if ingredient.Color == Color3.fromRGB(33, 84, 185) and ingredient.Material == "Plastic" then
                	text.Text = "Dire Flower"
                end
                if ingredient.Color == Color3.fromRGB(100, 255, 100) then
                	text.Text = "Trote"
                end
                if ingredient.Color == Color3.fromRGB(226, 155, 64) then
                	text.Text = "Acorn Light"
                end
                if ingredient.Color == Color3.fromRGB(98, 37, 209) then
                	text.Text = "Blood Thorn"
                end
                if ingredient.Color == Color3.fromRGB(75, 151, 75) and ingredient.Material == "Grass" then
                	text.Text = "Canewood"
                end
                if ingredient.Color == Color3.fromRGB(128, 187, 219) then
                	text.Text = "Creely"
                end
                if ingredient.Color == Color3.fromRGB(100, 255, 100) then
                	text.Text = "Crown Flower"
                end
                if ingredient.Color == Color3.fromRGB(177, 229, 166) then
                	text.Text = "Desert Mist"
                end
                if ingredient.Color == Color3.fromRGB(175, 221, 255) then
                	text.Text = "Freeleaf"
                end
                if ingredient.Color == Color3.fromRGB(202, 203, 209) then
                	text.Text = "Glow Shroom"
                end
                if ingredient.Color == Color3.fromRGB(190, 104, 98) then
                	text.Text = "Lava Flower"
                end
                if ingredient.Color == Color3.fromRGB(211, 190, 150) then
                	text.Text = "Scroom"
                end
                if ingredient.Color == Color3.fromRGB(27, 42, 53) then
                	text.Text = "Vile Seed"
                end
            else
                text.Visible = false
            end
        else
            text.Visible = false
            update:Disconnect()
        end
    end)
end

local function oreesp(trinket)
    local text = Drawing.new("Text")
    text.Center = true
    text.Size = _G.oreSize
    text.Font = _G.oreFont
    text.Outline = true
    text.OutlineColor = Color3.new(0,0,0)
    text.Color = Color3.new(1,1,1)
	
    local update
    update = game:GetService("RunService").RenderStepped:Connect(function()
        if trinket and _G.oreEsp and trinket.OreLife.Value > 0 then
            local vector, onscreen = currentCamera:WorldToViewportPoint(trinket.Position)
            if onscreen then
                text.Visible = true
                text.Text = trinket.Name
                text.Position = Vector2.new(vector.X, vector.Y)
                text.Color = Color3.fromRGB(255, 255, 255)
                
                text.Size = _G.oreSize
    			text.Font = _G.oreFont
	
                if trinket.Name == "Tin" then
                	if _G.oreEspDistance then
                		text.Text = "Tin\n[" .. tostring(get_distance(trinket)) .. "]"
                	else
                		text.Text = "Tin"
                	end
                    text.Color = Color3.fromRGB(200, 200, 200)
                end
	
                if trinket.Name == "Copper" then
                    if _G.oreEspDistance then
                		text.Text = "Copper\n[" .. tostring(get_distance(trinket)) .. "]"
                	else
                		text.Text = "Copper"
                	end
                    text.Color = Color3.fromRGB(175, 148, 131)
                end
	
                if trinket.Name == "Iron" then
                    if _G.oreEspDistance then
                		text.Text = "Iron\n[" .. tostring(get_distance(trinket)) .. "]"
                	else
                		text.Text = "Iron"
                	end
                    text.Color = Color3.fromRGB(91, 93, 105)
                end
	
                if trinket.Name == "Mythril" then
                    if _G.oreEspDistance then
                		text.Text = "Mythril\n[" .. tostring(get_distance(trinket)) .. "]"
                	else
                		text.Text = "Mythril"
                	end
                    text.Color = Color3.fromRGB(110, 153, 202)
                end
            else
                text.Visible = false
            end
        else
            text.Visible = false
            update:Disconnect()
        end
    end)
end

local function trinketesp(trinket)
    local text = Drawing.new("Text")
    text.Center = true
    text.Size = _G.trinketSize
    text.Font = _G.trinketFont
    text.Outline = true
    text.OutlineColor = Color3.new(0,0,0)
    text.Color = Color3.new(1,1,1)
	
    local update
    update = game:GetService("RunService").RenderStepped:Connect(function()
        if trinket and _G.trinketEsp and trinket:FindFirstChild("ID") then
            local vector, onscreen = currentCamera:WorldToViewportPoint(trinket.Position)
            
            text.Size = _G.trinketSize
    		text.Font = _G.trinketFont
            
            if onscreen then
                text.Visible = true
                text.Text = "Part"
                text.Position = Vector2.new(vector.X, vector.Y)
                text.Color = Color3.fromRGB(255, 255, 255)
	
				if trinket:IsA("MeshPart") then
					if trinket.Color == Color3.fromRGB(33, 84, 185) and trinket.MeshId == "rbxassetid://923469333" and trinket.Material == Enum.Material.Plastic then
	                	text.Text = "Blue Candy"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.MeshId == "rbxassetid://5196551436" and trinket.Material == Enum.Material.Metal then
	                	text.Text = "Amulet"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.MeshId == "rbxassetid://5204003946" and trinket.Material == Enum.Material.Metal then
	                	text.Text = "Goblet"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(30, 185, 30) and trinket.MeshId == "rbxassetid://923469333" and trinket.Material == Enum.Material.Plastic then
	                	text.Text = "Green Candy"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.MeshId == "rbxassetid://2520762076" and trinket.Material == Enum.Material.SmoothPlastic then
	                	text.Text = "Howler Friend"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.MeshId == "rbxassetid://5196577540" and trinket.Material == Enum.Material.Metal then
	                	text.Text = "Old Amulet"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.MeshId == "rbxassetid://5196782997" and trinket.Material == Enum.Material.Metal then
	                	text.Text = "Old Ring"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(255, 137, 1) and trinket.MeshId == "rbxassetid://923469333" and trinket.Material == Enum.Material.Plastic then
	                	text.Text = "Orange Candy"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.MeshId == "rbxassetid://5196776695" and trinket.Material == Enum.Material.Plastic then
	                	text.Text = "Ring"
	                    text.Color = _G.trinketNormalColor
	                end
	                
	                if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.MeshId == "rbxassetid://5204453430" and trinket.Material == Enum.Material.Fabric then
	                	text.Text = "Scroll"
	                    text.Color = _G.trinketNormalColor
	                end
	            else
	            	if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.Material == Enum.Material.Neon then
	                	text.Text = "White Kings Amulet"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(111, 113, 125) and trinket.Material == Enum.Material.Slate then
	                	text.Text = "Idol of the Forgotten"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.Material == Enum.Material.Neon then
	                	text.Text = "Lannis Amulet"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(29, 46, 58) and trinket.Material == Enum.Material.Neon then
	                	text.Text = "Nightstone"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(255, 89, 89) and trinket.Material == Enum.Material.Neon then
	                	text.Text = "Philosopher's Stone"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(255, 0, 0) and trinket.Material == Enum.Material.Glass then
	                	text.Text = "Ruby"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(248, 217, 109) and trinket.Material == Enum.Material.DiamondPlate then
	                	text.Text = "Scroom Key"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(89, 34, 89) and trinket.Material == Enum.Material.Plastic then
	                	text.Text = "???"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(163, 162, 165) and trinket.Material == Enum.Material.Plastic then
	                	text.Text = "Azael Horn"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(164, 187, 190) and trinket.Material == Enum.Material.Glass then
	                	text.Text = "Diamond"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(0, 184, 49) and trinket.Material == Enum.Material.Glass then
	                	text.Text = "Emerald"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(128, 187, 219) and trinket.Material == Enum.Material.Neon then
	                	text.Text = "Fairfrozen"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(254, 85, 100) and trinket.Material == Enum.Material.Neon then
	                	text.Text = "Ice Essence"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(163, 162, 165) and trinket.Material == Enum.Material.Plastic then
	                	text.Text = "Mysterious Artifact"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.Material == Enum.Material.Glass then
	                	text.Text = "Opal"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(163, 162, 165) and trinket.Material == Enum.Material.Plastic then
	                	text.Text = "Phoenix Down"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(255, 0, 191) and trinket.Material == Enum.Material.Glass then
	                	text.Text = "Rift Gem"
	                    text.Color = _G.trinketArtifactColor
	                end
	                if trinket.Color == Color3.fromRGB(16, 42, 220) and trinket.Material == Enum.Material.Glass then
	                	text.Text = "Sapphire"
	                    text.Color = _G.trinketNormalColor
	                end
	                if trinket.Color == Color3.fromRGB(255, 255, 0) and trinket.Material == Enum.Material.Neon then
	                	text.Text = "Spider Cloak"
	                    text.Color = _G.trinketArtifactColor
	                end
				end
            else
                text.Visible = false
            end
        else
            text.Visible = false
            update:Disconnect()
        end
    end)
end

-- You do not have to set your tabs & groups up this way, just a prefrence.
local Tabs = {
    -- Creates a new tab titled Main
    --Player = Window:AddTab('Player'), 
    Visual = Window:AddTab('Visual'), 
    --Movement = Window:AddTab('Movement'), 
    --World = Window:AddTab('World'), 
    Misc = Window:AddTab('Misc'), 
    --BotFarm = Window:AddTab('Farming'), 
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
local currentCamera = workspace.CurrentCamera
local rs = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

------------------------- VISUAL
local G_PlayerEsp = Tabs.Visual:AddLeftGroupbox("PLAYER ESP")
G_PlayerEsp:AddToggle('playeresptoggle', {
    Text = 'Enabled',
    Default = true,
})
G_PlayerEsp:AddSlider('playerespsize', {
    Text = 'Text Size',
    
    Default = 13,
    Min = 0,
    Max = 20,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})
G_PlayerEsp:AddSlider('playerespfont', {
    Text = 'Text Font',
    
    Default = 3,
    Min = 0,
    Max = 3,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})
G_PlayerEsp:AddLabel('Color'):AddColorPicker('playerespcolor', {
    Default = Color3.fromRGB(150, 50, 200), -- Bright green
    Title = 'Player Esp Color', -- Optional. Allows you to have a custom color picker title (when you open it)
})

local G_TrinketEsp = Tabs.Visual:AddLeftGroupbox("TRINKET ESP")
G_TrinketEsp:AddToggle('trinketesptoggle', {
    Text = 'Enabled',
    Default = false,
})
G_TrinketEsp:AddSlider('trinketespsize', {
    Text = 'Text Size',
    
    Default = 13,
    Min = 0,
    Max = 20,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})
G_TrinketEsp:AddSlider('trinketespfont', {
    Text = 'Text Font',
    
    Default = 3,
    Min = 0,
    Max = 3,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})
G_TrinketEsp:AddLabel('Trinket Color'):AddColorPicker('trinketespcolor', {
    Default = Color3.fromRGB(255, 255, 255), -- Bright green
    Title = 'Common Trinket Esp Color', -- Optional. Allows you to have a custom color picker title (when you open it)
})
G_TrinketEsp:AddLabel('Artifact Color'):AddColorPicker('artifactespcolor', {
    Default = Color3.fromRGB(255, 0, 0), -- Bright green
    Title = 'Rare Trinket Esp Color', -- Optional. Allows you to have a custom color picker title (when you open it)
})

local G_IngredientEsp = Tabs.Visual:AddRightGroupbox("INGREDIENT ESP")
G_IngredientEsp:AddToggle('ingredientesptoggle', {
    Text = 'Enabled',
    Default = false,
})
G_IngredientEsp:AddSlider('ingredientespsize', {
    Text = 'Text Size',
    
    Default = 13,
    Min = 0,
    Max = 20,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})
G_IngredientEsp:AddSlider('ingredientespfont', {
    Text = 'Text Font',
    
    Default = 3,
    Min = 0,
    Max = 3,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})

local G_OreEsp = Tabs.Visual:AddRightGroupbox("ORE ESP")
G_OreEsp:AddToggle('oreesptoggle', {
    Text = 'Enabled',
    Default = false,
})
G_OreEsp:AddSlider('oreespsize', {
    Text = 'Text Size',
    
    Default = 13,
    Min = 0,
    Max = 20,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})
G_OreEsp:AddSlider('oreespfont', {
    Text = 'Text Font',
    
    Default = 3,
    Min = 0,
    Max = 3,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})
------------------------- MOVEMENT
--[[
local G_Move = Tabs.Movement:AddRightGroupbox("Flight")
G_Move:AddToggle('movementtoggle', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)
})
G_Move:AddSlider('movementspeed', {
    Text = 'Speed',
    
    Default = 150,
    Min = 10,
    Max = 200,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})
G_Move:AddLabel('Keybind'):AddKeyPicker('movementkeybind', {
    -- SyncToggleState only works with toggles. 
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = 'C', -- String as the name of the keybind (MB1, MB2 for mouse buttons)  
    SyncToggleState = false, 


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Keybind', -- Text to display in the keybind menu
    NoUI = true, -- Set to true if you want to hide from the Keybind menu,
})
]]


------------------------- MISC
local G_Misc = Tabs.Misc:AddRightGroupbox("Misc")
G_Misc:AddLabel('Trinket Auto Pickup')
G_Misc:AddToggle('autotrinketpicktoggle', {
    Text = 'Enabled',
    Default = false,
})

_G.loaded = true

xpcall(function() -- security
------------------------------------- STUFF
Toggles.trinketesptoggle:OnChanged(function()
    if _G.trinketEsp == true then
    	_G.trinketEsp = false
    else
    	_G.trinketEsp = true
    end
end)
Toggles.oreesptoggle:OnChanged(function()
    if _G.oreEsp == true then
    	_G.oreEsp = false
    else
    	_G.oreEsp = true
    end
end)
Toggles.ingredientesptoggle:OnChanged(function()
    if _G.ingredientEsp == true then
    	_G.ingredientEsp = false
    else
    	_G.ingredientEsp = true
    end
end)
Toggles.autotrinketpicktoggle:OnChanged(function()
    if _G.trinketAutoPickup == true then
    	_G.trinketAutoPickup = false
    else
    	_G.trinketAutoPickup = true
    end
end)

-------------------------------------- WHILE LOOP HANDLERS
game:GetService("Workspace").ChildAdded:Connect(function(item)
	for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
		if v:FindFirstChild("ID") then
			if v:FindFirstChild("Part") then
				if v.Part:FindFirstChild("ClickDetector") then
					trinketesp(v)
				end
			end
		end
	end
end)

game:GetService("Workspace").Ores.ChildAdded:Connect(function(item)
    if v:IsA("Part") then
		if item.OreLife.Value > 0 then
	    	oreesp(v)
	    end
    end
end)

game:GetService("Players").LocalPlayer.PlayerGui.LeaderboardGui.MainFrame.ScrollingFrame.ChildAdded:Connect(function(v)
	wait(1)
	addSpectate(v)
end)

for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
	if v:FindFirstChild("ID") then
		if v:FindFirstChild("Part") then
			if v.Part:FindFirstChild("ClickDetector") then
				trinketesp(v)
			end
		end
	end
end

for i,v in pairs(game:GetService("Workspace").Ores:GetChildren()) do
	if v:IsA("Part") then
		if v.OreLife.Value > 0 then
	    	oreesp(v)
	    end
    end
end

task.spawn(function()
	while _G.trinketAutoPickup and wait() do
		for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
			if v:FindFirstChild("ID") then
				if v.Part:FindFirstChild("ClickDetector") then
					if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
						fireclickdetector(v.Part.ClickDetector)
						wait(.08)
					end
				end
			end
		end
	end
end)

for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.LeaderboardGui.MainFrame.ScrollingFrame:GetChildren()) do
	addSpectate(v)
end

end, print)


Library.KeybindFrame.Visible = false; -- todo: add a function for this
Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI SETTINGS
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end) 
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' }) 
Library.ToggleKeybind = Options.MenuKeybind

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Library)
ThemeManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager. 
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings() 

-- Adds our MenuKeybind to the ignore list 
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({}) 

-- use case for doing it this way: 
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('kold/' .. tostring(game.PlaceId))
SaveManager:SetFolder('kold/' .. tostring(game.PlaceId))

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings']) 

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config 
-- which has been marked to be one that auto loads!

end, print)
