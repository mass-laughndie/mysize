import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import MypageSquarePosts from './components/MypageSquarePost';
import MypagePosts from './components/MypagePosts';

if ($('[data-react-entry="MypageSquarePosts"]').length) {
  ReactDOM.render(
    <MypageSquarePosts />,
    document.querySelector('[data-react-entry="MypageSquarePosts"]')
  );
} else {
  ReactDOM.render(
    <MypagePosts />,
    document.querySelector('[data-react-entry="MypagePosts"]')
  );
}
