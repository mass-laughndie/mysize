import * as React from 'react';
import classnames from 'classnames';
import { User, CurrentInfo } from '../../../types/commonTypes';
import FollowForm from '../../FollowForm/components';
import * as styles from './UserListContent.module.scss';

interface Props {
  user: User;
  currentInfo: CurrentInfo;
}

const UserListContent = (props: Props) => {
  const cx = classnames.bind(styles);
  const { user, currentInfo } = props;
  const { name, mysize_id, content, isMyself } = user;

  return (
    <div className={styles['user-list-content']}>
      <div className={cx('user-list-upper', 'clear')}>
        <div className={styles['user-list-text']}>
          <div className={cx('user-list-name', 'over-name')}>{name}</div>
          <div className={cx('user-list-msid', 'key')}>{`@${mysize_id}`}</div>
        </div>
        <div className='user-list-follow'>
          <div className='abs-center'>
            {!isMyself && <FollowForm user={user} isLoggedIn={currentInfo.isLoggedIn} />}
          </div>
        </div>
      </div>
      <div className='index-profile autolink key'>{content}</div>
    </div>
  );
};

export { UserListContent };
