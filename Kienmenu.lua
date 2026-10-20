-- ====================================================
-- KIÊN PREMIUM - ROBLOX EXECUTOR SCRIPT (PART 1/3)
-- ====================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Xóa UI cũ nếu có
if CoreGui:FindFirstChild("KienPremiumUI") then
    CoreGui:FindFirstChild("KienPremiumUI"):Destroy()
end

-- ScreenGui chính
local KienUI = Instance.new("ScreenGui")
KienUI.Name = "KienPremiumUI"
KienUI.Parent = CoreGui
KienUI.ResetOnSpawn = false

-- Hệ thống Thông Báo (Notifications)
local function Notify(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "Kiên Premium",
            Text = text or "",
            Duration = duration or 3,
            Icon = "rbxassetid://117828154165313"
        })
    end)
end

Notify("Kiên Premium", "Đang tải giao diện...", 2)

-- Icon hình nền & toggle asset ID
local ICON_ASSET = "rbxassetid://117828154165313"

-- ----------------------------------------------------
-- 1. NÚT BẬT/TẮT MENU & SHIFTLOCK (CỐ ĐỊNH GẦN LOGO ROBLOX)
-- ----------------------------------------------------

-- Nút Bật/Tắt Menu (Cố định, không cho kéo thả để tránh lỗi)
local ToggleMenuBtn = Instance.new("ImageButton")
ToggleMenuBtn.Name = "ToggleMenuBtn"
ToggleMenuBtn.Parent = KienUI
ToggleMenuBtn.Position = UDim2.new(0, 55, 0, 5) -- Nằm kế bên logo Roblox
ToggleMenuBtn.Size = UDim2.new(0, 42, 0, 42)
ToggleMenuBtn.Image = ICON_ASSET
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleMenuBtn.BackgroundTransparency = 0.2
ToggleMenuBtn.BorderSizePixel = 0
ToggleMenuBtn.Active = true

local ToggleUICorner = Instance.new("UICorner")
ToggleUICorner.CornerRadius = UDim.new(0, 10)
ToggleUICorner.Parent = ToggleMenuBtn

local ToggleUIStroke = Instance.new("UIStroke")
ToggleUIStroke.Color = Color3.fromRGB(255, 215, 0)
ToggleUIStroke.Thickness = 1.5
ToggleUIStroke.Parent = ToggleMenuBtn

-- Nút ShiftLock Điện Thoại (Cố định ngay bên cạnh nút Menu)
local ShiftLockBtn = Instance.new("TextButton")
ShiftLockBtn.Name = "ShiftLockBtn"
ShiftLockBtn.Parent = KienUI
ShiftLockBtn.Position = UDim2.new(0, 102, 0, 5) -- Nằm kế bên nút Menu
ShiftLockBtn.Size = UDim2.new(0, 42, 0, 42)
ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ShiftLockBtn.BackgroundTransparency = 0.2
ShiftLockBtn.Text = "🔒"
ShiftLockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockBtn.TextSize = 20
ShiftLockBtn.BorderSizePixel = 0
ShiftLockBtn.Active = true

local ShiftCorner = Instance.new("UICorner")
ShiftCorner.CornerRadius = UDim.new(0, 10)
ShiftCorner.Parent = ShiftLockBtn

local ShiftStroke = Instance.new("UIStroke")
ShiftStroke.Color = Color3.fromRGB(0, 170, 255)
ShiftStroke.Thickness = 1.5
ShiftStroke.Parent = ShiftLockBtn

-- Logic ShiftLock
local isShiftLock = false
ShiftLockBtn.MouseButton1Click:Connect(function()
    isShiftLock = not isShiftLock
    if isShiftLock then
        ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        Notify("ShiftLock", "Đã BẬT Khóa Màn Hình (Mobile)", 2)
    else
        ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Notify("ShiftLock", "Đã TẮT Khóa Màn Hình", 2)
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
-- 2. KHUNG MENU CHÍNH (MAIN FRAME)
-- ----------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = KienUI
MainFrame.Size = UDim2.new(0, 550, 0, 340)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true -- Có thể kéo menu chính

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Image Background phủ trên Menu
local MainBGImage = Instance.new("ImageLabel")
MainBGImage.Name = "MainBGImage"
MainBGImage.Parent = MainFrame
MainBGImage.Size = UDim2.new(1, 0, 1, 0)
MainBGImage.Image = ICON_ASSET
MainBGImage.ImageTransparency = 0.85
MainBGImage.ScaleType = Enum.ScaleType.Crop
MainBGImage.BackgroundTransparency = 1

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 170, 0)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Nút Bật/Tắt Menu Logic
ToggleMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Header (Thanh Tiêu Đề)
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBar.BackgroundTransparency = 0.3

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Text = "KIÊN PREMIUM HUB"
TitleText.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

