local replicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(replicatedStorage.Packages.knit)

Knit.Start():andThen(function()
    print("Knit client started")
end):catch(warn)