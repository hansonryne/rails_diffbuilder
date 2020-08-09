function toggle_file_vis(tgt) {
        var y = tgt.name;
        console.log(y);
        var x = document.getElementsByClassName("file-" + tgt.name);
        for (var i = 0; i < x.length; i++) {
                if (x[i].style.display === "none") {
                        tgt.style.backgroundColor = "#2C7A7B";
                        x[i].style.display = "";
                } else {
                        tgt.style.backgroundColor = "#EDF2F7";
                        x[i].style.display = "none";
                }
        }
}
