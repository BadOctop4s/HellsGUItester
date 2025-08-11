-- Script atualizado: GUI 85%, Teleport ao lado do dropdown, AutoClick mantido (VirtualUser)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Cores
local blackBG = Color3.fromHex("000000")
local purple = Color3.fromHex("6a0dad")
local darkButton = Color3.fromHex("1a1a1a")
local hoverPurple = Color3.fromHex("7f3fff")
local textColor = Color3.fromHex("eeeeee")

-- Blur para loading
local blur = Instance.new("BlurEffect")
blur.Size = 24
blur.Parent = game.Lighting

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EodraxkkGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Loading (central, arredondado)
local loadingFrame = Instance.new("Frame", ScreenGui)
loadingFrame.Size = UDim2.new(0, 380, 0, 130)
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingFrame.BackgroundColor3 = blackBG
loadingFrame.BackgroundTransparency = 0
loadingFrame.ClipsDescendants = true
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 14)

local loadingLabel = Instance.new("TextLabel", loadingFrame)
loadingLabel.AnchorPoint = Vector2.new(0.5, 0.5)
loadingLabel.Position = UDim2.new(0.5, 0, 0.35, 0)
loadingLabel.Size = UDim2.new(0, 260, 0, 36)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Carregando..."
loadingLabel.Font = Enum.Font.GothamBold
loadingLabel.TextSize = 24
loadingLabel.TextColor3 = textColor

local loadingBarBack = Instance.new("Frame", loadingFrame)
loadingBarBack.AnchorPoint = Vector2.new(0.5, 0.5)
loadingBarBack.Position = UDim2.new(0.5, 0, 0.76, 0)
loadingBarBack.Size = UDim2.new(0, 320, 0, 12)
loadingBarBack.BackgroundColor3 = Color3.fromRGB(40,40,40)
loadingBarBack.ClipsDescendants = true
Instance.new("UICorner", loadingBarBack).CornerRadius = UDim.new(0,8)

local loadingBar = Instance.new("Frame", loadingBarBack)
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = purple
Instance.new("UICorner", loadingBar).CornerRadius = UDim.new(0,8)

local progress = 0
local loadingComplete = false
local increment = 0.02
local function updateLoading()
    if progress < 1 then
        progress = math.min(progress + increment, 1)
        loadingBar:TweenSize(UDim2.new(progress,0,1,0), "Out", "Quad", 0.12, true)
    else
        loadingComplete = true
    end
end

-- MAIN GUI (70% para ficar menor)
local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0.7,0,0.7,0) -- reduzido para 70%
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
mainFrame.Position = UDim2.new(0.5,0,0.5,0)
mainFrame.BackgroundColor3 = blackBG
mainFrame.BackgroundTransparency = 0
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Color = purple
uiStroke.Thickness = 2

-- UIScale responsivo (mais amigável em telas pequenas)
local uiScale = Instance.new("UIScale", mainFrame)
local function updateScale()
    local w = workspace.CurrentCamera.ViewportSize.X
    if isMobile then
        uiScale.Scale = math.clamp(w / 900, 0.95, 1.6) -- mantém UI legível em mobile
    else
        uiScale.Scale = math.clamp(w / 1200, 0.95, 1.6)
    end
end
updateScale()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

-- TabBar
local tabBar = Instance.new("Frame", mainFrame)
tabBar.Size = UDim2.new(1,0,0,46)
tabBar.Position = UDim2.new(0,0,0,0)
tabBar.BackgroundTransparency = 1
local UIList = Instance.new("UIListLayout", tabBar)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 12)

local function CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.BackgroundColor3 = darkButton
    btn.Text = name
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.TextColor3 = textColor
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = hoverPurple}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = darkButton}):Play() end)
    return btn
end

local mainTabBtn = CreateTab("Main"); mainTabBtn.Parent = tabBar
local trollTabBtn = CreateTab("Troll"); trollTabBtn.Parent = tabBar
local teleportTabBtn = CreateTab("Teleport"); teleportTabBtn.Parent = tabBar

-- Conteúdo
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1,0,1,-46)
contentFrame.Position = UDim2.new(0,0,0,46)
contentFrame.BackgroundTransparency = 1
contentFrame.ClipsDescendants = true

local function CreateContent()
    local f = Instance.new("Frame", contentFrame)
    f.Size = UDim2.new(1,0,1,0)
    f.BackgroundTransparency = 1
    f.Visible = false
    return f
