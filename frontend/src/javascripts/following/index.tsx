import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import FollowingUserLists from './components/FollowingUserLists';

const $entryPoint = $('[data-react-entry="FollowingUserLists"]');

if ($entryPoint.length) {
  ReactDOM.render(<FollowingUserLists />, document.querySelector($entryPoint));
}
