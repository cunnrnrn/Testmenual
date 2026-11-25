-- √12kientomato - Pure Code Badass 3D Dragon (Part 1/2)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("KienTomato_BadassDragon") then
	playerGui.KienTomato_BadassDragon:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KienTomato_BadassDragon"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- Khung nền tối bo góc hiện đại
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0.82, 0, 0.86, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(4, 7, 11)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 26)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(65, 92, 122)
MainStroke.Thickness = 1.6
MainStroke.Transparency = 0.2
MainStroke.Parent = MainFrame

-- Chỉ số FPS & Ping góc trên bên phải
local StatsLabel = Instance.new("TextLabel")
StatsLabel.Name = "StatsLabel"
StatsLabel.AnchorPoint = Vector2.new(1, 0)
StatsLabel.Position = UDim2.new(0.965, 0, 0.025, 0)
StatsLabel.Size = UDim2.new(0.36, 0, 0.05, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Font = Enum.Font.GothamMedium
StatsLabel.TextColor3 = Color3.fromRGB(235, 244, 255)
StatsLabel.TextSize = 13
StatsLabel.TextXAlignment = Enum.TextXAlignment.Right
StatsLabel.Text = "• 60 FPS • 50ms"
StatsLabel.ZIndex = 70
StatsLabel.Parent = MainFrame

-- ==========================================
-- VIEWPORT 3D DỰNG RỒNG BÁ KHÍ BẰNG CODE THUẦN
-- ==========================================
local DragonVP = Instance.new("ViewportFrame")
DragonVP.Name = "DragonVP"
DragonVP.AnchorPoint = Vector2.new(0.5, 0.5)
DragonVP.Position = UDim2.new(0.5, 0, 0.52, 0)
DragonVP.Size = UDim2.new(0.46, 0, 0.86, 0)
DragonVP.BackgroundColor3 = Color3.fromRGB(8, 12, 18)
DragonVP.BackgroundTransparency = 0.2
DragonVP.ImageTransparency = 0
DragonVP.Ambient = Color3.fromRGB(145, 175, 200)
DragonVP.LightColor = Color3.fromRGB(215, 242, 255)
DragonVP.LightDirection = Vector3.new(-0.7, -1, -0.75)
DragonVP.ZIndex = 20
DragonVP.Parent = MainFrame
Instance.new("UICorner", DragonVP).CornerRadius = UDim.new(0, 18)

local vpStroke = Instance.new("UIStroke")
vpStroke.Color = Color3.fromRGB(62, 92, 125)
vpStroke.Thickness = 1.3
vpStroke.Parent = DragonVP

local cam = Instance.new("Camera")
cam.FieldOfView = 39
cam.Parent = DragonVP
DragonVP.CurrentCamera = cam

local dragonRig = Instance.new("Model")
dragonRig.Name = "BadassDragonRig"
dragonRig.Parent = DragonVP

local bodyGroup = {}
local eyesGroup = {}
local auraGroup = {}

local function create3D(opts)
	local p = Instance.new("Part")
	p.Name = opts.name or "DragonNode"
	p.Size = opts.size or Vector3.new(1, 1, 1)
	p.CFrame = opts.cf or CFrame.new()
	p.Color = opts.color or Color3.fromRGB(42, 58, 72)
	p.Material = opts.mat or Enum.Material.SmoothPlastic
	p.Transparency = opts.alpha ~= nil and opts.alpha or 0
	p.Anchored = true
	p.CanCollide = false
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.Parent = dragonRig

	if opts.mesh then
		local m = Instance.new("SpecialMesh")
		m.MeshType = opts.mesh
		if opts.scale then
			m.Scale = opts.scale
		end
		m.Parent = p
	end

	if opts.tag == "eye" then
		table.insert(eyesGroup, p)
	elseif opts.tag == "aura" then
		table.insert(auraGroup, p)
	else
		table.insert(bodyGroup, p)
	end

	return p
end

local rootNode = create3D({
	name = "RootNode",
	size = Vector3.new(0.4, 0.4, 0.4),
	cf = CFrame.new(0, 0, 0),
	alpha = 1,
})
dragonRig.PrimaryPart = rootNode

-- Đầu rồng bá khí nhìn thẳng: hộp sọ, vầng trán uy nghiêm, sống mũi & mõm dữ tợn
local headBase = CFrame.new(0, 0.85, -1.25)

create3D({
	name = "SkullCore",
	size = Vector3.new(1.52, 1.18, 1.56),
	cf = headBase,
	color = Color3.fromRGB(34, 48, 60),
	mat = Enum.Material.Slate,
	mesh = Enum.MeshType.Sphere,
	scale = Vector3.new(1.08, 0.96, 1.12),
})

create3D({
	name = "CrownCrest",
	size = Vector3.new(0.95, 0.45, 1.1),
	cf = headBase * CFrame.new(0, 0.52, -0.15) * CFrame.Angles(math.rad(18), 0, 0),
	color = Color3.fromRGB(58, 78, 94),
	mat = Enum.Material.Slate,
	mesh = Enum.MeshType.Sphere,
})

create3D({
	name = "HeavyBrow",
	size = Vector3.new(1.38, 0.36, 1.22),
	cf = headBase * CFrame.new(0, 0.24, -0.55) * CFrame.Angles(math.rad(12), 0, 0),
	color = Color3.fromRGB(52, 72, 88),
	mat = Enum.Material.Slate,
	mesh = Enum.MeshType.Sphere,
})

create3D({
	name = "SnoutBridge",
	size = Vector3.new(0.98, 0.66, 1.38),
	cf = headBase * CFrame.new(0, -0.14, -0.96) * CFrame.Angles(math.rad(16), 0, 0),
	color = Color3.fromRGB(66, 90, 108),
	mat = Enum.Material.Slate,
	mesh = Enum.MeshType.Sphere,
})

create3D({
	name = "DragonNostrilBlock",
	size = Vector3.new(0.68, 0.50, 0.60),
	cf = headBase * CFrame.new(0, -0.02, -1.58),
	color = Color3.fromRGB(98, 128, 146),
	mat = Enum.Material.SmoothPlastic,
	mesh = Enum.MeshType.Sphere,
})

-- Má giáp, nanh sắc nhọn & hàm dưới uy lực
for side = -1, 1, 2 do
	create3D({
		name = "CheekPlate",
		size = Vector3.new(0.46, 0.78, 1.12),
		cf = headBase * CFrame.new(side * 0.68, -0.18, -0.22) * CFrame.Angles(0, side * math.rad(-16), side * math.rad(14)),
		color = Color3.fromRGB(46, 65, 80),
		mat = Enum.Material.Slate,
		mesh = Enum.MeshType.Sphere,
	})

	create3D({
		name = "UpperFang",
		size = Vector3.new(0.13, 0.42, 0.13),
		cf = headBase * CFrame.new(side * 0.31, -0.52, -1.24) * CFrame.Angles(math.rad(180), 0, 0),
		color = Color3.fromRGB(235, 242, 248),
		mat = Enum.Material.SmoothPlastic,
		mesh = Enum.MeshType.Wedge,
	})

	create3D({
		name = "LowerFang",
		size = Vector3.new(0.10, 0.32, 0.10),
		cf = headBase * CFrame.new(side * 0.22, -0.45, -1.02),
		color = Color3.fromRGB(215, 224, 232),
		mat = Enum.Material.SmoothPlastic,
		mesh = Enum.MeshType.Wedge,
	})
end

create3D({
	name = "JawBone",
	size = Vector3.new(0.84, 0.36, 1.12),
	cf = headBase * CFrame.new(0, -0.64, -0.84) * CFrame.Angles(math.rad(-8), 0, 0),
	color = Color3.fromRGB(30, 40, 50),
	mesh = Enum.MeshType.Sphere,
})

-- Đôi mắt rồng ánh xanh trắng rực sáng + tia sáng lóe ngang
for side = -1, 1, 2 do
	local eyePose = headBase * CFrame.new(side * 0.49, 0.12, -0.68) * CFrame.Angles(0, side * math.rad(-22), side * math.rad(10))
	create3D({
		name = "DragonEyeGlow",
		size = Vector3.new(0.35, 0.17, 0.24),
		cf = eyePose,
		color = Color3.fromRGB(242, 251, 255),
		mat = Enum.Material.Neon,
		mesh = Enum.MeshType.Sphere,
		tag = "eye",
	})
	create3D({
		name = "DragonEyeRay",
		size = Vector3.new(1.85, 0.06, 0.09),
		cf = eyePose * CFrame.new(side * 0.15, 0, -0.04),
		color = Color3.fromRGB(110, 205, 255),
		mat = Enum.Material.Neon,
		mesh = Enum.MeshType.Sphere,
		tag = "eye",
	})
end

-- Sừng gạc cong vút đa nhánh + bờm/râu trắng bạc tua tủa khí thế
for side = -1, 1, 2 do
	local hRoot = headBase * CFrame.new(side * 0.44, 0.58, 0.18) * CFrame.Angles(math.rad(40), side * math.rad(-14), side * math.rad(-18))
	create3D({
		name = "AntlerBeam",
		size = Vector3.new(0.26, 0.26, 2.35),
		cf = hRoot * CFrame.new(0, 0, 0.98),
		color = Color3.fromRGB(145, 168, 185),
		mat = Enum.Material.SmoothPlastic,
		mesh = Enum.MeshType.Sphere,
	})
	create3D({
		name = "AntlerTineA",
		size = Vector3.new(0.18, 0.18, 1.18),
		cf = hRoot * CFrame.new(side * 0.20, 0.30, 0.88) * CFrame.Angles(math.rad(28), 0, side * math.rad(-32)),
		color = Color3.fromRGB(168, 190, 206),
		mesh = Enum.MeshType.Sphere,
	})
	create3D({
		name = "AntlerTineB",
		size = Vector3.new(0.16, 0.16, 1.02),
		cf = hRoot * CFrame.new(side * -0.14, 0.28, 1.38) * CFrame.Angles(math.rad(36), 0, side * math.rad(22)),
		color = Color3.fromRGB(168, 190, 206),
		mesh = Enum.MeshType.Sphere,
	})
	create3D({
		name = "AntlerTineC",
		size = Vector3.new(0.14, 0.14, 0.85),
		cf = hRoot * CFrame.new(side * 0.12, 0.34, 1.78) * CFrame.Angles(math.rad(42), 0, side * math.rad(-25)),
		color = Color3.fromRGB(185, 205, 220),
		mesh = Enum.MeshType.Sphere,
	})

	-- Bờm / râu uốn lượn hai bên đầu
	for idx = 1, 7 do
		local ratio = idx / 7
		create3D({
			name = "DragonManePlume",
			size = Vector3.new(0.16, 0.16, 1.38 - ratio * 0.28),
			cf = headBase * CFrame.new(side * (0.60 + ratio * 0.25), 0.38 - ratio * 0.52, 0.14 - ratio * 0.12) * CFrame.Angles(math.rad(16 + idx * 5), side * math.rad(-24), side * math.rad(-34 - idx * 4)),
			color = Color3.fromRGB(204, 220, 234),
			mesh = Enum.MeshType.Sphere,
		})
	end
end

-- Thân rồng cuộn sóng mạnh mẽ + hàng gai/vảy sống lưng
for seg = 1, 12 do
	local u = seg / 12
	local zPos = -0.55 + seg * 0.42
	local yPos = 0.22 - math.sin(u * math.pi * 0.85) * 1.32 - seg * 0.05
	local xPos = math.sin(u * math.pi * 1.25) * 0.92
	local rad = 1.32 - u * 0.42

	create3D({
		name = "DragonTorsoSeg",
		size = Vector3.new(rad, rad * 0.94, 0.78),
		cf = CFrame.new(xPos, yPos, zPos) * CFrame.Angles(math.rad(-22), math.sin(u * 3.5) * 0.35, 0),
		color = Color3.fromRGB(36 + seg * 2, 52 + seg * 2, 65 + seg * 2),
		mat = Enum.Material.Slate,
		mesh = Enum.MeshType.Sphere,
	})

	create3D({
		name = "DragonSpineSpike",
		size = Vector3.new(0.20, 0.58, 0.28),
		cf = CFrame.new(xPos, yPos + rad * 0.52, zPos) * CFrame.Angles(math.rad(-28), 0, 0),
		color = Color3.fromRGB(140, 165, 182),
		mesh = Enum.MeshType.Sphere,
	})
end

-- Vòng khí / mây mù cuộn quanh chân rồng tăng độ bá khí
for k = 1, 6 do
	local ang = (k / 6) * math.pi * 2
	create3D({
		name = "DragonSpiritMist",
		size = Vector3.new(1.65, 0.92, 1.3),
		cf = CFrame.new(math.cos(ang) * 1.25, -1.05 + (k % 2) * 0.28, -0.45 + math.sin(ang) * 0.55),
		color = Color3.fromRGB(24, 38, 50),
		mat = Enum.Material.SmoothPlastic,
		alpha = 0.45,
		mesh = Enum.MeshType.Sphere,
		tag = "aura",
	})
end

-- Đặt camera nhìn thẳng vào mặt rồng
cam.CFrame = CFrame.lookAt(Vector3.new(0, 0.55, -6.55), Vector3.new(0, 0.10, -0.55))
-- √12kientomato - Step Forward, Function Tabs & Controls (Part 2/2)
local TabsPanel = Instance.new("Frame")
TabsPanel.Name = "TabsPanel"
TabsPanel.AnchorPoint = Vector2.new(0, 0.5)
TabsPanel.Position = UDim2.new(0.03, 0, 0.52, 0)
TabsPanel.Size = UDim2.new(0.50, 0, 0.86, 0)
TabsPanel.BackgroundTransparency = 1
TabsPanel.Visible = false
TabsPanel.ZIndex = 35
TabsPanel.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0.28, 0, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(11, 16, 23)
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel = 0
Sidebar.Parent = TabsPanel
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 14)