end

-- === Main tab content ===
local mainContent = CreateContent()
local thumb = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
local playerImage = Instance.new("ImageLabel", mainContent)
playerImage.Size = UDim2.new(0,150,0,150)
playerImage.Position = UDim2.new(0,28,0,36)
playerImage.BackgroundTransparency = 1
playerImage.Image = thumb
Instance.new("UICorner", playerImage).CornerRadius = UDim.new(1,0)
local playerImgBorder = Instance.new("Frame", playerImage)
playerImgBorder.Size = UDim2.new(1,6,1,6); playerImgBorder.Position = UDim2.new(0,-3,0,-3)
playerImgBorder.BackgroundTransparency = 1
playerImgBorder.BorderColor3 = purple; playerImgBorder.BorderSizePixel = 2
playerImgBorder.ZIndex = 2

local welcomeText = Instance.new("TextLabel", mainContent)
welcomeText.Size = UDim2.new(1,-220,0,64)
welcomeText.Position = UDim2.new(0,196,0,82)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = "Bem-vindo, "..LocalPlayer.Name
welcomeText.Font = Enum.Font.GothamBold
welcomeText.TextColor3 = textColor
welcomeText.TextSize = 32
welcomeText.TextXAlignment = Enum.TextXAlignment.Left

local creatorText = Instance.new("TextLabel", mainContent)
creatorText.Size = UDim2.new(1,-20,0,22)
creatorText.Position = UDim2.new(0,10,1,-44)
creatorText.BackgroundTransparency = 1
creatorText.Text = "Criado por Eodraxkk"
creatorText.Font = Enum.Font.Gotham
creatorText.TextColor3 = textColor
creatorText.TextSize = 14
creatorText.TextXAlignment = Enum.TextXAlignment.Right

-- === Troll tab content ===
local trollContent = CreateContent()
local function notify(text)
    StarterGui:SetCore("SendNotification", {Title = "Script"; Text = text; Duration = 2.5})
end

-- AutoClick (VirtualUser attempt + notify)
local autoClickEnabled = false
local autoClickConn = nil
local clickInterval = 0.25
local elapsed = 0

local autoClickBtn = Instance.new("TextButton", trollContent)
autoClickBtn.Size = UDim2.new(0, 230, 0, 56)
autoClickBtn.Position = UDim2.new(0.5, -115, 0.28, -28)
autoClickBtn.BackgroundColor3 = darkButton
autoClickBtn.Text = "Auto Click: OFF"
autoClickBtn.Font = Enum.Font.GothamSemibold
autoClickBtn.TextSize = 20
autoClickBtn.TextColor3 = textColor
autoClickBtn.AutoButtonColor = false
Instance.new("UICorner", autoClickBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", autoClickBtn).Color = purple

local function setAutoClick(on)
    autoClickEnabled = on
    if autoClickEnabled then
        notify("Auto Click ativado")
        pcall(function() VirtualUser:CaptureController() end)
        if autoClickConn then autoClickConn:Disconnect() end
        elapsed = 0
        autoClickConn = RunService.Heartbeat:Connect(function(dt)
            elapsed = elapsed + dt
            if elapsed >= clickInterval then
                elapsed = 0
                -- tenta VirtualUser (pode não funcionar em todos dispositivos)
                pcall(function()
                    if VirtualUser.Button1Down then VirtualUser:Button1Down() end
                    if VirtualUser.Button1Up then VirtualUser:Button1Up() end
                    if VirtualUser.ClickButton1 then
                        VirtualUser:ClickButton1(Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2))
                    end
                end)
            end
        end)
    else
        notify("Auto Click desativado")
        if autoClickConn then autoClickConn:Disconnect(); autoClickConn = nil end
    end
    TweenService:Create(autoClickBtn, TweenInfo.new(0.22), {BackgroundColor3 = (autoClickEnabled and hoverPurple or darkButton)}):Play()
    autoClickBtn.Text = (autoClickEnabled and "Auto Click: ON" or "Auto Click: OFF")
end

autoClickBtn.MouseButton1Click:Connect(function() setAutoClick(not autoClickEnabled) end)

