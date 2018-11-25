import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import { gon } from '../../types/window';
import UserLists from '../../shared/components/UserLists';

const users = gon.followedUsers;
const currentInfo = gon.currentInfo;

const entryPoint = '[data-react-entry="FollowersUserLists"]';

if ($(entryPoint).length) {
  ReactDOM.render(
    <UserLists users={users} currentInfo={currentInfo} />,
    document.querySelector('[data-react-entry="FollowersUserLists"]')
  );
}
