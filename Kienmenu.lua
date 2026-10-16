--[[
    KIÊN | LỚP 94 — THCS NHUẬN PHÚ TÂN
    BLACK NEBULA — Part 1: Core & UI Setup
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("KEY_Lop94")
if old then old:Destroy() end

--// COLORS
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
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function round(parent, radius)
    create("UICorner", { CornerRadius = UDim.new(0, radius or 10) }, parent)
end

local function stroke(parent, color, thickness, transparency)
    return create("UIStroke", {
        Color = color or C.Red,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    }, parent)
end

local function tween(obj, duration, props)
    local t = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local gui = create("ScreenGui", {
    Name = "KEY_Lop94",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

--// FLOATING OPEN BUTTON
local openButton = create("TextButton", {
    Name = "OpenButton",
    Size = UDim2.fromOffset(58, 58),
    Position = UDim2.new(0, 18, 0.5, -29),
    BackgroundColor3 = C.Background,
    Text = "K",
    TextColor3 = C.Red,
    TextSize = 27,
    Font = Enum.Font.GothamBlack,
    AutoButtonColor = false,
}, gui)
round(openButton, 18)
stroke(openButton, C.Red, 2)

--// MAIN WINDOW
local main = create("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(650, 420),
    BackgroundColor3 = C.Background,
    BorderSizePixel = 0,
    Visible = false,
    ClipsDescendants = true,
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
    BLACK NEBULA — Part 2: TopBar, Navigation & Notifications
]]

--// TOP BAR
local top = create("Frame", {
    Size = UDim2.new(1, 0, 0, 64),
    BackgroundColor3 = C.Panel,
    BorderSizePixel = 0,
}, main)

create("Frame", {
    Position = UDim2.new(0, 0, 1, -2),
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = C.Red,
    BorderSizePixel = 0,
}, top)

local logo = create("Frame", {
    Position = UDim2.new(0, 17, 0.5, -19),
    Size = UDim2.fromOffset(38, 38),
    BackgroundColor3 = C.RedDark,
}, top)
round(logo, 12)
stroke(logo, C.Red, 1)

create("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "K",
    TextColor3 = C.White,
    Font = Enum.Font.GothamBlack,
    TextSize = 23,
}, logo)

create("TextLabel", {
    Position = UDim2.new(0, 65, 0, 9),
    Size = UDim2.new(0, 360, 0, 25),
    BackgroundTransparency = 1,
    Text = "KIÊN | LỚP 94 — THCS NHUẬN PHÚ TÂN",
    TextColor3 = C.White,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
    TextSize = 14,
}, top)

create("TextLabel", {
    Position = UDim2.new(0, 66, 0, 35),
    Size = UDim2.new(0, 300, 0, 17),
    BackgroundTransparency = 1,
    Text = "BLACK NEBULA  •  ULTIMATE ACTIVE HUB",
    TextColor3 = C.Muted,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium,
    TextSize = 9,
}, top)

local close = create("TextButton", {
    Position = UDim2.new(1, -45, 0, 15),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = C.Card,
    Text = "×",
    TextColor3 = C.Red,
    TextSize = 23,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
}, top)
round(close, 9)

--// SIDEBAR & CONTENT
local sidebar = create("Frame", {
    Position = UDim2.new(0, 0, 0, 66),
    Size = UDim2.new(0, 155, 1, -66),
    BackgroundColor3 = C.Panel,
    BorderSizePixel = 0,
}, main)

create("UIListLayout", { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, sidebar)
create("UIPadding", { PaddingTop = UDim.new(0, 17), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }, sidebar)

local content = create("Frame", {
    Position = UDim2.new(0, 155, 0, 66),
    Size = UDim2.new(1, -155, 1, -66),
    BackgroundTransparency = 1,
}, main)

local pageTitle = create("TextLabel", {
    Position = UDim2.new(0, 20, 0, 15),
    Size = UDim2.new(1, -40, 0, 30),
    BackgroundTransparency = 1,
    Text = "HOME / OVERVIEW",
    TextColor3 = C.White,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
}, content)

local pageHint = create("TextLabel", {
    Position = UDim2.new(0, 20, 0, 44),
    Size = UDim2.new(1, -40, 0, 20),
    BackgroundTransparency = 1,
    Text = "Hệ thống script mở rộng chuyên nghiệp.",
    TextColor3 = C.Muted,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.Gotham,
    TextSize = 11,
}, content)

local pageBody = create("ScrollingFrame", {
    Position = UDim2.new(0, 15, 0, 75),
    Size = UDim2.new(1, -30, 1, -88),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.Red,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)

local bodyLayout = create("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }, pageBody)

--// TOAST NOTIFICATION
local toast = create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -12),
    Size = UDim2.fromOffset(300, 38),
    BackgroundColor3 = C.Card,
    TextColor3 = C.White,
    Text = "",
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    Visible = false,
    ZIndex = 10,
}, main)
round(toast, 10)
stroke(toast, C.Red, 1)

local toastVersion = 0
local function notify(message)
    toastVersion += 1
    local version = toastVersion
    toast.Text = "  " .. message
    toast.Visible = true
    toast.TextTransparency = 1
    tween(toast, 0.2, {TextTransparency = 0})
    task.delay(1.8, function()
        if toastVersion == version then
            tween(toast, 0.2, {TextTransparency = 1})
            task.wait(0.22)
            if toastVersion == version then toast.Visible = false end
        end
    end)
end
--[[
    KIÊN | LỚP 94 — THCS NHUẬN PHÚ TÂN
    BLACK NEBULA — Part 3: Active Functions & Logic Execution
]]

local function getHumanoid()
    local char = player.Character
    if char then return char:FindFirstChildOfClass("Humanoid") end
    return nil
end

local savedBasePosition = nil
local flyConnection = nil
local noclipConnection = nil

--// PAGES & ACTIVE FEATURES CONFIG
local pages = {
    HOME = {
        title = "HOME / TỔNG QUAN",
        hint = "Chào mừng Kiên đến với Hub độc quyền",
        items = {
            {kind = "banner", title = "KIÊN LỚP 94 - NHUẬN PHÚ TÂN", desc = "Đã tích hợp các tính năng VIP hoạt động 100%."},
            {kind = "info", title = "TRƯỜNG", desc = "THCS Nhuận Phú Tân • Vĩnh Long"},
        },
    },
    PLAYER = {
        title = "PLAYER / NHÂN VẬT",
        hint = "Tùy chỉnh tốc độ, nhảy cao và khả năng bay",
        items = {
            {
                kind = "toggle", title = "Tăng Tốc Độ Chạy (Speed 35)", 
                desc = "Giúp nhân vật di chuyển nhanh hơn.", default = false,
                callback = function(enabled)
                    local hum = getHumanoid()
                    if hum then hum.WalkSpeed = enabled and 35 or 16 end
                end
            },
            {
                kind = "toggle", title = "Nhảy Siêu Cao (Super Jump)", 
                desc = "Tăng lực nhảy lên 100.", default = false,
                callback = function(enabled)
                    local hum = getHumanoid()
                    if hum then hum.JumpPower = enabled and 100 or 50 end
                end
            },
            {
                kind = "toggle", title = "Nhảy Vô Hạn Không Trung (Inf Jump)", 
                desc = "Cho phép bấm nhảy liên tục trên không.", default = false,
                callback = function(enabled)
                    if enabled then
                        _G.InfJumpConn = UserInputService.JumpRequest:Connect(function()
                            local hum = getHumanoid()
                            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                        end)
                    else
                        if _G.InfJumpConn then _G.InfJumpConn:Disconnect() end
                    end
                end
            },
        },
    },
    COMBAT = {
        title = "MOVEMENT / BAY & XUYÊN TƯỜNG",
        hint = "Các công cụ di chuyển đặc biệt",
        items = {
            {
                kind = "toggle", title = "Đi Xuyên Tường (Noclip)", 
                desc = "Cho phép đi xuyên qua mọi vật cản.", default = false,
                callback = function(enabled)
                    if enabled then
                        noclipConnection = RunService.Stepped:Connect(function()
                            local char = player.Character
                            if char then
                                for _, part in ipairs(char:GetDescendants()) do
                                    if part:IsA("BasePart") then part.CanCollide = false end
                                end
                            end
                        end)
                    else
                        if noclipConnection then noclipConnection:Disconnect() end
                    end
                end
            },
            {
                kind = "toggle", title = "Bay Tự Do (Fly Hack)", 
                desc = "Bay lượn trên không trung cực mượt.", default = false,
                callback = function(enabled)
                    local char = player.Character
                    local root = char and char:FindFirstChild("HumanoidRootPart")
                    if enabled and root then
                        local bv = Instance.new("BodyVelocity")
                        bv.Name = "KienFlyVel"
                        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        bv.Velocity = Vector3.new(0, 0, 0)
                        bv.Parent = root
                        
                        flyConnection = RunService.RenderStepped:Connect(function()
                            local cam = workspace.CurrentCamera
                            local vel = Vector3.new(0,0,0)
                            if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += cam.CoordinateFrame.LookVector * 50 end
                            if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= cam.CoordinateFrame.LookVector * 50 end
                            if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += cam.CoordinateFrame.RightVector * 50 end
                            if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= cam.CoordinateFrame.RightVector * 50 end
                            bv.Velocity = vel
                        end)
                    else
                        if flyConnection then flyConnection:Disconnect() end
                        if root and root:FindFirstChild("KienFlyVel") then root.KienFlyVel:Destroy() end
                    end
                end
            },
        },
    },
    VISUAL = {
        title = "VISUAL / ESP NGƯỜI CHƠI",
        hint = "Hỗ trợ nhìn xuyên vật thể",
        items = {
            {
                kind = "toggle", title = "Highlight ESP Toàn Bộ Player", 
                desc = "Phủ màu sáng quanh người chơi khác.", default = false,
                callback = function(enabled)
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            local hl = p.Character:FindFirstChild("KienHighlight")
                            if enabled and not hl then
                                local h = Instance.new("Highlight")
                                h.Name = "KienHighlight"
                                h.FillColor = Color3.fromRGB(255, 48, 75)
                                h.OutlineColor = Color3.fromRGB(255, 255, 255)
                                h.Parent = p.Character
                            elseif not enabled and hl then
                                hl:Destroy()
                            end
                        end
                    end
                end
            },
        },
    },
    SETTINGS = {
        title = "SETTINGS / CÀI ĐẶT & TELEPORT",
        hint = "Quản lý điểm lưu và chuyển server",
        items = {
            {
                kind = "button", title = "Lưu Tọa Độ Căn Cứ (Save Base)", 
                desc = "Ghi nhớ vị trí hiện tại của bạn.",
                callback = function()
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        savedBasePosition = char.HumanoidRootPart.CFrame
                        notify("Đã lưu vị trí căn cứ thành công!")
                    end
                end
            },
            {
                kind = "button", title = "Bay Về Căn Cứ (Teleport Base)", 
                desc = "Dịch chuyển tức thì về vị trí đã lưu.",
                callback = function()
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") and savedBasePosition then
                        char.HumanoidRootPart.CFrame = savedBasePosition
                        notify("Đã dịch chuyển về căn cứ!")
                    else
                        notify("Chưa lưu tọa độ nào cả!")
                    end
                end
            },
            {
                kind = "button", title = "Đổi Server Nhanh (Server Hop)", 
                desc = "Tìm server khác chơi ổn định hơn.",
                callback = function()
                    notify("Đang chuyển server...")
                    pcall(function() TeleportService:Teleport(game.PlaceId, player) end)
                end
            },
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
    stroke(card, C.RedDark, 1, 0.35)

    create("TextLabel", {
        Position = UDim2.new(0, 14, 0, 11), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1,
        Text = titleText, TextColor3 = C.White, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 12,
    }, card)

    create("TextLabel", {
        Position = UDim2.new(0, 14, 0, 34), Size = UDim2.new(1, -28, 0, 22), BackgroundTransparency = 1,
        Text = descText, TextColor3 = C.Muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 10, TextWrapped = true,
    }, card)
    return card
end

local function addToggle(item)
    local card = makeCard(item.title, item.desc, 72)
    local key = currentPage .. "_" .. item.title
    if states[key] == nil then states[key] = item.default or false end

    local switch = create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -13, 0.5, 0), Size = UDim2.fromOffset(42, 23),
        BackgroundColor3 = states[key] and C.Red or Color3.fromRGB(55, 55, 66), Text = "", AutoButtonColor = false,
    }, card)
    round(switch, 12)

    local knob = create("Frame", {
        Position = states[key] and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8),
        Size = UDim2.fromOffset(16, 16), BackgroundColor3 = C.White, BorderSizePixel = 0,
    }, switch)
    round(knob, 8)

    switch.Activated:Connect(function()
        states[key] = not states[key]
        local enabled = states[key]
        tween(switch, 0.18, { BackgroundColor3 = enabled and C.Red or Color3.fromRGB(55, 55, 66) })
        tween(knob, 0.18, { Position = enabled and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8) })
        notify(item.title .. (enabled and " : ĐÃ BẬT" or " : ĐÃ TẮT"))

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
            local action = create("TextButton", {
                AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(90, 28),
                BackgroundColor3 = C.RedDark, Text = "THỰC THI", TextColor3 = C.White, Font = Enum.Font.GothamBold, TextSize = 9, AutoButtonColor = false,
            }, card)
            round(action, 8)
            action.Activated:Connect(function()
                if item.callback then pcall(function() item.callback() end) end
            end)
        else
            makeCard(item.title, item.desc, 68)
        end
    end
end

local navItems = {"HOME", "PLAYER", "COMBAT", "VISUAL", "SETTINGS"}
local navNames = {HOME = "Trang Chủ", PLAYER = "Nhân Vật", COMBAT = "Di Chuyển", VISUAL = "Giao Diện", SETTINGS = "Cài Đặt"}
local navButtons = {}

for index, name in ipairs(navItems) do
    local button = create("TextButton", {
        Name = name, LayoutOrder = index, Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = name == "HOME" and C.RedDark or C.Panel, Text = "   " .. navNames[name],
        TextColor3 = name == "HOME" and C.White or C.Muted, TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold, TextSize = 11, AutoButtonColor = false,
    }, sidebar)
    round(button, 9)
    navButtons[name] = button

    button.Activated:Connect(function()
        for _, other in pairs(navButtons) do
            tween(other, 0.15, { BackgroundColor3 = C.Panel })
            other.TextColor3 = C.Muted
        end
        tween(button, 0.15, { BackgroundColor3 = C.RedDark })
        button.TextColor3 = C.White
        renderPage(name)
    end)
end

local function setOpen(visible)
    if visible then
        main.Visible = true
        main.Size = UDim2.fromOffset(610, 390)
        tween(main, 0.22, { Size = UDim2.fromOffset(650, 420) })
    else
        tween(main, 0.18, { Size = UDim2.fromOffset(610, 390) })
        task.delay(0.19, function() main.Visible = false end)
    end
end

openButton.Activated:Connect(function() setOpen(not main.Visible) end)
close.Activated:Connect(function() setOpen(false) end)

local dragging, dragStart, startPosition
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

renderPage("HOME")
notify("KIÊN | LỚP 94 — THCS NHUẬN PHÚ TÂN SẴN SÀNG!")
