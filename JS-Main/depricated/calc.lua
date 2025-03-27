STAGE = {
	DEGREE = 1,
	MINUTE = 2,
	SECOND = 3,
	CARDINAL = 4,
}

function degree_decimal(degree, minute, second)
	return degree + math.floor(minute/60) + math.floor(second/3600)
end

function read_coordinate(input)
	current_stage = STAGE.DEGREE
	degree = 0.0
	minute = 0.0
	second = 0.0
	south = false

	for i = 1,input.len do
		if input[i] == 'd' or input[i] == 'D' then
			current_stage = STAGE.MINUTE
			goto continue
		end
		if input[i] == '\'' then
			current_stage = STAGE.SECOND
			goto continue
		end
		if input[i] == '\"' then
			current_stage = STAGE.CARDINAL
			goto continue
		end

		local case = {
			[STAGE.DEGREE] = function()
				degree = degree*10 + tonumber(input[i])
			end,
			[STAGE.MINUTE] = function()
				minute = minute*10 + tonumber(input[i])
			end,
			[STAGE.SECOND] = function()
				second = second*10 + tonumber(input[i])
			end,
			[STAGE.CARDINAL] = function()
				if input[i] == 's' or input[i] == "s" then
					south = true
				end
			end,
		}

		local switch = case[current_stage]
		if switch then
			switch()
		else
			print("an error has occured in the switch case")
		end

		::continue::
	end

	local sum = degree_decimal(degree, minute, second)
	if south then
		sum = sum * (-1)
	end

	return sum
end
