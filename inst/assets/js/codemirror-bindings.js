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

      try {
        var pattern = new SRL(textInput.value);
        console.log(pattern);
        pattern = pattern._regEx.join("");
      } catch(exception) {
        var pattern = textInput.value;
      }

      try {
        $(textInput).attr('pattern', pattern);

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
      } catch(exception) {

      }
    }

    editor.on("change", function(el) {
      var text = el.getDoc().getValue();

      Shiny.setInputValue(textOutput.id, text);
      textOutput.innerHTML = text;

      updateMarkers();
    })

    $(textInput).on("change keyup paste", function() {
      updateMarkers();
    })

    $(textOutput).on("change keyup paste", function() {
      editor.getDoc().setValue(textOutput.innerHTML);
      editor.setOption("placeholder", textOutput.placeholder);

      updateMarkers();
    })
  },
  getId: function(el) {
    return $(el).attr('id');
  },
  getValue: function(el) {
    var values = [
      el.children[1].attr('pattern'),
      el.children[3].innerHTML
    ];

    return values;
  },
  setValue: function(el, values) {
    return null;
  },
  subscribe: function(el, callback) {
    $(el).on("change.CodeMirrorInputBinding", function(e) {
      callback(false);
    });
  },
  unsubscribe: function(el) {
    $(el).off(".CodeMirrorInputBinding");
  },
  receiveMessage: function(el, data) {
    var textInput = el.children[1];
    var textOutput = el.children[3];

    var labelInput = el.children[0];
    var labelOutput = el.children[2];

    if (data.hasOwnProperty('labels')) {
      if (data.labels.length == 2) {
        if (data.labels[0] !== null) {
          labelInput.innerHTML = data.labels[0];
        }

        if (data.labels[1] !== null) {
          labelOutput.innerHTML = data.labels[1];
        }
      }
    }

    if (data.hasOwnProperty('values')) {
      if (data.values.length == 2) {
        if (data.values[0] !== null) {
          textInput.value = data.values[0];
        }

        if (data.values[1] !== null) {
          textOutput.innerHTML = data.values[1];
        }
      }
    }

    if (data.hasOwnProperty('placeholders')) {
      if (data.placeholders.length == 2) {
        if (data.placeholders[0] !== null) {
          textInput.placeholder = data.placeholders[0];
        }

        if (data.placeholders[1] !== null) {
          textOutput.placeholder = data.placeholders[1];
        }
      }
    }

    $(textInput).keyup();
    $(textOutput).keyup();

    $(el).trigger('change');
  },
});

Shiny.inputBindings.register(CodeMirrorInputBinding);
