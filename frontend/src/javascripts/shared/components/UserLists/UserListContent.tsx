import * as React from 'react';
import classnames from 'classnames';
import { User } from '../../../types/commonTypes';
import * as styles from './UserListContent.module.scss';

interface Props {
  user: User;
}

const UserListContent = (props: Props) => {
  const { name, mysize_id, content } = props.user;

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
            {/* <% unless current_user?(user) %>
                  <%= render partial: 'users/follow_form',
                             locals: { user: user } %>
                <% end %> */}
          </div>
        </div>
      </div>
      <div className="index-profile autolink key">{content}</div>
    </div>
  );
};

export { UserListContent };
