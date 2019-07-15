import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import { gon } from '../../types/window';
import NormalPosts from '../../features/NormalPosts/components';
import SquarePosts from '../../features/SquarePosts/components';

const posts = gon.mypageKicksposts;
const currentInfo = gon.currentInfo;

const squarePostsEntryPoint = '[data-react-entry="MypageSquarePosts"]';
const normalPostsEntryPoint = '[data-react-entry="MypagePosts"]';

if ($(squarePostsEntryPoint).length) {
  ReactDOM.render(<SquarePosts posts={posts} />, document.querySelector(squarePostsEntryPoint));
}

if ($(normalPostsEntryPoint).length) {
  ReactDOM.render(
    <NormalPosts posts={posts} currentInfo={currentInfo} />,
    document.querySelector(normalPostsEntryPoint)
  );
}
