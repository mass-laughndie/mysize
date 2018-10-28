import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import FollowersUserLists from './components/FollowersUserLists';

const $entryPoint = $('[data-react-entry="FollowersUserLists"]');

if ($entryPoint.length) {
  ReactDOM.render(<FollowersUserLists />, document.querySelector($entryPoint));
}
