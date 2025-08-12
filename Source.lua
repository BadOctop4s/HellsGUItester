local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RoyalHubGUI"
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.2)
frame.Parent = screenGui

local label = Instance.new("TextLabel")
label.Text = "ROYAL HUB CARREGADO!"
label.Size = UDim2.new(1, 0, 1, 0)
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.GothamBold
label.TextSize = 24
label.BackgroundTransparency = 1
label.Parent = frame

print("Royal Hub inicializado!")
