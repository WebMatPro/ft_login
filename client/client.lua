-- @Project: FiveM Tools ft_login
-- @License: GNU General Public License v3.0


local ft_login = true -- true = enable mod or use false to disabled mod


-- Main function to open login panel
function EnableGuiLogin( StatusGui ) -- string 'StatusGui' can be true or false    
    
	ft_login = StatusGui -- use to disable everything from if true, look like : EnableGuiLogin(true)

	SetNuiFocus(StatusGui, StatusGui) -- Disable all the control and active the FiveM native cursor

	DisplayRadar(false) -- Remove mini map	
	
	-- send in javascript
    SendNUIMessage({
        type = "EnableGuiLogin",
        StatusJs = StatusGui
    })
end


-- CallBack from server event : Error login
AddEventHandler('ft_login:ErrorMessageClientInChat', function( ErrorMessage )
	local text = '<b>~r~ERROR!~s~</b> ' .. ErrorMessage	
	DisplayNotification(text)
end)
RegisterNetEvent('ft_login:ErrorMessageClientInChat') -- register event for use from server side


-- CallBack from server event : SuccessFul login
AddEventHandler('ft_login:ValidMessageClientInChat', function( ValidMessage )
	
	local text = '<b>~g~WELCOME!~s~</b> ' .. ValidMessage	
	DisplayNotification(text)	
	EnableGuiLogin(false) -- Disable	
	DisplayRadar(true) -- Display mini map
		
end)
RegisterNetEvent('ft_login:ValidMessageClientInChat') -- register event for use from server side


-- Call disconnect button
RegisterNUICallback('ft_login:LeaveServer', function()
	TriggerServerEvent( 'ft_login:QuitServer' )		
end)


-- Call login button
RegisterNUICallback('ft_login:LoginServer', function(data)

	local username = data.username
	local password = data.password

	TriggerServerEvent( 'ft_login:CheckServer', username, password ) -- sent to server the local string from data. json
	
end)


-- Call error login
RegisterNUICallback('ft_login:LoginErrorServer', function()
	local text = '<b>~r~ERROR!~s~</b> Can you enter something dude ?'	
	DisplayNotification(text)		
end)


-- Init Player
Citizen.CreateThread(function()
    while true do
        if ft_login then
		
			EnableGuiLogin(true) -- required to lunch Nui		

		end		
		
        Citizen.Wait(0)

    end
end)


-- 
function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, false)
end