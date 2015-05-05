
$(document).ready(function(){ 
    /* sidebar toggle */
    /*
    $('[data-toggle=sidebar]').click(function() {
        $('.sidebar-normal').toggleClass('hidden-xs').toggleClass('visible-xs');
        $('.sidebar-mini').toggleClass('visible-xs').toggleClass('hidden-xs');
        var pad;
        if ($('.sidebar-normal').is(':visible')) {
            pad = 200;
        } else {
            pad = 50;
        }
        $('body').css('padding-left', pad);
    });
    */

    $('[data-toggle=shrink-sidebar]').click(function() {
        $('.sidebar-normal').removeClass('hidden-xs').hide();
        $('.sidebar-mini').removeClass('visible-xs').show();
        $('body').css('padding-left', 50);
    });

    $('[data-toggle=expand-sidebar]').click(function() {
        $('.sidebar-normal').removeClass('hidden-xs').show();
        $('.sidebar-mini').removeClass('visible-xs').hide();
        $('body').css('padding-left', 200);
    });
});
