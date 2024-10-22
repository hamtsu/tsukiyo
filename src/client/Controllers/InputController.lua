local UserInputService = game:GetService("UserInputService")
local Knit = require(game:GetService("ReplicatedStorage").Packages.knit)
local Signal = require(game:GetService("ReplicatedStorage").Packages.Signal)

local InputController = Knit.CreateController { Name = "InputController" }

------ CONTROLLER VARIABLES ------

InputController.inputType = "KEYBOARD" -- KEYBOARD, GAMEPAD
InputController.moveDirection = nil -- FORWARD, BACKWARD, LEFT, RIGHT, FORWARD_LEFT, FORWARD_RIGHT, BACKWARD_LEFT, BACKWARD_RIGHT
InputController.moveDirectionChanged = Signal.new()

------ PRIVATE METHODS ------

local function onInputBegan(input, _gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        InputController.inputType = "KEYBOARD"

        -- MOVEMENT
        if input.KeyCode == Enum.KeyCode.W then
            InputController.moveDirection = "FORWARD"
            InputController.moveDirectionChanged:Fire()
        elseif input.KeyCode == Enum.KeyCode.A then
            InputController.moveDirection = "LEFT"
            InputController.moveDirectionChanged:Fire()
        elseif input.KeyCode == Enum.KeyCode.S then
            InputController.moveDirection = "BACKWARD"
            InputController.moveDirectionChanged:Fire()
        elseif input.KeyCode == Enum.KeyCode.D then
            InputController.moveDirection = "RIGHT"
            InputController.moveDirectionChanged:Fire()
        end
    end
end

-- Controller inputs
local function onInputChanged(input, _gameProcessed)
    if input.UserInputType == Enum.UserInputType.Gamepad1 then
        InputController.inputType = "GAMEPAD"

        -- MOVEMENT
        if input.KeyCode == Enum.KeyCode.Thumbstick1 then
            if input.Position.X > 0.1 then
                if input.Position.Y > 0.3 then
                    InputController.moveDirection = "FORWARD_RIGHT"
                elseif input.Position.Y < -0.3 then
                    InputController.moveDirection = "BACKWARD_RIGHT"
                else
                    InputController.moveDirection = "RIGHT"
                end
            elseif input.Position.X < -0.1 then
                if input.Position.Y > 0.3 then
                    InputController.moveDirection = "FORWARD_LEFT"
                elseif input.Position.Y < -0.3 then
                    InputController.moveDirection = "BACKWARD_LEFT"
                else
                    InputController.moveDirection = "LEFT"
                end
            else
                if input.Position.Y > 0.1 then
                    InputController.moveDirection = "FORWARD"
                elseif input.Position.Y < -0.1 then
                    InputController.moveDirection = "BACKWARD"
                else
                    InputController.moveDirection = nil
                end
            end
        end

        print(InputController.moveDirection)
    end
end

------ LIFECYCLE METHODS ------

function InputController:KnitInit()
    UserInputService.InputBegan:Connect(onInputBegan)
    UserInputService.InputChanged:Connect(onInputChanged)
    print("InputController initialized")
end

function InputController:KnitStart()
    print("InputController started")
end

return InputController