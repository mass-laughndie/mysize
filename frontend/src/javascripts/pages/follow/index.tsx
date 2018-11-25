import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { gon } from '../../types/window';
import NormalPosts from '../../shared/components/NormalPosts';

const posts = gon.followingKicksposts;
const currentInfo = gon.currentInfo;

ReactDOM.render(
  <NormalPosts posts={posts} currentInfo={currentInfo} />,
  document.querySelector('[data-react-entry="NormalPosts"]')
);
