--[[
    KIÊN | LỚP 94 — THCS NHUẬN PHÚ TÂN
    BLACK NEBULA — Part 1: Core Setup & Window
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("KEY_Lop94") then playerGui.KEY_Lop94:Destroy() end
if playerGui:FindFirstChild("KienFlyGUIV3") then playerGui.KienFlyGUIV3:Destroy() end

local C = {
    Background = Color3.fromRGB(10, 10, 14),
    Panel = Color3.fromRGB(17, 17, 23),
    Card = Color3.fromRGB(24, 24, 32),
    Red = Color3.fromRGB(255, 48, 75),
    RedDark = Color3.fromRGB(120, 20, 40),
    White = Color3.fromRGB(245, 245, 250),
    Muted = Color3.fromRGB(145, 145, 160),
    Green = Color3.fromRGB(70, 230, 155),
}

local function create(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function round(parent, radius)
    create("UICorner", { CornerRadius = UDim.new(0, radius or 10) }, parent)
end

local function stroke(parent, color, thickness)
    return create("UIStroke", { Color = color or C.Red, Thickness = thickness or 1, Transparency = 0 }, parent)
end

local function tween(obj, duration, props)
    local t = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local gui = create("ScreenGui", {
    Name = "KEY_Lop94", ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

local openButton = create("TextButton", {
    Name = "OpenButton", Size = UDim2.fromOffset(58, 58), Position = UDim2.new(0, 18, 0.5, -29),
    BackgroundColor3 = C.Background, Text = "K", TextColor3 = C.Red, TextSize = 27, Font = Enum.Font.GothamBlack,
    Active = true, Draggable = true, AutoButtonColor = false,
}, gui)
round(openButton, 18)
stroke(openButton, C.Red, 2)

local main = create("Frame", {
    Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(650, 420), BackgroundColor3 = C.Background, BorderSizePixel = 0, Visible = false, ClipsDescendants = true,
}, gui)
round(main, 16)
stroke(main, C.Red, 1.5)

local scale = create("UIScale", { Scale = 1 }, main)
local function updateScale()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    scale.Scale = math.min(viewport.X / 690, viewport.Y / 460, 1)
end
updateScale()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end
--[[
    KIÊN | LỚP 94 — THCS NHUẬN PHÚ TÂN
    BLACK NEBULA — Part 2: TopBar, Sidebar & Fly GUI V3
]]

local top = create("Frame", { Size = UDim2.new(1, 0, 0, 64), BackgroundColor3 = C.Panel, BorderSizePixel = 0 }, main)
create("Frame", { Position = UDim2.new(0, 0, 1, -2), Size = UDim2.new(1, 0, 0, 2), BackgroundColor3 = C.Red, BorderSizePixel = 0 }, top)

local logo = create("Frame", { Position = UDim2.new(0, 17, 0.5, -19), Size = UDim2.fromOffset(38, 38), BackgroundColor3 = C.RedDark }, top)
round(logo, 12)
stroke(logo, C.Red, 1)

create("TextLabel", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "K", TextColor3 = C.White, Font = Enum.Font.GothamBlack, TextSize = 23 }, logo)
create("TextLabel", { Position = UDim2.new(0, 65, 0, 10), Size = UDim2.new(0, 320, 0, 25), BackgroundTransparency = 1, Text = "KIÊN | LỚP 94 — THCS NPT", TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBlack, TextSize = 17 }, top)
create("TextLabel", { Position = UDim2.new(0, 66, 0, 35), Size = UDim2.new(0, 260, 0, 17), BackgroundTransparency = 1, Text = "BLACK NEBULA  •  FLY V3 & ANTI-CHEAT EDITION", TextColor3 = C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamMedium, TextSize = 9 }, top)

local close = create("TextButton", { Position = UDim2.new(1, -45, 0, 15), Size = UDim2.fromOffset(30, 30), BackgroundColor3 = C.Card, Text = "×", TextColor3 = C.Red, TextSize = 23, Font = Enum.Font.GothamBold, AutoButtonColor = false }, top)
round(close, 9)

local sidebar = create("Frame", { Position = UDim2.new(0, 0, 0, 66), Size = UDim2.new(0, 155, 1, -66), BackgroundColor3 = C.Panel, BorderSizePixel = 0 }, main)
create("UIListLayout", { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, sidebar)
create("UIPadding", { PaddingTop = UDim.new(0, 17), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }, sidebar)

local content = create("Frame", { Position = UDim2.new(0, 155, 0, 66), Size = UDim2.new(1, -155, 1, -66), BackgroundTransparency = 1 }, main)
local pageTitle = create("TextLabel", { Position = UDim2.new(0, 20, 0, 15), Size = UDim2.new(1, -40, 0, 30), BackgroundTransparency = 1, Text = "HOME / OVERVIEW", TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 17 }, content)
local pageHint = create("TextLabel", { Position = UDim2.new(0, 20, 0, 44), Size = UDim2.new(1, -40, 0, 20), BackgroundTransparency = 1, Text = "Your space. Your style.", TextColor3 = C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 11 }, content)

local pageBody = create("ScrollingFrame", {
    Position = UDim2.new(0, 15, 0, 75), Size = UDim2.new(1, -30, 1, -88), BackgroundTransparency = 1, BorderSizePixel = 0,
    ScrollBarThickness = 3, ScrollBarImageColor3 = C.Red, CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)
local bodyLayout = create("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }, pageBody)

local toast = create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -12), Size = UDim2.fromOffset(270, 38),
    BackgroundColor3 = C.Card, TextColor3 = C.White, Text = "", TextSize = 12, Font = Enum.Font.GothamMedium, Visible = false, ZIndex = 10,
}, main)
round(toast, 10)
stroke(toast, C.Red, 1)

local function notify(message)
    toast.Text = message
    toast.Visible = true
    task.delay(1.5, function() toast.Visible = false end)
end

--// FLY GUI V3 (EXTERNAL FLOATING MENU)
local flyGui = create("ScreenGui", { Name = "KienFlyGUIV3", ResetOnSpawn = false, IgnoreGuiInset = true, Enabled = false }, playerGui)
local flyFrame = create("Frame", { Name = "FlyControl", Size = UDim2.fromOffset(190, 125), Position = UDim2.new(0.75, 0, 0.25, 0), BackgroundColor3 = C.Background, Active = true, Draggable = true }, flyGui)
round(flyFrame, 12)
stroke(flyFrame, C.Red, 1.5)

create("TextLabel", { Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = C.Panel, Text = "FLY GUI V3", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 12 }, flyFrame)
local flyStatus = create("TextLabel", { Position = UDim2.new(0, 10, 0, 35), Size = UDim2.new(1, -20, 0, 20), BackgroundTransparency = 1, Text = "Trạng thái: Tắt", TextColor3 = C.Muted, Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left }, flyFrame)
local flySpeedLbl = create("TextLabel", { Position = UDim2.new(0, 10, 0, 55), Size = UDim2.new(1, -20, 0, 20), BackgroundTransparency = 1, Text = "Tốc độ: 50 / 165", TextColor3 = C.White, Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left }, flyFrame)

local flyToggleBtn = create("TextButton", { Position = UDim2.new(0, 10, 0, 82), Size = UDim2.new(1, -20, 0, 32), BackgroundColor3 = C.RedDark, Text = "BẬT / TẮT BAY", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 11, AutoButtonColor = false }, flyFrame)
round(flyToggleBtn, 8)
--[[
    KIÊN | LỚP 94 — THCS NHUẬN PHÚ TÂN
    BLACK NEBULA — Part 3: Active Functions & Logic
]]

local function getHumanoid()
    local char = player.Character
    if char then return char:FindFirstChildOfClass("Humanoid") end
    return nil
end

local savedBases = { [1] = nil, [2] = nil }
local flyActive = false
local flySpeed = 50
local flyConn = nil
local noclipConn = nil

local function toggleFly(state)
    flyActive = state
    flyGui.Enabled = state
    flyStatus.Text = state and "Trạng thái: Bật (Max 165)" or "Trạng thái: Tắt"
    flyToggleBtn.BackgroundColor3 = state and C.Green or C.RedDark
    
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if state and root then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "KienFlyV3Vel"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = root
        
        flyConn = RunService.RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            local vel = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += cam.CoordinateFrame.LookVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= cam.CoordinateFrame.LookVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += cam.CoordinateFrame.RightVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= cam.CoordinateFrame.RightVector * flySpeed end
            bv.Velocity = vel
        end)
    else
        if flyConn then flyConn:Disconnect() end
        if root and root:FindFirstChild("KienFlyV3Vel") then root.KienFlyV3Vel:Destroy() end
    end
end

flyToggleBtn.MouseButton1Click:Connect(function() toggleFly(not flyActive) end)

local pages = {
    HOME = {
        title = "HOME / OVERVIEW",
        hint = "Welcome to KIÊN | LỚP 94",
        items = {
            {kind = "banner", title = "BLACK NEBULA V3", desc = "Đã tích hợp Fly GUI V3, 2 Base và Fix Lag giữ sáng."},
            {kind = "info", title = "AN TOÀN", desc = "Có chế độ giả lập chạy bộ chống Anti-Cheat."},
        },
    },
    PLAYER = {
        title = "PLAYER / NHÂN VẬT",
        hint = "Tùy chỉnh tốc độ và nhảy cao",
        items = {
            {kind = "toggle", title = "Tăng Tốc Độ Chạy (Speed 35)", desc = "Di chuyển nhanh hơn.", default = false, callback = function(enabled) local h = getHumanoid() if h then h.WalkSpeed = enabled and 35 or 16 end end},
            {kind = "toggle", title = "Nhảy Siêu Cao (Super Jump)", desc = "Tăng lực nhảy lên 100.", default = false, callback = function(enabled) local h = getHumanoid() if h then h.JumpPower = enabled and 100 or 50 end end},
        },
    },
    MOVEMENT = {
        title = "MOVEMENT / FLY V3 & NOCLIP",
        hint = "Bật menu Fly nổi và điều chỉnh tốc độ bay",
        items = {
            {kind = "toggle", title = "Bật Menu Fly GUI V3 Nổi", desc = "Hiển thị bảng điều khiển bay độc lập ngoài màn hình.", default = false, callback = function(enabled) toggleFly(enabled) end},
            {kind = "button", title = "Tăng Tốc Bay (+25 [Max 165])", desc = "Tăng tốc độ Fly V3 (Hiện tại: 50)", callback = function() flySpeed = math.min(flySpeed + 25, 165) flySpeedLbl.Text = "Tốc độ: " .. flySpeed .. " / 165" notify("Đã tăng tốc bay lên: " .. flySpeed) end},
            {kind = "button", title = "Giảm Tốc Bay (-25 [Min 25])", desc = "Giảm tốc độ Fly V3.", callback = function() flySpeed = math.max(flySpeed - 25, 25) flySpeedLbl.Text = "Tốc độ: " .. flySpeed .. " / 165" notify("Đã giảm tốc bay xuống: " .. flySpeed) end},
            {kind = "toggle", title = "Đi Xuyên Tường (Noclip)", desc = "Xuyên qua mọi vật cản trong game.", default = false, callback = function(enabled) if enabled then noclipConn = RunService.Stepped:Connect(function() local c = player.Character if c then for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end) else if noclipConn then noclipConn:Disconnect() end end end},
        },
    },
    BASE = {
        title = "BASES / LƯU & DI CHUYỂN 2 VỊ TRÍ",
        hint = "Hỗ trợ 2 Base và chế độ giả lập chạy chống ban",
        items = {
            {kind = "button", title = "Lưu Vị Trí Căn Cứ 1", desc = "Ghi nhớ tọa độ hiện tại vào Base 1.", callback = function() local c = player.Character if c and c:FindFirstChild("HumanoidRootPart") then savedBases[1] = c.HumanoidRootPart.CFrame notify("Đã lưu Căn cứ 1 thành công!") end end},
            {kind = "button", title = "Lưu Vị Trí Căn Cứ 2", desc = "Ghi nhớ tọa độ hiện tại vào Base 2.", callback = function() local c = player.Character if c and c:FindFirstChild("HumanoidRootPart") then savedBases[2] = c.HumanoidRootPart.CFrame notify("Đã lưu Căn cứ 2 thành công!") end end},
            {kind = "button", title = "Bay Về Căn Cứ 1 (Teleport)", desc = "Dịch chuyển tức thì đến Base 1.", callback = function() local c = player.Character if c and c:FindFirstChild("HumanoidRootPart") and savedBases[1] then c.HumanoidRootPart.CFrame = savedBases[1] notify("Đã bay về Căn cứ 1!") else notify("Chưa lưu Căn cứ 1!") end end},
            {kind = "button", title = "Bay Về Căn Cứ 2 (Teleport)", desc = "Dịch chuyển tức thì đến Base 2.", callback = function() local c = player.Character if c and c:FindFirstChild("HumanoidRootPart") and savedBases[2] then c.HumanoidRootPart.CFrame = savedBases[2] notify("Đã bay về Căn cứ 2!") else notify("Chưa lưu Căn cứ 2!") end end},
            {kind = "button", title = "Chạy Giả Lập Về Căn Cứ 1 (Chống Ban)", desc = "Tự động kéo nút di chuyển chạy bộ về Base 1 theo tốc độ gốc.", callback = function() local c = player.Character local h = getHumanoid() if c and c:FindFirstChild("HumanoidRootPart") and savedBases[1] and h then notify("Đang chạy giả lập về Base 1 (Chống quét)...") h:MoveTo(savedBases[1].Position) else notify("Chưa lưu Căn cứ 1 hoặc mất nhân vật!") end end},
        },
    },
    MISC = {
        title = "OPTIMIZE / FIX LAG SẠCH SẼ",
        hint = "Xóa hiệu ứng nặng gây lag nhưng giữ nguyên độ sáng",
        items = {
            {kind = "button", title = "Fix Lag Sạch Sẽ (Giữ Nguyên Sáng)", desc = "Dọn sạch particle, trail, khói lửa gây lag, không làm tối màn hình.", callback = function() local count = 0 for _, o in ipairs(workspace:GetDescendants()) do if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Fire") or o:IsA("Smoke") or o:IsA("Explosion") then o:Destroy() count += 1 end end Lighting.GlobalShadows = false Lighting.Brightness = 2 notify("Đã fix lag sạch sẽ (" .. count .. " hiệu ứng), giữ nguyên độ sáng!") end},
        },
    },
}

local states = {}
local currentPage = "HOME"
local renderPage

local function clearBody()
    for _, child in ipairs(pageBody:GetChildren()) do
        if child:IsA("GuiObject") and child ~= bodyLayout then child:Destroy() end
    end
end

local function makeCard(titleText, descText, height)
    local card = create("Frame", { Size = UDim2.new(1, -4, 0, height or 68), BackgroundColor3 = C.Card, BorderSizePixel = 0 }, pageBody)
    round(card, 12)
    stroke(card, C.RedDark, 1)

    create("TextLabel", { Position = UDim2.new(0, 14, 0, 11), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = titleText, TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 12 }, card)
    create("TextLabel", { Position = UDim2.new(0, 14, 0, 34), Size = UDim2.new(1, -28, 0, 22), BackgroundTransparency = 1, Text = descText, TextColor3 = C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 10, TextWrapped = true }, card)
    return card
end

local function addToggle(item)
    local card = makeCard(item.title, item.desc, 72)
    local key = currentPage .. "_" .. item.title
    if states[key] == nil then states[key] = item.default or false end

    local switch = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -13, 0.5, 0), Size = UDim2.fromOffset(42, 23), BackgroundColor3 = states[key] and C.Red or Color3.fromRGB(55, 55, 66), Text = "", AutoButtonColor = false }, card)
    round(switch, 12)

    local knob = create("Frame", { Position = states[key] and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8), Size = UDim2.fromOffset(16, 16), BackgroundColor3 = C.White, BorderSizePixel = 0 }, switch)
    round(knob, 8)

    switch.MouseButton1Click:Connect(function()
        states[key] = not states[key]
        local enabled = states[key]
        switch.BackgroundColor3 = enabled and C.Red or Color3.fromRGB(55, 55, 66)
        knob.Position = enabled and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8)
        notify(item.title .. (enabled and " : ON" or " : OFF"))
        if item.callback then pcall(function() item.callback(enabled) end) end
    end)
