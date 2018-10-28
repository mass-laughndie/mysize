import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import SearchKicksposts from './components/SearchKicksposts';
import SearchComments from './components/SearchComments';

const entryPoint1 = '[data-react-entry="SearchKicksposts"]';
const entryPoint2 = '[data-react-entry="SearchComments"]';

if ($(entryPoint1).length) {
  ReactDOM.render(<SearchKicksposts />, document.querySelector(entryPoint1));
}

if ($(entryPoint2).length) {
  ReactDOM.render(<SearchComments />, document.querySelector(entryPoint2));
}
