import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { gon } from '../../types/window';
import SquarePosts from '../../shared/components/SquarePosts';

const posts = gon.followingKicksposts;

ReactDOM.render(
  <SquarePosts posts={posts} />,
  document.querySelector('[data-react-entry="FollowingSquarePosts"]')
);
