//= require tinymce-jquery

Portcullis.bind('boot', function(){
  tinyMCE.init({
    selector: 'textarea.tinymce',
    mode: 'textarea',
    theme: 'modern',
    height: 400
  });
});
