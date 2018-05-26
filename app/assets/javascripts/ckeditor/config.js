/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
  //  #fafdff is $softer_background
  CKEDITOR.addCss('.cke_editable{background-color: #fafdff}');
  config.extraPlugins = 'SimpleLink';
  config.extraPlugins = 'confighelper';
  config.allowedContent = true;
  config.removePlugins = 'elementspath';
  config.resize_enabled = false;
  // Toolbar groups configuration.
  config.toolbar = [
    // { name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ], items: [ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
    // { name: 'forms', items: [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField' ] },
    { name: 'links', items: [ 'SimpleLink', 'Unlink' ] },
    { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', '-', 'Blockquote' ] },
    { name: 'styles', items: [ 'Format', 'FontSize' ] },
    { name: 'colors', items: [ 'TextColor' ] },
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike' ] }
  ];
};
