//= require jquery_ujs
//= require jquery/fitText
//= require jquery/number.min
//= require rails-timeago
//= require foundation
//= require_tree ./lib
//= require_tree ./controllers
//= require count_up

// Force timeago to publish times in a future tense (nearly all of them will be
// anyways, so why not?)
if (jQuery) jQuery.timeago.settings.allowFuture = true;

$(window).load(function(){
  // Set up Foundation.
  $(document).foundation({
    tooltips: {
      selector: '.has-tip, *[data-tooltip]'
    },
    topbar: {
      is_hover: false,
      mobile_show_parent_link: true
    },
    reveal: {
      close_on_background_click: true
    }
  });

  // Make text fit.
  $('.fit-text').fitText(0.7, {
    minFontSize: '1rem'
  });

  // Set up counters.
  // TODO Stop doing this.
  $('[data-countup-start]').each(function(index, rawElem){
    var elem = $(rawElem)
    numAnim = new countUp(rawElem, elem.attr('data-countup-start'), elem.attr('data-countup-end'), elem.attr('data-countup-places'), elem.attr('data-countup-speed'));
    numAnim.start()
  });
});
