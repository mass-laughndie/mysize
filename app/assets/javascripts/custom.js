


//flash非表示
function clearBox() {
  $("#temp3").css('display', 'none');
}

setTimeout( clearBox, 3000 );


//post-menuスライドバー
document.addEventListener('turbolinks:load', function() {
  $(function(){
    $("[id^=post-nav]").on('click', function(){
      var
        str = $(this).attr("id"),
        num = str.match(/\d/g).join("");
      $('#nav-list-' + num).slideToggle('fast');
    });
  });
});


//comment返信
document.addEventListener('turbolinks:load', function() {
  $(function(){
    //同じ要素内でautolink化しているためclick発火には静的な親要素で仕込む必要あり
    $('body').on('click', '[id^=comment-reply]', function(){
      var
        cid = $(this).attr("id"),
        num = cid.match(/\d/g).join("");
        //返信先のIDを取得
        str = $('#content-name-' + num).text();
      //コメントフォームに「@ID 」を挿入しカーソル移動
      $('.comment-text-form').val("@" + str + " ").focus();
    });
  });
});


function indexId(){
  return $.ajax({
    type: 'GET',
    url: '/index?for=mysizeid&key=mysizeid',
    dataType: 'html'
  })
}

//comment返信ユーザーのリンク化
function changeLink(_iid) {
  $('.comment-content').each(function(){
    var
      txt = $(this).html(),
      exp = txt.match(/@[a-zA-Z0-9_]+\s/g);               //全「@ID 」
    if(exp != null){
      for(var i = 0; i < exp.length; i++){
        var
          elength = exp[i].length;                         //文字数
          msid = exp[i].substring(1, elength - 1);         //「ID」
        //indexid内のものと一致する場合リンク化
        if (iid.indexOf(msid) >= 0){
          var
            url = window.location.protocol + "//"
                  + window.location.host + '/'
                  + msid + "?display=square",
            str = exp[i].substring(0, elength - 1),         //「@ID」
            txt = $(this).html();             //新たに定義しないと複数置換できない
          $(this).html(txt.replace(str, "<a class='com-link' href=" + url + ">" + str + "</a>"));
        }
      }
    }
  });
}

//index_id
iid = [];

//comment送信先ユーザーリンク化
document.addEventListener('turbolinks:load', function() {
  $(function(){
    //commentがある場合
    if ($('.comment-content').length) {
      //data未取得
      if (iid.length == 0) {
        indexId().done(function(data) {
          iid = $(data).find('#index-id').text().split(/\s+/);
          iid.shift();
          iid.pop();
          changeLink(iid);
        }).fail(function(data) {
          console.log('failed loading data!!!');
          return false;
        })
      //data取得済み
      } else {
        changeLink(iid);
      }
    }
  });
});
