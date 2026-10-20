-- ====================================================
-- KIÊN PREMIUM - ULTIMATE ADVANCED EDITION (PART 1/3)
-- ====================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Xóa UI cũ nếu có
if CoreGui:FindFirstChild("KienPremiumUI") then
    CoreGui:FindFirstChild("KienPremiumUI"):Destroy()
end

local KienUI = Instance.new("ScreenGui")
KienUI.Name = "KienPremiumUI"
KienUI.Parent = CoreGui
KienUI.ResetOnSpawn = false

local ICON_ASSET = "rbxassetid://117828154165313"

-- ----------------------------------------------------
-- HỆ THỐNG THÔNG BÁO TỰ TẠO (NẰM Ở MÉP TRÊN MÀN HÌNH - TOP NOTIFICATION)
-- ----------------------------------------------------
local NotifContainer = Instance.new("Frame")
NotifContainer.Name = "NotifContainer"
NotifContainer.Parent = KienUI
NotifContainer.Position = UDim2.new(0.5, -140, 0, 10) -- Nằm ngay giữa viền trên màn hình
NotifContainer.Size = UDim2.new(0, 280, 0, 150)
NotifContainer.BackgroundTransparency = 1
NotifContainer.ClipsDescendants = false

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.Parent = NotifContainer
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.Padding = UDim.new(0, 5)
NotifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function Notify(title, text, duration)
    pcall(function()
        local NotifFrame = Instance.new("Frame")
        NotifFrame.Parent = NotifContainer
        NotifFrame.Size = UDim2.new(1, 0, 0, 36)
        NotifFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
        NotifFrame.BackgroundTransparency = 0.1

        local NC = Instance.new("UICorner")
        NC.CornerRadius = UDim.new(0, 8)
        NC.Parent = NotifFrame

        local NS = Instance.new("UIStroke")
        NS.Color = Color3.fromRGB(0, 180, 255)
        NS.Thickness = 1.2
        NS.Parent = NotifFrame

        local NTitle = Instance.new("TextLabel")
        NTitle.Parent = NotifFrame
        NTitle.Position = UDim2.new(0, 10, 0, 3)
        NTitle.Size = UDim2.new(1, -20, 0, 14)
        NTitle.Text = title or "Kiên Premium"
        NTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
        NTitle.Font = Enum.Font.GothamBold
        NTitle.TextSize = 11
        NTitle.TextXAlignment = Enum.TextXAlignment.Left
        NTitle.BackgroundTransparency = 1

        local NText = Instance.new("TextLabel")
        NText.Parent = NotifFrame
        NText.Position = UDim2.new(0, 10, 0, 18)
        NText.Size = UDim2.new(1, -20, 0, 14)
        NText.Text = text or ""
        NText.TextColor3 = Color3.fromRGB(220, 225, 235)
        NText.Font = Enum.Font.Gotham
        NText.TextSize = 10
        NText.TextXAlignment = Enum.TextXAlignment.Left
        NText.BackgroundTransparency = 1

        task.spawn(function()
            task.wait(duration or 2.5)
            for i = 0, 1, 0.1 do
                NotifFrame.BackgroundTransparency = 0.1 + (i * 0.9)
                NTitle.TextTransparency = i
                NText.TextTransparency = i
                NS.Transparency = i
                task.wait(0.02)
            end
            NotifFrame:Destroy()
        end)
    end)
end

Notify("Kiên Premium", "Đang khởi tạo hệ thống...", 2)

-- ----------------------------------------------------
-- NÚT BẬT/TẮT MENU & SHIFTLOCK (CỐ ĐỊNH PHÍA TRÊN)
-- ----------------------------------------------------

local ToggleMenuBtn = Instance.new("ImageButton")
ToggleMenuBtn.Name = "ToggleMenuBtn"
ToggleMenuBtn.Parent = KienUI
ToggleMenuBtn.Position = UDim2.new(0, 55, 0, 5)
ToggleMenuBtn.Size = UDim2.new(0, 38, 0, 38)
ToggleMenuBtn.Image = ICON_ASSET
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
ToggleMenuBtn.BorderSizePixel = 0
ToggleMenuBtn.Active = true

local ToggleUICorner = Instance.new("UICorner") ToggleUICorner.CornerRadius = UDim.new(0, 8) ToggleUICorner.Parent = ToggleMenuBtn
local ToggleUIStroke = Instance.new("UIStroke") ToggleUIStroke.Color = Color3.fromRGB(0, 200, 255) ToggleUIStroke.Thickness = 1.2 ToggleUIStroke.Parent = ToggleMenuBtn

