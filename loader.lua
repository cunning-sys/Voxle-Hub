repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local Main_Https = "https://raw.githubusercontent.com/cunning-sys/voxle-hub/main/"

local games = {
    [12521539843] = "Lee-RPG.lua"
}

for i, v in pairs(games) do
    if i == game.PlaceId or i == game.GameId then
        loadstring(game:HttpGet(Main_Https .. v))()
    end
end
