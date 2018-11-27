import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import { gon } from '../../types/window';
import NormalPosts from '../../modules/NormalPosts/components';
import SquarePosts from '../../shared/components/SquarePosts';

const posts = gon.mypageKicksposts;
const currentInfo = gon.currentInfo;

const squarePostsEntryPoint = '[data-react-entry="MypageSquarePosts"]';
const normalPostsEntryPoint = '[data-react-entry="MypagePosts"]';

if ($(squarePostsEntryPoint).length) {
  ReactDOM.render(
    <SquarePosts posts={posts} />,
    document.querySelector(squarePostsEntryPoint)
  );
}

if ($(normalPostsEntryPoint).length) {
  ReactDOM.render(
    <NormalPosts posts={posts} currentInfo={currentInfo} />,
    document.querySelector(normalPostsEntryPoint)
  );
}
