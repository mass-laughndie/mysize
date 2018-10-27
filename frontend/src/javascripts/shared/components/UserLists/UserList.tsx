import * as React from 'react';
import * as $ from 'jquery';
import classnames from 'classnames';
import { User } from '../../../types/commonTypes';
import { NormalPostLeft } from '../NormalPosts/NormalPostLeft';
import * as styles from '../List.module.scss';

interface Props {
  user: User;
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
    const { user } = this.props;

    return (
      <li id={`user-${user.id}`} className={styles['link-list']}>
        <a className={styles['content-link']} href={`/${user.mysize_id}`} />
        <div className={styles['content-abs']}>
          <div className={styles['content-height']}>
            <div className={classnames(styles['list-content'], styles.clear)}>
              <NormalPostLeft postUser={user} />
              <div className="index-right">
                <div className="index-upper clear">
                  <div className="index-text">
                    <div className="index-name over-name">{user.name}</div>
                    <div className="index-msid key">{`@${user.mysize_id}`}</div>
                  </div>
                  <div className="index-follow">
                    <div className="abs-center">
                      {/* <% unless current_user?(user) %>
                  <%= render partial: 'users/follow_form',
                             locals: { user: user } %>
                <% end %> */}
                    </div>
                  </div>
                </div>
                <div className="index-profile autolink key">{user.content}</div>
              </div>
            </div>
          </div>
        </div>
      </li>
    );
  }
}

export { UserList };
