jQuery(document).on('turbolinks:load', function() {
  jQuery('#navigation').on("click", function() {
    jQuery('.ui.sidebar').sidebar('setting', 'transition', 'overlay').sidebar('toggle');
  });
  
  jQuery('.ui.checkbox').checkbox();
  jQuery('.menu .item').tab();
});
