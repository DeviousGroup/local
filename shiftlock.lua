local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

game:GetService("StarterGui"):SetCore("SendNotification", {
Title = "DeviousGroup",
Text = "Shiftlock loaded.",
Icon = "rbxthumb://type=Asset&id=109407088220871&w=150&h=150",
Duration = 8
})

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local enabled = false

local shiftlockOnImage = "rbxassetid://123024195021150"
local shiftlockOffImage = "rbxassetid://93785956143278"

local function getChar()
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
return character, root, humanoid
end

local character, root, humanoid = getChar()

player.CharacterAdded:Connect(function()
character, root, humanoid = getChar()

if enabled then  
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter  
    UserInputService.MouseIconEnabled = false  
    humanoid.CameraOffset = Vector3.new(1.75, 0, 0)  
    humanoid.AutoRotate = false  
else  
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default  
    UserInputService.MouseIconEnabled = true  
    humanoid.CameraOffset = Vector3.new(0, 0, 0)  
    humanoid.AutoRotate = true  
end

end)

local function createUI()
local gui = Instance.new("ScreenGui")
gui.Name = "ShiftlockGui"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("ImageButton")  
button.BorderSizePixel = 0  
button.BackgroundTransparency = 1  
button.AutoButtonColor = false  
button.Size = UDim2.new(0.06612, 0, 0.15894, 0)  
button.Position = UDim2.new(0.7989, 0, 0.78808, 0)  
button.Image = shiftlockOffImage  
button.Parent = gui  

button.MouseButton1Click:Connect(function()  
    enabled = not enabled  

    if enabled then  
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter  
        UserInputService.MouseIconEnabled = false  
        button.Image = shiftlockOnImage  
        humanoid.CameraOffset = Vector3.new(1.75, 0, 0)  
        humanoid.AutoRotate = false  
    else  
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default  
        UserInputService.MouseIconEnabled = true  
        button.Image = shiftlockOffImage  
        humanoid.CameraOffset = Vector3.new(0, 0, 0)  
        humanoid.AutoRotate = true  
    end  
end)

end

if UserInputService.TouchEnabled then
createUI()
end

RunService.RenderStepped:Connect(function()
if not enabled then return end
if not character or not root or not humanoid then return end

local look = camera.CFrame.LookVector  
local flat = Vector3.new(look.X, 0, look.Z)  

if flat.Magnitude > 0 then  
    root.CFrame = CFrame.lookAt(root.Position, root.Position + flat.Unit)  
end

end)
