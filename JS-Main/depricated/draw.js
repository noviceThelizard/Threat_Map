function draw_circle(x, y, size)
{
	const canvas = document.getElementById("canvas");
	const brush = canvas.getContext("2d");

	const width = canvas.width;
	const height = canvas.height;

	brush.strokeStyle = "#FF0000";
	brush.lineWidth = 2;

	brush.beginPath();
	brush.arc((x-90)*(width/50), ((-1*y)+10)*(height/20), size*5, 0, 2*Math.PI);

	brush.stroke();

}

function draw_grid()
{
	const canvas = document.getElementById("canvas");
	const brush = canvas.getContext("2d");

	const width = canvas.width;
	const height = canvas.height;

	brush.strokeStyle = "#808080";
	brush.lineWidth = 1;

	const x = width / 10;
	const y = height / 10;

	for (let i = x; i < width; i += x)
	{
		brush.moveTo(i,0);
		brush.lineTo(i,height);
	}
	for (let j = y; j < height; j += y)
	{
		brush.moveTo(0,j);
		brush.lineTo(width,j);
	}
	

	brush.stroke();
}

function draw_line(x1,y1,x2,y2)
{
	const canvas = document.getElementById("canvas");
	const brush = canvas.getContext("2d");

	const width = canvas.width;
	const height = canvas.height;

	brush.strokeStyle = "#808080";
	brush.lineWidth = 1;

	brush.moveTo(x1,y1);
	brush.lineTo(x2,y2);
}

function draw_xhair()
{
	draw_circle(25,10,1);
	draw_circle(26,10,1);
	draw_circle(24,10,1);
	draw_circle(25,11,1);
	draw_circle(25,9,1);
}
