import * as React from 'react';
import { Post } from '../../../types/commonTypes';
import PostMenu from '../PostMenu';
import classnames from 'classnames';
import * as styles from './NormalPost.module.scss';

interface Props {
  post: Post;
  twitterShareUrl: string;
}

const NormalPostRight = (props: Props) => {
  const { id, picture_url, size, title, postType, isMyPost } = props.post;
  const { twitterShareUrl } = props;
  const { mysize_id } = props.post.postUser;

  return (
    <div
      className={classnames(styles['kpost-right'], styles[`${postType}-right`])}
    >
      <div className={classnames(styles.c, styles['kpost-right-top'])}>
        <div
          className={classnames(
            styles['kpost-menu'],
            styles[`${postType}-menu`],
            styles.clear
          )}
        >
          {isMyPost && (
            <PostMenu post={props.post} twitterShareUrl={twitterShareUrl} />
          )}
        </div>
        <div
          className={classnames(styles['kpost-picture'], styles['abs-center'])}
        >
          <a href={`/${mysize_id}/kicksposts/${id}?display='picture'`}>
            <img
              className={classnames(styles.cover, 'lazyload')}
              src="/images/grey.gif"
              data-src={picture_url}
              alt={title}
            />
          </a>
          <div
            className={classnames(styles['kpost-size'], styles['index-size'])}
          >
            {size.toFixed(1)}
          </div>
        </div>
      </div>
    </div>
  );
};

export { NormalPostRight };