local ShiftLockBtn = Instance.new("TextButton")
ShiftLockBtn.Name = "ShiftLockBtn"
ShiftLockBtn.Parent = KienUI
ShiftLockBtn.Position = UDim2.new(0, 98, 0, 5)
ShiftLockBtn.Size = UDim2.new(0, 38, 0, 38)
ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
ShiftLockBtn.Text = "LOCK"
ShiftLockBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
ShiftLockBtn.TextSize = 11
ShiftLockBtn.Font = Enum.Font.GothamBold
ShiftLockBtn.BorderSizePixel = 0
ShiftLockBtn.Active = true

local ShiftCorner = Instance.new("UICorner") ShiftCorner.CornerRadius = UDim.new(0, 8) ShiftCorner.Parent = ShiftLockBtn
local ShiftStroke = Instance.new("UIStroke") ShiftStroke.Color = Color3.fromRGB(60, 65, 80) ShiftStroke.Thickness = 1.2 ShiftStroke.Parent = ShiftLockBtn

local isShiftLock = false
ShiftLockBtn.MouseButton1Click:Connect(function()
    isShiftLock = not isShiftLock
    if isShiftLock then
        ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230)
        ShiftLockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ShiftStroke.Color = Color3.fromRGB(0, 200, 255)
        Notify("ShiftLock", "Đã BẬT Khóa Màn Hình", 1.5)
    else
        ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
        ShiftLockBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        ShiftStroke.Color = Color3.fromRGB(60, 65, 80)
        Notify("ShiftLock", "Đã TẮT Khóa Màn Hình", 1.5)
    end
end)

RunService.RenderStepped:Connect(function()
    if isShiftLock and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
            LocalPlayer.Character.HumanoidRootPart.Position,
            LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
        )
    end
end)

-- ----------------------------------------------------
-- MAIN FRAME & NÚT THU NHỎ / XÓA MENU VĨNH VIỄN
-- ----------------------------------------------------

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = KienUI
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 10) MainCorner.Parent = MainFrame
local MainBGImage = Instance.new("ImageLabel") MainBGImage.Name = "MainBGImage" MainBGImage.Parent = MainFrame MainBGImage.Size = UDim2.new(1, 0, 1, 0) MainBGImage.Image = ICON_ASSET MainBGImage.ImageTransparency = 0.92 MainBGImage.ScaleType = Enum.ScaleType.Crop MainBGImage.BackgroundTransparency = 1
local MainStroke = Instance.new("UIStroke") MainStroke.Color = Color3.fromRGB(45, 50, 65) MainStroke.Thickness = 1.5 MainStroke.Parent = MainFrame

ToggleMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Header Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(1, -120, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Text = "KIÊN PREMIUM"
TitleText.TextColor3 = Color3.fromRGB(0, 200, 255)
TitleText.TextSize = 14
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

-- Nút Thu Nhỏ Menu (Minimize)
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.Position = UDim2.new(1, -65, 0.5, -11)
MinBtn.Size = UDim2.new(0, 24, 0, 22)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 52)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
local MinCorner = Instance.new("UICorner") MinCorner.CornerRadius = UDim.new(0, 4) MinCorner.Parent = MinBtn

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 520, 0, 38), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 520, 0, 320), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    end
end)

-- Nút Xóa Menu Vĩnh Viễn (Destroy UI & Reset State)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.Position = UDim2.new(1, -35, 0.5, -11)
CloseBtn.Size = UDim2.new(0, 24, 0, 22)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
local CloseCorner = Instance.new("UICorner") CloseCorner.CornerRadius = UDim.new(0, 4) CloseCorner.Parent = CloseBtn

-- Sidebar Chứa Các Tab
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.Position = UDim2.new(0, 8, 0, 44)
TabContainer.Size = UDim2.new(0, 120, 1, -50)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabContainer
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

-- Content Area
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.Position = UDim2.new(0, 135, 0, 44)
ContentContainer.Size = UDim2.new(1, -143, 1, -50)
ContentContainer.BackgroundTransparency = 1

local Tabs = {}
local TabButtons = {}

