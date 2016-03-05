$(document).ready(function() {
    $('.lang-dropdown-item').on('click', function() {
        var selectedValue = $(this).html()
        window.location = "/transcriptions?lang=" + selectedValue;
    })
})