import * as React from 'react';
import { Post } from '../../types/commonTypes';

interface Props {
  post: Post;
}

const NormalPostRight = (props: Props) => {
  const { id, picture_url, size, title, postType } = props.post;
  const { mysize_id } = props.post.postUser;

  return (
    <div className={`kpost-right ${postType}-right`}>
      <div className="c kpost-right-top">
        <div className={`kpost-menu  ${postType}-menu clear`}>
          {/* <% if current_user == post.user %>
                <%= render partial: 'shared/post_menu',
                          locals: { post: post,
                                    type: type } %>
              <% end %> */}
        </div>
        <div className="kpost-picture abs-center">
          <a href={`/${mysize_id}/kicksposts/${id}?display='picture'`}>
            <img
              className="cover lazyload"
              src="/images/grey.gif"
              data-src={picture_url}
              alt={title}
            />
          </a>
          <div className="kpost-size index-size">{size}</div>
        </div>
      </div>
    </div>
  );
};

export { NormalPostRight };