local function CreateTab(id, name)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = "Tab_" .. id
    TabBtn.Parent = TabContainer
    TabBtn.Size = UDim2.new(1, 0, 0, 34)
    TabBtn.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(150, 155, 170)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 12

    local TBtnCorner = Instance.new("UICorner") TBtnCorner.CornerRadius = UDim.new(0, 6) TBtnCorner.Parent = TabBtn

    local Page = Instance.new("ScrollingFrame")
    Page.Name = "Page_" .. id
    Page.Parent = ContentContainer
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(60, 65, 80)
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 6)

    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
    end)

    TabBtn.MouseButton1Click:Connect(function()
        for _, tBtn in pairs(TabButtons) do
            tBtn.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
            tBtn.TextColor3 = Color3.fromRGB(150, 155, 170)
        end
        for _, p in pairs(Tabs) do p.Visible = false end
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Page.Visible = true
    end)

    Tabs[id] = Page
    table.insert(TabButtons, TabBtn)
    return Page
end

local Tab1 = CreateTab(1, "Chính")
local Tab2 = CreateTab(2, "Vị Trí")
local Tab3 = CreateTab(3, "Người Chơi")
local Tab4 = CreateTab(4, "Cài Đặt")
local Tab5 = CreateTab(5, "Đổi Server")
local Tab6 = CreateTab(6, "Tối Ưu")

TabButtons[1].BackgroundColor3 = Color3.fromRGB(0, 160, 230)
TabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
Tabs[1].Visible = true

local ActiveToggles = {}

