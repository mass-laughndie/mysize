import * as React from 'react';

interface Props {
  post_id: number;
  mysize_id: string;
  encodedURI: string;
}

const NormalPostAct = (props: Props) => {
  const { post_id, mysize_id, encodedURI } = props;
  return (
    <div className="kpost-act  kickspost-act clear">
      <div className="kpost-alist">
        <div className="kpost-aicon">
          {/* <%= render partial: 'goods/good_form',
                            locals: { post: post,
                                      type: type } %> */}
        </div>
        <div className="kpost-num" id={`good-num-kickspost-${post_id}`}>
          <a href={`/kicksposts/${post_id}/gooders`}>{'0'}</a>
          {/* <%= link_to post.goods.size, gooders_kickspost_path(post) %> */}
        </div>
      </div>
      <div className="kpost-alist">
        <a className="kpost-alink" href={`${mysize_id}/kicksposts/${post_id}`}>
          <div className="kpost-aicon">
            <i className="fa fa-comment-o" />
          </div>
          <div className="kpost-num">
            <span>
              {'0'}
              {/* {post.comments.size} */}
            </span>
          </div>
        </a>
      </div>
      <div className="kpost-alist alist-last">
        <a
          className="kpost-alink"
          href={`https://twitter.com/intent/tweet?text=${encodedURI}&url=${
            window.location.origin
          }/${mysize_id}/kicksposts/${post_id}`}
          // onclick="window.open(encodeURI(decodeURI(this.href)), 'tweetwindow', 'width=650, height=470, personalbar=0, toolbar=0, scrollbars=1, sizable=31'); return false;"
        >
          <div className="kpost-aicon">
            <i className="fa fa-twitter" />
          </div>
        </a>
        {/* <%= link_to "https://twitter.com/intent/tweet?text=" +
              ERB::Util.url_encode(post.user.name + "さんの投稿｜" +
                                    post.title + "\n") +
              "&url=" + kickspost_url(post.user, post),
              className: "kpost-alink",
              onclick: "window.open(encodeURI(decodeURI(this.href)), 'tweetwindow', 'width=650, height=470, personalbar=0, toolbar=0, scrollbars=1, sizable=1'); return false;" do %>
              <div className="kpost-aicon">
                <i className='fa fa-twitter' />
                <%= fa_icon('twitter') %>
              </div>
            <% end %> */}
      </div>
    </div>
  );
};

export { NormalPostAct };
