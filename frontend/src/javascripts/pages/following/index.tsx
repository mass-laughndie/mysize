import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { gon } from '../../types/window';
import UserLists from '../../shared/components/UserLists';

const users = gon.followingUsers;
const currentInfo = gon.currentInfo;

ReactDOM.render(
  <UserLists users={users} currentInfo={currentInfo} />,
  document.querySelector('[data-react-entry="FollowingUserLists"]')
);
