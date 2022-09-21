ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local PlayerData              = {}
local isShopOpen = false   

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	for k,v in pairs(RNL.Zones) do
		for i = 1, #v.Pos, 1 do
			local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
			SetBlipSprite (blip, 52)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.5)
			SetBlipColour (blip, 2)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Supermarkt')
			EndTextCommandSetBlipName(blip)
		end
	end
end)

AddEventHandler('nv-winkels:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = 'Druk op ~INPUT_CONTEXT~ Om de Winkel te openen.'
	CurrentActionData = {zone = zone}
end)

AddEventHandler('nv-winkels:hasExitedMarker', function(zone)
    isShopOpen = false
    SetDisplay(false)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(4)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local inRange = false

		for k,v in pairs(RNL.Zones) do
			for i = 1, #v.Pos, 1 do
				if(2 ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) then
					DrawMarker(2, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 0.7, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.2, 0.15, 240, 132, 74, 255, false, true, 2, false, false, false, false)
					inRange = true
				end
			end
		end
		if not inRange then Citizen.Wait(1000) end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil
		local inRange = false

		for k,v in pairs(RNL.Zones) do
			for i = 1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < RNL.Size.x) then
					isInMarker  = true
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k
					inRange = true
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			inRange = true
			TriggerEvent('nv-winkels:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			inRange = false
			TriggerEvent('nv-winkels:hasExitedMarker', LastZone)
		end
		if not inRange then Citizen.Wait(1000) end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, 38) then

				if CurrentAction == 'shop_menu' then
                    isShopOpen = true
                    SetDisplay(not display)
				end

				CurrentAction = nil
			elseif IsControlJustReleased (0, 44) then
				ESX.SetTimeout(200, function()
					SetNuiFocus(false, false)
				end)	
			end
		end
	end
end)

RegisterNUICallback("exit", function(data)
    isShopOpen = false
    SetDisplay(false)
end)

RegisterNUICallback("main", function(data)
    chat(data.text, {0,255,0})
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end


RegisterNUICallback("brood", function(data)
    TriggerServerEvent("nv-winkels:brood")
end)

RegisterNUICallback("water", function(data)
    TriggerServerEvent("nv-winkels:water")
end)

RegisterNUICallback("telefoon", function(data)
    TriggerServerEvent("nv-winkels:telefoon")
end)

RegisterNUICallback("hengel", function(data)
    TriggerServerEvent("nv-winkels:hengel")
end)

RegisterNUICallback("schroevendraaier", function(data)
    TriggerServerEvent("nv-winkels:schroevendraaier")
end)

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)

        DisableControlAction(0, 1, display) 
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display) 
        DisableControlAction(0, 18, display) 
        DisableControlAction(0, 322, display) 
        DisableControlAction(0, 106, display) 
    end
end)
