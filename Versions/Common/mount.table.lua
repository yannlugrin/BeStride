function BeStride:buildMountTables()
	BeStride:BuildMasterMountTable()
	BeStride:LoadMountTables()
end

function BeStride:LoadMountTables()
	mountTable["ground"] = {}
	mountTable["flying"] = {}
	mountTable["swimming"] = {}
	mountTable["passenger"] = {}
	mountTable["repair"] = {}
	for key,value in pairs(mountTable["master"]) do
		if value["faction"] == nil or value["faction"] == playerTable["faction"]["id"] then
			--if value["faction"] then
				--print("Adding Mount: " .. value["name"] .. " Id: " .. key .. " Type: " .. value["type"] .. " Faction: " .. value["faction"] .. " Player Faction: " .. playerTable["faction"]["id"] .. " SID: " .. value["spellID"] .. " MID: " .. value["mountID"])
			--end
			--print("Adding Mount: " .. value["name"] .. " Id: " .. key .. " Type: " .. value["type"] .. " SID: " .. value["spellID"] .. " MID: " .. value["mountID"] .. " Type: " .. value["type"])
			BeStride:AddCommonMount(key)
			BeStride:AddPassengerMount(key)
			BeStride:AddRepairMount(key)
		end
	end
end

function BeStride:AddCommonMount(mountId)
	local mount = mountTable["master"][mountId]
	if BeStride_MountDB and BeStride_MountDB[mount.spellID] and BeStride_MountDB[mount.spellID].attributes.flying and BeStride_MountDB[mount.spellID].attributes.ground then
		table.insert(mountTable["flying"],mountId)
		table.insert(mountTable["ground"],mountId)
	elseif mount["type"] == "ground" then
		--print("Adding Mount: " .. mount["name"] .. " Id: " .. mountId .. " Type: " .. mount["type"])
		table.insert(mountTable["ground"],mountId)
	elseif mount["type"] == "flying" then
		--print("Adding Mount: " .. mount["name"] .. " Id: " .. mountId .. " Type: " .. mount["type"])
		table.insert(mountTable["flying"],mountId)
	elseif mount["type"] == "swimming" then
		--print("Adding Mount: " .. mount["name"] .. " Id: " .. mountId .. " Type: " .. mount["type"])
		table.insert(mountTable["swimming"],mountId)
	elseif mount["type"] == "zone" then
		if mountId == 373 then
			table.insert(mountTable["swimming"],mountId)
		end
		table.insert(mountTable["zone"],mountId)
	end
end

function BeStride:AddPassengerMount(mountId)
	if BeStride_Constants.Mount.Mounts[mountTable["master"][mountId]["spellID"]] ~= nil and BeStride_Constants.Mount.Mounts[mountTable["master"][mountId]["spellID"]]["type"] == "passenger" then
		table.insert(mountTable["passenger"],mountId)
	end
end

function BeStride:AddRepairMount(mountId)
	if BeStride_Constants.Mount.Mounts[mountTable["master"][mountId]["spellID"]] ~= nil and BeStride_Constants.Mount.Mounts[mountTable["master"][mountId]["spellID"]]["repair"] then
		table.insert(mountTable["repair"],mountId)
	end
end