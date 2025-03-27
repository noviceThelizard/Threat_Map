local html = [[
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
	<title>Threatmap Prototype</title>
	<!--
		Code
	-->
	<script src="./script.js"></script>
	<script src="./draw.js"></script>
	<script src="./calc.js"></script>
	<!--
		Library
	-->
	<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
     integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
     crossorigin=""/>
	<!-- Make sure you put this AFTER Leaflet's CSS -->
	 <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
	<script src="https://d3js.org/d3.v4.js"></script>
	<!--script src="https://cdn.rawgit.com/fabid/d3-rectbin/master/rectbin.js"></script-->
	<script src="fengari-web.js" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.5.16/p5.min.js" type="text/javascript"></script>
	<!--script src="https://unpkg.com/mappa-mundi/dist/mappa.min.js" type="text/javascript"></script-->
</head>

<style>
	table, th, td {
		border: 1px solid black
	}
</style>

<body>
	<div style="width:100%; display:table;">
		<div style="display: table-row;">
			<div id="map" style="height: 400px; width:1000px; display: table-cell;"></div>
			<div id="leaderboard" style="height: 300px; width: 250px; border: 1px solid black; overflow-y: scroll; display: table-cell;"></div>
		</div>
	</div>
	<div id="button_box" style="width: 200px;border: 1px solid black;">
	<button onClick="read()">1</button> Read CSV File <br>
	<button onClick="parse()">2</button> Parse data for Map <br>
	<button onClick="render()">3</button> Render points on Map <br>
	<button onClick="parse_ip()">4</button> Parse data for Table <br>
	<button onClick="score()">5</button> Generate Table <br>
	</div>
	
	<script>
		var map = L.map('map').setView([-2,120], 4);
		L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
			minZoom: 3,
			maxZoom: 8,
			attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
		}).addTo(map);

		let arr = [];
		let hash = [];
		let hash_ip = [];
		const read = async() => {arr = await read_file();}
		const parse = async() => {hash = await parse_file(arr);}
		const render = async() => {await render_points(hash, map);}
		const parse_ip = async() => {hash_ip = await parse_file_ip(arr);}
		const score = async() => {await leaderboard_func(hash_ip);}

	</script>
</body>

</html>
]]

local ui = require "ui"
require "webview"

-- create a simple Webview 
local win = ui.Window("Webview:postmessage() sample", 640, 480)
local Webview = ui.Webview(win, 0, 50, 640, 430)
Webview.align = "all"

-- once ready, load the html content from string
function Webview:onReady()
  Webview:loadstring(html)
end

-- update the user interface until the user closes the Window
ui.run(win):wait()

