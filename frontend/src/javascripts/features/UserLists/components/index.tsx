import * as React from 'react';
import { User, CurrentInfo } from '../../../types/commonTypes';
import { UserList } from './UserList';

interface Props {
  users: User[];
  currentInfo: CurrentInfo;
}

class UserLists extends React.Component<Props> {
  private renderUserList(user: User) {
    const { currentInfo } = this.props;
    return <UserList key={user.id} user={user} currentInfo={currentInfo} />;
  }

  public render() {
    const { users } = this.props;
    return <ul>{users.map((user) => this.renderUserList(user))}</ul>;
  }
}

export default UserLists;
