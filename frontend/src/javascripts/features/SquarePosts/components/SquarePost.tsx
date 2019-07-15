import * as React from 'react';
import { Post } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './SquarePost.module.scss';

interface Props {
  post: Post;
}

const SquarePost = (props: Props) => {
  const cx = classnames.bind(styles);
  const { id, title, size, picture_url } = props.post;
  const { mysize_id } = props.post.postUser;
  return (
    <li id={`square-${id}`} className={cx('square-list')}>
      <div className={cx('square-picture')}>
        <a href={`/${mysize_id}/kicksposts/${id}`}>
          <img className={cx(styles.cover, 'lazyload')} src='/images/grey.gif' data-src={picture_url} alt={title} />
        </a>
      </div>
      <div className={cx('square-size')}>{typeof size === 'number' && size.toFixed(1)}</div>
    </li>
  );
};

export { SquarePost };
