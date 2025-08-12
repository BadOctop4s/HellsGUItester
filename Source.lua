-- Source.lua

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Verificar se já existe GUI e remover
if game.CoreGui:FindFirstChild("MainGUI") then
    game.CoreGui:FindFirstChild("MainGUI"):Destroy()
end

-- Criar GUI principal
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "MainGUI"
mainGui.Parent = game.CoreGui

-- [SEU CÓDIGO PRINCIPAL AQUI]
-- Adicione toda a funcionalidade da sua GUI aqui

print("GUI principal carregada com sucesso!")
