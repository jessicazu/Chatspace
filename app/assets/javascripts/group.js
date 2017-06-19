$(document).on('turbolinks:load', function(){
  function buildHTML(user) {
    var html = `<li class='chat-group-user clearfix'>
                <div class='chat-group-user__name'>${ user.name }</div>
                <div class='chat-group-user__btn chat-group-user__btn--add'
                data-name="${ user.name }" data-id="${ user.id }">追加</div>
                  </li>`;
    return html;
  };

  function removeHTML(user) {
    var html = `<li class='chat-group-user clearfix'>
                  <div class='chat-group-user__name'>${ user.name }</div>
                  <div class='chat-group-user__btn
                  chat-group-user__btn--remove'>削除</div>
                  <input type='hidden' value="${ user.id }" name="group[user_ids][]">
                </li>`;
    return html;
  };

  $('.chat-group-form__input').on('keyup',function(){
    $('#user-search-result').empty();
    var input = $('#user-search-field').val();
    $.ajax ({
      type: 'GET',
      url: '/users/search',
      data: { keyword: input },
      dataType: 'json',
    })
    .done(function(data) {
      var addHtml = "";
      var users = data.users;
      if (input.length !== 0) {
        $.each (users, function(i, user) {
          addHtml += buildHTML(user);
        });
      };
      $('#user-search-result').append(addHtml);
    })
    .fail(function() {
      alert('もう一度入力してください');
    });
  });

  $('#user-search-result').on('click', '.chat-group-user__btn--add', function() {
    var name = $(this).data(name);
    var id = $(this).data(id);
    var responseHTML = removeHTML(name, id);
    $('#chat-group-users').append(responseHTML);
    $('this').parent('.chat-group-form__field--right').remove();
  });

  $('#chat-group-users').on('click', '.chat-group-user__btn--remove', function() {
    $(this).parent().remove();
  });
});
