Shiny.addCustomMessageHandler("testmessage",
function(message){
  console.log(message.name);
  if(message.name == ""){
    alert(JSON.stringify("Please type your name first"));
  }else{
    document.getElementById("sketchrow").style.visibility = "visible";
    document.getElementById("student").style.visibility = "hidden";
  }
  
    
});