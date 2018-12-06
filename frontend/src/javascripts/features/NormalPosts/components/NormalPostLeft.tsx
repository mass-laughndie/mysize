import * as React from 'react';
import { User } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './NormalPost.module.scss';

interface Props {
  postUser: User;
}

const NormalPostLeft = (props: Props) => {
  const cx = classnames.bind(styles);
  const { mysize_id, image_url, size } = props.postUser;
  const image = image_url != null ? image_url : '/images/default1.png';
  return (
    <div className={cx('c', 'index-left', 'kpost-left')}>
      <div className={cx('index-image', 'kpost-icon', 'abs-center')}>
        <a className={cx('list-image')} href={`/${mysize_id}?display=square`}>
          <img src={image} alt={mysize_id} width="40" height="40" />
        </a>
        <div className={cx('index-size', 'kpost-shoesize')}>
          <span>{size.toFixed(1)}</span>
        </div>
      </div>
    </div>
  );
};

export { NormalPostLeft };
