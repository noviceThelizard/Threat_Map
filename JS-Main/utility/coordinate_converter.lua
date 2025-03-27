local con = require "console"

function convert_to_coordinate(degree_decimal)
	local degree = math.floor(degree_decimal)
	degree_decimal = (degree_decimal - degree) * 60
	local minute = math.floor(degree_decimal)
	degree_decimal = (degree_decimal - minute) * 60
	local second = math.floor(degree_decimal)
	return degree, minute, second
end

function main()
	local quit = false

	while not quit do
		con.clear()
		print("Insert value in Decimal Degree")
		local input1, input2 = tonumber(io.read()), tonumber(io.read())
		if input1 == nil or input2 == nil then
			goto continue
		end
		local d, m, s = convert_to_coordinate(input1)
		if d < 0 then
			print(math.abs(d).."°"..m.."\'"..s.."\"S")
		else
			print(d.."°"..m.."\'"..s.."\"N")
		end
		local ed, em, es = convert_to_coordinate(input2)
		print(ed.."°"..em.."\'"..es.."\"E")
		print("Exit program? [Y/N]")
		local exit = io.read()
		if exit == "Y" or exit == "y" then
			quit = true
		end
		::continue::
	end
end

main()
