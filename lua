-- staff-alert by zai

local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "Shit com - Zai",
    Text = "Mod Notifier LoadedZZZAAAAAAIIII",
    Icon = "rbxassetid://15059364356",
    Duration = 5
})

local Players = game:GetService("Players")

local GROUP_ID = 33986332
local DEFAULT_ICON = "rbxassetid://15059364356"

local function getHeadshot(userId)
    local success, content = pcall(function()
        return Players:GetUserThumbnailAsync(
            userId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size420x420
        )
    end)

    return success and content or DEFAULT_ICON
end

local function sendNoti(player, action)
    local headShot = getHeadshot(player.UserId)
    local actionText = action == "join" and "has joined the server" or "has left the server"

    StarterGui:SetCore("SendNotification", {
        Title = player.DisplayName,
        Text = string.format("%s %s", player.Name, actionText),
        Icon = headShot,
        Duration = 10
    })
end

local function checkPlayer(plr, action)
    if plr:IsInGroup(GROUP_ID) then
        sendNoti(plr, action)
    end
end

-- Notify for current players
for _, plr in ipairs(Players:GetPlayers()) do
    checkPlayer(plr, "join")
end

-- Listen for player join
Players.PlayerAdded:Connect(function(plr)
    checkPlayer(plr, "join")
end)

-- Listen for player leave
Players.PlayerRemoving:Connect(function(plr)
    checkPlayer(plr, "leave")
end)
