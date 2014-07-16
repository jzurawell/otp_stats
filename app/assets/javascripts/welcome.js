$(document).ready(function() {

    $('#completed-after').on('change', function(event) {
        var $form = $(this).parent();
        $form.submit();
    });

});
