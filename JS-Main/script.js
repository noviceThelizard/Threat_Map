//read csv file
async function read_file(filename)
{
	let arr = [];
	d3.csv(filename, (d) => { 
		for (let i = 0; i < d.length; i++)
		{
			arr.push(d[i]);
		}
	});
	return arr;
}

//parse csv file to a hashmap
async function parse_file(arr)
{
	const map = new Map();
	for (let i=0; i<arr.length; i++)
	{
		let lat_degree = read_coordinate(arr[i].Latitude);
		let lon_degree = read_coordinate(arr[i].Longitude);
		let ip_addr = arr[i].IP;
		let attack_src = arr[i].Country;
		let coordinates = lat_degree+","+lon_degree;

		if (map.has(coordinates))
		{
			let size = map.get(coordinates).size + 1;
			map.set(coordinates, {lat: lat_degree,lon: lon_degree, size: size});
		} else
		{
			map.set(coordinates, {lat: lat_degree, lon: lon_degree, size: 1});
		}
	}
	return map;
}

//render points on to the map
async function render_points(hash, map)
{
	hash.forEach( (v,k) => {
		L.circle(
			[v.lat, v.lon],
			{radius:500*v.size, color: '#7db37d'}
		).addTo(map);
		L.circle(
			[v.lat, v.lon],
			{radius:500, color: '#7db37d'}
		).addTo(map);
	});
}

async function parse_file_ip(arr)
{
	const map = new Map();
	for (let i=0; i<arr.length; i++)
	{
		let ip_addr = arr[i].IP;
		let attack_src = arr[i].Country;

		if (map.has(ip_addr))
		{
			let count = map.get(ip_addr).count + 1;
			map.set(ip_addr, {ip: ip_addr, count: count});
		} else
		{
			map.set(ip_addr, {ip: ip_addr, count: 1});
		}
	}
	return map;
}
//count the frequency of attack
async function leaderboard_func(hash_ip)
{
	let table = document.createElement('table');
	let thead = document.createElement('thead');
	let tbody = document.createElement('tbody');

	table.appendChild(thead);
	table.appendChild(tbody);

	// Adding the entire table to the body tag
	document.getElementById('leaderboard').appendChild(table);

	// Creating and adding data to first row of the table
	let row_1 = document.createElement('tr');
	let heading_1 = document.createElement('th');
	heading_1.innerHTML = 'Index';
	let heading_2 = document.createElement('th');
	heading_2.innerHTML = 'Target IP Address';
	let heading_3 = document.createElement('th');
	heading_3.innerHTML = 'Attack Frequency';

	row_1.appendChild(heading_1);
	row_1.appendChild(heading_2);
	row_1.appendChild(heading_3);
	thead.appendChild(row_1);

	let index = 1;
	hash_ip.forEach( (v,k) => {
		let row_2 = document.createElement('tr');
		let row_2_data_1 = document.createElement('td');
		row_2_data_1.innerHTML = index;
		let row_2_data_2 = document.createElement('td');
		row_2_data_2.innerHTML = v.ip;
		let row_2_data_3 = document.createElement('td');
		row_2_data_3.innerHTML = v.count;
	
		row_2.appendChild(row_2_data_1);
		row_2.appendChild(row_2_data_2);
		row_2.appendChild(row_2_data_3);
		tbody.appendChild(row_2);

		index += 1;
	});

}