-- Noclip
local noclipEnabled = false
local noclipBtn = Instance.new("TextButton", trollContent)
noclipBtn.Size = UDim2.new(0, 230, 0, 56)
noclipBtn.Position = UDim2.new(0.5, -115, 0.64, -28)
noclipBtn.BackgroundColor3 = darkButton
noclipBtn.Text = "Noclip: OFF"
noclipBtn.Font = Enum.Font.GothamSemibold
noclipBtn.TextSize = 20
noclipBtn.TextColor3 = textColor
noclipBtn.AutoButtonColor = false
Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", noclipBtn).Color = purple

local function setNoclip(enabled)
    noclipEnabled = enabled
    local character = LocalPlayer.Character
    if character then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = not enabled end
        end
    end
    TweenService:Create(noclipBtn, TweenInfo.new(0.22), {BackgroundColor3 = (noclipEnabled and hoverPurple or darkButton)}):Play()
    noclipBtn.Text = (noclipEnabled and "Noclip: ON" or "Noclip: OFF")
    notify(noclipEnabled and "Noclip ativado" or "Noclip desativado")
end

noclipBtn.MouseButton1Click:Connect(function() setNoclip(not noclipEnabled) end)

-- === Teleport tab content (dropdown + botão ao lado) ===
local teleportContent = CreateContent()

local dropdownBtn = Instance.new("TextButton", teleportContent)
dropdownBtn.Size = UDim2.new(0, 300, 0, 56)
dropdownBtn.Position = UDim2.new(0, 28, 0, 28)
dropdownBtn.BackgroundColor3 = darkButton
dropdownBtn.TextColor3 = textColor
dropdownBtn.Text = "Selecionar Player ▼"
dropdownBtn.Font = Enum.Font.GothamSemibold
dropdownBtn.TextSize = 18
dropdownBtn.AutoButtonColor = false
Instance.new("UICorner", dropdownBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", dropdownBtn).Color = purple

local dropdownList = Instance.new("ScrollingFrame", teleportContent)
dropdownList.Size = UDim2.new(0, 300, 0, 0)
dropdownList.Position = UDim2.new(0, 28, 0, 94)
dropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
dropdownList.ScrollBarThickness = 8
dropdownList.BackgroundColor3 = darkButton
dropdownList.Visible = false
dropdownList.ClipsDescendants = true
Instance.new("UICorner", dropdownList).CornerRadius = UDim.new(0, 10)

local layout = Instance.new("UIListLayout", dropdownList)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 8)

local selectedPlayer = nil

local function refreshPlayerList()
    for _, child in ipairs(dropdownList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local players = Players:GetPlayers()
    local count = 0
    for _, plr in ipairs(players) do
        if plr ~= LocalPlayer then
            count = count + 1
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -16, 0, 42)
            btn.Position = UDim2.new(0, 8, 0, (count-1)*48)
            btn.BackgroundColor3 = darkButton
            btn.TextColor3 = textColor
            btn.Text = plr.Name
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 18
            btn.AutoButtonColor = false
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
            btn.Parent = dropdownList
            btn.MouseButton1Click:Connect(function()
                selectedPlayer = plr
                dropdownBtn.Text = plr.Name.." ▼"
                TweenService:Create(dropdownList, TweenInfo.new(0.18), {Size = UDim2.new(0, 300, 0, 0)}):Play()
                wait(0.18)
                dropdownList.Visible = false
                teleportBtn.BackgroundColor3 = hoverPurple
            end)
            btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = hoverPurple}):Play() end)
            btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = darkButton}):Play() end)
        end
    end
    local totalHeight = math.min(count * 48, 320)
    dropdownList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

