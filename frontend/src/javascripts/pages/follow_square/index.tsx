import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import { gon } from '../../types/window';
import SquarePosts from '../../features/SquarePosts/components';

const posts = gon.followingKicksposts;

const entryPoint = '[data-react-entry="FollowingSquarePosts"]';

if ($(entryPoint).length) {
  ReactDOM.render(<SquarePosts posts={posts} />, document.querySelector('[data-react-entry="FollowingSquarePosts"]'));
}
