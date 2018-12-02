import * as React from 'react';
import classnames from 'classnames';
import * as styles from './GoodForm.module.scss';
import { Post } from '../../../types/commonTypes';

interface Props {
  post: Post;
  onClick: React.ReactEventHandler<HTMLElement>;
}

const GoodButton = (props: Props) => {
  const cx = classnames.bind(styles);

  return (
    <div className={cx('form-good')}>
      <a onClick={props.onClick}>
        <i className="fa fa-thumbs-o-up" />
      </a>
    </div>
  );
};

export { GoodButton };
