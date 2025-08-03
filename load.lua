-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local selectedPlayer = nil

--== GUI Container ==--
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainGUIs"
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

-- Universe background
local universeBackground = Instance.new("ImageLabel")
universeBackground.Name = "UniverseBackground"
universeBackground.Parent = screenGui
universeBackground.Size = UDim2.new(1, 0, 1, 0)
universeBackground.Position = UDim2.new(0, 0, 0, 0)
universeBackground.BackgroundTransparency = 1
universeBackground.Image = "rbxassetid://11372818792"
universeBackground.ZIndex = -100

-- Neon helper
local function addNeonStroke(ui, color)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Color = color or Color3.fromRGB(0, 255, 255)
	stroke.Parent = ui
end

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0, 15, 0, 15)
toggleButton.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Text = "Toggle GUI"
toggleButton.TextSize = 18
toggleButton.Draggable = true
toggleButton.Active = true
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
addNeonStroke(toggleButton)

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 350, 0, 120)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -60)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
addNeonStroke(mainFrame)

-- Shadow
local shadowFrame = Instance.new("Frame")
shadowFrame.Name = "Shadow"
shadowFrame.Parent = mainFrame
shadowFrame.Position = UDim2.new(0, 0, 0, 4)
shadowFrame.Size = UDim2.new(1, 0, 1, 0)
shadowFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 23)
shadowFrame.BackgroundTransparency = 0.3
shadowFrame.ZIndex = -1
Instance.new("UICorner", shadowFrame).CornerRadius = UDim.new(0, 12)

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = mainFrame
titleLabel.Size = UDim2.new(1, -40, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "Player Select"
titleLabel.TextSize = 22

-- Player List Button
local playerListButton = Instance.new("TextButton")
playerListButton.Name = "PlayerListButton"
playerListButton.Parent = mainFrame
playerListButton.Size = UDim2.new(0, 310, 0, 40)
playerListButton.Position = UDim2.new(0.5, -155, 0, 55)
playerListButton.BackgroundColor3 = Color3.fromRGB(60, 63, 65)
playerListButton.TextColor3 = Color3.fromRGB(220, 220, 220)
playerListButton.Font = Enum.Font.SourceSans
playerListButton.Text = "Search for players..."
playerListButton.TextSize = 18
Instance.new("UICorner", playerListButton).CornerRadius = UDim.new(0, 8)
addNeonStroke(playerListButton)

-- Scrolling Frame
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Name = "PlayerListFrame"
playerListFrame.Parent = mainFrame
playerListFrame.Size = UDim2.new(0, 310, 0, 130)
playerListFrame.Position = UDim2.new(0.5, -155, 0, 100)
playerListFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 50)
playerListFrame.BorderSizePixel = 0
playerListFrame.Visible = false
playerListFrame.ZIndex = 2
playerListFrame.ScrollBarThickness = 6
Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIListLayout", playerListFrame).SortOrder = Enum.SortOrder.Name

-- Player Template
local playerTemplate = Instance.new("TextButton")
playerTemplate.Name = "PlayerTemplate"
playerTemplate.Size = UDim2.new(1, -10, 0, 30)
playerTemplate.BackgroundColor3 = Color3.fromRGB(60, 63, 65)
playerTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
playerTemplate.Font = Enum.Font.SourceSansSemibold
playerTemplate.TextSize = 16
Instance.new("UICorner", playerTemplate).CornerRadius = UDim.new(0, 6)
addNeonStroke(playerTemplate)

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Parent = mainFrame
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Text = "X"
closeButton.TextSize = 20
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 8)

-- Side Panel
local sideFrame = Instance.new("Frame")
sideFrame.Name = "SideFrame"
sideFrame.Parent = screenGui
sideFrame.Size = UDim2.new(0, 250, 0, 295)
sideFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
sideFrame.BackgroundTransparency = 0.2
sideFrame.BorderSizePixel = 0
sideFrame.Visible = false
sideFrame.ClipsDescendants = true
Instance.new("UICorner", sideFrame).CornerRadius = UDim.new(0, 10)
addNeonStroke(sideFrame)

-- Profile Picture
local profilePicture = Instance.new("ImageLabel")
profilePicture.Name = "ProfilePicture"
profilePicture.Parent = sideFrame
profilePicture.Size = UDim2.new(0, 80, 0, 80)
profilePicture.Position = UDim2.new(0.5, 0, 0, 15)
profilePicture.AnchorPoint = Vector2.new(0.5, 0)
profilePicture.BackgroundTransparency = 1
Instance.new("UICorner", profilePicture).CornerRadius = UDim.new(1, 0)

-- Username Label
local targetUsernameLabel = Instance.new("TextLabel")
targetUsernameLabel.Name = "TargetUsernameLabel"
targetUsernameLabel.Parent = sideFrame
targetUsernameLabel.Size = UDim2.new(1, -20, 0, 30)
targetUsernameLabel.Position = UDim2.new(0.5, 0, 0, 105)
targetUsernameLabel.AnchorPoint = Vector2.new(0.5, 0)
targetUsernameLabel.BackgroundColor3 = Color3.fromRGB(44, 62, 80)
targetUsernameLabel.TextColor3 = Color3.fromRGB(236, 240, 241)
targetUsernameLabel.Font = Enum.Font.SourceSans
targetUsernameLabel.TextSize = 16
Instance.new("UICorner", targetUsernameLabel).CornerRadius = UDim.new(0, 6)

