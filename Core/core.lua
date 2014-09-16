--########################--
-- Script: core.lua
-- Development: MulTi
-- Type: OOP
--#########################--


ServerCore = {};
PlayerData = {};

ServerCore.__index = ServerCore;




function ServerCore:New()
	local self = {}
	setmetatable({}, {__index = self});
	
	self.host 	  = '127.0.0.1';
	self.username = 'username';
	self.database = 'database';
	self.password = 'password';
	self.type 	  = 'mysql';
	
	self.connect = dbConnect('host='..self.host..';dbname='..self.database, self.username, self.password, self.type);
	
	if self.connect then self:outputCore('Die Datenverbindung wurde erfolgreich aufgebaut...'); else self:outputCore('Die Datenverbindung ist Fehlgeschlagen überprüfe die angaben...') end;
	
	return self;
end
core = ServerCore:New();


function ServerCore:query(...)
	local querystring = table.concat({...}, ' ');
	local query = dbQuery(self.connect, querystring);
	return query
end

function ServerCore:assoc(..., data2)
	local querystring = table.concat({...}, ' ');
	local query = dbQuery(self.connect, querystring);
	
	if query then
		for _, data in pairs(query) do 
			if data[data2] then
				return data[data2];
			end
		end
	end
	return nil
end

-- Todo --
function ServerCore:outputCore(text)
	return outputDebugString(text);
end


function setPlayerData(player, element, value)
	if isElement(player) then
		if not PlayerData[player] then
			PlayerData[player] = {}
		end
		PlayerData[player][element] = value;
		setElementData(player, element, value);
	end
end

function getPlayerData(player, element)
	if isElement(player) then
		if PlayerData[player] then
			return PlayerData[player][element] or getElementData(player, element);
		end
	end
	return nil
end

function getPlayerInformations(player)
	return {
		name = getPlayerName(player),
		serial = getPlayerSerial(player)
	}
end



