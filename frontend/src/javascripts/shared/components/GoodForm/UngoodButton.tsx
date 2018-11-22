import * as React from 'react';
import classnames from 'classnames';
import * as styles from './GoodForm.module.scss';
import { Post } from '../../../types/commonTypes';

interface Props {
  post: Post;
  onClick: React.ReactEventHandler<HTMLElement>;
}

const UngoodButton = (props: Props) => {
  const cx = classnames.bind(styles);

  return (
    <div className={cx('form-ungood')}>
      <a onClick={props.onClick}>
        <i className={classnames('fa', 'fa-thumbs-up')} />
      </a>
    </div>
  );
};

export { UngoodButton };
