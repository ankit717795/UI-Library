local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerListGUI"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 350)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 20)
topBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -25, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Text = "X"
closeButton.Parent = topBar

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Draggable UI
local dragging, dragInput, dragStart, startPos

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- The rest of your original script follows unchanged...
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerListGUI"
screenGui.Parent = playerGui


local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 350)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui


local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 20)
topBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame


local dragging = false
local dragStart, startPos

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)


local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "PlayerScrollFrame"
scrollFrame.Size = UDim2.new(1, -10, 1, -30)
scrollFrame.Position = UDim2.new(0, 5, 0, 25)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.Parent = mainFrame


local stopSpectateBtn = Instance.new("TextButton")
stopSpectateBtn.Name = "StopSpectateBtn"
stopSpectateBtn.Size = UDim2.new(0, 150, 0, 30)
stopSpectateBtn.Position = UDim2.new(0.5, -75, 0, 10)
stopSpectateBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
stopSpectateBtn.TextColor3 = Color3.new(1, 1, 1)
stopSpectateBtn.Text = "Stop Spectating"
stopSpectateBtn.Visible = false
stopSpectateBtn.Parent = screenGui

stopSpectateBtn.MouseButton1Click:Connect(function()
	local cam = workspace.CurrentCamera
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		-- Kamera zurück auf den eigenen Charakter setzen
		cam.CameraSubject = player.Character.Humanoid
		cam.CameraType = Enum.CameraType.Custom
	end
	stopSpectateBtn.Visible = false
end)


local function updatePlayerList()

	scrollFrame:ClearAllChildren()
	local yPos = 0
	for _, plr in ipairs(game.Players:GetPlayers()) do
		if plr ~= player then

			local row = Instance.new("Frame")
			row.Name = plr.Name .. "_Row"
			row.Size = UDim2.new(1, 0, 0, 30)
			row.Position = UDim2.new(0, 0, 0, yPos)
			row.BackgroundTransparency = 1
			row.Parent = scrollFrame
			

			local spectateBtn = Instance.new("TextButton")
			spectateBtn.Name = "SpectateBtn"
			spectateBtn.Size = UDim2.new(0, 30, 1, 0)
			spectateBtn.Position = UDim2.new(0, 0, 0, 0)
			spectateBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
			spectateBtn.Text = "S"
			spectateBtn.TextColor3 = Color3.new(1, 1, 1)
			spectateBtn.Parent = row
			
			spectateBtn.MouseButton1Click:Connect(function()
				if plr.Character and plr.Character:FindFirstChild("Humanoid") then
					local cam = workspace.CurrentCamera
					cam.CameraSubject = plr.Character.Humanoid
					cam.CameraType = Enum.CameraType.Attach

					stopSpectateBtn.Visible = true
				end
			end)
			

			local nameLabel = Instance.new("TextLabel")
			nameLabel.Name = "NameLabel"
			nameLabel.Size = UDim2.new(1, -60, 1, 0) 
			nameLabel.Position = UDim2.new(0, 30, 0, 0)
			nameLabel.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
			nameLabel.TextColor3 = Color3.new(1, 1, 1)
			nameLabel.Text = plr.Name
			nameLabel.Parent = row
			

			local teleportBtn = Instance.new("TextButton")
			teleportBtn.Name = "TeleportBtn"
			teleportBtn.Size = UDim2.new(0, 30, 1, 0)
			teleportBtn.Position = UDim2.new(1, -30, 0, 0)
			teleportBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			teleportBtn.TextColor3 = Color3.new(0, 0, 0)
			teleportBtn.Text = "T"
			teleportBtn.Parent = row
			
			teleportBtn.MouseButton1Click:Connect(function()
				if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and
				   player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local targetPos = plr.Character.HumanoidRootPart.Position

					player.Character:MoveTo(targetPos + Vector3.new(0, 5, 0))
				end
			end)
			
			yPos = yPos + 35
		end
	end
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
end


updatePlayerList()


game.Players.PlayerAdded:Connect(function(plr)
	updatePlayerList()
	plr.CharacterAdded:Connect(function()
		updatePlayerList()
	end)
end)

game.Players.PlayerRemoving:Connect(function()
	updatePlayerList()
end)

-- Regelmäßige
while wait(5) do
	updatePlayerList()
end
