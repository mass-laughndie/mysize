import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import { gon } from '../../types/window';
import NormalPosts from '../../shared/components/NormalPosts';
import UserLists from '../../shared/components/UserLists';

const searchUsers = gon.searchUsers;
const searchKicksposts = gon.searchKicksposts;
const searchComments = gon.searchComments;
const currentInfo = gon.currentInfo;

const searchUsersEntryPoint = '[data-react-entry="SearchUsers"]';
const searchKickspostsEntryPoint = '[data-react-entry="SearchKicksposts"]';
const searchCommentsEntryPoint = '[data-react-entry="SearchComments"]';

if ($(searchUsersEntryPoint).length) {
  ReactDOM.render(
    <UserLists users={searchUsers} currentInfo={currentInfo} />,
    document.querySelector(searchUsersEntryPoint)
  );
}

if ($(searchKickspostsEntryPoint).length) {
  ReactDOM.render(
    <NormalPosts posts={searchKicksposts} currentInfo={currentInfo} />,
    document.querySelector(searchKickspostsEntryPoint)
  );
}

if ($(searchCommentsEntryPoint).length) {
  ReactDOM.render(
    <NormalPosts posts={searchComments} currentInfo={currentInfo} />,
    document.querySelector(searchCommentsEntryPoint)
  );
}