local function CreateToggle(parent, text, toggleKey, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -6, 0, 36)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
    Frame.Parent = parent

    local FCorner = Instance.new("UICorner") FCorner.CornerRadius = UDim.new(0, 6) FCorner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 225, 235)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.BackgroundTransparency = 1

    local SwitchBg = Instance.new("TextButton")
    SwitchBg.Parent = Frame
    SwitchBg.Position = UDim2.new(1, -52, 0.5, -10)
    SwitchBg.Size = UDim2.new(0, 42, 0, 20)
    SwitchBg.Text = ""
    SwitchBg.BackgroundColor3 = default and Color3.fromRGB(0, 180, 120) or Color3.fromRGB(45, 48, 60)
    SwitchBg.AutoButtonColor = false

    local SwCorner = Instance.new("UICorner") SwCorner.CornerRadius = UDim.new(1, 0) SwCorner.Parent = SwitchBg

    local Knob = Instance.new("Frame")
    Knob.Parent = SwitchBg
    Knob.Position = default and UDim2.new(1, -18, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local KCorner = Instance.new("UICorner") KCorner.CornerRadius = UDim.new(1, 0) KCorner.Parent = Knob

    local state = default

    local function SetState(val, silent)
        state = val
        if state then
            SwitchBg.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
            Knob.Position = UDim2.new(1, -18, 0.5, -7)
        else
            SwitchBg.BackgroundColor3 = Color3.fromRGB(45, 48, 60)
            Knob.Position = UDim2.new(0, 2, 0.5, -7)
        end
        if not silent then
            Notify("Chức Năng", text .. " -> " .. (state and "ĐÃ BẬT" or "ĐÃ TẮT"), 1.5)
        end
        local success, err = pcall(function() callback(state) end)
        if not success then
            Notify("Lỗi Chức Năng", text .. " gặp lỗi: " .. tostring(err), 3)
        end
    end

    SwitchBg.MouseButton1Click:Connect(function()
        SetState(not state, false)
    end)

    if toggleKey then
        ActiveToggles[toggleKey] = SetState
    end
end

local function CreateSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -6, 0, 46)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
    Frame.Parent = parent

    local FCorner = Instance.new("UICorner") FCorner.CornerRadius = UDim.new(0, 6) FCorner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Position = UDim2.new(0, 12, 0, 6)
    Label.Size = UDim2.new(1, -24, 0, 16)
    Label.Text = text .. ": " .. tostring(default)
    Label.TextColor3 = Color3.fromRGB(220, 225, 235)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.BackgroundTransparency = 1

    local SliderTrack = Instance.new("Frame")
    SliderTrack.Parent = Frame
    SliderTrack.Position = UDim2.new(0, 12, 0, 28)
    SliderTrack.Size = UDim2.new(1, -24, 0, 6)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(45, 48, 60)

    local STCorner = Instance.new("UICorner") STCorner.CornerRadius = UDim.new(1, 0) STCorner.Parent = SliderTrack

    local Fill = Instance.new("Frame")
    Fill.Parent = SliderTrack
    Fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 160, 230)

    local FCorner2 = Instance.new("UICorner") FCorner2.CornerRadius = UDim.new(1, 0) FCorner2.Parent = Fill

    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Label.Text = text .. ": " .. tostring(val)
        pcall(function() callback(val) end)
    end

    SliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true Update(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            Update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end
-- ====================================================
-- KIÊN PREMIUM - ULTIMATE ADVANCED EDITION (PART 2/3)
-- ====================================================

-- ----------------------------------------------------
-- TAB 1: GÀ / CHÍNH (THÊM ESP TÊN + KHOẢNG CÁCH MÀU ĐỎ)
-- ----------------------------------------------------

-- 1. Noclip
local noclip = false
CreateToggle(Tab1, "Đi Xuyên Tường (Noclip)", "Noclip", false, function(v)
    noclip = v
    if not v and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end)

RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- 2. ESP Nâng Cấp: Box + Tên Nổi Bật + Khoảng Cách Mắt Thấy (Màu Đỏ Neon)
local espEnabled = false
local espObjects = {}

local function ClearESP()
    for plr, obj in pairs(espObjects) do
        if obj.Highlight then obj.Highlight:Destroy() end
        if obj.Billboard then obj.Billboard:Destroy() end
    end
    espObjects = {}
end

CreateToggle(Tab1, "ESP Box + Tên + Khoảng Cách", "ESP", false, function(v)
    espEnabled = v
    if not v then ClearESP() end
end)

RunService.RenderStepped:Connect(function()
    if espEnabled then
        local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") then
                local hrp = p.Character.HumanoidRootPart
                local dist = myHrp and math.floor((hrp.Position - myHrp.Position).Magnitude) or 0

                if not espObjects[p] then
                    espObjects[p] = {}

                    -- Highlight Box Đỏ
                    local hl = Instance.new("Highlight")
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.5
                    hl.Parent = p.Character
                    espObjects[p].Highlight = hl

                    -- BillboardGui cho Tên & Khoảng Cách
                    local bg = Instance.new("BillboardGui")
                    bg.Name = "ESP_Text"
                    bg.Adornee = p.Character:FindFirstChild("Head") or hrp
                    bg.Size = UDim2.new(0, 150, 0, 30)
                    bg.StudsOffset = Vector3.new(0, 2.5, 0)
                    bg.AlwaysOnTop = true
                    bg.Parent = p.Character

                    local txt = Instance.new("TextLabel")
                    txt.Parent = bg
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.TextColor3 = Color3.fromRGB(255, 30, 30) -- Màu Đỏ Nổi Bật
                    txt.TextStrokeTransparency = 0
                    txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    txt.Font = Enum.Font.GothamBold
                    txt.TextSize = 11
                    espObjects[p].TextLabel = txt
                    espObjects[p].Billboard = bg
                else
                    if espObjects[p].TextLabel then
                        espObjects[p].TextLabel.Text = p.DisplayName .. " [" .. tostring(dist) .. "m]"
                    end
                end
            end
        end
    else
        if next(espObjects) ~= nil then ClearESP() end
    end
end)

-- 3. Instant Pickup
local instantPickup = false
CreateToggle(Tab1, "Nhặt Đồ Tức Thì", "InstantPick", false, function(v)
    instantPickup = v
end)

RunService.RenderStepped:Connect(function()
    if instantPickup then
        for _, prompt in pairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then prompt.HoldDuration = 0 end
        end
    end
end)

-- 4. TÍNH NĂNG MỚI HỮU ÍCH: Anti-AFK (Không bị văng game khi treo máy)
local antiAFK = false
CreateToggle(Tab1, "Tự Động Chống AFK (Anti-AFK)", "AntiAFK", true, function(v)
    antiAFK = v
end)

local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    if antiAFK then
        VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
        Notify("Anti-AFK", "Đã ngăn văng game do đứng yên!", 2)
    end
end)

-- 5. TÍNH NĂNG MỚI HỮU ÍCH: Nhảy Vô Hạn (Infinite Jump)
local infJump = false
CreateToggle(Tab1, "Nhảy Vô Hạn (Infinite Jump)", "InfJump", false, function(v)
    infJump = v
end)

UserInputService.JumpRequest:Connect(function()
    if infJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)


-- ----------------------------------------------------
-- TAB 2: VỊ TRÍ & WIDGET BAY NHANH 📍
-- ----------------------------------------------------

local Pos1, Pos2 = nil, nil
local FlySpeed = 50

local PosWidget = Instance.new("Frame")
PosWidget.Name = "PosWidget"
PosWidget.Parent = KienUI
PosWidget.Size = UDim2.new(0, 150, 0, 85)
PosWidget.Position = UDim2.new(0.85, -150, 0.35, 0)
PosWidget.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
PosWidget.Visible = false
PosWidget.Active = true
PosWidget.Draggable = true

