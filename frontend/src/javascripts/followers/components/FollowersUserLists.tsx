import * as React from 'react';
import { gon } from '../../types/window';
import UserLists from '../../shared/components/UserLists/UserLists';

const users = gon.followedUsers;
const currentInfo = gon.currentInfo;

class FollowersUserLists extends React.Component {
  render() {
    return <UserLists users={users} currentInfo={currentInfo} />;
  }
}

export default FollowersUserLists;
