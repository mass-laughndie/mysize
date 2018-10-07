import * as React from 'react';
import { Post, User } from '../../types/commonTypes';
import { NormalPostLeft } from './NormalPostLeft';
import { NormalPostCenter } from './NormalPostCenter';
import { NormalPostAct } from './NormalPostAct';
import { NormalPostRight } from './NormalPostRight';

interface Props {
  post: Post;
  logged_in: boolean;
}

const NormalPost = (props: Props) => {
  const { post, logged_in } = props;
  const encodedURI = encodeURI(
    `${post.postUser.name}さんの投稿｜${post.title}\n`
  );
  return (
    <li id={`kickspost-${post.id}`} className="link-list kpost-main clear">
      <a
        className="content-link"
        href="<%= kickspost_path(post.user, post) %>"
      />
      <div className="content-abs">
        <div className="content-height">
          <div className="list-content clear">
            <NormalPostLeft postUser={post.postUser} />
            <NormalPostCenter post={post} />
            <NormalPostAct
              post={post}
              encodedURI={encodedURI}
              logged_in={logged_in}
            />
            <NormalPostRight post={post} />
          </div>
        </div>
      </div>
    </li>
  );
};

export { NormalPost };
