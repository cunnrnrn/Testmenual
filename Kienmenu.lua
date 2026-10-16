--[[
    KIÊN | LỚP 94 — THCS NHUẬN PHÚ TÂN
    BLACK NEBULA — Part 1: Core, Window, Fly V3 & Popout
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
if playerGui:FindFirstChild("KienPopoutGui") then playerGui.KienPopoutGui:Destroy() end

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

local gui = create("ScreenGui", { Name = "KEY_Lop94", ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, playerGui)

local openButton = create("TextButton", {
    Name = "OpenButton", Size = UDim2.fromOffset(58, 58), Position = UDim2.new(0, 18, 0.5, -29),
    BackgroundColor3 = C.Background, Text = "K", TextColor3 = C.Red, TextSize = 27, Font = Enum.Font.GothamBlack,
    Active = true, Draggable = true, AutoButtonColor = false,
}, gui)
round(openButton, 18)
stroke(openButton, C.Red, 2)

local main = create("Frame", {
    Name = "Main", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(650, 420), BackgroundColor3 = C.Background, BorderSizePixel = 0, Visible = true, ClipsDescendants = true,
}, gui)
round(main, 16)
stroke(main, C.Red, 1.5)

--// TOP BAR & SIDEBAR
local top = create("Frame", { Size = UDim2.new(1, 0, 0, 64), BackgroundColor3 = C.Panel, BorderSizePixel = 0 }, main)
create("Frame", { Position = UDim2.new(0, 0, 1, -2), Size = UDim2.new(1, 0, 0, 2), BackgroundColor3 = C.Red, BorderSizePixel = 0 }, top)

local logo = create("Frame", { Position = UDim2.new(0, 17, 0.5, -19), Size = UDim2.fromOffset(38, 38), BackgroundColor3 = C.RedDark }, top)
round(logo, 12)
stroke(logo, C.Red, 1)
create("TextLabel", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "K", TextColor3 = C.White, Font = Enum.Font.GothamBlack, TextSize = 23 }, logo)
create("TextLabel", { Position = UDim2.new(0, 65, 0, 10), Size = UDim2.new(0, 320, 0, 25), BackgroundTransparency = 1, Text = "KIÊN | LỚP 94 — THCS NPT", TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBlack, TextSize = 17 }, top)
create("TextLabel", { Position = UDim2.new(0, 66, 0, 35), Size = UDim2.new(0, 260, 0, 17), BackgroundTransparency = 1, Text = "BLACK NEBULA  •  STABLE 2-PART EDITION", TextColor3 = C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamMedium, TextSize = 9 }, top)

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

local function notify(msg)
    toast.Text = msg
    toast.Visible = true
    task.delay(1.5, function() toast.Visible = false end)
end

--// FLY GUI V3 NỔI
local flyGui = create("ScreenGui", { Name = "KienFlyGUIV3", ResetOnSpawn = false, IgnoreGuiInset = true, Enabled = false }, playerGui)
local flyFrame = create("Frame", { Name = "FlyControl", Size = UDim2.fromOffset(190, 125), Position = UDim2.new(0.75, 0, 0.25, 0), BackgroundColor3 = C.Background, Active = true, Draggable = true }, flyGui)
round(flyFrame, 12)
stroke(flyFrame, C.Red, 1.5)
create("TextLabel", { Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = C.Panel, Text = "FLY GUI V3", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 12 }, flyFrame)
local flyStatus = create("TextLabel", { Position = UDim2.new(0, 10, 0, 35), Size = UDim2.new(1, -20, 0, 20), BackgroundTransparency = 1, Text = "Trạng thái: Tắt", TextColor3 = C.Muted, Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left }, flyFrame)
local flySpeedLbl = create("TextLabel", { Position = UDim2.new(0, 10, 0, 55), Size = UDim2.new(1, -20, 0, 20), BackgroundTransparency = 1, Text = "Tốc độ: 50 / 165", TextColor3 = C.White, Font = Enum.Font.Gotham, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left }, flyFrame)
local flyToggleBtn = create("TextButton", { Position = UDim2.new(0, 10, 0, 82), Size = UDim2.new(1, -20, 0, 32), BackgroundColor3 = C.RedDark, Text = "BẬT / TẮT BAY", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 11, AutoButtonColor = false }, flyFrame)
round(flyToggleBtn, 8)

--// POPOUT GUI
local popoutGui = create("ScreenGui", { Name = "KienPopoutGui", ResetOnSpawn = false, IgnoreGuiInset = true }, playerGui)
local function createPopoutButton(name, title, onToggle)
    local btn = create("TextButton", {
        Name = name .. "Popout", Size = UDim2.fromOffset(110, 38), Position = UDim2.new(0.2, math.random(0, 200), 0.1, math.random(0, 150)),
        BackgroundColor3 = C.Background, Text = title, TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 10,
        Active = true, Draggable = true, AutoButtonColor = false, Visible = false,
    }, popoutGui)
    round(btn, 8)
    stroke(btn, C.Red, 1.5)
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and C.Green or C.Background
        if onToggle then onToggle(state) end
    end)
    return btn
end

local speedPopout = createPopoutButton("Speed", "Tốc độ 35", function(s) local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed = s and 35 or 16 end end)
local jumpPopout = createPopoutButton("Jump", "Nhảy Cao", function(s) local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid") if h then h.JumpPower = s and 100 or 50 end end)
local lootPopout = createPopoutButton("AutoLoot", "Auto Loot", function(s)
    _G.FastLoot = s
    task.spawn(function()
        while _G.FastLoot do
            task.wait(0.2)
            pcall(function() for _, o in ipairs(workspace:GetDescendants()) do if o:IsA("ProximityPrompt") then fireproximityprompt(o) end end end)
        end
    end)
end)
--[[
    KIÊN | LỚP 94 — THCS NHUẬN PHÚ TÂN
    BLACK NEBULA — Part 2: Logic, Pages & UI Builder
]]

local flyActive = false
local flySpeed = 50
local flyConn = nil
local savedBases = { [1] = nil, [2] = nil }
local selectedBase = 1
local travelMode = "Bay Thật"

local function toggleFly(state)
    flyActive = state
    flyGui.Enabled = state
    flyStatus.Text = state and "Trạng thái: Bật (Max 165)" or "Trạng thái: Tắt"
    flyToggleBtn.BackgroundColor3 = state and C.Green or C.RedDark
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
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

-- Hàm bay thật về vị trí đích với tốc độ tùy chỉnh (Max 165)
local function flyToPos(targetPos, speed, onDone)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    hum.PlatformStand = true
    local bv = Instance.new("BodyVelocity", root)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    local bg = Instance.new("BodyGyro", root)
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.P = 3000
    local conn
    conn = RunService.RenderStepped:Connect(function()
        local dist = (targetPos - root.Position).Magnitude
        if dist < 5 then
            hum.PlatformStand = false
            if conn then conn:Disconnect() end
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
            if onDone then onDone() end
        else
            bv.Velocity = (targetPos - root.Position).Unit * speed
            bg.CFrame = CFrame.new(root.Position, targetPos)
        end
    end)
end

local pages = {
    HOME = { title = "HOME", hint = "Welcome to KIÊN | LỚP 94", items = { {kind = "banner", title = "BLACK NEBULA V3", desc = "Hỗ trợ popout đầy đủ, fly v3 thật và 2 base."} } },
    PLAYER = { title = "PLAYER", hint = "Tốc độ và nhảy cao", items = {
        {kind = "toggle", title = "Tăng Tốc Độ (Speed 35)", default = false, popout = speedPopout, callback = function(s) local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed = s and 35 or 16 end end},
        {kind = "toggle", title = "Nhảy Cao (Super Jump)", default = false, popout = jumpPopout, callback = function(s) local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid") if h then h.JumpPower = s and 100 or 50 end end},
    }},
    MOVEMENT = { title = "MOVEMENT", hint = "Fly V3 & Tốc độ bay", items = {
        {kind = "toggle", title = "Bật Menu Fly GUI Nổi", default = false, callback = function(s) toggleFly(s) end},
        {kind = "button", title = "Tăng Tốc Bay (+25 [Max 165])", callback = function() flySpeed = math.min(flySpeed + 25, 165) flySpeedLbl.Text = "Tốc độ: " .. flySpeed .. " / 165" notify("Tốc độ bay: " .. flySpeed) end},
        {kind = "button", title = "Giảm Tốc Bay (-25 [Min 25])", callback = function() flySpeed = math.max(flySpeed - 25, 25) flySpeedLbl.Text = "Tốc độ: " .. flySpeed .. " / 165" notify("Tốc độ bay: " .. flySpeed) end},
    }},
    BASE = { title = "BASES", hint = "Lưu và di chuyển tới Base", items = {
        {kind = "button", title = "Lưu Base 1", callback = function() local c = player.Character if c and c:FindFirstChild("HumanoidRootPart") then savedBases[1] = c.HumanoidRootPart.CFrame notify("Đã lưu Base 1!") end end},
        {kind = "button", title = "Lưu Base 2", callback = function() local c = player.Character if c and c:FindFirstChild("HumanoidRootPart") then savedBases[2] = c.HumanoidRootPart.CFrame notify("Đã lưu Base 2!") end end},
        {kind = "dropdown", title = "Chọn Base & Kiểu Về (^)", options = {"Đổi Base (Đang: 1)", "Đổi Base (Đang: 2)", "Chế độ: Bay Thật", "Chế độ: Giả Lập Chạy"}, callback = function(opt)
            if opt:find("Đổi Base") then selectedBase = (selectedBase == 1) and 2 or 1 notify("Đang chọn Base " .. selectedBase)
            elseif opt:find("Bay Thật") then travelMode = "Bay Thật" notify("Chọn: Bay thật")
            elseif opt:find("Giả Lập Chạy") then travelMode = "Giả Lập Chạy" notify("Chọn: Giả lập chạy") end
        end},
        {kind = "button", title = "Di Chuyển Về Base Đã Chọn", callback = function()
            local target = savedBases[selectedBase]
            local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if target and h then
                if travelMode == "Bay Thật" then notify("Đang bay thật về Base " .. selectedBase) flyToPos(target.Position, flySpeed, function() notify("Đã đến Base " .. selectedBase) end)
                else notify("Đang chạy giả lập về Base " .. selectedBase) h:MoveTo(target.Position) end
            else notify("Chưa lưu Base " .. selectedBase) end
        end},
    }},
    MISC = { title = "OPTIMIZE", hint = "Fix lag & Auto Loot", items = {
        {kind = "button", title = "Fix Lag (Giữ Nguyên Sáng)", callback = function() for _, o in ipairs(workspace:GetDescendants()) do if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Fire") or o:IsA("Smoke") then o:Destroy() end end Lighting.GlobalShadows = false Lighting.Brightness = 2 notify("Đã fix lag giữ sáng!") end},
        {kind = "toggle", title = "Nhặt Vật Phẩm Nhanh", default = false, popout = lootPopout, callback = function(s) _G.FastLoot = s task.spawn(function() while _G.FastLoot do task.wait(0.2) pcall(function() for _, o in ipairs(workspace:GetDescendants()) do if o:IsA("ProximityPrompt") then fireproximityprompt(o) end end) end end) end},
    }},
}

local states = {}
local currentPage = "HOME"
local renderPage

local function clearBody()
    for _, child in ipairs(pageBody:GetChildren()) do
        if child:IsA("GuiObject") and child ~= bodyLayout then child:Destroy() end
    end
end

local function makeCard(titleText, descText)
    local card = create("Frame", { Size = UDim2.new(1, -4, 0, 68), BackgroundColor3 = C.Card, BorderSizePixel = 0 }, pageBody)
    round(card, 12)
    stroke(card, C.RedDark, 1)
    create("TextLabel", { Position = UDim2.new(0, 14, 0, 11), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = titleText, TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 12 }, card)
    create("TextLabel", { Position = UDim2.new(0, 14, 0, 34), Size = UDim2.new(1, -28, 0, 22), BackgroundTransparency = 1, Text = descText or "", TextColor3 = C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 10, TextWrapped = true }, card)
    return card
end

local function addToggle(item)
    local card = makeCard(item.title, item.desc)
    local key = currentPage .. "_" .. item.title
    if states[key] == nil then states[key] = item.default or false end

    if item.popout then
        local popBtn = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -60, 0.5, 0), Size = UDim2.fromOffset(24, 24), BackgroundColor3 = C.Panel, Text = "□", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 12, AutoButtonColor = false }, card)
        round(popBtn, 6)
        stroke(popBtn, C.Red, 1)
        popBtn.MouseButton1Click:Connect(function() item.popout.Visible = not item.popout.Visible end)
    end

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
            makeCard(item.title, item.desc)
        elseif item.kind == "button" then
            local card = makeCard(item.title, item.desc)
            local action = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(80, 28), BackgroundColor3 = C.RedDark, Text = "EXECUTE", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9, AutoButtonColor = false }, card)
            round(action, 8)
            action.MouseButton1Click:Connect(function() if item.callback then pcall(function() item.callback() end) end end)
        elseif item.kind == "dropdown" then
            local card = makeCard(item.title, item.desc)
            local dropBtn = create("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(45, 28), BackgroundColor3 = C.RedDark, Text = "^", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 14, AutoButtonColor = false }, card)
            round(dropBtn, 8)
            local dropdownList = create("Frame", { Position = UDim2.new(0, 0, 1, 5), Size = UDim2.new(1, 0, 0, #item.options * 28), BackgroundColor3 = C.Panel, Visible = false, ZIndex = 20 }, card)
            round(dropdownList, 8)
            stroke(dropdownList, C.Red, 1)
            create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, dropdownList)
            for _, optText in ipairs(item.options) do
                local optBtn = create("TextButton", { Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, Text = "  " .. optText, TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 10, ZIndex = 21 }, dropdownList)
                optBtn.MouseButton1Click:Connect(function()
                    dropdownList.Visible = false
                    if item.callback then item.callback(optText) end
                end)
            end
            dropBtn.MouseButton1Click:Connect(function() dropdownList.Visible = not dropdownList.Visible end)
        end
    end
end

local navItems = {"HOME", "PLAYER", "MOVEMENT", "BASE", "MISC"}
local navNames = {HOME = "HOME", PLAYER = "PLAYER", MOVEMENT = "MOVEMENT", BASE = "BASES", MISC = "OPTIMIZE"}
for index, name in ipairs(navItems) do
    local button = create("TextButton", { Name = name, LayoutOrder = index, Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = name == "HOME" and C.RedDark or C.Panel, Text = "   " .. navNames[name], TextColor3 = name == "HOME" and C.White or C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 11, AutoButtonColor = false }, sidebar)
    round(button, 9)
    button.MouseButton1Click:Connect(function()
        for _, b in pairs(sidebar:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = C.Panel b.TextColor3 = C.Muted end end
        button.BackgroundColor3 = C.RedDark
        button.TextColor3 = C.White
        renderPage(name)
    end)
end

openButton.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
close.MouseButton1Click:Connect(function() main.Visible = false end)

renderPage("HOME")
notify("KIÊN | LỚP 94 — SẴN SÀNG HOẠT ĐỘNG!")
    
