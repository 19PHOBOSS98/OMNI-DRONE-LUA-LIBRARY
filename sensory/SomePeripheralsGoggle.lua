local Object = require "lib.object.Object"
local list_manager = require "lib.list_manager"
local IndexedListScroller = list_manager.IndexedListScroller

local SomePeripheralsGoggle = Object:subclass()

function SomePeripheralsGoggle:init(configs)
	self.peripheral = peripheral.find("goggle_link_port")
	self.use_external_goggle_port = configs.use_external_goggle_port or true
	configs.channels_config = configs.channels_config or {}
	self.EXTERNAL_GOGGLE_PORT_CHANNEL = configs.channels_config.EXTERNAL_GOGGLE_PORT_CHANNEL or 0
	self.max_distance = configs.max_distance or 300
	self.prev_distance = self.max_distance
	SomePeripheralsGoggle.superClass.init(self)
end

function SomePeripheralsGoggle:useExternal(mode)
	self.use_external_goggle_port = mode
end

function SomePeripheralsGoggle:isUsingExternal()
	return self.use_external_goggle_port
end

function SomePeripheralsGoggle:updatePrevDistance(range)
	self.prev_distance = range
end

--local modem = peripheral.find("modem")

function SomePeripheralsGoggle:listenToExternalPort()
	if (self.use_external_goggle_port) then
		local _, _, senderChannel, _, message, _ = os.pullEvent("modem_message")
		if (senderChannel == self.EXTERNAL_GOGGLE_PORT_CHANNEL) then
			if (message.range) then
				self:updatePrevDistance(message.range)
			end
		end
	end
end

function SomePeripheralsGoggle:getDistance()
	if (self.use_external_goggle_port or self.peripheral==nil) then
		return self.prev_distance
	end

	for k, v in pairs(self.peripheral.getConnected()) do
		local item = v.raycast(self.max_distance, {0, 0, 1}, false, true, true)--make sure to use some-peripherals version 00.12+
		if (item.distance) then
			self:updatePrevDistance(item.distance)
		end
		
		return self.prev_distance
	end
	return self.prev_distance
end

return SomePeripheralsGoggle