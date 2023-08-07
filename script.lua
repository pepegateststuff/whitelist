local gameLoader = string.format('https://raw.githubusercontent.com/pepegateststuff/whitelist/main/Games/%s.lua',game.PlaceId)
local gameLink = "https://pepegateststuff.000webhostapp.com/check_game.php?id=" .. tostring(game.PlaceId)

local request = syn and syn.request or request
local response = request({Url = gameLink; Method = "GET"})

if response["Body"] then
	xpcall(loadstring(game:HttpGet(gameLoader)), print)
end