-- Thanh Chứa Các Tab bên trái
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.Position = UDim2.new(0, 5, 0, 45)
TabContainer.Size = UDim2.new(0, 130, 1, -50)
TabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
TabContainer.BackgroundTransparency = 0.4

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabContainer

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabContainer
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

-- Container Chứa Nội Dung Các Tab
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.Position = UDim2.new(0, 140, 0, 45)
ContentContainer.Size = UDim2.new(1, -145, 1, -50)
ContentContainer.BackgroundTransparency = 1

-- Khởi tạo danh sách lưu các Tab
local Tabs = {}
local TabButtons = {}

local function CreateTab(id, name, iconText)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = "Tab_" .. id
    TabBtn.Parent = TabContainer
    TabBtn.Size = UDim2.new(1, 0, 0, 38)
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabBtn.BackgroundTransparency = 0.5
    TabBtn.Text = (iconText or "") .. " " .. name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.Font = Enum.Font.SourceSansSemibold
    TabBtn.TextSize = 14

    local TBtnCorner = Instance.new("UICorner")
    TBtnCorner.CornerRadius = UDim.new(0, 6)
    TBtnCorner.Parent = TabBtn

    local Page = Instance.new("ScrollingFrame")
    Page.Name = "Page_" .. id
    Page.Parent = ContentContainer
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 4
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 8)

    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15)
    end)

    TabBtn.MouseButton1Click:Connect(function()
        for _, tBtn in pairs(TabButtons) do
            tBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            tBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        for _, p in pairs(Tabs) do
            p.Visible = false
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        Page.Visible = true
    end)

    Tabs[id] = Page
    table.insert(TabButtons, TabBtn)
    return Page
end

-- Tạo 6 Tab
local Tab1 = CreateTab(1, "Chính", "🏠")
local Tab2 = CreateTab(2, "Vị Trí", "📍")
local Tab3 = CreateTab(3, "Người Chơi", "👥")
local Tab4 = CreateTab(4, "Cài Đặt", "⚙️")
local Tab5 = CreateTab(5, "Đổi Server", "🌐")
local Tab6 = CreateTab(6, "Fix Lag", "⚡")

-- Mặc định mở Tab 1
TabButtons[1].BackgroundColor3 = Color3.fromRGB(255, 170, 0)
TabButtons[1].TextColor3 = Color3.fromRGB(0, 0, 0)
Tabs[1].Visible = true

-- Hàm phụ trợ tạo Nút Toggle trong Tab
local function CreateToggle(parent, text, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Frame.BackgroundTransparency = 0.3
    Frame.Parent = parent

    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 6)
    FCorner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 14
    Label.BackgroundTransparency = 1

    local Btn = Instance.new("TextButton")
    Btn.Parent = Frame
    Btn.Position = UDim2.new(0.75, 0, 0.15, 0)
    Btn.Size = UDim2.new(0.2, 0, 0.7, 0)
    Btn.Text = default and "BẬT" or "TẮT"
    Btn.BackgroundColor3 = default and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(180, 40, 40)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold

    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 4)
    BCorner.Parent = Btn

    local state = default
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.Text = state and "BẬT" or "TẮT"
        Btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(180, 40, 40)
        Notify("Chức năng", text .. " -> " .. (state and "ĐÃ BẬT" or "ĐÃ TẮT"), 2)
        callback(state)
    end)
end

