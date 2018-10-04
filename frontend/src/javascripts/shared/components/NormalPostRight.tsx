import * as React from 'react';

interface Props {
  post_id: number;
  mysize_id: string;
  picture_url: string;
  size: number;
  title: string;
  postType: string;
}

const NormalPostRight = (props: Props) => {
  const { post_id, mysize_id, picture_url, size, title, postType } = props;
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
          <a href={`/${mysize_id}/kicksposts/${post_id}?display='picture'`}>
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
