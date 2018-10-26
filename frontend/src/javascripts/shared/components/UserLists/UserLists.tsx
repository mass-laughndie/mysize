import * as React from 'react';
import { User } from '../../../types/commonTypes';
import { UserList } from './UserList';

interface Props {
  users: User[];
}

class UserLists extends React.Component<Props> {
  private renderUserList(user: User) {
    return <UserList user={user} />;
  }

  public render() {
    const { users } = this.props;
    return <ul>{users.map(user => this.renderUserList(user))}</ul>;
  }
}

export default UserLists;
