import * as React from 'react';
import { Post } from '../../types/commonTypes';
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
  const twitterShareUrl = (post: Post): string => {
    const encodedURI = encodeURI(
      `${post.postUser.name}さんの投稿｜${post.title}\n`
    );
    return `https://twitter.com/intent/tweet?text=${encodedURI}&url=${
      window.location.origin
    }/${post.postUser.mysize_id}/kicksposts/${post.id}`;
  };

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
              twitterShareUrl={twitterShareUrl(post)}
              logged_in={logged_in}
            />
            <NormalPostRight
              post={post}
              twitterShareUrl={twitterShareUrl(post)}
            />
          </div>
        </div>
      </div>
    </li>
  );
};

export { NormalPost };
