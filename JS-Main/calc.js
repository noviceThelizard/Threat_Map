const STAGE = {
	DEGREE: 1,
	MINUTE: 2,
	SECOND: 3,
	CARDINAL: 4,
};

function degree_decimal(degree, minute, second)
{
	return degree + (minute/60) + (second/3600);
}

function read_coordinate(rawdata)
{
	current_stage = STAGE.DEGREE;
	let degree = 0.0;
	let minute = 0.0;
	let second = 0.0;
	let south = false;

	for (let i = 0; i<rawdata.length; i++)
	{
		if (rawdata[i] === 'd') { current_stage = STAGE.MINUTE; continue; }
		if (rawdata[i] === '\'') { current_stage = STAGE.SECOND; continue; }
		if (rawdata[i] === '\"') { current_stage = STAGE.CARDINAL; continue; }
		switch (current_stage)
		{
			case STAGE.DEGREE:
				degree = degree*10 + (+rawdata[i]);
				break;
			case STAGE.MINUTE:
				minute = minute*10 + (+rawdata[i]);
				break;
			case STAGE.SECOND:
				second = second*10 + (+rawdata[i]);
				break;
			case STAGE.CARDINAL:
				if (rawdata[i] === 's' || rawdata[i] === 'S') { south = true;}
				break;
			default:
				break;
		}
	}

	let sum = degree_decimal(degree, minute, second);
	if (south === true) { sum *= -1; }

	return sum;
}
