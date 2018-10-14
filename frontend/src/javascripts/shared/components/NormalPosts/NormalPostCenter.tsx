import * as React from 'react';
import { Post } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './NormalPost.module.scss';

interface Props {
  post: Post;
}

const NormalPostCenter = (props: Props) => {
  const { brand, color, title, content } = props.post;
  const { name, mysize_id } = props.post.postUser;

  return (
    <div
      className={classnames(styles['kpost-center'], styles['kickspost-center'])}
    >
      <div className={classnames(styles['kpost-name'], styles['over-name'])}>
        <a href={`/${mysize_id}`}>
          {name}
          <span>{`@${mysize_id}`}</span>
        </a>
      </div>
      <div className={styles['kpost-brand']}>
        <span>{brand}</span>
      </div>
      <div className={styles['kpost-title']}>
        <h2>
          {`${title} `}
          <span>{`( ${color} )`}</span>
        </h2>
      </div>
      <div
        className={classnames(
          styles['kpost-content'],
          'autolink',
          styles['over-text']
        )}
      >
        <span>{content}</span>
      </div>
    </div>
  );
};

export { NormalPostCenter };
