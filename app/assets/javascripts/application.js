// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

//= require jquery


// $(function() {
//   $($fileField).on('change', $fileField, function(e) {
//   file = e.target.files[0]
//   reader = new FileReader(),
//   $preview = $("#img");
//
//           reader.onload = function (e) {
//             $('#img').attr('src', e.target.result);
//           }
//           reader.readAsDataURL(input.files[0]);
//         }
//       }
//       $("#file").change(function() {
//         readURL(this);
//       });
//     });

$(function(){
  $fileField = $('#file')
    $($fileField).on('change', $fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
    $preview = $("#img");
      reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: "100%",
          height: "100%",
          class: "preview",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });
});

$(function(){
$(".btn_star").click( function() {
    var radioVal = $("input[name='star']:checked").val();
});
});