local sideStroke = Instance.new("UIStroke")
sideStroke.Color = Color3.fromRGB(54, 78, 104)
sideStroke.Thickness = 1
sideStroke.Parent = Sidebar

local BrandTitle = Instance.new("TextLabel")
BrandTitle.Position = UDim2.new(0.08, 0, 0.04, 0)
BrandTitle.Size = UDim2.new(0.84, 0, 0.08, 0)
BrandTitle.BackgroundTransparency = 1
BrandTitle.Font = Enum.Font.GothamBold
BrandTitle.TextColor3 = Color3.fromRGB(125, 208, 255)
BrandTitle.TextSize = 13
BrandTitle.TextXAlignment = Enum.TextXAlignment.Left
BrandTitle.Text = "√12kientomato"
BrandTitle.Parent = Sidebar

local TabButtons = Instance.new("Frame")
TabButtons.Position = UDim2.new(0.06, 0, 0.15, 0)
TabButtons.Size = UDim2.new(0.88, 0, 0.8, 0)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = Sidebar

local tabLayout = Instance.new("UIListLayout")
tabLayout.Padding = UDim.new(0, 8)
tabLayout.Parent = TabButtons

local ContentBox = Instance.new("Frame")
ContentBox.Position = UDim2.new(0.30, 0, 0, 0)
ContentBox.Size = UDim2.new(0.70, 0, 1, 0)
ContentBox.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
ContentBox.BackgroundTransparency = 0.25
ContentBox.BorderSizePixel = 0
ContentBox.Parent = TabsPanel
Instance.new("UICorner", ContentBox).CornerRadius = UDim.new(0, 14)

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = Color3.fromRGB(54, 78, 104)
boxStroke.Thickness = 1
boxStroke.Parent = ContentBox

