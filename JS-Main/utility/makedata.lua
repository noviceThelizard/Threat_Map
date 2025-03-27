local filename = "data_lua.csv"
local file = io.open(filename, "w")
math.randomseed(os.time())

-- random function
function dice(min, max)
	return math.random(min,max)
end
function roll(min, max)
	return tostring(dice(min, max))
end

-- data generation function
function polar()
	return (dice(1,2)>1) and "S" or "N"
end

function lat()
	local polarity = polar()
	-- default (0,11) S and (0,6) N
	local min, max = 0, 0
	-- default 0,59
	local dmin, dmax = 0, 59
	
	if polarity == "S" then
		min, max = 0, 11
	elseif polarity =="N" then
		min, max = 0, 6
	end

	local degree = roll(min, max)
	local minute = roll(dmin, dmax)
	local second = roll(dmin, dmax)

	-- ex. 7d21'36"S
	local result = degree .. "d" .. minute .. "\'" .. second .. "\"" .. polarity
	return result
end

function long()
	-- default 95, 141
	local min, max = 95, 141
	-- default 0,59
	local dmin, dmax = 0, 59

	local degree = roll(min, max)
	local minute = roll(dmin, dmax)
	local second = roll(dmin, dmax)
	
	-- ex. 101d47'35"E
	local result = degree .. "d" .. minute .. "\'" .. second .. "\"" .. "E"
	return result
end

function ip()
	-- default 1, 255
	local ip1 = roll(1,192) .. "."
	local ip2 = roll(1,255) .. "."
	local ip3 = roll(1,255) .. "."
	local ip4 = roll(1,255)

	local result = ip1 .. ip2 .. ip3 .. ip4
	return result
end

function country()
	list = {
		[1] = "ID",
		[2] = "MY",
		[3] = "PH",
		[4] = "CN",
	}

	return list[dice(1,4)]
end

function set_list()
	lat, long, ip = nil, nil, nil
	lat_case = {
		[1] = "6d10'30\"S",
		[2] = "7d14'45\"S",
		[3] = "1d16'36\"S",
	}

	long_case = {
		[1] = "106d49'39\"E",
		[2] = "112d44'16\"E",
		[3] = "116d49'39\"E",
	}


	ip_case = {
		[1] = "172.5.1.51",
		[2] = "164.26.2.1",
		[3] = "125.78.16.4",
	}

	local choice = dice(1,3)
	return lat_case[choice], long_case[choice], ip_case[choice]
end

function catdata(...)
	local result = ""

	for k, v in pairs(...) do
		result = result .. v
		if k ~= 5 then
			result = result .. ","
		else
			result = result .. "\n"
		end
	end

	return result
end

io.output(file)
io.write("Index,Latitude,Longitude,IP,Country\n")

for i = 1,1000 do
	local polar = (dice(1,2) > 1) and "S" or "N"
	--[[
	local lat = lat()
	local long = long()
	local ip = ip()
	]]
	local lat, long, ip = set_list()
	local country = country()
	io.write(catdata({i, lat, long, ip, country}))
end


io.close(file)
