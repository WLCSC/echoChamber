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