local HeaderLabel = Instance.new("TextLabel")
HeaderLabel.Position = UDim2.new(0.04, 0, 0.04, 0)
HeaderLabel.Size = UDim2.new(0.92, 0, 0.08, 0)
HeaderLabel.BackgroundTransparency = 1
HeaderLabel.Font = Enum.Font.GothamBold
HeaderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderLabel.TextSize = 15
HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderLabel.Text = "Main"
HeaderLabel.Parent = ContentBox

local FeatureScroll = Instance.new("ScrollingFrame")
FeatureScroll.Position = UDim2.new(0.04, 0, 0.15, 0)
FeatureScroll.Size = UDim2.new(0.92, 0, 0.8, 0)
FeatureScroll.BackgroundTransparency = 1
FeatureScroll.ScrollBarThickness = 3
FeatureScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
FeatureScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
FeatureScroll.Parent = ContentBox

local featLayout = Instance.new("UIListLayout")
featLayout.Padding = UDim.new(0, 9)
featLayout.Parent = FeatureScroll

local function clearFeatures()
	for _, c in ipairs(FeatureScroll:GetChildren()) do
		if c:IsA("Frame") then
			c:Destroy()
		end
	end
end

local function addToggle(labelText, initVal, callback)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -4, 0, 38)
	row.BackgroundColor3 = Color3.fromRGB(17, 23, 32)
	row.BackgroundTransparency = 0.15
	row.BorderSizePixel = 0
	row.Parent = FeatureScroll
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

	local lbl = Instance.new("TextLabel")
	lbl.Position = UDim2.new(0.04, 0, 0, 0)
	lbl.Size = UDim2.new(0.68, 0, 1, 0)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextColor3 = Color3.fromRGB(235, 243, 252)
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Text = labelText
	lbl.Parent = row

	local active = initVal
	local btn = Instance.new("TextButton")
	btn.AnchorPoint = Vector2.new(1, 0.5)
	btn.Position = UDim2.new(0.96, 0, 0.5, 0)
	btn.Size = UDim2.new(0, 60, 0, 25)
	btn.BackgroundColor3 = active and Color3.fromRGB(80, 175, 255) or Color3.fromRGB(36, 45, 58)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	btn.Text = active and "ON" or "OFF"
	btn.Parent = row
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)

	btn.MouseButton1Click:Connect(function()
		active = not active
		btn.Text = active and "ON" or "OFF"
		btn.BackgroundColor3 = active and Color3.fromRGB(80, 175, 255) or Color3.fromRGB(36, 45, 58)
		if callback then callback(active) end
	end)
