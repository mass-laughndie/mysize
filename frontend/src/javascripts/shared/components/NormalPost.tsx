import * as React from 'react';
import { Post, User } from '../../types/commonTypes';
import { NormalPostLeft } from './NormalPostLeft';
import { NormalPostCenter } from './NormalPostCenter';
import { NormalPostAct } from './NormalPostAct';

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
            <NormalPostAct
              post_id={post.id}
              mysize_id={user.mysize_id}
              encodedURI={encodedURI}
            />
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