local WCorner = Instance.new("UICorner") WCorner.CornerRadius = UDim.new(0, 8) WCorner.Parent = PosWidget
local WStroke = Instance.new("UIStroke") WStroke.Color = Color3.fromRGB(0, 160, 230) WStroke.Thickness = 1.2 WStroke.Parent = PosWidget

local WTitle = Instance.new("TextLabel")
WTitle.Parent = PosWidget
WTitle.Size = UDim2.new(1, 0, 0, 22)
WTitle.Text = "BAY NHANH"
WTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
WTitle.TextSize = 11
WTitle.Font = Enum.Font.GothamBold
WTitle.BackgroundTransparency = 1

local FlyBtn1 = Instance.new("TextButton")
FlyBtn1.Parent = PosWidget
FlyBtn1.Position = UDim2.new(0, 8, 0, 26)
FlyBtn1.Size = UDim2.new(1, -16, 0, 24)
FlyBtn1.Text = "Bay Về Vị Trí 1"
FlyBtn1.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
FlyBtn1.TextColor3 = Color3.fromRGB(220, 220, 220)
FlyBtn1.Font = Enum.Font.GothamSemibold
FlyBtn1.TextSize = 11
local F1C = Instance.new("UICorner") F1C.CornerRadius = UDim.new(0, 4) F1C.Parent = FlyBtn1

local FlyBtn2 = Instance.new("TextButton")
FlyBtn2.Parent = PosWidget
FlyBtn2.Position = UDim2.new(0, 8, 0, 54)
FlyBtn2.Size = UDim2.new(1, -16, 0, 24)
FlyBtn2.Text = "Bay Về Vị Trí 2"
FlyBtn2.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
FlyBtn2.TextColor3 = Color3.fromRGB(220, 220, 220)
FlyBtn2.Font = Enum.Font.GothamSemibold
FlyBtn2.TextSize = 11
local F2C = Instance.new("UICorner") F2C.CornerRadius = UDim.new(0, 4) F2C.Parent = FlyBtn2

local function FlyToPos(targetCFrame)
    if not targetCFrame then
        Notify("Lỗi Vị Trí", "Chưa lưu vị trí!", 1.5)
        return
    end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        Notify("Di Chuyển", "Đang bay tới vị trí...", 1.5)
        local distance = (targetCFrame.Position - hrp.Position).Magnitude
        local duration = distance / math.max(FlySpeed, 10)
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = game:GetService("TweenService"):Create(hrp, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
    end
end

FlyBtn1.MouseButton1Click:Connect(function() FlyToPos(Pos1) end)
FlyBtn2.MouseButton1Click:Connect(function() FlyToPos(Pos2) end)

CreateToggle(Tab2, "Hiện Bảng Bay Vị Trí Nhanh", "ShowPosWidget", false, function(v)
    PosWidget.Visible = v
end)

local Save1Btn = Instance.new("TextButton")
Save1Btn.Parent = Tab2 Save1Btn.Size = UDim2.new(1, -6, 0, 32) Save1Btn.Text = "Lưu Vị Trí 1" Save1Btn.BackgroundColor3 = Color3.fromRGB(30, 34, 45) Save1Btn.TextColor3 = Color3.fromRGB(220, 225, 235) Save1Btn.Font = Enum.Font.GothamSemibold Save1Btn.TextSize = 12
local S1C = Instance.new("UICorner") S1C.CornerRadius = UDim.new(0, 6) S1C.Parent = Save1Btn
Save1Btn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Pos1 = LocalPlayer.Character.HumanoidRootPart.CFrame
        Notify("Vị Trí", "Đã lưu Vị Trí 1", 1.5)
    end
end)

local Save2Btn = Instance.new("TextButton")
Save2Btn.Parent = Tab2 Save2Btn.Size = UDim2.new(1, -6, 0, 32) Save2Btn.Text = "Lưu Vị Trí 2" Save2Btn.BackgroundColor3 = Color3.fromRGB(30, 34, 45) Save2Btn.TextColor3 = Color3.fromRGB(220, 225, 235) Save2Btn.Font = Enum.Font.GothamSemibold Save2Btn.TextSize = 12
local S2C = Instance.new("UICorner") S2C.CornerRadius = UDim.new(0, 6) S2C.Parent = Save2Btn
Save2Btn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Pos2 = LocalPlayer.Character.HumanoidRootPart.CFrame
        Notify("Vị Trí", "Đã lưu Vị Trí 2", 1.5)
    end