end

local function addAction(labelText, btnText, callback)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -4, 0, 38)
	row.BackgroundColor3 = Color3.fromRGB(17, 23, 32)
	row.BackgroundTransparency = 0.15
	row.BorderSizePixel = 0
	row.Parent = FeatureScroll
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

	local lbl = Instance.new("TextLabel")
	lbl.Position = UDim2.new(0.04, 0, 0, 0)
	lbl.Size = UDim2.new(0.64, 0, 1, 0)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextColor3 = Color3.fromRGB(235, 243, 252)
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Text = labelText
	lbl.Parent = row

	local btn = Instance.new("TextButton")
	btn.AnchorPoint = Vector2.new(1, 0.5)
	btn.Position = UDim2.new(0.96, 0, 0.5, 0)
	btn.Size = UDim2.new(0, 82, 0, 25)
	btn.BackgroundColor3 = Color3.fromRGB(30, 82, 148)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	btn.Text = btnText
	btn.Parent = row
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)

	btn.MouseButton1Click:Connect(function()
		if callback then callback(btn) end
	end)
end

-- Chức năng thực tế nhẹ nhàng
local speedActive = false
local instantPrompt = false
local antiKbConn = nil
local savedEyeSizes = {}

for _, p in ipairs(eyesGroup) do
	savedEyeSizes[p] = p.Size
