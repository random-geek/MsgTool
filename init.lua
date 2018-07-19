local members, newMembers = {}

local getName = function(player) -- Find an applicable name from a string with wildcards.
	local players = minetest.get_player_names()
	local pattern = "^" .. player:gsub("*", ".+") .. "$"
	
	for _,name in ipairs(players) do
		if name:find(pattern) then
			return name
		end
	end
	
	return false -- If no names match, return false.
end

local append = function(arr, newItem) -- Append an item, avoiding duplicates.
	for _,item in ipairs(arr) do
		if item == newItem then -- If item is already in array, there is no need to add it.
			return arr
		end
	end
	arr[#arr+1] = newItem
	return arr
end

minetest.register_chatcommand("p", {
	params = "<players> <message>",
	description = "Send a private message. To set recipients only, use '.p <players>'. Use commas (no spaces) to separate player names. Use an asterisk (*) to get last recipients. Wildcards are also acceptable in player names.",
	func = function(param)
		local players, msg = string.match(param, "^(%g+)%s?(.*)$")
		
		if not players then -- Reject bad input
			minetest.display_chat_message("Invalid parameters. See '.help p'.")
			return
		end
		
		playerList = string.split(players, ",")
		newMembers = {} -- Reset the variable
		
		for _,player in ipairs(playerList) do
			if player == "*" then -- User wants to use last recipients.
				if #members == 0 then -- Reject if there are no existing players
					minetest.display_chat_message("No previous recipients found.")
					return
				else
					for _,member in ipairs(members) do -- Insert each member from existing table
						newMembers = append(newMembers, member)
					end
				end
			elseif player:find("*") then -- Player name contains wildcards
				local name = getName(player)
				if not name then -- If the player was not found
					minetest.display_chat_message("No match for player '" .. player .. "'.")
					return
				else
					newMembers = append(newMembers, name)
				end
			else
				newMembers = append(newMembers, player)
			end
		end
		
		members = newMembers -- Update list
		
		if msg and msg:len() > 0 then -- Do not send messages if no message was specified.
			for _,member in ipairs(members) do
				minetest.run_server_chatcommand("msg", member .. " " .. msg)
			end
		else
			minetest.display_chat_message("Recipients: " .. table.concat(members, ", "))
		end
	end
})