end)

CreateSlider(Tab2, "Tốc Độ Bay (1 - 500)", 1, 500, 50, function(v) FlySpeed = v end)


-- ----------------------------------------------------
-- TAB 3: NGƯỜI CHƠI (TELEPORT/FLY TO PLAYER) 👥
-- ----------------------------------------------------

local SelectedPlayer = nil

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Parent = Tab3 RefreshBtn.Size = UDim2.new(1, -6, 0, 32) RefreshBtn.Text = "Làm Mới Danh Sách Người Chơi" RefreshBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45) RefreshBtn.TextColor3 = Color3.fromRGB(220, 225, 235) RefreshBtn.Font = Enum.Font.GothamSemibold RefreshBtn.TextSize = 12
local RBC = Instance.new("UICorner") RBC.CornerRadius = UDim.new(0, 6) RBC.Parent = RefreshBtn

local PlayerDropdownFrame = Instance.new("Frame")
PlayerDropdownFrame.Parent = Tab3 PlayerDropdownFrame.Size = UDim2.new(1, -6, 0, 90) PlayerDropdownFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
local PDFC = Instance.new("UICorner") PDFC.CornerRadius = UDim.new(0, 6) PDFC.Parent = PlayerDropdownFrame

local PlrListScroll = Instance.new("ScrollingFrame")
PlrListScroll.Parent = PlayerDropdownFrame PlrListScroll.Size = UDim2.new(1, 0, 1, 0) PlrListScroll.BackgroundTransparency = 1 PlrListScroll.ScrollBarThickness = 2
local PlrListLayout = Instance.new("UIListLayout") PlrListLayout.Parent = PlrListScroll PlrListLayout.SortOrder = Enum.SortOrder.LayoutOrder PlrListLayout.Padding = UDim.new(0, 2)

local function UpdatePlayerList()
    for _, c in pairs(PlrListScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local PBtn = Instance.new("TextButton")
            PBtn.Parent = PlrListScroll PBtn.Size = UDim2.new(1, -4, 0, 24) PBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")" PBtn.BackgroundColor3 = Color3.fromRGB(25, 28, 36) PBtn.TextColor3 = Color3.fromRGB(180, 185, 200) PBtn.Font = Enum.Font.Gotham PBtn.TextSize = 11
            PBtn.MouseButton1Click:Connect(function()
                SelectedPlayer = p
                Notify("Người Chơi", "Đã chọn: " .. p.DisplayName, 1.5)
            end)
        end
    end
end
RefreshBtn.MouseButton1Click:Connect(function() UpdatePlayerList() Notify("Danh Sách", "Đã cập nhật!", 1.5) end)
UpdatePlayerList()

local FlyToPlrBtn = Instance.new("TextButton")
FlyToPlrBtn.Parent = Tab3 FlyToPlrBtn.Size = UDim2.new(1, -6, 0, 32) FlyToPlrBtn.Text = "Bay Đến Người Chơi Đã Chọn" FlyToPlrBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230) FlyToPlrBtn.TextColor3 = Color3.fromRGB(255, 255, 255) FlyToPlrBtn.Font = Enum.Font.GothamBold FlyToPlrBtn.TextSize = 12
local FTPC = Instance.new("UICorner") FTPC.CornerRadius = UDim.new(0, 6) FTPC.Parent = FlyToPlrBtn

FlyToPlrBtn.MouseButton1Click:Connect(function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        FlyToPos(SelectedPlayer.Character.HumanoidRootPart.CFrame)
    else
        Notify("Lỗi", "Vui lòng chọn người chơi!", 1.5)
    end
end)
-- ====================================================
-- KIÊN PREMIUM - ULTIMATE ADVANCED EDITION (PART 3/3)
-- ====================================================

-- ----------------------------------------------------
-- TAB 4: CÀI ĐẶT & HỆ THỐNG LƯU / NẠP CONFIG HOÀN CHỈNH
-- ----------------------------------------------------

local WalkSpeedVal = 16
local JumpPowerVal = 50
local SpeedEnabled = false
local JumpEnabled = false

