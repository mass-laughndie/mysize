
//escape
function escapeHtml(string) {
  if (typeof string !== 'string' ) {
    return string;
  }

  return string.replace(/[&'`"<>=\/]/g, function(match) {
    return {
      '&': '&amp;',
      "'": '&#x39;',
      '`': '&#x60;',
      '"': '&quot;',
      '/': '&#x2F;',
      '<': '&lt;',
      '>': '&gt;',
      '=': '&#x3D;'
    }[match]
  });
}

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
    $("[id^=post-nav-comment]").on('click', function(){
      var
        str = $(this).attr("id"),
        num = str.match(/\d/g).join("");
      $('#nav-list-comment-' + num).slideToggle('fast');
    });

    $("[id^=post-nav-kickspost]").on('click', function(){
      var
        str = $(this).attr("id"),
        num = str.match(/\d/g).join("");
      $('#nav-list-kickspost-' + num).slideToggle('fast');
    });
  });
});


//comment返信(reply_idの設定,自動focus)
document.addEventListener('turbolinks:load', function() {
  $(function() {
    //同じ要素内でautolink化しているためclick発火には静的な親要素で仕込む必要あり
    $('body').on('click', '[id^=comment-reply]', function() {
      var
        cid = $(this).attr('id'),
        comID = cid.match(/\d/g).join(''),                     //comment.id
        forIDs = $('#content-name-' + comID).text(),           //返信先の親@IDを取得(返信相手全@ID配列)
        comLink = $('#comment-' + comID).find('.id-link'),    //親の返信相手オブジェクト
        myID = '@' + $('#my-icon').attr('alt'),                //自分の@ID
        rclass = $('#comment-' + comID).attr('class'),
        replyID = rclass.match(/\d/g).join('');                //返信先のcomment.reply_id

      //reply_id　== 0(返信先がコメントの場合)
      if (replyID == 0 ) {
        $('#reply-id').attr('value', comID);          //返信先のIDを挿入(=>reply_id)
      //それ以外(返信先がリプライの場合)
      } else {
        $('#reply-id').attr('value', replyID);        //元のコメントのIDを挿入(=>reply_id)
      }


      //親の返信相手がいる場合
      if ( comLink.length ) {
        var parentID = forIDs;               //親@iD複製(forIDs更新のため)
        //各返信相手において
        comLink.each(function(){
          var rid = $(this).text();   //  返信相手の@ID
          //@IDが親と自分と違う場合
          if ( rid != parentID && rid != myID ) {
            forIDs = forIDs + ' ' + $(this).text();   //@ID連結
          }
        });
      }
      //コメントフォームに「@ID (@ID ...)」を挿入しカーソル移動
      $('.comment-text-form').val(forIDs + " ").focus();
    });
  });
});

//ポスト内容の改行挿入
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('.post-text').each(function() {
      var txt = escapeHtml($(this).text());
      txt = txt.replace(/\r\n|\r/g, '\n').replace(/\n/g, '<br>');
      $(this).html(txt);
    });
  });
});

//reply_idチェック(@IDがない場合 => reply_id:　0　に変える)
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('#comment-button').on('click', function() {
      var
        content = $('#comment_content').val(),
        uid = content.match(/@[a-zA-Z0-9_]+\s/g);
      if ( uid == null ) {
        $('#reply-id').attr('value', 0);
      }
    });
  });
});


