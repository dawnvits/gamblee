jQuery(document).on('turbolinks:load', function() {
  jQuery('#navigation').on("click", function() {
    jQuery('#sidebar').sidebar('setting', 'transition', 'overlay').sidebar('toggle');
  });

  jQuery('#home__request-cashout-button').on("click", function() {
    $('.ui.modal').modal('show');
  });

  $('.ui.dropdown').dropdown();

  jQuery('#bottom_menu-trigger').on("click", function() {
    jQuery('#bottom_menu').sidebar('setting', 'transition', 'overlay').sidebar('toggle');
  });
  
  jQuery('.ui.checkbox').checkbox();
  jQuery('.menu .item').tab();
  
  jQuery('.message .close').on('click', function() {
    jQuery(this).closest('.message').transition('fade');
  });
});
