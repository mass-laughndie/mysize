import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { FollowingPosts } from './components/FollowingPosts';

ReactDOM.render(
  <FollowingPosts />,
  document.querySelector('[data-react-entry="NormalPosts"]')
);
