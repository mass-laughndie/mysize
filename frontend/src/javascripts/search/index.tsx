import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import SearchKicksposts from './components/SearchKicksposts';
import SearchComments from './components/SearchComments';

if ($('[data-react-entry="SearchKicksposts"]').length) {
  ReactDOM.render(
    <SearchKicksposts />,
    document.querySelector('[data-react-entry="SearchKicksposts"]')
  );
}

if ($('[data-react-entry="SearchComments"]').length) {
  ReactDOM.render(
    <SearchComments />,
    document.querySelector('[data-react-entry="SearchComments"]')
  );
}
