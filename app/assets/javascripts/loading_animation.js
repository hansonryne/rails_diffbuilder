function show_loader() {
    var l = document.getElementById("loading-animation");
    if (l.classList.contains("hidden")) {
        l.classList.remove("hidden");
    }
}
