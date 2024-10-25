local Knit = require(game:GetService("ReplicatedStorage").Packages.knit)

local InputController
local AnimationController

local MovementController = Knit.CreateController { Name = "MovementController" }

------ PRIVATE METHODS ------

local function onMoveDirectionChange()
    local moveDirection = InputController.moveDirection

    if moveDirection == "FORWARD" then
        AnimationController:Play("FemWalk")
        AnimationController:ListCurrentAnimations()
    elseif moveDirection == "BACKWARD" then
        AnimationController:Play("FemWalk", true)
    elseif moveDirection == "LEFT" then
        AnimationController:Play("FemWalkLeft")
    elseif moveDirection == "RIGHT" then
        AnimationController:Play("FemWalkRight")
    end
end

local function onMovementStopped(lastMoveDirection)
    if lastMoveDirection == "FORWARD" then
        AnimationController:Stop("FemWalk")
    elseif lastMoveDirection == "LEFT" then
        AnimationController:Stop("FemWalkLeft")
    elseif lastMoveDirection == "RIGHT" then
        AnimationController:Stop("FemWalkRight")
    elseif lastMoveDirection == "BACKWARD" then
        AnimationController:Stop("FemWalk")
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
    InputController.movementStopped:Connect(onMovementStopped)

    AnimationController:Play("FemIdle")
    print("MovementController started")
end

return MovementController