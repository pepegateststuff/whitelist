local repo =																																																																																							 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Rogue Spells',
    Center = true, 
    AutoShow = true,
})

_G.loaded = false

-- You do not have to set your tabs & groups up this way, just a prefrence.
local Tabs = {
    -- Creates a new tab titled Main
    Main = Window:AddTab('Main'), 
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
local currentCamera = workspace.CurrentCamera
local rs = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

_G.trinketEsp = false

local fallionEsp = true
local houseEsp = true
local merchantEsp = true
local snapEsp = true
local scrollEsp = true
local sigilEsp = true

local webhookUrl = ""

function getdistance(part)
    if game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        return (hrp.Position - part.Position).Magnitude
    end
end

local function trinketesp(trinket)
    local text = Drawing.new("Text")
    text.Center = true
    text.Size = 13
    text.Font = 2
    text.Outline = true
    text.OutlineColor = Color3.new(0,0,0)
    text.Color = Color3.new(1,1,1)

    local update
    update = game:GetService("RunService").RenderStepped:Connect(function()
        if trinket and trinket:FindFirstChild("Handle") and _G.trinketEsp then
            local vector, onscreen = currentCamera:WorldToViewportPoint(trinket.Handle.Position)
            if onscreen then
                text.Visible = true
                text.Text = trinket.Handle.Parent.Name
                text.Position = Vector2.new(vector.X, vector.Y)

                text.Color = Color3.fromRGB(255, 0, 0)

                if trinket.Name == "Scroll" then
                    text.Text = "Scroll"
                    text.Color = Color3.fromRGB(255, 250, 0)
                end

                if trinket.Name == "Amulet" then
                    text.Visible = false
                    text.Text = "Amulet"
                    text.Color = Color3.fromRGB(0.3, 0.3, 0.3)
                end

                if trinket.Name == "Emerald" then
                    text.Visible = true
                    text.Text = "Emerald"
                    text.Color = Color3.fromRGB(0, 255, 0)
                end

                if trinket.Name == "Ice Essence" then
                    text.Text = "Ice Essence"
                    text.Color = Color3.fromRGB(0, 255, 255)
                end

                if trinket.Name == "Old Fragment" then
                    text.Visible = false
                    text.Text = "Old Fragment"
                    text.Color = Color3.fromRGB(0.3, 0.3, 0.3)
                end

                if trinket.Name == "Ring" then
                    text.Visible = false
                    text.Text = "Ring"
                    text.Color = Color3.fromRGB(0.3, 0.3, 0.3)
                end

                if trinket.Name == "Sapphire" then
                    text.Visible = true
                    text.Text = "Sapphire"
                    text.Color = Color3.fromRGB(0, 0, 255)
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

local function post(itemName)
    pcall(function()
        request({
            Url = webhookUrl,
            Body = game:GetService("HttpService"):JSONEncode({
                ["content"] = '@everyone Found item in server [' .. tostring(itemName) .. ']' .. ' (' .. tostring(game.Players.LocalPlayer.Name) .. ')'
            }),
            Method = "POST",
            Headers = {
                ["content-type"] = "application/json"
            }
        })
    end)
end

local function testwebhook()
    pcall(function()
        request({
            Url = webhookUrl,
            Body = game:GetService("HttpService"):JSONEncode({
                ["content"] = '@everyone test'
            }),
            Method = "POST",
            Headers = {
                ["content-type"] = "application/json"
            }
        })
    end)
end

local function postMaxItems(count)
    pcall(function()
        request({
            Url = webhookUrl,
            Body = game:GetService("HttpService"):JSONEncode({
                ["content"] = '@everyone Server is full of shit [JobId: ' .. tostring(game.JobId) .. ', Item Count:' .. tostring(count)
            }),
            Method = "POST",
            Headers = {
                ["content-type"] = "application/json"
            }
        })
    end)
end

local function checkMaxItems()
    local loot = 0
    for i,v in pairs(game:GetService("Workspace").Items:GetChildren()) do
        loot = loot + 1
    end
    if loot >= 191 then
        if Toggles.discordwebhooktoggle then
            postMaxItems(loot)
        end
    end
end

local function trinketesp(trinket)
    local text = Drawing.new("Text")
    text.Center = true
    text.Size = 13
    text.Font = 2
    text.Outline = true
    text.OutlineColor = Color3.new(0,0,0)
    text.Color = Color3.new(1,1,1)

    local update
    update = game:GetService("RunService").RenderStepped:Connect(function()
        if trinket and trinket:FindFirstChild("Handle") and _G.trinketEsp then
            local vector, onscreen = currentCamera:WorldToViewportPoint(trinket.Handle.Position)
            if onscreen then
                text.Visible = true
                text.Text = trinket.Handle.Parent.Name
                text.Position = Vector2.new(vector.X, vector.Y)

                text.Color = Color3.fromRGB(255, 0, 0)

                if trinket.Name == "Scroll" then
                    text.Text = "Scroll"
                    text.Color = Color3.fromRGB(255, 250, 0)
                end

                if trinket.Name == "Amulet" then
                    text.Visible = false
                    text.Text = "Amulet"
                    text.Color = Color3.fromRGB(0.3, 0.3, 0.3)
                end

                if trinket.Name == "Emerald" then
                    text.Visible = true
                    text.Text = "Emerald"
                    text.Color = Color3.fromRGB(0, 255, 0)
                end

                if trinket.Name == "Ice Essence" then
                    text.Text = "Ice Essence"
                    text.Color = Color3.fromRGB(0, 255, 255)
                end

                if trinket.Name == "Old Fragment" then
                    text.Visible = false
                    text.Text = "Old Fragment"
                    text.Color = Color3.fromRGB(0.3, 0.3, 0.3)
                end

                if trinket.Name == "Ring" then
                    text.Visible = false
                    text.Text = "Ring"
                    text.Color = Color3.fromRGB(0.3, 0.3, 0.3)
                end

                if trinket.Name == "Sapphire" then
                    text.Visible = true
                    text.Text = "Sapphire"
                    text.Color = Color3.fromRGB(0, 0, 255)
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

------------------------- ESP
local G_Esp = Tabs.Main:AddLeftGroupbox("ESP")
G_Esp:AddLabel('Trinket ESP')
G_Esp:AddToggle('trinketesptoggle', {
    Text = 'Enabled',
    Default = false,
})
G_Esp:AddLabel('Artifact Color'):AddColorPicker('tesp_artifactcolor', {
    Default = Color3.fromRGB(255, 0, 0),
    Title = 'Artifact Color',
})
G_Esp:AddLabel('Gems color'):AddColorPicker('tesp_gemcolor', {
    Default = Color3.fromRGB(100, 100, 0),
    Title = 'Artifact Color',
})
G_Esp:AddLabel('Common trinket color'):AddColorPicker('tesp_commoncolor', {
    Default = Color3.fromRGB(100, 100, 100),
    Title = 'Artifact Color',
})
G_Esp:AddDivider()

G_Esp:AddLabel('NPC ESP')
G_Esp:AddToggle('npcesptoggle', {
    Text = 'Enabled',
    Default = false,
})
G_Esp:AddDivider()

------------------------- MOVEMENT
local G_Move = Tabs.Main:AddLeftGroupbox("Flight")
G_Move:AddToggle('movementtoggle', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)
})
G_Move:AddSlider('movementspeed', {
    Text = 'Speed',

    -- Text, Default, Min, Max, Rounding must be specified.
    -- Rounding is the number of decimal places for precision.

    -- Example:
    -- Rounding 0 - 5
    -- Rounding 1 - 5.1
    -- Rounding 2 - 5.15
    -- Rounding 3 - 5.155

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

------------------------- MISC
local G_Misc = Tabs.Main:AddRightGroupbox("Misc")

G_Misc:AddToggle('trinketpicktoggle', {
    Text = 'Auto Trinket Pickup',
    Default = false, -- Default value (true / false)
})
G_Misc:AddToggle('infmanatoggle', {
	Text = 'Infinite Mana (CS)',
	Default = false,
    ToolTip = "Spells dont work"
})
G_Misc:AddToggle('discordwebhooktoggle', {
	Text = 'Artifact Notifier',
	Default = false,
	ToolTip = "Notifies you in discord when the server is full of trinkets and if in the server there is an artifact"
})
G_Misc:AddInput('discordwebhookinput', {
    Default = '',
    Numeric = false, -- true / false, only allows numbers
    Finished = true, -- true / false, only calls callback when you press enter

    Text = 'Webhook:',
    Tooltip = 'Notifies you in discord when the server is full of trinkets and if in the server there is an artifact. Enable Artifact Notifer', -- Information shown when you hover over the textbox

    Placeholder = 'Url', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text
})
G_Misc:AddButton('Test Webhook', function()
    testwebhook()
end)
G_Misc:AddButton('Reset', function()
    game.Players.LocalPlayer.Character:BreakJoints();
end)
G_Misc:AddButton('Remove Fall Damage', function()
    if game.Players.LocalPlayer.Character:FindFirstChild("Fall Damage") then
        game.Players.LocalPlayer.Character:FindFirstChild("Fall Damage"):Destroy()
    end
end)
G_Misc:AddButton('Remove Killbricks', function()
    for i,v in pairs(game:GetService("Workspace").Void:GetDescendants()) do
        if v.Name == "TouchInterest" then
            v:Destroy()
        end
    end
end)

_G.loaded = true

------------------------------------- STUFF
Toggles.infmanatoggle:OnChanged(function()
    if Toggles.infmanatoggle.Value then
        game.Players.LocalPlayer.Mana.Value = 100
    else
        game.Players.LocalPlayer.Mana.Value = 0
    end
end)
Toggles.trinketesptoggle:OnChanged(function()
    if Toggles.trinketesptoggle.Value then
        _G.trinket = false
    else
        _G.trinket = true
    end
end)
Options.discordwebhookinput:OnChanged(function()
    webhookUrl = Options.discordwebhookinput.Value
end)
Options.movementkeybind:OnClick(function()
    if Toggles.movementtoggle.Value then
        Toggles.movementtoggle:SetValue(false)
    else
        Toggles.movementtoggle:SetValue(true)
    end
end)
-------------------------------------- WHILE LOOP HANDLERS
local connections = {}
task.spawn(function()
	while _G.loaded and wait() do
		if Toggles.movementtoggle.Value then
            local move = game.Players.LocalPlayer.Character.Humanoid.MoveDirection
            local bodyvelo
            if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("movement") then
                bodyvelo = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("movement")
                bodyvelo.Velocity = move * Options.movementspeed.Value
            else
                bodyvelo = Instance.new("BodyVelocity")
                bodyvelo.Name = "movement"
                bodyvelo.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                bodyvelo.Velocity = move * Options.movementspeed.Value
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                bodyvelo.Velocity = Vector3.new(bodyvelo.Velocity.X,-Options.movementspeed.Value,bodyvelo.Velocity.Z)
            elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                bodyvelo.Velocity = Vector3.new(bodyvelo.Velocity.X,Options.movementspeed.Value,bodyvelo.Velocity.Z)
            else
                bodyvelo.Velocity = Vector3.new(bodyvelo.Velocity.X,0,bodyvelo.Velocity.Z)
            end
        else
            pcall(function()
                if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("movement") then
                    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("movement"):Destroy()
                end
            end)
		end
	end
end)
task.spawn(function()
	while _G.loaded and wait() do
		if Toggles.trinketpicktoggle.Value then
            for i,v in pairs(game.Workspace.Items:GetDescendants()) do
                if v.Name == "Click" then
                    if getdistance(v.Parent) <= 15 then
                        fireclickdetector(v)
                    end
                end
            end
		end
	end
end)
task.spawn(function()
    table.insert(connections,
	    game:GetService("Workspace").Items.ChildAdded:Connect(function(v)
	        checkMaxItems()
	        if v.Name == "Old Fragment"
	        or v.Name == "Emerald"
	        or v.Name == "Sapphire"
	        or v.Name == "" -- Scroll
	        or v.Name == "Amulet"
	        or v.Name == "Ring" then
	            return
	        else
	            post(v.Name)
	        end
	    end)
	)

    table.insert(connections,
        game.Workspace.Items.ChildAdded:Connect(function(item)
            trinketesp(item)
        end)
	)
end)

for i,v in pairs(game.Workspace.Items:GetDescendants()) do
    if v.Name == "Handle" then
        trinketesp(v.Parent)
    end
end

Library.KeybindFrame.Visible = false; -- todo: add a function for this
Library:OnUnload(function()
    print('Unloaded!')
    _G.loaded = false
    for i,v in pairs(connections) do
        v:Disconnect()
    end
    Library.Unloaded = true
end)

-- UI SETTINGS
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end) 
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' }) 
Library.ToggleKeybind = Options.MenuKeybind
