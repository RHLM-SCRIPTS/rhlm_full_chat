ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

----------------------------------------------------------------------------------
RegisterNetEvent("esx_admin:killPlayer")
AddEventHandler("esx_admin:killPlayer", function()
  SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("esx_admin:freezePlayer")
AddEventHandler("esx_admin:freezePlayer", function(input)
    local player = PlayerId()
	local ped = PlayerPedId()
    if input == 'freeze' then
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
    elseif input == 'unfreeze' then
        SetEntityCollision(ped, true)
	    FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    end
end)



-------- noclip --------------
local noclip = false
RegisterNetEvent("esx_admin:noclip")
AddEventHandler("esx_admin:noclip", function(input)
    local player = PlayerId()
	local ped = PlayerPedId
	
    local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(PlayerPedId(), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "Noclip has been ^2^*" .. msg)
	end)
	
	local heading = 0
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(noclip)then
			SetEntityCoordsNoOffset(PlayerPedId(), noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)

			if(IsControlPressed(1, 34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
			end

			if(IsControlPressed(1, 32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1, 27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 1.0)
			end

			if(IsControlPressed(1, 173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -1.0)
			end
		else
			Citizen.Wait(200)
		end
	end
end)

--Thanks to qalle for this code | https://github.com/qalle-fivem/esx_marker
RegisterNetEvent("esx_admin:tpm")
AddEventHandler("esx_admin:tpm", function()
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                break
            end

            Citizen.Wait(5)
        end
        TriggerEvent('chatMessage', _U('teleported'))
    else
        TriggerEvent('chatMessage', _U('set_waypoint'))
    end
end)

RegisterNetEvent('esx_rpchat:sendProximityMessage')
AddEventHandler('esx_rpchat:sendProximityMessage', function(playerId, title, message, color)
	local player = PlayerId()
	local target = GetPlayerFromServerId(playerId)
	if target ~= -1 then
      local playerPed = PlayerPedId()
      local targetPed = GetPlayerPed(target)
      local playerCoords = GetEntityCoords(playerPed)
      local targetCoords = GetEntityCoords(targetPed)

      if target == player or #(playerCoords - targetCoords) < 20 then
          TriggerEvent('chat:addMessage', {args = {title, message}, color = color})
      end
   end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; border: 1px solid rgba(0, 0, 0); margin: 1px; background-color: rgba(0, 0, 0); border-radius: 4px;"><i class="fas fa-user"></i> ME - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; border: 1px solid rgba(0, 0, 0); margin: 1px; background-color: rgba(0, 0, 0); border-radius: 4px;"><i class="fas fa-user"></i> ME - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)


RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(84, 0, 0); border-radius: 4px;"><i class="fas fa-user"></i> DO - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(84, 0, 0); border-radius: 4px;"><i class="fas fa-user"></i> DO - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('sendProximityMessageOop')
AddEventHandler('sendProximityMessageOop', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(43, 43, 43); border-radius: 4px;"><i class="fas fa-user"></i> OOP - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(43, 43, 43); border-radius: 4px;"><i class="fas fa-user"></i> OOP - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageTeq')
AddEventHandler('chatMessageTeq', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(247, 212, 0, 1); border-radius: 4px;"><i class="fas fa-user"></i> Tequila-la - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(247, 212, 0, 1); border-radius: 4px;"><i class="fas fa-user"></i> Tequila-la - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessagePol')
AddEventHandler('chatMessagePol', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(0, 13, 247); border-radius: 4px;"><i class="fas fa-user"></i> Policía - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(0, 13, 247); border-radius: 4px;"><i class="fas fa-user"></i> Policía - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageEms')
AddEventHandler('chatMessageEms', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(255, 0, 0); border-radius: 4px;"><i class="fas fa-user"></i> EMS - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(255, 0, 0); border-radius: 4px;"><i class="fas fa-user"></i> EMS - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageAmu')
AddEventHandler('chatMessageAmu', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(255, 0, 0); border-radius: 4px;"><i class="fas fa-user"></i> Amunation - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(255, 0, 0); border-radius: 4px;"><i class="fas fa-user"></i> Amunation - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)


RegisterNetEvent('chatMessageShe')
AddEventHandler('chatMessageShe', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(32, 50, 11); border-radius: 4px;"><i class="fas fa-user"></i> Sheriff - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(32, 50, 11); border-radius: 4px;"><i class="fas fa-user"></i> Sheriff - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)


RegisterNetEvent('chatMessageCock')
AddEventHandler('chatMessageCock', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(199, 172, 4); border-radius: 4px;"><i class="fas fa-user"></i> Cockatoos - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(199, 172, 4); border-radius: 4px;"><i class="fas fa-user"></i> Cockatoos - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageAyuda')
AddEventHandler('chatMessageAyuda', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(96, 150, 94); border-radius: 4px;"><i class="fas fa-user"></i> Ayuda - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(96, 150, 94); border-radius: 4px;"><i class="fas fa-user"></i> Ayuda - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageTwt')
AddEventHandler('chatMessageTwt', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(55, 143, 158); border-radius: 4px;"><i class="fas fa-user"></i> Twitter - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(55, 143, 158); border-radius: 4px;"><i class="fas fa-user"></i> Twitter - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageAnon')
AddEventHandler('chatMessageAnon', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(28, 72, 79); border-radius: 4px;"><i class="fas fa-user"></i> Twitter Anónimo - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(28, 72, 79); border-radius: 4px;"><i class="fas fa-user"></i> Twitter Anónimo - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)


RegisterNetEvent('chatMessageDark')
AddEventHandler('chatMessageDark', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(45, 28, 79); border-radius: 4px;"><i class="fas fa-user"></i> Darkweb - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(45, 28, 79); border-radius: 4px;"><i class="fas fa-user"></i> Darkweb - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageSeg')
AddEventHandler('chatMessageSeg', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(79, 47, 28); border-radius: 4px;"><i class="fas fa-user"></i> Segunda Mano - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(79, 47, 28); border-radius: 4px;"><i class="fas fa-user"></i> Segunda Mano - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageMec')
AddEventHandler('chatMessageMec', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(53, 47, 47); border-radius: 4px;"><i class="fas fa-user"></i> Mecánico - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(53, 47, 47); border-radius: 4px;"><i class="fas fa-user"></i> Mecánico - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageIg')
AddEventHandler('chatMessageIg', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(128, 0, 128); border-radius: 4px;"><i class="fas fa-user"></i> Instagram - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(128, 0, 128); border-radius: 4px;"><i class="fas fa-user"></i> Instagram - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageId')
AddEventHandler('chatMessageId', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(128, 0, 128); border-radius: 4px;"><i class="fas fa-user"></i> ID - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(128, 0, 128); border-radius: 4px;"><i class="fas fa-user"></i> ID - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageTinder')
AddEventHandler('chatMessageTinder', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(51, 0, 51); border-radius: 4px;"><i class="fas fa-user"></i> Tinder - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(51, 0, 51); border-radius: 4px;"><i class="fas fa-user"></i> Tinder - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessagePuti')
AddEventHandler('chatMessagePuti', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(128, 0, 128); border-radius: 4px;"><i class="fas fa-user"></i> Puticlub - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(128, 0, 128); border-radius: 4px;"><i class="fas fa-user"></i> Puticlub - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageBah')
AddEventHandler('chatMessageBah', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(0, 192, 255); border-radius: 4px;"><i class="fas fa-user"></i> Bahamas - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(0, 192, 255); border-radius: 4px;"><i class="fas fa-user"></i> Bahamas - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageBadu')
AddEventHandler('chatMessageBadu', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(6, 70, 4); border-radius: 4px;"><i class="fas fa-user"></i> Badulaque - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(6, 70, 4); border-radius: 4px;"><i class="fas fa-user"></i> Badulaque - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageLico')
AddEventHandler('chatMessageLico', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(8, 123, 110); border-radius: 4px;"><i class="fas fa-user"></i> Licorería - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(8, 123, 110); border-radius: 4px;"><i class="fas fa-user"></i> Licorería - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageTaxi')
AddEventHandler('chatMessageTaxi', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(212, 200, 49); border-radius: 4px;"><i class="fas fa-user"></i> Taxis - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(212, 200, 49); border-radius: 4px;"><i class="fas fa-user"></i> Taxis - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

RegisterNetEvent('chatMessageOoc')
AddEventHandler('chatMessageOoc', function(id, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(148, 146, 146); border-radius: 4px;"><i class="fas fa-user"></i> OOC - {0}  ➥ ^0{1}</div>',
            args = { id, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.9 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 2px; margin: 1px; background-color: rgba(148, 146, 146); border-radius: 4px;"><i class="fas fa-user"></i> OOC - {0} ➥ ^0{1}</div>',
            args = { id, message }
        })
    end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/twt',  _U('twt_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    --TriggerEvent('chat:addSuggestion', '/atwt',  _U('anon_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/me',   _U('me_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/entorno',   _U('entorno_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/do',   _U('do_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/ooc',   _U('ooc_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerEvent('chat:removeSuggestion', '/twt')
        TriggerEvent('chat:removeSuggestion', '/me')
        TriggerEvent('chat:removeSuggestion', '/entorno')
        TriggerEvent('chat:removeSuggestion', '/do')
        TriggerEvent('chat:removeSuggestion', '/anon')
        TriggerEvent('chat:removeSuggestion', '/ooc')
    end
end)

local font = 0 -- Font of the text
local time = 350 -- Duration of the display of the text : 500 ~= 13sec
local msgQueue = {}

RegisterNetEvent('esx_rpchat:drawOnHead')
AddEventHandler('esx_rpchat:drawOnHead', function(text, color, source)
    Display(GetPlayerFromServerId(source), text, color)
end)

function Display(mePlayer, text, color)
    local timer = 0
    if msgQueue[mePlayer] == nil then
        msgQueue[mePlayer] = {}
    end
    table.insert(msgQueue[mePlayer], { txt = text , c= color, tim = 0 })
    while tablelength(msgQueue[mePlayer]) > 0 do
        Wait(0)
        timer = timer + 1
        local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local lineNumber = 1
        for k, v in pairs(msgQueue[mePlayer]) do
            DrawText3D(coords['x'], coords['y'], coords['z']+lineNumber, v.txt, v.c)
            lineNumber = lineNumber + 0.12
            if(v.tim > time)then
                msgQueue[mePlayer][k] = nil
            else
                v.tim= v.tim + 1
            end
        end
    end
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end
function DrawText3D(x,y,z, text, color)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end
