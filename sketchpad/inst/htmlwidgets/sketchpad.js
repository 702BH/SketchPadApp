HTMLWidgets.widget({

  name: 'sketchpad',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        sketchpad = new sketchPad(el);

      },


      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
