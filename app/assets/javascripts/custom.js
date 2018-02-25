
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
    $('[id^=comment-reply]').on('click', function(){
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

/*
function load(_url){
  var xhr;
  xhr = new XMLHttpRequest();
  xhr.open("GET", _url, true);
  xhr.send(null);
  console.log("???")
  return xhr.status;
}
*/

//commentリンク
document.addEventListener('turbolinks:load', function() {
  $(function(){
    if($('.comment-content').length) {
      $('.comment-content').each(function(){
        var
          txt = $(this).html(),
          exp = txt.match(/@[a-zA-Z0-9_]+\s/g);               //全「@ID 」
        if(exp != null){
          for(var i = 0; i < exp.length; i++){
            var
              elength = exp[i].length;                         //文字数
              msid = exp[i].substring(1, elength - 1);         //「ID」
              url = window.location.protocol + "//"
                    + window.location.host + '/'
                    + msid + "?display=square";
              str = exp[i].substring(0, elength - 1);          //「@ID」
            var txt = $(this).html();             //新たに定義しないと複数置換できない
            $(this).html(txt.replace(str, "<a class='com-link' href=" + url + ">" + str + "</a>"));
          }
        }
      });
    }
  });
});