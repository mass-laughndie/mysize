import * as React from 'react';
import { User } from '../../../types/commonTypes';

interface Props {
  user: User;
}

const UserListContent = (props: Props) => {
  const { name, mysize_id, content } = props.user;

  return (
    <div className="index-right">
      <div className="index-upper clear">
        <div className="index-text">
          <div className="index-name over-name">{name}</div>
          <div className="index-msid key">{`@${mysize_id}`}</div>
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
      <div className="index-profile autolink key">{content}</div>
    </div>
  );
};

export { UserListContent };