end

local function applySpeed(val)
	speedActive = val
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = val and 28 or 16
	end
end

local function applyAntiKnockback(val)
	if antiKbConn then
		antiKbConn:Disconnect()
		antiKbConn = nil
	end
	if val then
		antiKbConn = RunService.Heartbeat:Connect(function()
			local char = player.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			if root then
				for _, v in ipairs(root:GetChildren()) do
					if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") or v:IsA("VectorForce") then
						v:Destroy()
					end
				end
			end
		end)
	end
end

ProximityPromptService.PromptShown:Connect(function(prompt)
	if instantPrompt and prompt then
		prompt.HoldDuration = 0
	end
end)

local moveTween = nil
local function moveDragonFacing(goalPos)
	if moveTween then
		moveTween:Cancel()
	end
	local curPivot = dragonRig:GetPivot()
	local targetPivot = CFrame.new(goalPos) -- Luôn nhìn thẳng về phía trước
	local holder = Instance.new("CFrameValue")
	holder.Value = curPivot
	holder:GetPropertyChangedSignal("Value"):Connect(function()
		dragonRig:PivotTo(holder.Value)
	end)
	moveTween = TweenService:Create(holder, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Value = targetPivot
	})
	moveTween:Play()
	moveTween.Completed:Once(function()
		holder:Destroy()
	end)