//コメントフォーム自動拡張&格納
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('.comment-text-form').focus( function() {
      $('.comment-form').css('height', '181px');
    }).blur( function() {
      $('.comment-form').css('height', '71px');
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


//@IDのリンク化
function changeLink(_iid) {
  $('.autolink').each(function(){
    var
      txt = $(this).html(),
      exp = txt.match(/@[a-zA-Z0-9_]+?(\s|<br>|<\/span>)/g);    //全「@ID(空白|<br>|</span>)」
    exp = Array.from(new Set(exp));                        //重複削除
    if(exp != null){
      for(var i = 0; i < exp.length; i++){
        var
          elength = exp[i].length,                            //文字数
          msid = exp[i].replace(/@|\s|<br>|<\/span>/g, '');   //「ID」
        //indexid内のものと一致する場合リンク化
        if (iid.indexOf(msid) >= 0) {
          var
            url = window.location.protocol + "//"
                  + window.location.host + '/'
                  + msid + "?display=square",                 //リンクURL
            str = exp[i].replace(/\s|<br>|<\/span>/g, ''),    //「@ID」
            option = exp[i].replace(str, ''),                 //msidの後続
            txt = $(this).html(),             //新たに定義しないと複数置換できない
            //new RegExp(exp[i], 'g')で重複を一括replace
            //exp[i]は重複(=完全一致)以外は一意の文字列のため、exp[i]でreplaceして削られるoptionを後から追加
            replaceText = txt.replace(new RegExp(exp[i], 'g'), "<a class='id-link' href=" + escapeHtml(url) + ">" + escapeHtml(str) + "</a>" + option);
          $(this).html(replaceText);
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


//indexリンクの高さ自動調整
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

//textareaの高さ自動変更(要縮小対応[※のはカクつく])
document.addEventListener('turbolinks:load', function() {
  $(function(){
    if ($('.autoheight').length) {
      var maxHeight = $('.autoheight').css('maxHeight').split('px')[0];
      $('.autoheight').on('keyup', function(e){
        var
          $textarea = $(e.target),
          allHeight = e.target.scrollHeight,     //スクロールを含めた全体の高さ
          areaHeight = e.target.offsetHeight;    //要素(textarea)の高さ

        if(allHeight < maxHeight && allHeight > areaHeight) {
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
        }*/
      });
    }
  });
});

/* (autolinkとの相性×)
//searchの該当文字を太文字に変更(要com-link内検索対応)
document.addEventListener('turbolinks:load', function() {
  $(function() {
    if ( $('#keyword').length ) {
      var
        keyword = $('#keyword').val(),            //フォーム入力文字
        keywords = keyword.split(/ |　/g);         //空白(全||半)で区切って配列ｌ化

      keywords = keywords.filter(v => v);         //空文字を配列から削除
      //keywordsがある場合
      if ( keywords.length ){
        $('.key').each(function() {
          //各keywordにおいて
          for( var i = 0; i < keywords.length; i++ ) {
            var
              txt = $(this).html(),
              replaceText = txt.replace(keywords[i], '<span class="match">' + keywords[i] + '</span>');
            $(this).html(replaceText);
          }
        });
      }
    }
  });
});
*/

//ハッシュタグのリンク化
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('.autolink').each(function(){
      var
        txt = $(this).html(),
        exp = txt.match(/#\S+?(\s|<br>)/g),     //全「#(任意の文字列)(空白or<br>」
        exp = Array.from(new Set(exp));         //重複削除
    if ( exp != null ){
      for ( var i = 0; i < exp.length; i++ ) {
        var
          elength = exp[i].length,                          //文字数
          word = exp[i].replace(/\s|<br>|<\/span>/g, ''),   //「#(任意の文字列)」
          option = exp[i].replace(word, ''),                //wordの後続
          key = "%23" + word.slice(1),                       //「#」削除
          url = '/search?for=post&keyword=' + key,        //リンクURL
          txt = $(this).html();             //新たに定義しないと複数置換できない
          //new RegExp(exp[i], 'g')で重複を一括replace
          //exp[i]は重複(=完全一致)以外は一意の文字列のため、exp[i]でreplaceして削られるoptionを後から追加
        var replaceText = txt.replace(new RegExp(exp[i], 'g'), "<a class='tag-link' href=" + url + ">" + word + "</a>" + option);
        $(this).html(replaceText);
        }
      }
    });
  });
});

/*
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('img.lazyload').lazyload({
      threshold: 0,
      effect: 'fadeIn',
      effect_speed: 10000,
      placeholder: "/images/grey.gif",
    });
  });
});
*/

function jumpScroll(_this, _point){
  var target = $(_point == '#' || _point == '' ? $('html') : _point );
  if ( target.length == '0' ) target = $('html');
  var
    position = target.offset().top,
    move = _this.data('scroll');
  if ( move !== undefined ) position = position + Number(move);
  if ( position <= 0 ) position = 1;
  $("html, body").animate( { scrollTop : position }, 500, 'swing');
}

//ページ遷移 or アンカーポイントへジャンプ
document.addEventListener('turbolinks:load', function() {
  $(function() {
    $('body').on('click', '.jump', function(e) {
      var
        _this = $(this);
        link = _this.attr('href'),
        index = link.indexOf('#comment'),
        point = link.slice(index),
        linkPath = link.replace(point, ''),
        nowPath = window.location.pathname;
      if ( linkPath != nowPath ) {
        window.location.href = linkPath + escapeHtml(point);
        return false;
      }

      if ( point.match(/#comment/) != null ) {
        e.preventDefault();          //リクエストキャンセル
        jumpScroll(_this, point);
      }
      return false;
    });
  });
});

//ページ遷移後、アンカーポイントへジャンプ
document.addEventListener('turbolinks:load', function() {
  $(function() {
    if ( $('.jump').length != '0' ) {
      var
        _hash = escapeHtml(window.location.hash);

      console.log(_hash);
      if ( _hash !== '' ) {
        $(_hash).css('background', 'rgba(255, 0, 0, 0.05)');
        jumpScroll($('.jump'), _hash);
      }
    }
    return false;
  });
});