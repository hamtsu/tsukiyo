local Knit = require(game:GetService("ReplicatedStorage").Packages.knit)

local InputController
local AnimationController

local MovementController = Knit.CreateController { Name = "MovementController" }

------ PRIVATE METHODS ------

local function onMoveDirectionChange()
    local moveDirection = InputController.moveDirection

    if moveDirection == "FORWARD" then
        AnimationController:Play("FemWalking")
        AnimationController:ListCurrentAnimations()
    elseif moveDirection == "BACKWARD" then
        print("Moving backward")
    elseif moveDirection == "LEFT" then
        print("Moving left")
    elseif moveDirection == "RIGHT" then
        print("Moving right")
    end
end

------ LIFECYCLE METHODS ------

function MovementController:KnitInit()
    print("MovementController initialized")
end

function MovementController:KnitStart()
    -- Import other controllers
    InputController = Knit.GetController("InputController")
	AnimationController = Knit.GetController("AnimationController")

    InputController.moveDirectionChanged:Connect(onMoveDirectionChange)
    print("MovementController started")
end

return MovementController