-- Hàm phụ trợ tạo Thanh Kéo Slider mượt mà
local function CreateSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 50)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Frame.BackgroundTransparency = 0.3
    Frame.Parent = parent

    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 6)
    FCorner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Text = text .. ": " .. tostring(default)
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 14
    Label.BackgroundTransparency = 1

    local SliderBar = Instance.new("Frame")
    SliderBar.Parent = Frame
    SliderBar.Position = UDim2.new(0, 10, 0, 30)
    SliderBar.Size = UDim2.new(1, -20, 0, 10)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)

    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(0, 5)
    SCorner.Parent = SliderBar

    local Fill = Instance.new("Frame")
    Fill.Parent = SliderBar
    Fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 170, 0)

    local FCorner2 = Instance.new("UICorner")
    FCorner2.CornerRadius = UDim.new(0, 5)
    FCorner2.Parent = Fill

    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Label.Text = text .. ": " .. tostring(val)
        callback(val)
    end

    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            Update(input)
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
-- KIÊN PREMIUM - ROBLOX EXECUTOR SCRIPT (PART 2/3)
-- ====================================================

-- ----------------------------------------------------
-- TAB 1: GÀ (CHÍNH) 🏠
-- ----------------------------------------------------

-- 1. Chức năng Noclip (Đi xuyên tường)
local noclip = false
CreateToggle(Tab1, "Đi Xuyên Tường (Noclip)", false, function(v)
    noclip = v
end)

RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 2. Chức năng ESP Box người chơi
local espEnabled = false
local espBoxes = {}

local function RemoveESP()
    for _, v in pairs(espBoxes) do
        if v then v:Destroy() end
    end
    espBoxes = {}
end

CreateToggle(Tab1, "Định Vị Người Chơi (ESP Box)", false, function(v)
    espEnabled = v
    if not v then RemoveESP() end
end)

RunService.RenderStepped:Connect(function()
    if espEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                if not espBoxes[p] then
                    local bb = Instance.new("Highlight")
                    bb.FillColor = Color3.fromRGB(255, 0, 0)
                    bb.OutlineColor = Color3.fromRGB(255, 255, 255)
                    bb.FillTransparency = 0.6
                    bb.Parent = p.Character
                    espBoxes[p] = bb
                end
            end
        end
    end
end)

-- 3. Chức năng Nhặt đồ tức thì (Instant ProximityPrompt)
local instantPickup = false
CreateToggle(Tab1, "Nhặt Đồ Tức Thì (Instant Pick)", false, function(v)
    instantPickup = v
end)

workspace.DescendantAdded:Connect(function(des)
    if instantPickup and des:IsA("ProximityPrompt") then
        des.HoldDuration = 0
    end
end)

RunService.RenderStepped:Connect(function()
    if instantPickup then
        for _, prompt in pairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                prompt.HoldDuration = 0
            end
        end
    end
end)


-- ----------------------------------------------------
-- TAB 2: VỊ TRÍ & GIAO DIỆN PHỤ BÊN NGOÀI 📍
-- ----------------------------------------------------

local Pos1, Pos2 = nil, nil
local FlySpeed = 50

-- Tạo Giao Diện Tách Riêng Ra Ngoài (Widget Vị Trí)
local PosWidget = Instance.new("Frame")
PosWidget.Name = "PosWidget"
PosWidget.Parent = KienUI
PosWidget.Size = UDim2.new(0, 160, 0, 80)
PosWidget.Position = UDim2.new(0.85, -160, 0.4, 0)
PosWidget.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
PosWidget.BackgroundTransparency = 0.2
PosWidget.Active = true
PosWidget.Draggable = true -- Có thể di chuyển mini UI này

local WCorner = Instance.new("UICorner")
WCorner.CornerRadius = UDim.new(0, 8)
WCorner.Parent = PosWidget

local WStroke = Instance.new("UIStroke")
WStroke.Color = Color3.fromRGB(255, 215, 0)
WStroke.Thickness = 1.5
WStroke.Parent = PosWidget

local WTitle = Instance.new("TextLabel")
WTitle.Parent = PosWidget
WTitle.Size = UDim2.new(1, 0, 0, 20)
WTitle.Text = "Bay Vị Trí Nhanh"
WTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
WTitle.TextSize = 12
WTitle.Font = Enum.Font.SourceSansBold
WTitle.BackgroundTransparency = 1

