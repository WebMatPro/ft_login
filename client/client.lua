-- @Project: FiveM Tools ft_login
-- @License: GNU General Public License v3.0


local ft_login = true -- true = enable mod or use false to disabled mod


-- Main function to open login panel
function EnableGuiLogin( StatusGui ) -- string 'StatusGui' can be true or false
    SetNuiFocus( StatusGui ) -- focus the Nui
    ft_login = StatusGui -- use to disable everything from if true, look like : EnableGuiLogin(true)

	-- send in javascript
    SendNUIMessage({
        type = "EnableGuiLogin",
        StatusJs = StatusGui
    })
end


-- CallBack from server event : Error login
AddEventHandler('ft_login:ErrorMessageClientInChat', function( ErrorMessage )
	PrintChatMessage( ErrorMessage )
end)
RegisterNetEvent('ft_login:ErrorMessageClientInChat') -- register event for use from server side


-- CallBack from server event : SuccessFul login
AddEventHandler('ft_login:ValidMessageClientInChat', function( ValidMessage )
	PrintChatMessage( ValidMessage )		
	EnableGuiLogin(false) -- Disable 
end)
RegisterNetEvent('ft_login:ValidMessageClientInChat') -- register event for use from server side


-- Print direct message in chat
function PrintChatMessage(text)
    TriggerEvent('chatMessage', "[Login-Panel]", { 135,206,250 }, text) -- use the default chat message of FiveM
end


-- Call disconnect button
RegisterNUICallback('ft_login:LeaveServer', function()

	TriggerServerEvent( 'ft_login:QuitServer' )	
	--PrintChatMessage(GetPlayerServerId()) -- debug
	
end)


-- Call login button
RegisterNUICallback('ft_login:LoginServer', function(data)

	local username = data.username
	local password = data.password

	TriggerServerEvent( 'ft_login:CheckServer', username, password ) -- sent to server the local string from data. json
	
    --PrintChatMessage(data.username .. " - " .. data.password)	-- debug	
end)


-- Init Player
Citizen.CreateThread(function()
    while true do
        if ft_login then
		
			EnableGuiLogin(true) -- required to lunch Nui
				
            DisableControlAction(0, 1, ft_login) -- Lock LookLeftRight
            DisableControlAction(0, 2, ft_login) -- Lock LookUpDown
            DisableControlAction(0, 142, ft_login) -- Lock MeleeAttackAlternate
            DisableControlAction(0, 106, ft_login) -- Lock VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
											--else 																-------------- FOR DEBUG
											--    if IsDisabledControlJustReleased(0, 182) then -- Key L		-------------- FOR DEBUG			
											--			EnableGui(true)											-------------- FOR DEBUG				
											--end																-------------- FOR DEBUG
		end		
		
        Citizen.Wait(0)
    end
end)



-- What is that ? not use for the moment
function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end


-------------- FOR DEBUG		
--RegisterNUICallback('escape', function()
--    PrintChatMessage('To open again the login panel, press L') -- print simple message chat	
--	EnableGui(false)
--end)