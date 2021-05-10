QBCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

local show = false
function openGui()
  if show == false then
    show = true
    SetNuiFocus(true, true)

    SendNUIMessage(
      {
        show = true
      }
    )
  end
end

function closeGui()
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
end

RegisterCommand('bugreport', function(source)
	openGui()
end)

RegisterNetEvent("ui-bugreport:openGui")
AddEventHandler("ui-bugreport:openGui", function(user_id)
	user_id = user_id
    openGui()
end)

RegisterNUICallback("sendReport", function(data)
  discord = data['data'][1]
  description = data['data'][2]
  if (discord == "" or description == "") then

  else
    TriggerServerEvent("ui-bugreport:sendReport", data)
  end

end)

RegisterNetEvent("ui-bugreport:reportSent")
AddEventHandler("ui-bugreport:reportSent", function(user_id)
	user_id = user_id
    closeGui()
end)

RegisterNUICallback("close", function()
	closeGui()
end)
