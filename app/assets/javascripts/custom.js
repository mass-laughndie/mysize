

//flash非表示
document.addEventListener('turbolinks:load', function() {
  $(function(){
    setTimeout( function(){
      $("#flash").css('display', 'none');
    }, 3000);
  });
});


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
    dataType: 'html',
    timeout: 20000
  })
}

//comment返信ユーザーのリンク化
function changeLink(_iid) {
  $('.autolink').each(function(){
    var
      txt = $(this).html(),
      exp = txt.match(/@[a-zA-Z0-9_]+\s/g);                //全「@ID 」
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
    //.autolinkがある場合
    if ($('.autolink').length) {
      //data未取得
      if (iid.length == 0) {
        indexId().done(function(data) {
          iid = $(data).find('#index-id').text().split(/\s+/);
          iid.shift();
          iid.pop();
          changeLink(iid);
        }).fail(function(data) {
          alert('ページの読み込みに失敗しました。電波の良い場所で再度読み込んでください。');
          return false;
        })
      //data取得済み
      } else {
        changeLink(iid);
      }
    }
  });
});


//高さ自動調整リンク
document.addEventListener('turbolinks:load', function() {
  $(function(){
    $('.link-list').each(function() {
      //子要素(=absolute要素内の固定長要素)の高さ
      var height = $(this).find('.content-height').height();
      //親要素を子要素の高さで確保
      $(this).height(height);
      //同長のリンクcover生成
      $(this).find(".content-link").css('padding-bottom', height);
    });
  });
});


//現在位置ボタンの色変換
document.addEventListener('turbolinks:load', function(){
  $(function(){
    $('.alist').each(function(){
      var
        fullPath = location.pathname + location.search,
        link = $(this).find('a'),
        linkPath = link.attr("href");
      if(fullPath == linkPath) {
        link.addClass("active");
      }
    });
  });
});


//未ログインアラートボタン
document.addEventListener('turbolinks:load', function(){
  $(function(){
    $('.ban').on('click', function(){
      alert('登録またはログインしてください！');
      return false;
    });
  });
});


//画像ファイルプレビュー
document.addEventListener('turbolinks:load', function() {
  $(function(){
    //from内の該当要素を選択されたら(ファイルを選択しないときは発火しない)
    $('form').on('change', 'input[type="file"]', function(e) {
      var
        file = e.target.files[0],   //ファイルオブジェクト
        reader = new FileReader(),
        $preview = $('.preview');

      //fileが選択されなかった || fileタイプがimageでないとき => 実効終了
      if ( file == undefined || file.type.indexOf('image') < 0){
        return false;
      }

      //読み込み成功して完了(onload)
      reader.onload = (function(file) {
        return function(e) {
          //既存のプレビュー削除
          $preview.empty();
          //プレビュー挿入
          $preview.append($('<img>').attr({
            src: e.target.result,
            width: "35%",
            class: "cover",
            title: file.name
          }));
          $('.upload-icon').empty();
          $('.upload-icon').append($('<i>').attr('class', 'fa fa-refresh'));
        };
      })(file);
      //ファイルをURLとして読み込む
      reader.readAsDataURL(file);
    });
  });
});

//textareaの高さ自動変更(要縮小対応[※/**/のはカクつく])
document.addEventListener('turbolinks:load', function() {
  $(function(){
    $('.autoheight').on('keyup', function(e){
      var
        $textarea = $(e.target),
        allHeight = e.target.scrollHeight,     //スクロールを含めた全体の高さ
        areaHeight = e.target.offsetHeight;    //要素(textarea)の高さ

      if(allHeight > areaHeight) {
        $textarea.height(allHeight);
      }/*else {
        //line-heightの値を取得
        var lineHeight = Number($textarea.css('lineHeight').split('px')[0]);
        while (true) {
          //1行分ずつ縮小する
          $textarea.height($textarea.height() - lineHeight);
          if(allHeight > areaHeight){
            $textarea.height(allHeight);
          }
          break;
        }
        console.log("!!!!");
      }*/
    });
  });
});