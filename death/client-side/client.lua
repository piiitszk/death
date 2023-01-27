local timer = rs["deathTimer"]
local dead = false
local playerCam

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local wait = 1000
        if GetEntityHealth(ped) <= rs["minHealth"] then
            dead = true

            if timer >= 0 then
                SendNUIMessage({ text = string.format(rs["deadText"],timer)})
                timer = timer - 1
            else
                wait = 5
                SendNUIMessage({ text = rs["returnText"] })

                if IsControlJustPressed(1, rs["buttonHash"]) then
                    DoScreenFadeOut(900)
                    Wait(1000)
                    resetTimer()
                    
                    if rs["advancedCam"]["use"] then
                        local camCFG = rs["advancedCam"]

                        local ped = PlayerPedId()
                        NetworkResurrectLocalPlayer(camCFG["INICIAL_CAM_COORDS"].coords,camCFG["INICIAL_CAM_COORDS"].heading, true, true, false)
                        SetEntityVisible(ped,false)
                        Wait(120)
                        deleteCams()
                        playerCam = CreateCamWithParams(camCFG["FINAL_CAM_COORDS"].cameraHash,camCFG["FINAL_CAM_COORDS"].posX,camCFG["FINAL_CAM_COORDS"].posY,camCFG["FINAL_CAM_COORDS"].posZ,camCFG["FINAL_CAM_COORDS"].rotX,camCFG["FINAL_CAM_COORDS"].rotY,camCFG["FINAL_CAM_COORDS"].rotZ,camCFG["FINAL_CAM_COORDS"].fov,false,0)
                        SetEntityVisible(ped,true)
                        SetEntityCoords(ped,camCFG["PLAYER_SPAWN_COORDS"].coords)
                        SetEntityHeading(ped,camCFG["PLAYER_SPAWN_COORDS"].heading)
                        SetCamActive(playerCam,true)
                        RenderScriptCams(true,true,3000,true,true)
                        DoScreenFadeIn(200)
                        Wait(6000)
                        DoScreenFadeOut(500)
                        Wait(600)
                        deleteCams()
                        DoScreenFadeIn(500)
                    else
                        Wait(800)
                        NetworkResurrectLocalPlayer(rs["spawn"].coords,rs["spawn"].heading,true, true, false)
                        DoScreenFadeIn(500)
                    end 
                end
            end
        elseif GetEntityHealth(ped) >= rs["minHealth"] and dead then
            resetTimer()
        end
        Citizen.Wait(wait)
    end
end)

function deleteCams()
    if DoesCamExist(playerCam) then
        RenderScriptCams(false,false,0,true,true)
        SetCamActive(playerCam,false)
        DestroyCam(playerCam,true)
        playerCam = nil
    end
end

function resetTimer()
    timer = rs["deathTimer"]
    dead = false
    SendNUIMessage({ action = "hide" })
end