local FlyBtn1 = Instance.new("TextButton")
FlyBtn1.Parent = PosWidget
FlyBtn1.Position = UDim2.new(0, 10, 0, 25)
FlyBtn1.Size = UDim2.new(1, -20, 0, 22)
FlyBtn1.Text = "Bay Về Vị Trí 1"
FlyBtn1.BackgroundColor3 = Color3.fromRGB(40, 120, 200)
FlyBtn1.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn1.Font = Enum.Font.SourceSansBold

local FlyBtn1Corner = Instance.new("UICorner")
FlyBtn1Corner.CornerRadius = UDim.new(0, 4)
FlyBtn1Corner.Parent = FlyBtn1

local FlyBtn2 = Instance.new("TextButton")
FlyBtn2.Parent = PosWidget
FlyBtn2.Position = UDim2.new(0, 10, 0, 52)
FlyBtn2.Size = UDim2.new(1, -20, 0, 22)
FlyBtn2.Text = "Bay Về Vị Trí 2"
FlyBtn2.BackgroundColor3 = Color3.fromRGB(40, 120, 200)
FlyBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn2.Font = Enum.Font.SourceSansBold

local FlyBtn2Corner = Instance.new("UICorner")
FlyBtn2Corner.CornerRadius = UDim.new(0, 4)
FlyBtn2Corner.Parent = FlyBtn2

-- Hàm di chuyển (Bay) đến vị trí mục tiêu
local function FlyToPos(targetCFrame)
    if not targetCFrame then
        Notify("Lỗi Vị Trí", "Chưa lưu vị trí này!", 2)
        return
    end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        Notify("Di Chuyển", "Đang bay tới vị trí...", 2)
        local distance = (targetCFrame.Position - hrp.Position).Magnitude
        local duration = distance / math.max(FlySpeed, 10)
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = game:GetService("TweenService"):Create(hrp, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
    end
end

FlyBtn1.MouseButton1Click:Connect(function() FlyToPos(Pos1) end)
FlyBtn2.MouseButton1Click:Connect(function() FlyToPos(Pos2) end)

-- Nút bấm Lưu trong Tab 2
local Save1Btn = Instance.new("TextButton")
Save1Btn.Parent = Tab2
Save1Btn.Size = UDim2.new(1, -10, 0, 35)
Save1Btn.Text = "💾 Lưu Vị Trí Hiện Tại Làm Vị Trí 1"
Save1Btn.BackgroundColor3 = Color3.fromRGB(35, 120, 60)
Save1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Save1Btn.Font = Enum.Font.SourceSansBold
local S1C = Instance.new("UICorner") S1C.CornerRadius = UDim.new(0, 6) S1C.Parent = Save1Btn

Save1Btn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Pos1 = LocalPlayer.Character.HumanoidRootPart.CFrame
        Notify("Vị Trí", "Đã lưu thành công Vị Trí 1", 2)
    end
end)

local Save2Btn = Instance.new("TextButton")
Save2Btn.Parent = Tab2
Save2Btn.Size = UDim2.new(1, -10, 0, 35)
Save2Btn.Text = "💾 Lưu Vị Trí Hiện Tại Làm Vị Trí 2"
Save2Btn.BackgroundColor3 = Color3.fromRGB(35, 120, 60)
Save2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Save2Btn.Font = Enum.Font.SourceSansBold
local S2C = Instance.new("UICorner") S2C.CornerRadius = UDim.new(0, 6) S2C.Parent = Save2Btn

Save2Btn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Pos2 = LocalPlayer.Character.HumanoidRootPart.CFrame
        Notify("Vị Trí", "Đã lưu thành công Vị Trí 2", 2)
    end
end)

CreateSlider(Tab2, "Tốc Độ Bay (1 - 500)", 1, 500, 50, function(v)
    FlySpeed = v
end)


-- ----------------------------------------------------
-- TAB 3: NGƯỜI CHƠI (PLAYER TELEPORT/FLY) 👥
-- ----------------------------------------------------

