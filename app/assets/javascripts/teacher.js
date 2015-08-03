var teacherClient = new Faye.Client("http://localhost:3000/faye");

play = function (path) {
	document.getElementById("jukebox").play();
	$("#logo").attr("src", path);
};

pause = function (path) {
	document.getElementById("jukebox").pause();
	$("#logo").attr("src", path);
};
