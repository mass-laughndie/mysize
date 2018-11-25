import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import { gon } from '../../types/window';
import NormalPosts from '../../shared/components/NormalPosts';

const posts = gon.latestKicksposts;
const currentInfo = gon.currentInfo;

const entryPoint = '[data-react-entry="NormalPosts"]';

if ($(entryPoint).length) {
  ReactDOM.render(
    <NormalPosts posts={posts} currentInfo={currentInfo} />,
    document.querySelector('[data-react-entry="NormalPosts"]')
  );
}
