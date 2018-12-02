import * as React from 'react';
import * as $ from 'jquery';
import classnames from 'classnames';
import { User, CurrentInfo } from '../../../types/commonTypes';
import { NormalPostLeft } from '../../NormalPosts/components/NormalPostLeft';
import * as styles from '../../../modules/Shared/components/List.module.scss';
import { UserListContent } from './UserListContent';

interface Props {
  user: User;
  currentInfo: CurrentInfo;
}

class UserList extends React.Component<Props> {
  public componentDidMount() {
    const { id } = this.props.user;
    const $linkList = $(`#user-${id}`);
    const height = $linkList.find('.content-height').height();
    $linkList.height(height);
    $linkList.find('.content-link').css('padding-bottom', height);
  }

  public render() {
    const cx = classnames.bind(styles);
    const { user, currentInfo } = this.props;

    return (
      <li id={`user-${user.id}`} className={styles['link-list']}>
        <a className={styles['content-link']} href={`/${user.mysize_id}`} />
        <div className={styles['content-abs']}>
          <div className={styles['content-height']}>
            <div className={cx('list-content', 'clear')}>
              <NormalPostLeft postUser={user} />
              <UserListContent user={user} currentInfo={currentInfo} />
            </div>
          </div>
        </div>
      </li>
    );
  }
}

export { UserList };
