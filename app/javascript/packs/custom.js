window.getSelectedText = function(node) {
    var text = document.getSelection();
    node.getElementsByClassName('selection-target')[0].attributes.getNamedItem('data-selection').value = text.toString();
}
