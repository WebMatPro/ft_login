
--print("server file loaded !") -- debug

-- Register Events Server
RegisterServerEvent('ft_login:QuitServer') -- register event for use from client side
RegisterServerEvent('ft_login:CheckServer')


-- Event click button leave server
AddEventHandler('ft_login:QuitServer', function()

  local LeaveMessage = 'You have logged out successfully, see you next time !'

  DropPlayer( source, LeaveMessage ) -- will kick the current player
  CancelEvent() -- cancel all events
  
end)


-- Event click button leave server
AddEventHandler('ft_login:CheckServer', function( user, password )	

    local result = MySQL.Sync.fetchAll("SELECT * FROM players WHERE login = @login AND password = @password", { ['@login'] = user, ['@password'] = password } )	-- get only matched login with password in table players
	local Player = result[1]
	
    if Player == nil then -- If resultat exist

		local ErrorMessage = "Player not exit in database"		
		TriggerClientEvent('ft_login:ErrorMessageClientInChat', -1, ErrorMessage) -- go to client event
	
	else -- otherwise
	
		local ValidMessage = "Login successFul"		
		TriggerClientEvent('ft_login:ValidMessageClientInChat', -1, ValidMessage) -- go to client event
	
	end	
  
end)