

Shiny.addCustomMessageHandler("testmessage",
function(message){
  console.log(message.name);
  if(message.name == ""){
    alert(JSON.stringify("Please type your name first"));
  }else{
    document.getElementById("sketchrow").style.visibility = "visible";
    document.getElementById("student").style.visibility = "hidden";
    document.getElementById("advanceBtn").disabled=true;
    document.getElementById("nextBtn").disabled=false;
  }
});

Shiny.addCustomMessageHandler("nextbutton",
function(message){
  document.getElementById("nextBtn").disabled=true;
  document.getElementById("saveBtn").disabled=false;
  Shiny.onInputChange("sketchData", sketchpad.paths);


})

Shiny.addCustomMessageHandler("resetCanvas", 
function(message){
  var el = document.getElementById('test');
  el.contentWindow.sketchPad.reset();
});