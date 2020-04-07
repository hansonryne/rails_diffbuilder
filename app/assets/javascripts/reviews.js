function toggle_file_vis(name) {
        var y = name;
        console.log(y);
        var x = document.getElementsByClassName("file-"+name);
        for (var i = 0; i < x.length; i++) {
                if (x[i].style.display === "none") {
                        x[i].style.display = "";
                } else {
                        x[i].style.display = "none";
                }
        }
}
