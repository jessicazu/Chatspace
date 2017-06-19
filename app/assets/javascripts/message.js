$(document).on('turbolinks:load', function(){
  function buildHTML(message) {
    var buildImage = ''
    if (message.image) {
      buildImage = `<p class= "chat-main__body__message--image">
      <img src= ${ message.image } alt= ${ message.image }>
      </p>`;
    };
    var html = `<p class= "chat-main__body__message--name">
                ${ message.name }
                </p>
                <p class= "chat-main__body__message--time">
                ${ message.time }
                </p>
                <p class= "chat-main__body__message--content">
                ${ message.body }
                </p>
                ${ buildImage }`;
    return html;
  };

  function scrollDown() {
    var height = $('.chat-main__body__message').height()
    $('.chat-main__body').animate({ scrollTop: height }, 500)
  };

  $('#message_image').on('change', function() {
    $('#new_message').submit();
  });

  $('#new_message').on('submit', function(e) {
    e.preventDefault();
    var fd = new FormData($('#new_message')[0]);

    $.ajax({
      url: './messages',
      type: 'POST',
      data: fd,
      dataType: 'json',
      processData: false,
      contentType: false
    })

    .done(function(data) {
      var html = buildHTML(data);
      $('.chat-main__body__message').append(html);
      $('#new_message')[0].reset();
      scrollDown();
    })
    .fail(function() {
      alert('メッセージを入力してください');
    });
    return false;
  });

  if(document.URL.match("/messages")) {
    setInterval(autoupdate, 10000);
  }

  function autoupdate() {
    if ($('#new_message').val() != 0); {
      $.ajax({
        url: './messages',
        type: 'GET',
        dataType: 'json'
      })
      .done(function(data) {
        var addHTML = "";
        var newMessage = $('.chat-main__body__message--name').length;
        var Messages = data.messages.length;
        for (var i = newMessage; i < Messages; i++) {
          addHTML += buildHTML(data.messages[i]);
        };
        $('.chat-main__body__message').append(addHTML);
      })
      .fail(function() {
        alert('更新に失敗しました');
      });
    }
  };
});
