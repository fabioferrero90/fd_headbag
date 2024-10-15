local QBCore = nil
local ESX = nil

CreateThread(function()
    if Config.framework == "qb" then
        QBCore = exports['qb-core']:GetCoreObject()

        QBCore.Functions.CreateUseableItem(Config.itemname, function(source)
            TriggerClientEvent("fd_headbag:CheckThread", source)
        end)

        -- Callback to check if player is cuffed or not 
        lib.callback.register('fd_headbag:server:GetCuffState', function(source, id)
            local player = QBCore.Functions.GetPlayer(id)
            if player then
                local handcuffed = player.PlayerData.metadata.ishandcuffed
                return handcuffed
            end
            return nil
        end)
    elseif Config.framework == "esx" then
        ESX = exports["es_extended"]:getSharedObject()

        ESX.RegisterUsableItem(Config.itemname, function(source)
            TriggerClientEvent("fd_headbag:CheckThread", source)
        end)

        -- Callback to check if player is cuffed or not 
        lib.callback.register('fd_headbag:server:GetCuffState', function(source, id)
            -- WORK IN PROGRESS
            return true
        end)


    elseif Config.framework == "standalone" then
        RegisterCommand(Config.command.commandname, function()
            TriggerClientEvent("fd_headbag:CheckThread", source)
        end)

        -- Callback to check if player is cuffed or not 
        lib.callback.register('fd_headbag:server:GetCuffState', function(source, id)
            -- Need to do some check (maybe anim playing?)
            return true
        end)
    end
    if Config.command.enabled and not Config.framework == "standalone" then
        RegisterCommand(Config.command.commandname, function()
            TriggerClientEvent("fd_headbag:CheckThread", source)
        end)
    end
end)

RegisterNetEvent("fd_headbag:serverAdd", function(closestPlayer)
    TriggerClientEvent("fd_headbag:StartThread", closestPlayer)
end)

RegisterNetEvent("fd_headbag:serverRemove", function(BaggedPlayer)
    TriggerClientEvent("fd_headbag:RemoveHeadBag", BaggedPlayer)
end)