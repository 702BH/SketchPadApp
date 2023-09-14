Shiny.addCustomMessageHandler("testmessage",
function(message){
  if(message == ""){
    alert(JSON.stringify("Please type your name first"));
  }
  document.getElementById("test").style.visibility = 'hidden';
    
});