CreateToggle(Tab4, "Bật Tốc Độ Chạy Custom", "SpeedToggle", false, function(v)
    SpeedEnabled = v
    if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

CreateSlider(Tab4, "Tốc Độ Chạy (1 - 500)", 1, 500, 16, function(v) WalkSpeedVal = v end)

CreateToggle(Tab4, "Bật Nhảy Cao Custom", "JumpToggle", false, function(v)
    JumpEnabled = v
    if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

CreateSlider(Tab4, "Độ Nhảy Cao (1 - 500)", 1, 500, 50, function(v) JumpPowerVal = v end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if SpeedEnabled then LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeedVal end
        if JumpEnabled then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = JumpPowerVal
        end
    end
end)

-- KHUNG NẬP / LƯU CONFIG NÂNG CẤP
local ConfigNameBox = Instance.new("TextBox")
ConfigNameBox.Parent = Tab4
ConfigNameBox.Size = UDim2.new(1, -6, 0, 32)
ConfigNameBox.PlaceholderText = "Nhập tên Config vào đây..."
ConfigNameBox.Text = ""
ConfigNameBox.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
ConfigNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfigNameBox.Font = Enum.Font.Gotham
ConfigNameBox.TextSize = 12
local CNBC = Instance.new("UICorner") CNBC.CornerRadius = UDim.new(0, 6) CNBC.Parent = ConfigNameBox

local CreateCfgBtn = Instance.new("TextButton")
CreateCfgBtn.Parent = Tab4
CreateCfgBtn.Size = UDim2.new(1, -6, 0, 32)
CreateCfgBtn.Text = "Tạo Cấu Hình Mới (Create Config)"
CreateCfgBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230)
CreateCfgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CreateCfgBtn.Font = Enum.Font.GothamBold
CreateCfgBtn.TextSize = 12
local CCBC = Instance.new("UICorner") CCBC.CornerRadius = UDim.new(0, 6) CCBC.Parent = CreateCfgBtn

-- Quản lý File Config bằng readfile/writefile (Hỗ trợ Delta Executor)
local ConfigFolder = "KienPremium_Configs"
if isfolder and not isfolder(ConfigFolder) then
    pcall(function() makefolder(ConfigFolder) end)
end

CreateCfgBtn.MouseButton1Click:Connect(function()
    local name = ConfigNameBox.Text
    if name == "" then
        Notify("Config", "Vui lòng nhập tên config!", 1.5)
        return
    end
    local data = {
        WalkSpeed = WalkSpeedVal,
        JumpPower = JumpPowerVal,
        SpeedEnabled = SpeedEnabled,
        JumpEnabled = JumpEnabled
    }
    local fileName = ConfigFolder .. "/" .. name .. ".json"
    if writefile then
        writefile(fileName, HttpService:JSONEncode(data))
        Notify("Config", "Đã lưu Config: " .. name, 2)
    else
        Notify("Config", "Executor không hỗ trợ lưu File!", 2)
    end
end)

local LoadCfgBtn = Instance.new("TextButton")
LoadCfgBtn.Parent = Tab4
LoadCfgBtn.Size = UDim2.new(1, -6, 0, 32)
LoadCfgBtn.Text = "Nạp Cấu Hình Đã Chọn (Load Config)"
LoadCfgBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 80)
LoadCfgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadCfgBtn.Font = Enum.Font.GothamBold
LoadCfgBtn.TextSize = 12
local LCBC = Instance.new("UICorner") LCBC.CornerRadius = UDim.new(0, 6) LCBC.Parent = LoadCfgBtn

LoadCfgBtn.MouseButton1Click:Connect(function()
    local name = ConfigNameBox.Text
    local fileName = ConfigFolder .. "/" .. name .. ".json"
    if readfile and isfile and isfile(fileName) then
        local raw = readfile(fileName)
        local data = HttpService:JSONDecode(raw)
        if data then
            WalkSpeedVal = data.WalkSpeed or 16
            JumpPowerVal = data.JumpPower or 50
            if data.SpeedEnabled and ActiveToggles["SpeedToggle"] then ActiveToggles["SpeedToggle"](true, true) end
            if data.JumpEnabled and ActiveToggles["JumpToggle"] then ActiveToggles["JumpToggle"](true, true) end
            Notify("Config", "Đã bật Config: " .. name, 2)
        end
    else
        Notify("Config", "Không tìm thấy file Config này!", 2)
    end
end)


-- ----------------------------------------------------
-- TAB 5: ĐỔI SERVER & REJOIN
-- ----------------------------------------------------

local HopBtn = Instance.new("TextButton")
HopBtn.Parent = Tab5 HopBtn.Size = UDim2.new(1, -6, 0, 34) HopBtn.Text = "Tìm Server Ít Người (1 Người)" HopBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45) HopBtn.TextColor3 = Color3.fromRGB(220, 225, 235) HopBtn.Font = Enum.Font.GothamBold HopBtn.TextSize = 12
local HBC = Instance.new("UICorner") HBC.CornerRadius = UDim.new(0, 6) HBC.Parent = HopBtn