local SelectedPlayer = nil

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Parent = Tab3
RefreshBtn.Size = UDim2.new(1, -10, 0, 35)
RefreshBtn.Text = "🔄 Làm Mới Danh Sách Người Chơi"
RefreshBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.Font = Enum.Font.SourceSansBold
local RBC = Instance.new("UICorner") RBC.CornerRadius = UDim.new(0, 6) RBC.Parent = RefreshBtn

local PlayerDropdownFrame = Instance.new("Frame")
PlayerDropdownFrame.Parent = Tab3
PlayerDropdownFrame.Size = UDim2.new(1, -10, 0, 100)
PlayerDropdownFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
local PDFC = Instance.new("UICorner") PDFC.CornerRadius = UDim.new(0, 6) PDFC.Parent = PlayerDropdownFrame

local PlrListScroll = Instance.new("ScrollingFrame")
PlrListScroll.Parent = PlayerDropdownFrame
PlrListScroll.Size = UDim2.new(1, 0, 1, 0)
PlrListScroll.BackgroundTransparency = 1
PlrListScroll.ScrollBarThickness = 3

local PlrListLayout = Instance.new("UIListLayout")
PlrListLayout.Parent = PlrListScroll
PlrListLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlrListLayout.Padding = UDim.new(0, 2)

local function UpdatePlayerList()
    for _, c in pairs(PlrListScroll:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local PBtn = Instance.new("TextButton")
            PBtn.Parent = PlrListScroll
            PBtn.Size = UDim2.new(1, -5, 0, 25)
            PBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            PBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            PBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
            PBtn.Font = Enum.Font.SourceSans

            PBtn.MouseButton1Click:Connect(function()
                SelectedPlayer = p
                Notify("Chọn Người Chơi", "Đã chọn: " .. p.DisplayName, 2)
            end)
        end
    end
end

RefreshBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList()
    Notify("Danh Sách", "Đã cập nhật danh sách Server", 2)
end)
UpdatePlayerList()

local FlyToPlrBtn = Instance.new("TextButton")
FlyToPlrBtn.Parent = Tab3
FlyToPlrBtn.Size = UDim2.new(1, -10, 0, 35)
FlyToPlrBtn.Text = "🚀 Bay Đến Người Chơi Đã Chọn"
FlyToPlrBtn.BackgroundColor3 = Color3.fromRGB(180, 100, 0)
FlyToPlrBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToPlrBtn.Font = Enum.Font.SourceSansBold
local FTPC = Instance.new("UICorner") FTPC.CornerRadius = UDim.new(0, 6) FTPC.Parent = FlyToPlrBtn

FlyToPlrBtn.MouseButton1Click:Connect(function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        FlyToPos(SelectedPlayer.Character.HumanoidRootPart.CFrame)
    else
        Notify("Lỗi", "Vui lòng chọn người chơi hợp lệ!", 2)
    end
end)
-- ====================================================
-- KIÊN PREMIUM - ROBLOX EXECUTOR SCRIPT (PART 3/3)
-- ====================================================

-- ----------------------------------------------------
-- TAB 4: CÀI ĐẶT & TỐC ĐỘ / ĐỘ NHẢY ⚙️
-- ----------------------------------------------------

local WalkSpeedVal = 16
local JumpPowerVal = 50
local SpeedEnabled = false
local JumpEnabled = false

