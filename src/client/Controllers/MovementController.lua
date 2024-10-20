local UserInputService = game:GetService("UserInputService")
local Knit = require(game:GetService("ReplicatedStorage").Packages.knit)

local MovementController = Knit.CreateController { Name = "MovementController" }

MovementController.inputType = "KEYBOARD" -- KEYBOARD, GAMEPAD
MovementController.moveDirection = nil -- FORWARD, BACKWARD, LEFT, RIGHT, FORWARD_LEFT, FORWARD_RIGHT, BACKWARD_LEFT, BACKWARD_RIGHT

local function onInputBegan(input, _gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        MovementController.inputType = "KEYBOARD"

        if input.KeyCode == Enum.KeyCode.W then
            MovementController.moveDirection = "FORWARD"
        elseif input.KeyCode == Enum.KeyCode.A then
            MovementController.moveDirection = "LEFT"
        elseif input.KeyCode == Enum.KeyCode.S then
            MovementController.moveDirection = "BACKWARD"
        elseif input.KeyCode == Enum.KeyCode.D then
            MovementController.moveDirection = "RIGHT"
        end
    end
end

local function onInputChanged(input, _gameProcessed)
    if input.UserInputType == Enum.UserInputType.Gamepad1 then
        MovementController.inputType = "GAMEPAD"

        if input.KeyCode == Enum.KeyCode.Thumbstick1 then
            if input.Position.X > 0.1 then
                if input.Position.Y > 0.3 then
                    MovementController.moveDirection = "FORWARD_RIGHT"
                elseif input.Position.Y < -0.3 then
                    MovementController.moveDirection = "BACKWARD_RIGHT"
                else
                    MovementController.moveDirection = "RIGHT"
                end
            elseif input.Position.X < -0.1 then
                if input.Position.Y > 0.3 then
                    MovementController.moveDirection = "FORWARD_LEFT"
                elseif input.Position.Y < -0.3 then
                    MovementController.moveDirection = "BACKWARD_LEFT"
                else
                    MovementController.moveDirection = "LEFT"
                end
            else
                if input.Position.Y > 0.1 then
                    MovementController.moveDirection = "FORWARD"
                elseif input.Position.Y < -0.1 then
                    MovementController.moveDirection = "BACKWARD"
                else
                    MovementController.moveDirection = nil
                end
            end
        end

        print(MovementController.moveDirection)
    end
end

function MovementController:KnitInit()
    UserInputService.InputBegan:Connect(onInputBegan)
    UserInputService.InputChanged:Connect(onInputChanged)
    print("MovementController initialized")
end

function MovementController:KnitStart()
    print("MovementController started")
end

return MovementController