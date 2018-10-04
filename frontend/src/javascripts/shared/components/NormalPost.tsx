import * as React from 'react';
import { Post, User } from '../../types/commonTypes';
import { NormalPostLeft } from './NormalPostLeft';
import { NormalPostCenter } from './NormalPostCenter';
import { NormalPostAct } from './NormalPostAct';
import { NormalPostRight } from './NormalPostRight';

interface Props {
  post: Post;
  user: User;
  logged_in: boolean;
}

const NormalPost = (props: Props) => {
  const { post, user, logged_in } = props;
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
              logged_in={logged_in}
              postType={post.postType}
              goodNum={post.goodNum}
              commentNum={post.commentNum}
              isGood={post.isGood}
            />
            <NormalPostRight
              post_id={post.id}
              mysize_id={user.mysize_id}
              picture_url={post.picture_url}
              size={post.size}
              title={post.title}
              postType={post.postType}
            />
          </div>
        </div>
      </div>
    </li>
  );
};

export { NormalPost };
