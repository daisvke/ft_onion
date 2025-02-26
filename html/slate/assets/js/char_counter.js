//
// This function counts the number of characters written in the
// text area and displays it with the appropriate color

$(function() {
    $('textarea').keyup(function() {
        var characterCount = $(this).val().length,
            current = $('#current'),
            max = $('#max'),
            char_count = $('#char_count');

        current.text(characterCount);

        if (characterCount < 2800)
            current.css('color', '#666');
        else if (characterCount < 3900) {
            current.css('color', '#6d5555');
        }
        else if (characterCount < 4999) {
            current.css('color', '#bb2903');
        }
        if (characterCount >= 5000) {
            max.css('color', '#bb2903');
            current.css('color', '#bb2903');
            char_count.css('font-weight','bold');
        } else {
            max.css('color','#666');
            char_count.css('font-weight','normal');
        }
    });
});