end

local function runDragonIntro()
	TabsPanel.Visible = false
	dragonRig:PivotTo(CFrame.new(0, -0.3, 1.5))

	for _, p in ipairs(bodyGroup) do
		p.Transparency = 1
	end
	for _, p in ipairs(auraGroup) do
		p.Transparency = 1
	end
	for _, p in ipairs(eyesGroup) do
		p.Transparency = 0
		p.Size = savedEyeSizes[p] * 0.25
	end

	TweenService:Create(DragonVP, TweenInfo.new(0.35), {
		Position = UDim2.new(0.5, 0, 0.52, 0),
		Size = UDim2.new(0.46, 0, 0.86, 0),
	}):Play()

	task.spawn(function()
		-- 1. Đôi mắt lóe sáng rực trước
		for _, p in ipairs(eyesGroup) do
			TweenService:Create(p, TweenInfo.new(0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = savedEyeSizes[p] * 1.28
			}):Play()
		end

		task.wait(0.55)

		-- Thu tia lóe lại gọn sắc
		for _, p in ipairs(eyesGroup) do
			TweenService:Create(p, TweenInfo.new(0.24), {
				Size = savedEyeSizes[p]
			}):Play()
		end

		-- 2. Rồng bước chân tiến ra nhìn thẳng vào mặt
		moveDragonFacing(Vector3.new(0, 0, -0.65))
		for _, p in ipairs(bodyGroup) do
			TweenService:Create(p, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 0
			}):Play()
		end
		for _, p in ipairs(auraGroup) do
			TweenService:Create(p, TweenInfo.new(0.55), {
				Transparency = 0.45
			}):Play()
		end

		task.wait(1.25)

		-- 3. Hiện các tab chức năng bên trái, rồng dạt sang phải và vẫn nhìn thẳng
		TabsPanel.Visible = true
		TweenService:Create(DragonVP, TweenInfo.new(0.42, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.76, 0, 0.52, 0),
			Size = UDim2.new(0.42, 0, 0.86, 0),
		}):Play()
		moveDragonFacing(Vector3.new(0, 0, 0))
	end)
end

