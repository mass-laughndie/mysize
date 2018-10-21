import * as React from 'react';
import { Post } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './SquarePost.module.scss';

interface Props {
  post: Post;
}

const SquarePost = (props: Props) => {
  const { id, title, size, picture_url } = props.post;
  const { mysize_id } = props.post.postUser;
  return (
    <li id={`square-${id}`} className={classnames(styles['square-list'])}>
      <div className={classnames(styles['square-picture'])}>
        <a href={`/${mysize_id}/kicksposts/${id}`}>
          <img
            className={classnames(styles.cover, 'lazyload')}
            src="/images/grey.gif"
            data-src={picture_url}
            alt={title}
          />
        </a>
      </div>
      <div className={classnames(styles['square-size'])}>
        {typeof size === 'number' && size.toFixed(1)}
      </div>
    </li>
  );
};

export { SquarePost };
