var CodeMirrorInputBinding = new Shiny.InputBinding();

$.extend(CodeMirrorInputBinding, {
  find: function(scope) {
    return $(scope).find(".codemirror-editor");
  },
  initialize: function(el) {
    const markers = [];

    var textInput = el.children[1];
    var textOutput = el.children[3];

    editor = CodeMirror.fromTextArea(
      textOutput, {
        mode: "text/html",
        lineNumbers: true
      }
    );

    updateMarkers();

    function addMarkers(value) {
      if (typeof value !== "undefined") {
        var index_from = new Object();
        index_from.line = value[0];
        index_from.ch = value[1];

        var index_to = new Object();
        index_to.line = value[0];
        index_to.ch = value[2];

        markers.push(
          editor.markText(
            index_from, index_to, {
              className: "highlight"
            }
          )
        );
      }
    }

    function removeMarkers() {
      markers.forEach(
        marker => marker.clear()
      );
    }

    function updateMarkers() {
      removeMarkers(); // remove previous markers
      var pattern = textInput.value;

      try {
        if (pattern.length > 0) {
          pattern = new RegExp(pattern, "igm");

          var testCases = textOutput.value;
          testCases = testCases.split(/\r?\n/g);

          testCases.forEach(function (value, i) {
            var counter = 0;

            while (match = pattern.exec(value)) {
              var lastIndex = match.index + match[0].length;
              addMarkers([i, match.index, lastIndex]);

              if (counter > 999) {
                break;
              }

              counter++;
            }
          });
        }
      } catch(error) {
        // potential error message
      }
    }

    editor.on("change", function(el) {
      var text = el.getDoc().getValue();
      Shiny.setInputValue(textOutput.id, text);

      textOutput.innerHTML = text;
      textOutput.value = text;

      updateMarkers();
    })

    $(textInput).on("change keyup paste", function() {
      updateMarkers();
    })
  },
  getId: function(el) {
  	return $(el).attr('id');
  },
  getValue: function(el) {
    return null;
  },
  setValue: function(el, value) {
    return null;
  },
  subscribe: function(el, callback) {
    $(el).on("change.CodeMirrorInputBinding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".CodeMirrorInputBinding");
  }
});

Shiny.inputBindings.register(CodeMirrorInputBinding);
