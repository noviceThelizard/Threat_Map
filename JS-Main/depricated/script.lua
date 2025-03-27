--read csv file
local reader = require "calc"

local js = require "js"
local window = js.global
local document = window.document


window:alert("МиГ-21 Балалаика")

function parse_file(array)
	local hashmap = {}

	for i = 1, #array do
		local latitude = reader:read_coordinate(array[i].latitude)
		local longitude = reader:read_coordinate(array[i].longitude)
		local coordinates = latitude..","..longitude

		print(lattitude, longitude, coordinates)
		if hashmap[coordinates] ~= nil then
			local size = hashmap[coordinates].size + 1
			--hashmap[coordinates] = {latitude: latitude, longitude: longitude, size: size}
			--table.insert(hashmap, coordinates, {latitude: latitude, longitude: longitude, size: size}
		else
			--hashmap[coordinates] = {latitude: latitude, longitude: longitude, size: 1}
			--table.insert(hashmap, coordinates, {latitude: latitude, longitude: longitude, size: 1}
		end
	end

	return hashmap
end
--[[
function parse_file_ip(array)
	local hashmap = {}

	for i = 1, #array do
		local ip_address = array[i].ip_address
		local attack_source = array[i].attack_source

		if hashmap[ip_address] ~= nil then
			local count = hashmap[ip_address].count + 1
			hashmap[ip_address] = {ip_address: ip_address, count: count}
		else
			hashmap[ip_address] = {ip_address: ip_address, count: 1}
		end
	end

	return hashmap
end
]]
function leaderboard_funcL(hash_ip)
	local main_table = document:createElement('table')
	local thead = document:createElement('thead')
	local tbody = document:createElement('tbody')
	
	main_table:appendChild(thead)
	main_table:appendChild(tbody)

	document:getElementById('leaderboard'):appendChild(main_table)
	
	local row_1 = document:createElement('tr')
	local heading_1 = document:createElement('th')
	heading_1.innerHTML = "Index"
	local heading_2 = document:createElement('th')
	heading_2.innerHTML = "Target IP Address"

	row_1:appendChild(heading_1)
	thead:appendChild(row_1)
end

function main()
end

main()