-- Button Container
local buttonContainer = Instance.new("Frame")
buttonContainer.Parent = sideFrame
buttonContainer.Size = UDim2.new(1, -20, 0, 135)
buttonContainer.Position = UDim2.new(0.5, 0, 1, -15)
buttonContainer.AnchorPoint = Vector2.new(0.5, 1)
buttonContainer.BackgroundTransparency = 1
Instance.new("UIListLayout", buttonContainer).Padding = UDim.new(0, 10)

-- Action Buttons
local function makeSideButton(text, color)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 35)
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.Text = text
	btn.TextSize = 16
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	addNeonStroke(btn)
	btn.Parent = buttonContainer
	return btn
end

local sideAutoAcceptButton = makeSideButton("AUTO ACCEPT TRADE", Color3.fromRGB(22, 160, 133))
local sideFreezeButton = makeSideButton("FREEZE PLAYER SCREEN", Color3.fromRGB(26, 188, 156))
local sideAddPetsButton = makeSideButton("FORCE ADD PETS", Color3.fromRGB(44, 62, 80))

-- Credit Label
local creditLabel = Instance.new("TextLabel")
creditLabel.Name = "CreditLabel"
creditLabel.Parent = screenGui
creditLabel.Size = UDim2.new(0, 200, 0, 25)
creditLabel.Position = UDim2.new(1, -210, 1, -30)
creditLabel.AnchorPoint = Vector2.new(0, 1)
creditLabel.BackgroundTransparency = 1
creditLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
creditLabel.Font = Enum.Font.Gotham
creditLabel.TextSize = 14
creditLabel.Text = "Made By ProjectB"
creditLabel.TextXAlignment = Enum.TextXAlignment.Right

--=== FUNCTIONALITY ===--

-- Player List Logic
local function updatePlayerList()
	for _, child in ipairs(playerListFrame:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	for _, player in ipairs(Players:GetPlayers()) do
		local newEntry = playerTemplate:Clone()
		newEntry.Text = player.Name
		newEntry.Parent = playerListFrame
		newEntry.MouseButton1Click:Connect(function()
			setSidePanelVisible(true, player)
			playerListFrame.Visible = false
			playerListButton.Text = player.Name
		end)
	end
end

-- Side panel slide animation
local isSidePanelVisible = false
local slideTween = nil

function setSidePanelVisible(visible, playerObject)
	if slideTween and slideTween.PlaybackState == Enum.PlaybackState.Playing then slideTween:Cancel() end
	isSidePanelVisible = visible

	local startPos, endPos
	local mainFramePos, mainFrameSize = mainFrame.Position, mainFrame.AbsoluteSize
	local hiddenPos = UDim2.new(mainFramePos.X.Scale, mainFramePos.X.Offset + mainFrameSize.X, mainFramePos.Y.Scale, mainFramePos.Y.Offset)
	local visiblePos = UDim2.new(mainFramePos.X.Scale, mainFramePos.X.Offset + mainFrameSize.X + 10, mainFramePos.Y.Scale, mainFramePos.Y.Offset)

	if visible and playerObject then
		selectedPlayer = playerObject
		sideFrame.Visible = true
		targetUsernameLabel.Text = playerObject.Name
		local success, img = pcall(function()
			return Players:GetUserThumbnailAsync(playerObject.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		end)
		profilePicture.Image = success and img or ""
		startPos, endPos = hiddenPos, visiblePos
	else
		selectedPlayer = nil
		startPos, endPos = sideFrame.Position, hiddenPos
		playerListButton.Text = "Search for players..."
	end

	sideFrame.Position = startPos
	slideTween = TweenService:Create(sideFrame, TweenInfo.new(0.4, Enum.EasingStyle.Cubic), {Position = endPos})
	slideTween:Play()
	if not visible then
		slideTween.Completed:Once(function() sideFrame.Visible = false end)
	end
end

-- Draggable
local function makeDraggable(guiObject)
	local dragging = false
	local dragInput, dragStart, startPos, sideStartPos
	guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and guiObject.Draggable then
			dragging = true
			dragStart = input.Position
			startPos = guiObject.Position
			sideStartPos = sideFrame.Position

			local conn
			conn = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false conn:Disconnect() end
			end)
		end
	end)
	guiObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			if isSidePanelVisible and guiObject == mainFrame then
				sideFrame.Position = UDim2.new(sideStartPos.X.Scale, sideStartPos.X.Offset + delta.X, sideStartPos.Y.Scale, sideStartPos.Y.Offset + delta.Y)
			end
		end
	end)
end

makeDraggable(mainFrame)
makeDraggable(toggleButton)

-- Button connections
toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
	playerListFrame.Visible = false
	if not mainFrame.Visible and isSidePanelVisible then setSidePanelVisible(false) end
end)

playerListButton.MouseButton1Click:Connect(function()
	if playerListFrame.Visible then
		playerListFrame.Visible = false
	else
		updatePlayerList()
		playerListFrame.Visible = true
	end
end)

closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	playerListFrame.Visible = false
	if isSidePanelVisible then setSidePanelVisible(false) end
end)

sideAutoAcceptButton.MouseButton1Click:Connect(function()
	if selectedPlayer then print("Auto Accept: " .. selectedPlayer.Name) end
end)
sideFreezeButton.MouseButton1Click:Connect(function()
	if selectedPlayer then print("Freeze Screen: " .. selectedPlayer.Name) end
end)
sideAddPetsButton.MouseButton1Click:Connect(function()
	if selectedPlayer then print("Force Add Pets: " .. selectedPlayer.Name) end
end)

