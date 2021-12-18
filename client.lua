-- ESX Implementation


ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- UI Initialization
local displayui = false


-- Main functionality
Citizen.CreateThread(function()

    local ped = PlayerPedId()

    while true do
        local pedCoords = GetEntityCoords(ped)

        for k,v in pairs(Config.CityGuideLocations) do
            local markerCoords = vector3(v.x, v.y, v.z)
            local dist = #(pedCoords - markerCoords)
            if dist < 5 then
                
                -- 3D TEXT + Marker
                Draw3DText(markerCoords.x, markerCoords.y, markerCoords.z + 0.7, 0.3, 'Press E to open the City Guide!')
                DrawMarker(Config.Marker.type, markerCoords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 1.0, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, true, 2, Config.Marker.rotate, false, false, false)
                
                if IsControlJustReleased(0, 38) then

                    -- Opens UI
                    SetDisplay(not displayui)

                end

            end


        end

        Citizen.Wait(1)

    end

end)

-- Disable common Controls while ui is open
Citizen.CreateThread(function()

    while displayui do
        Citizen.Wait(0)
        DisableControlAction(0,1,displayui)
        DisableControlAction(0,2,displayui)
        DisableControlAction(0,142, displayui)
        DisableControlAction(0,18,displayui)
        DisableControlAction(0, 322,displayui)
        DisableControlAction(0,106,displayui)
    end
end)

-- SetDisplay function
function SetDisplay(bool)

    displayui = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({

        type="ui",
        status = bool

    })

end

-- Callbacks for functions in the ui

RegisterNUICallback("cardealerbtn", function()
    SetDisplay(not displayui)
    SetNewWaypoint(Config.Cardealer.x, Config.Cardealer.y)

    if Config.UseCustomNotify then

        print('CURRENTLY It doesnt work. contact Zykem#9999 for support')

    else

        TriggerEvent('z-cityguide:notify', 'You have set the Waypoint to the Cardealer')

    end
    
end)

RegisterNUICallback("drivingschoolbtn", function()
    SetDisplay(not displayui)
    SetNewWaypoint(Config.Drivingschool.x, Config.Drivingschool.y)

    if Config.UseCustomNotify then

        print('CURRENTLY It doesnt work. visit github.com/Zykem for the latest Updates of the Script.')

    else

        TriggerEvent('z-cityguide:notify', 'You have set the Waypoint to the Driving School')

    end
    
end)

RegisterNUICallback("hospitalbtn", function()
    SetDisplay(not displayui)
    SetNewWaypoint(Config.Hospital.x, Config.Hospital.y)

    if Config.UseCustomNotify then

        print('CURRENTLY It doesnt work. visit github.com/Zykem for the latest Updates of the Script.')

    else
        TriggerEvent('z-cityguide:notify', 'You have set the Waypoint to the Hospital')

    end
    
end)

RegisterNUICallback("policebtn", function()
    SetDisplay(not displayui)
    SetNewWaypoint(Config.Police.x, Config.Police.y)

    if Config.UseCustomNotify then

        print('CURRENTLY It doesnt work. visit github.com/Zykem for the latest Updates of the Script.')

    else
        TriggerEvent('z-cityguide:notify', 'You have set the Waypoint to the Police Station')

    end
    
end)

RegisterNUICallback("rentbikebtn", function()
    SetDisplay(not displayui)
    local bike = KeyboardInput("Choose a bike! Available bicycles: bmx, scorcher", "", 20)

    if bike == 'bmx' then

        print('Spawned BMX')
        spawnBike('bmx')
        if Config.UseCustomNotify then

            print('CURRENTLY It doesnt work. visit github.com/Zykem for the latest Updates of the Script.')
    
        else
            TriggerEvent('z-cityguide:notify', 'You rented a Bicycle!')
    
        end
    elseif bike == 'scorcher' then

        print('Spawned SCORCHER')
        spawnBike('scorcher')
        if Config.UseCustomNotify then

            print('CURRENTLY It doesnt work. visit github.com/Zykem for the latest Updates of the Script.')
    
        else
            TriggerEvent('z-cityguide:notify', 'You rented a Bicycle!')
    
        end
    else 

        TriggerEvent('z-cityguide:notify', 'You entered a wrong vehicle Model.')

    end


    
    
end)

RegisterNUICallback("job1", function()

    SetDisplay(not displayui)
    SetNewWaypoint(Config.Job1.x, Config.Job1.y)

    if Config.UseCustomNotify then

        print('Currently not working. Visit github.com/Zykem for updates')
    
    else

        TriggerEvent('z-cityguide:notify', 'You have set the Waypoint to the Job')

    end

end)

RegisterNUICallback("job2", function()

    SetDisplay(not displayui)
    SetNewWaypoint(Config.Job2.x, Config.Job2.y)

    if Config.UseCustomNotify then

        print('Currently not working. Visit github.com/Zykem for updates')
    
    else

        TriggerEvent('z-cityguide:notify', 'You have set the Waypoint to the Job')

    end

end)

RegisterNUICallback("job3", function()

    SetDisplay(not displayui)
    SetNewWaypoint(Config.Job3.x, Config.Job3.y)

    if Config.UseCustomNotify then

        print('Currently not working. Visit github.com/Zykem for updates')
    
    else

        TriggerEvent('z-cityguide:notify', 'You have set the Waypoint to the Job')

    end

end)

-- Error callback if something bad happens
RegisterNUICallback("error", function(data)

    print('SOMETHING BAD HAPPENED!')
    SetDisplay(false)

end)


-- Exit callback to call it 
RegisterNUICallback("exit", function(data)

    print('Exitted UI')
    SetDisplay(not displayui)

end)

-- function for spawning bicycles
function spawnBike(model) 

    local x,y,z = GetEntityCoords(PlayerPedId())
    local veh = model
    if veh == nil then print('Model not found') end
    vehicleHash = GetHashKey(veh)
    RequestModel(vehicleHash)

    local wait = 0
    while not HasModelLoaded(vehicleHash) do

        wait = wait + 100
        Wait(100)
        if wait > 3000 then

            TriggerEvent('z-cityguide:notify', 'Could not load the vehicle model! Crash was prevented.')
            break

        end

    end
    local vehicleCreated = CreateVehicle(vehicleHash, x,y,z, GetEntityHeading(PlayerPedId())+90, 1, 0)
    SetPedIntoVehicle(PlayerPedId(), vehicleCreated, -1)

end

-- Event for default fivem notification (native)
RegisterNetEvent('z-cityguide:notify')
AddEventHandler('z-cityguide:notify', function(msg)

    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)

end)

-- function for Keyboard Input (bike-rent)
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end

-- Function for 3D Text above the Marker
function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end