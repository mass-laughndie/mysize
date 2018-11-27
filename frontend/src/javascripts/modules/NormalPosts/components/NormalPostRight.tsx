import * as React from 'react';
import { Post } from '../../../types/commonTypes';
import PostMenu from '../../shared/components/PostMenu';
import classnames from 'classnames';
import * as styles from './NormalPost.module.scss';

interface Props {
  post: Post;
  twitterShareUrl: string;
}

const NormalPostRight = (props: Props) => {
  const cx = classnames.bind(styles);
  const { id, picture_url, size, title, postType, isMyPost } = props.post;
  const { twitterShareUrl } = props;
  const { mysize_id } = props.post.postUser;
  const isKickspost = postType === 'kickspost';

  return (
    <div className={cx('kpost-right', `${postType}-right`)}>
      <div className={cx('c', 'kpost-right-top')}>
        <div className={cx('kpost-menu', `${postType}-menu`, 'clear')}>
          {isMyPost && (
            <PostMenu post={props.post} twitterShareUrl={twitterShareUrl} />
          )}
        </div>
        {isKickspost && (
          <div className={cx('kpost-picture', 'abs-center')}>
            <a href={`/${mysize_id}/kicksposts/${id}?display='picture'`}>
              <img
                className={cx('cover', 'lazyload')}
                src="/images/grey.gif"
                data-src={picture_url}
                alt={title}
              />
            </a>
            <div className={cx('kpost-size', 'index-size')}>
              {typeof size === 'number' ? size.toFixed(1) : 0.0}
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export { NormalPostRight };
