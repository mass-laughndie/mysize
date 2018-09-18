import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { LatestPosts } from './components/LatestPosts';

ReactDOM.render(
  <LatestPosts />,
  document.querySelector('[data-react-entry="LatestPosts"]')
);
