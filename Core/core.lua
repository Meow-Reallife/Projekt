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
	setmetatable(self, self);
	
	self.host 	  = 'localhost';
	self.username 	  = 'root';
	self.databas      = 'test12';
	self.passwor	  = '';
	self.type 	  = 'mysql';
	
	self.connect = dbConnect(self.type, 'dbname='..self.database..';host='..self.host, self.username, self.password, 'share-1');
	
	if self.connect then outputServerCore('Datenverbindung wurde erfolgreich aufgebaut...'); else outputServerCore('Datenverbindung ist Fehlgeschlagen überprüfe die angaben...'); end;
	
	return self;
end

addEventHandler('onResourceStart', getResourceRootElement(getThisResource()), function()
	core = ServerCore:New();
end);


function ServerCore:query(...)
	local querystring = table.concat({...}, ' ');
	local query = dbQuery(self.connect, querystring);
	return query
end

function ServerCore:assoc(data2, querystring)
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
function outputServerCore(text)
	outputDebugString(text);
end
--

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
		name = player:getName(),
		serial = player:getSerial(),
		position = player:getPosition(),
		ping = player:getPing(),
		money = player:getMoney(),
		health = player:getHealth(),
		vehicle = getPedOccupiedVehicle(player)
	}
end





