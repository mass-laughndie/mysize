import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import { gon } from '../../types/window';
import UserLists from '../../shared/components/UserLists';

const users = gon.followingUsers;
const currentInfo = gon.currentInfo;

const entryPoint = '[data-react-entry="FollowingUserLists"]';

if ($(entryPoint).length) {
  ReactDOM.render(
    <UserLists users={users} currentInfo={currentInfo} />,
    document.querySelector('[data-react-entry="FollowingUserLists"]')
  );
}
