document.addEventListener('DOMContentLoaded', function() {
    var el_tabs = document.querySelector(".tabs");
    var instance_tabs = M.Tabs.init(el_tabs);
    var el_sidenav = document.querySelectorAll('.sidenav');
    var instance_sidenav = M.Sidenav.init(el_sidenav);
    /* instance_sidenav.open(); */
    var el_fixActBtn = document.querySelectorAll('.fixed-action-btn');
    var instance_fixActBtn = M.FloatingActionButton.init(el_fixActBtn);
    
    var el_leaflet = $('div.leaflet-bottom.leaflet-right');
    el_leaflet.attr("style", "display: none;");
});