HopBtn.MouseButton1Click:Connect(function()
    Notify("Hop Server", "Đang tìm server...", 2)
    pcall(function()
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local data = HttpService:JSONDecode(req)
        for _, server in pairs(data.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                break
            end
        end
    end)
end)

local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Parent = Tab5 RejoinBtn.Size = UDim2.new(1, -6, 0, 34) RejoinBtn.Text = "Vào Lại Server Hiện Tại (Rejoin)" RejoinBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45) RejoinBtn.TextColor3 = Color3.fromRGB(220, 225, 235) RejoinBtn.Font = Enum.Font.GothamBold RejoinBtn.TextSize = 12
local RBC2 = Instance.new("UICorner") RBC2.CornerRadius = UDim.new(0, 6) RBC2.Parent = RejoinBtn

RejoinBtn.MouseButton1Click:Connect(function()
    Notify("Rejoin", "Đang tải lại game...", 2)
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)


-- ----------------------------------------------------
-- TAB 6: FIX LAG & KHÔI PHÚC NGUYÊN BẢN
-- ----------------------------------------------------

local OriginalLightingSettings = { GlobalShadows = Lighting.GlobalShadows, FogEnd = Lighting.FogEnd }
local OriginalPartMaterials = {}

local FixLagBtn = Instance.new("TextButton")
FixLagBtn.Parent = Tab6 FixLagBtn.Size = UDim2.new(1, -6, 0, 34) FixLagBtn.Text = "Tối Ưu Đồ Họa (Fix Lag)" FixLagBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230) FixLagBtn.TextColor3 = Color3.fromRGB(255, 255, 255) FixLagBtn.Font = Enum.Font.GothamBold FixLagBtn.TextSize = 12
local FBC = Instance.new("UICorner") FBC.CornerRadius = UDim.new(0, 6) FBC.Parent = FixLagBtn

FixLagBtn.MouseButton1Click:Connect(function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not OriginalPartMaterials[v] then
                OriginalPartMaterials[v] = { Material = v.Material, Reflectance = v.Reflectance }
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = false
            end
        end
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Notify("Fix Lag", "Đã bật chế độ siêu mượt!", 2)
    end)
end)

local RestoreBtn = Instance.new("TextButton")
RestoreBtn.Parent = Tab6 RestoreBtn.Size = UDim2.new(1, -6, 0, 34) RestoreBtn.Text = "Khôi Phục Đồ Họa Ban Đầu" RestoreBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45) RestoreBtn.TextColor3 = Color3.fromRGB(220, 225, 235) RestoreBtn.Font = Enum.Font.GothamBold RestoreBtn.TextSize = 12
local RBC3 = Instance.new("UICorner") RBC3.CornerRadius = UDim.new(0, 6) RBC3.Parent = RestoreBtn

RestoreBtn.MouseButton1Click:Connect(function()
    pcall(function()
        for part, props in pairs(OriginalPartMaterials) do
            if part and part.Parent then
                part.Material = props.Material
                part.Reflectance = props.Reflectance
            end
        end
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = true
            end
        end
        Lighting.GlobalShadows = OriginalLightingSettings.GlobalShadows
        Lighting.FogEnd = OriginalLightingSettings.FogEnd
        Notify("Khôi Phục", "Đã trả lại đồ họa ban đầu!", 2)
    end)
end)


-- ----------------------------------------------------
-- LOGIC XÓA MENU VĨNH VIỄN (DESTROY ALL & RESET ALL STATES)
-- ----------------------------------------------------
CloseBtn.MouseButton1Click:Connect(function()
    Notify("Kiên Premium", "Đang tắt tất cả tính năng và xóa Menu...", 2)

    -- Tắt toàn bộ tính năng đang bật để tránh bị lỗi Noclip/ESP/Speed ngầm
    for key, setFunc in pairs(ActiveToggles) do
        pcall(function() setFunc(false, true) end)
    end

    -- Đặt lại tốc độ nhân vật chuẩn
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            LocalPlayer.Character.Humanoid.JumpPower = 50
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end)

    task.wait(0.5)
    KienUI:Destroy() -- Xóa vĩnh viễn toàn bộ GUI & nút bấm
end)

Notify("KIÊN PREMIUM", "Đã khởi tạo thành công 100%!", 3)
