import * as React from 'react';
import { User } from '../../../types/commonTypes';
import { NormalPostLeft } from '../NormalPosts/NormalPostLeft';

interface Props {
  user: User;
}

const UserList = (props: Props) => {
  const { user } = props;
  return (
    <li className="link-list">
      <a className="content-link" href="<%= user_path(user) %>" />
      <div className="content-abs">
        <div className="content-height">
          <div className="list-content clear">
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
};

export { UserList };
