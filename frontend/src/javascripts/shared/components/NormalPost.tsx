import * as React from 'react';
import { Post, User } from '../../types/commonTypes';
import { NormalPostLeft } from './NormalPostLeft';
import { NormalPostCenter } from './NormalPostCenter';
import { pseudoRandomBytes } from 'crypto';

interface Props {
  post: Post;
  user: User;
}

const NormalPost = (props: Props) => {
  const { post, user } = props;
  const encodedURI = encodeURI(`${user.name}さんの投稿｜${post.title}\n`);
  return (
    <li id={`kickspost-${post.id}`} className="link-list kpost-main clear">
      <a
        className="content-link"
        href="<%= kickspost_path(post.user, post) %>"
      />
      <div className="content-abs">
        <div className="content-height">
          <div className="list-content clear">
            <NormalPostLeft
              mysize_id={user.mysize_id}
              image_url={user.image_url}
              size={user.size}
            />
            <NormalPostCenter
              name={user.name}
              mysize_id={user.mysize_id}
              brand={post.brand}
              color={post.color}
              title={post.title}
              content={post.content}
            />
            <div className="kpost-act  kickspost-act clear">
              <div className="kpost-time">
                {/* <%= time_ago_in_words(post.created_at) %>前 */}
              </div>
              <div className="kpost-alist">
                <div className="kpost-aicon">
                  {/* <%= render partial: 'goods/good_form',
                            locals: { post: post,
                                      type: type } %> */}
                </div>
                <div className="kpost-num" id={`good-num-kickspost-${post.id}`}>
                  <a href={`/kicksposts/${post.id}/gooders`}>{'0'}</a>
                  {/* <%= link_to post.goods.size, gooders_kickspost_path(post) %> */}
                </div>
              </div>
              <div className="kpost-alist">
                <a
                  className="kpost-alink"
                  href={`${user.mysize_id}/kicksposts/${post.id}`}
                >
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
                  }/${user.mysize_id}/kicksposts/${post.id}`}
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
            <div className="kpost-right kickspost-right">
              <div className="c kpost-right-top">
                <div className="kpost-menu  kickspost-menu clear">
                  {/* <% if current_user == post.user %>
                    <%= render partial: 'shared/post_menu',
                              locals: { post: post,
                                        type: type } %>
                  <% end %> */}
                </div>
                <div className="kpost-picture abs-center">
                  <a
                    href={`/${user.mysize_id}/kicksposts/${
                      post.id
                    }?display='picture'`}
                  >
                    <img
                      className="cover lazyload"
                      src="/images/grey.gif"
                      data-src={post.picture_url}
                      alt={post.title}
                    />
                  </a>
                  <div className="kpost-size index-size">{post.size}</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </li>
  );
};

export { NormalPost };