local tabsList = {
	{
		name = "Main",
		title = "Main • Chức năng chính",
		build = function()
			addToggle("Tăng tốc chạy (Speed 28)", speedActive, applySpeed)
			addToggle("Kích hoạt nhanh Prompt", instantPrompt, function(v)
				instantPrompt = v
			end)
			addAction("Chạy lại Mắt Lóe -> Rồng Ra", "Replay", function()
				runDragonIntro()
			end)
		end
	},
	{
		name = "Movement",
		title = "Movement • Di chuyển",
		build = function()
			addToggle("Speed Boost 28", speedActive, applySpeed)
			addAction("Reset tốc độ mặc định (16)", "Reset", function()
				applySpeed(false)
			end)
		end
	},
	{
		name = "Combat",
		title = "Combat • Chiến đấu",
		build = function()
			addToggle("Chống đẩy lùi nhẹ", false, applyAntiKnockback)
			addAction("Test phản hồi nút", "Test", function(b)
				b.Text = "OK!"
				task.delay(0.8, function() b.Text = "Test" end)
			end)
		end
	},
	{
		name = "Visuals",
		title = "Visuals • Ánh mắt & Khí 3D",
		build = function()
			addToggle("Bật mắt rồng phát sáng", true, function(v)
				for _, p in ipairs(eyesGroup) do
					p.Transparency = v and 0 or 0.9
				end
			end)
			addToggle("Bật khí / mây nền", true, function(v)
				for _, p in ipairs(auraGroup) do
					p.Transparency = v and 0.45 or 1
				end
			end)
		end
	},
	{
		name = "Misc",
		title = "Misc • Tiện ích",
		build = function()
			addAction("Xem JobId Server", "Check", function(b)
				local idStr = game.JobId ~= "" and string.sub(game.JobId, 1, 8) or "Mobile"
				if setclipboard and game.JobId ~= "" then
					pcall(setclipboard, game.JobId)
				end
				b.Text = idStr
				task.delay(1.2, function() b.Text = "Check" end)
			end)
		end
	}
}

local tabBtnMap = {}
local function openTab(tabInfo)
	HeaderLabel.Text = tabInfo.title
	clearFeatures()
	tabInfo.build()
	for k, b in pairs(tabBtnMap) do
		local isSelected = (k == tabInfo.name)
		b.BackgroundColor3 = isSelected and Color3.fromRGB(80, 175, 255) or Color3.fromRGB(17, 23, 32)
		b.TextColor3 = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(175, 196, 218)
	end
end

for _, tabInfo in ipairs(tabsList) do
	local b = Instance.new("TextButton")
	b.Name = "Tab_" .. tabInfo.name
	b.Size = UDim2.new(1, 0, 0, 34)
	b.BackgroundColor3 = Color3.fromRGB(17, 23, 32)
	b.TextColor3 = Color3.fromRGB(175, 196, 218)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 12
	b.Text = tabInfo.name
	b.BorderSizePixel = 0
	b.Parent = TabButtons
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
	tabBtnMap[tabInfo.name] = b

	b.MouseButton1Click:Connect(function()
		openTab(tabInfo)
	end)
end

openTab(tabsList[1])

-- Nút bật/tắt nhanh góc dưới phải
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.AnchorPoint = Vector2.new(1, 1)
ToggleBtn.Position = UDim2.new(0.985, 0, 0.96, 0)
ToggleBtn.Size = UDim2.new(0, 102, 0, 32)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 22, 30)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12
ToggleBtn.Text = "√12kientomato"
ToggleBtn.ZIndex = 75
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

ToggleBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

MainFrame.Size = UDim2.new(0.76, 0, 0.80, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	Size = UDim2.new(0.82, 0, 0.86, 0)
}):Play()
runDragonIntro()

-- Cập nhật FPS & Ping real-time
local frames, elapsed = 0, 0
RunService.RenderStepped:Connect(function(dt)
	frames += 1
	elapsed += dt
	if elapsed >= 0.5 then
		local fps = math.round(frames / elapsed)
		local ping = 0
		pcall(function()
			ping = math.round(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
		end)
		StatsLabel.Text = string.format("• %d FPS • %dms", fps, ping)
		frames = 0
		elapsed = 0
	end
end)
