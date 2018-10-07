import * as React from 'react';
import { Post } from '../../types/commonTypes';

interface Props {
  post: Post;
}

const PostMenu = (props: Props) => {
  const { postType, id } = props.post;
  return (
    <React.Fragment>
      <div id={`post-nav-${postType}-${id}`} className="post-nav">
        <i className="fa fa-angle-down" />
      </div>
      <ul id={`nav-list-${postType}-${id}`} className="nav-list">
        <li>
          {/* <%= render partial: 'shared/post_delete',
                  locals: { post: post,
                            type: type } %> */}
          {/* <% if type == "Kickspost" %> */}
        </li>
        <li className="bar" />
        <li>
          {/* <%= link_to fa_icon("pencil-square-o") + " 投稿を編集する",
                    edit_kickspost_path(post.user.mysize_id, post) %> */}
        </li>
        <li className="bar" />
        <li>
          {/* <%= link_to fa_icon("twitter") + " Twitterでシェア",
                    "https://twitter.com/intent/tweet?text=" +
                    ERB::Util.url_encode(post.user.name + "さんの投稿｜" +
                                        post.title + "\n") +
                    "&url=" + kickspost_url(post.user, post),
                    class: "kpost-alink",
                    onclick: "window.open(encodeURI(decodeURI(this.href)), 'tweetwindow', 'width=650, height=470, personalbar=0, toolbar=0, scrollbars=1, sizable=1'); return false;" %> */}
        </li>
        {/* <% end %> */}
      </ul>
    </React.Fragment>
  );
};

export { PostMenu };