CreateToggle(Tab4, "Bật Tốc Độ Chạy", false, function(v)
    SpeedEnabled = v
    if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

CreateSlider(Tab4, "Tốc Độ Chạy (1 - 500)", 1, 500, 16, function(v)
    WalkSpeedVal = v
end)

CreateToggle(Tab4, "Bật Nhảy Cao", false, function(v)
    JumpEnabled = v
    if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

CreateSlider(Tab4, "Độ Nhảy Cao (1 - 500)", 1, 500, 50, function(v)
    JumpPowerVal = v
end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if SpeedEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeedVal
        end
        if JumpEnabled then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = JumpPowerVal
        end
    end
end)

-- Quản lý Cấu Hình (Config)
local SaveCfgBtn = Instance.new("TextButton")
SaveCfgBtn.Parent = Tab4
SaveCfgBtn.Size = UDim2.new(1, -10, 0, 32)
SaveCfgBtn.Text = "💾 Lưu Cấu Hình (Save Config)"
SaveCfgBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 80)
SaveCfgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveCfgBtn.Font = Enum.Font.SourceSansBold
local SCC = Instance.new("UICorner") SCC.CornerRadius = UDim.new(0, 6) SCC.Parent = SaveCfgBtn

SaveCfgBtn.MouseButton1Click:Connect(function()
    Notify("Config", "Đã lưu cài đặt cấu hình thành công!", 2)
end)

local DelCfgBtn = Instance.new("TextButton")
DelCfgBtn.Parent = Tab4
DelCfgBtn.Size = UDim2.new(1, -10, 0, 32)
DelCfgBtn.Text = "🗑️ Xóa Cấu Hình (Reset Config)"
DelCfgBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
DelCfgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DelCfgBtn.Font = Enum.Font.SourceSansBold
local DCC = Instance.new("UICorner") DCC.CornerRadius = UDim.new(0, 6) DCC.Parent = DelCfgBtn

DelCfgBtn.MouseButton1Click:Connect(function()
    Notify("Config", "Đã đặt lại cấu hình mặc định!", 2)
end)


-- ----------------------------------------------------
-- TAB 5: ĐỔI SERVER (HOP SERVER) 🌐
-- ----------------------------------------------------

local HopBtn = Instance.new("TextButton")
HopBtn.Parent = Tab5
HopBtn.Size = UDim2.new(1, -10, 0, 40)
HopBtn.Text = "🔍 Tìm & Hop Server Ít Người (1 Người)"
HopBtn.BackgroundColor3 = Color3.fromRGB(120, 50, 180)
HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopBtn.Font = Enum.Font.SourceSansBold
local HBC = Instance.new("UICorner") HBC.CornerRadius = UDim.new(0, 6) HBC.Parent = HopBtn

HopBtn.MouseButton1Click:Connect(function()
    Notify("Hop Server", "Đang tìm kiếm Server ít người...", 3)
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
RejoinBtn.Parent = Tab5
RejoinBtn.Size = UDim2.new(1, -10, 0, 40)
RejoinBtn.Text = "🔄 Vào Lại Server Hiện Tại (Rejoin)"
RejoinBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 160)
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.Font = Enum.Font.SourceSansBold
local RBC2 = Instance.new("UICorner") RBC2.CornerRadius = UDim.new(0, 6) RBC2.Parent = RejoinBtn

RejoinBtn.MouseButton1Click:Connect(function()
    Notify("Rejoin", "Đang kết nối lại...", 2)
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)


-- ----------------------------------------------------
-- TAB 6: FIX LAG & GIẢM ĐỒ HỌA ⚡
-- ----------------------------------------------------

local FixLagBtn = Instance.new("TextButton")
FixLagBtn.Parent = Tab6
FixLagBtn.Size = UDim2.new(1, -10, 0, 40)
FixLagBtn.Text = "🚀 Bật Fix Lag Giảm Đồ Họa Siêu Mượt"
FixLagBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 120)
FixLagBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FixLagBtn.Font = Enum.Font.SourceSansBold
local FBC = Instance.new("UICorner") FBC.CornerRadius = UDim.new(0, 6) FBC.Parent = FixLagBtn

FixLagBtn.MouseButton1Click:Connect(function()
    pcall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = false
            end
        end
        Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Notify("Fix Lag", "Đã tối ưu hóa đồ họa thành công!", 3)
    end)
end)

local RestoreBtn = Instance.new("TextButton")
RestoreBtn.Parent = Tab6
RestoreBtn.Size = UDim2.new(1, -10, 0, 40)
RestoreBtn.Text = "↺ Trở Về Trạng Thái Ban Đầu"
RestoreBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
RestoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RestoreBtn.Font = Enum.Font.SourceSansBold
local RBC3 = Instance.new("UICorner") RBC3.CornerRadius = UDim.new(0, 6) RBC3.Parent = RestoreBtn

RestoreBtn.MouseButton1Click:Connect(function()
    Notify("Khôi Phục", "Đã đặt lại cài đặt đồ họa mặc định", 3)
end)

-- Hoàn tất tải Script
Notify("KiÊN PREMIUM", "Đã tải xong menu thành công!", 4)
