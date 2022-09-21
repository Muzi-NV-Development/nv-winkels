ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("nv-winkels:brood")
AddEventHandler("nv-winkels:brood", function()
local source = source
local xPlayer = ESX.GetPlayerFromId(source)
local money = xPlayer.getMoney()

if(xPlayer.getMoney() >= 5) then
    xPlayer.removeMoney(5)
    xPlayer.addInventoryItem("bread", 1)    
    TriggerClientEvent("notify:sendnotify", source, {
        ['type'] = "success",
        ['message'] = "Je hebt een Broodje gekocht voor: €5,-"
    })
    sendtoDiscord("**Koper:** " .. GetPlayerName(source) .. "\n**Item:** Brood \n **Bedrag:** 5 Euro")
else
    TriggerClientEvent("notify:sendnotify", source, {
        ['type'] = "error",
        ['message'] = "Je hebt niet genoeg geld..."
    })
end
end)

RegisterServerEvent('nv-winkels:water')
AddEventHandler('nv-winkels:water', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()

    if(xPlayer.getMoney() >= 3) then
        xPlayer.removeMoney(3)
        xPlayer.addInventoryItem("water", 1)    
        TriggerClientEvent("notify:sendnotify", source, {
            ['type'] = "success",
            ['message'] = "Je hebt een Flesje Water gekocht voor: €3,-"
        })
        sendtoDiscord("**Koper:** " .. GetPlayerName(source) .. "\n**Item:** Water \n **Bedrag:** 3 Euro")
    else
        TriggerClientEvent("notify:sendnotify", source, {
            ['type'] = "error",
            ['message'] = "Je hebt niet genoeg geld..."
        })
    end
end)

RegisterServerEvent('nv-winkels:telefoon')
AddEventHandler('nv-winkels:telefoon', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()

    if(xPlayer.getMoney() >= 500) then
        xPlayer.removeMoney(500)
        xPlayer.addInventoryItem("telefoon", 1)    
        TriggerClientEvent("notify:sendnotify", source, {
            ['type'] = "success",
            ['message'] = "Je hebt een Telefoon gekocht voor: €500,-"
        })
        sendtoDiscord("**Koper:** " .. GetPlayerName(source) .. "\n**Item:** Telefoon \n **Bedrag:** 500 Euro")
    else
        TriggerClientEvent("notify:sendnotify", source, {
            ['type'] = "error",
            ['message'] = "Je hebt niet genoeg geld..."
        })
    end
end)

RegisterServerEvent('nv-winkels:hengel')
AddEventHandler('nv-winkels:hengel', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()

    if(xPlayer.getMoney() >= 90) then
        xPlayer.removeMoney(90)
        xPlayer.addInventoryItem("hengel", 1)    
        TriggerClientEvent("notify:sendnotify", source, {
            ['type'] = "success",
            ['message'] = "Je hebt een Hengel gekocht voor: €90,-"
        })
        sendtoDiscord("**Koper:** " .. GetPlayerName(source) .. "\n**Item:** Hengel \n **Bedrag:** 90 Euro")
    else
        TriggerClientEvent("notify:sendnotify", source, {
            ['type'] = "error",
            ['message'] = "Je hebt niet genoeg geld..."
        })
    end
end)

RegisterServerEvent('nv-winkels:schroevendraaier')
AddEventHandler('nv-winkels:schroevendraaier', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()

    if(xPlayer.getMoney() >= 310) then
        xPlayer.removeMoney(310)
        xPlayer.addInventoryItem("schroevendraaier", 1)    
        TriggerClientEvent("notify:sendnotify", source, {
            ['type'] = "success",
            ['message'] = "Je hebt een Schroevendraaier gekocht voor: €310,-"
        })
        sendtoDiscord("**Koper:** " .. GetPlayerName(source) .. "\n**Item:** Schroevendraaier \n **Bedrag:** 310 Euro")
    else
        TriggerClientEvent("notify:sendnotify", source, {
            ['type'] = "error",
            ['message'] = "Je hebt niet genoeg geld..."
        })
    end
end)

function sendtoDiscord(message)
    local WebHook = "Link"

    local discordInfo = {
        ["color"] = "3447003",
        ["type"] = "rich",
        ["title"] = "[NV  Development Logging]",
        ["description"] = message,
        ["footer"] = {
        ["text"] = "NV  Development Winkel Logs"
        }
    }
    PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'SolarRP', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end