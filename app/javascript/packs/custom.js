window.getSelectedText = function(node) {
    var text = document.getSelection();
    node.getElementsByClassName('selection-target')[0].attributes.getNamedItem('data-selection').value = text.toString();
}

window.toggle_category_vis = function(name) {
        var y = name;
        console.log(y);
        var x = document.getElementsByClassName("category-"+name);
        for (var i = 0; i < x.length; i++) {
                if (x[i].style.display === "none") {
                        x[i].style.display = "";
                } else {
                        x[i].style.display = "none";
                }
        }
}
