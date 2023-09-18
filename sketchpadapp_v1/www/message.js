
$(document).read(function(){
    var drawing = sketchPad.paths;

    $("advanceBtn").on("click", function(){
        Shiny.onInputChange("sketchData", drawing);

    })

})


