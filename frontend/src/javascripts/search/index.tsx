import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import SearchKickspost from './components/SearchKicksposts';

if ($('[data-react-entry="SearchKicksposts"]').length) {
  ReactDOM.render(
    <SearchKickspost />,
    document.querySelector('[data-react-entry="SearchKicksposts"]')
  );
}
