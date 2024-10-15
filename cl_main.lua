local QBCore = exports['qb-core']:GetCoreObject()

local headMask = false
local handcuffed = false
local baggedPlayer

RegisterNetEvent('fd_headbag:RemoveHeadBag', function(player)
    DeleteEntity(Object)
    SetEntityAsNoLongerNeeded(Object)
    SendNUIMessage({
        ["action"] = "remove"
    })
    headMask = false;
end)

RegisterNetEvent("fd_headbag:StartThread", function(player)
    local ped = PlayerPedId()
    local handsup = exports["rpemotes"]:IsPlayerInHandsUp(ped)
    local handcuffed = QBCore.Functions.GetPlayerData().metadata.ishandcuffed
    if handsup or handcuffed then
        Object = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
        AttachEntityToEntity(Object, ped, GetPedBoneIndex(ped, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
        SetEntityCompletelyDisableCollision(Object, false, true)
        SendNUIMessage({
            ["action"] = "open"
        })
        headMask = true;
    end
end)

AddEventHandler("playerSpawned", function()
    DeleteEntity(Object);
    SetEntityAsNoLongerNeeded(Object)
    headMask = false;
end)

RegisterNetEvent("fd_headbag:CheckThread", function()
    local closestPlayer = lib.getClosestPlayer(GetEntityCoords(PlayerPedId()), 1, false)
    if GetPlayerServerId(closestPlayer) ~= 0 then
        local handsup = IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "random@mugging3", "handsup_standing_base", 1)
        QBCore.Functions.TriggerCallback("fd_headbag:server:GetCuffState", function(handcuffed)
            if handcuffed ~= nil then
                if not headMask then
                    if handsup or handcuffed then
                        exports['rpemotes']:EmoteCommandStart("argue2", 0)
                        Wait(500)
                        TriggerServerEvent("fd_headbag:serverAdd", GetPlayerServerId(closestPlayer))
                        exports['rpemotes']:EmoteCancel(true)
                        headMask = true
                        baggedPlayer = GetPlayerServerId(closestPlayer)
                    else
                        TriggerEvent("QBCore:Notify", Locales[Config.lang].nohandsup, "error")
                    end
                else
                    local closestPlayerRemove = lib.getClosestPlayer(GetEntityCoords(PlayerPedId()), 1, false)
                    if GetPlayerServerId(closestPlayerRemove) == baggedPlayer then
                        exports['rpemotes']:EmoteCommandStart("damn2", 0)
                        Wait(500)
                        TriggerServerEvent("fd_headbag:serverRemove", baggedPlayer)
                        Wait(500)
                        exports['rpemotes']:EmoteCancel(true)
                        headMask = false
                    else
                        TriggerEvent("QBCore:Notify", Locales[Config.lang].nobag, "error")
                    end
                end
            end
        end, GetPlayerServerId(closestPlayer))
    else
        TriggerEvent("QBCore:Notify", Locales[Config.lang].noonenearby, "error")
    end
end)