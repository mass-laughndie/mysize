import * as React from 'react';
import { User } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './NormalPost.module.scss';

interface Props {
  postUser: User;
}

const NormalPostLeft = (props: Props) => {
  const { mysize_id, image_url, size } = props.postUser;
  return (
    <div
      className={classnames(
        styles.c,
        styles['index-left'],
        styles['kpost-left']
      )}
    >
      <div
        className={classnames(
          styles['index-image'],
          styles['kpost-icon'],
          styles['abs-center']
        )}
      >
        <a
          className={styles['list-image']}
          href={`/${mysize_id}?display=square`}
        >
          <img src={image_url} alt={mysize_id} width="40" height="40" />
        </a>
        <div
          className={classnames(styles['index-size'], styles['kpost-shoesize'])}
        >
          <span>{size}</span>
        </div>
      </div>
    </div>
  );
};

export { NormalPostLeft };
