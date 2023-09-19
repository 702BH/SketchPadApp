HTMLWidgets.widget({

  name: 'sketchpad',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    sketchpad = new sketchPad(el);

    function callMethod(methodName){
      if(methodName == "reset"){
        sketchpad.reset();
      }
    }

    Shiny.addCustomMessageHandler("callMethod", callMethod);


    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        sketchpad;


      },


      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