dropdownBtn.MouseButton1Click:Connect(function()
    if dropdownList.Visible then
        TweenService:Create(dropdownList, TweenInfo.new(0.18), {Size = UDim2.new(0, 300, 0, 0)}):Play()
        wait(0.18)
        dropdownList.Visible = false
    else
        refreshPlayerList()
        dropdownList.Visible = true
        TweenService:Create(dropdownList, TweenInfo.new(0.18), {Size = UDim2.new(0, 300, 0, math.min(#Players:GetPlayers()*48,320))}):Play()
    end
end)

-- Teleport button to the RIGHT of dropdown
local teleportBtn = Instance.new("TextButton", teleportContent)
teleportBtn.Size = UDim2.new(0, 180, 0, 56)
teleportBtn.Position = UDim2.new(0, 28 + 300 + 18, 0, 28) -- ao lado direito do dropdown
teleportBtn.BackgroundColor3 = darkButton
teleportBtn.TextColor3 = textColor
teleportBtn.Text = "Teleportar"
teleportBtn.Font = Enum.Font.GothamSemibold
teleportBtn.TextSize = 18
teleportBtn.AutoButtonColor = false
Instance.new("UICorner", teleportBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", teleportBtn).Color = purple

teleportBtn.MouseButton1Click:Connect(function()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = selectedPlayer.Character.HumanoidRootPart
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0,3,0)
            notify("Teleportado para "..selectedPlayer.Name)
        end
    else
        notify("Selecione um player válido!")
    end
end)

-- Atualizar lista quando players mudarem (apenas se a aba estiver aberta)
Players.PlayerAdded:Connect(function() if teleportContent.Visible then refreshPlayerList() end end)
Players.PlayerRemoving:Connect(function() if teleportContent.Visible then refreshPlayerList() end end)

-- Abas (garante o botão de teleport sempre visível ao lado)
local function setTab(btn)
    mainTabBtn.BackgroundColor3 = darkButton; trollTabBtn.BackgroundColor3 = darkButton; teleportTabBtn.BackgroundColor3 = darkButton
    mainTabBtn.TextColor3 = textColor; trollTabBtn.TextColor3 = textColor; teleportTabBtn.TextColor3 = textColor
    mainContent.Visible = false; trollContent.Visible = false; teleportContent.Visible = false

    btn.BackgroundColor3 = hoverPurple; btn.TextColor3 = Color3.new(1,1,1)

    if btn == mainTabBtn then mainContent.Visible = true
    elseif btn == trollTabBtn then trollContent.Visible = true
    elseif btn == teleportTabBtn then teleportContent.Visible = true end
end

mainTabBtn.MouseButton1Click:Connect(function() setTab(mainTabBtn) end)
trollTabBtn.MouseButton1Click:Connect(function() setTab(trollTabBtn) end)
teleportTabBtn.MouseButton1Click:Connect(function() setTab(teleportTabBtn) end)
setTab(mainTabBtn)

-- Toggle / fechar
if isMobile then
    local toggleBtn = Instance.new("ImageButton", ScreenGui)
    toggleBtn.Size = UDim2.new(0, 50, 0, 50)
    toggleBtn.Position = UDim2.new(0, 12, 0.84, 0)
    toggleBtn.BackgroundColor3 = purple
    toggleBtn.AutoButtonColor = false
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
    toggleBtn.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
else
    UserInputService.InputBegan:Connect(function(input, gp) if not gp and input.KeyCode == Enum.KeyCode.RightControl then mainFrame.Visible = not mainFrame.Visible end end)
end

local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -46, 0, 8)
closeBtn.BackgroundColor3 = darkButton; closeBtn.Text = "X"; closeBtn.TextColor3 = textColor
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy(); pcall(function() blur:Destroy() end) end)

-- Dragging (mantido)
do
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or (isMobile and input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true; dragStart = input.Position; startPos = mainFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    mainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if dragInput and input == dragInput and dragging and dragStart and startPos then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(math.clamp(startPos.X.Scale + delta.X / workspace.CurrentCamera.ViewportSize.X, 0, 1), 0,
                                           math.clamp(startPos.Y.Scale + delta.Y / workspace.CurrentCamera.ViewportSize.Y, 0, 1), 0)
        end
    end)
end

-- Loading loop e mostrar GUI
coroutine.wrap(function()
    while not loadingComplete do updateLoading(); wait(0.05) end
    pcall(function()
        TweenService:Create(loadingFrame, TweenInfo.new(0.45), {BackgroundTransparency = 1}):Play()
        TweenService:Create(loadingLabel, TweenInfo.new(0.45), {TextTransparency = 1}):Play()
        TweenService:Create(loadingBarBack, TweenInfo.new(0.45), {BackgroundTransparency = 1}):Play()
        TweenService:Create(loadingBar, TweenInfo.new(0.45), {BackgroundTransparency = 1}):Play()
    end)
    wait(0.45)
    pcall(function() loadingFrame:Destroy(); blur:Destroy() end)
    mainFrame.BackgroundTransparency = 1; mainFrame.Visible = true
    TweenService:Create(mainFrame, TweenInfo.new(0.45), {BackgroundTransparency = 0}):Play()
end)()