end

renderPage = function(name)
    currentPage = name
    local data = pages[name]
    if not data then return end

    pageTitle.Text = data.title
    pageHint.Text = data.hint
    clearBody()

    for _, item in ipairs(data.items) do
        if item.kind == "toggle" then
            addToggle(item)
        elseif item.kind == "banner" then
            local card = makeCard(item.title, item.desc, 90)
            create("Frame", { Position = UDim2.new(0, 14, 1, -5), Size = UDim2.new(0.45, 0, 0, 2), BackgroundColor3 = C.Red, BorderSizePixel = 0 }, card)
        elseif item.kind == "button" then
            local card = makeCard(item.title, item.desc, 76)
            local action = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(80, 28), BackgroundColor3 = C.RedDark, Text = "EXECUTE", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9, AutoButtonColor = false }, card)
            round(action, 8)
            action.MouseButton1Click:Connect(function() if item.callback then pcall(function() item.callback() end) end end)
        else
            makeCard(item.title, item.desc, 68)
        end
    end
end

local navItems = {"HOME", "PLAYER", "MOVEMENT", "BASE", "MISC"}
local navNames = {HOME = "HOME", PLAYER = "PLAYER", MOVEMENT = "MOVEMENT", BASE = "BASES", MISC = "OPTIMIZE"}
local navButtons = {}

for index, name in ipairs(navItems) do
    local button = create("TextButton", { Name = name, LayoutOrder = index, Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = name == "HOME" and C.RedDark or C.Panel, Text = "   " .. navNames[name], TextColor3 = name == "HOME" and C.White or C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 11, AutoButtonColor = false }, sidebar)
    round(button, 9)
    navButtons[name] = button

    button.MouseButton1Click:Connect(function()
        for _, other in pairs(navButtons) do
            other.BackgroundColor3 = C.Panel
            other.TextColor3 = C.Muted
        end
        button.BackgroundColor3 = C.RedDark
        button.TextColor3 = C.White
        renderPage(name)
    end)
end

openButton.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
close.MouseButton1Click:Connect(function() main.Visible = false end)

renderPage("HOME")
notify("KIÊN | LỚP 94 — SẴN SÀNG!")
