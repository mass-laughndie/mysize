import * as React from 'react';
import classnames from 'classnames';
import { User } from '../../../types/commonTypes';
import * as styles from './FollowForm.module.scss';

interface Props {
  user: User;
  onClick: React.ReactEventHandler<HTMLElement>;
}

const UnfollowButton = (props: Props) => {
  const cx = classnames.bind(styles);

  return (
    <div className={cx('form-unfollow')}>
      <a onClick={props.onClick}>
        <i className="fa fa-user" />
        <i className="fa fa-check" />
      </a>
    </div>
  );
};

export { UnfollowButton };
