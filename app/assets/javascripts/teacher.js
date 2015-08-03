var teacherClient = new Faye.Client("http://localhost:3000/faye");

play = function (path, room_id) {
	document.getElementById("jukebox").play();
	$("#logo").attr("src", path);
	teacherClient.publish("/echochamber/" + room_id, { play: true });
};

pause = function (path, room_id) {
	document.getElementById("jukebox").pause();
	$("#logo").attr("src", path);
	teacherClient.publish("/echochamber/" + room_id, { pause: true });
};

setUpSlider = function (room_id) {
	$("#slider").slider({
		min: 0,
		//max: document.getElementById("jukebox").duration,
		range: "min",
		change: function () {
			var value = $("#slider").slider("value");
			document.getElementById("jukebox").fastSeek(value);
			teacherClient.publish("/echochamber/" + room_id, { seek: value });
		}
	});
};
