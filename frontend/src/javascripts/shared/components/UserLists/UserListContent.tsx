import * as React from 'react';
import classnames from 'classnames';
import { User, CurrentInfo } from '../../../types/commonTypes';
import FollowForm from '../FollowForm/FollowForm';
import * as styles from './UserListContent.module.scss';

interface Props {
  user: User;
  currentInfo: CurrentInfo;
}

const UserListContent = (props: Props) => {
  const { user, currentInfo } = props;
  const { name, mysize_id, content, isMyself } = user;

  return (
    <div className={styles['user-list-content']}>
      <div className={classnames(styles['user-list-upper'], styles.clear)}>
        <div className={styles['user-list-text']}>
          <div
            className={classnames(
              styles['user-list-name'],
              styles['over-name']
            )}
          >
            {name}
          </div>
          <div
            className={classnames(styles['user-list-msid'], 'key')}
          >{`@${mysize_id}`}</div>
        </div>
        <div className="user-list-follow">
          <div className="abs-center">
            {!isMyself && <FollowForm user={user} currentInfo={currentInfo} />}
          </div>
        </div>
      </div>
      <div className="index-profile autolink key">{content}</div>
    </div>
  );
};

export { UserListContent };
