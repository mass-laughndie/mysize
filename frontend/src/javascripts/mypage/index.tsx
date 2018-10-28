import * as React from 'react';
import * as ReactDOM from 'react-dom';
import * as $ from 'jquery';
import MypageSquarePosts from './components/MypageSquarePost';
import MypagePosts from './components/MypagePosts';

const $entryPoint = $('[data-react-entry="MypageSquarePosts"]');

if ($entryPoint.length) {
  ReactDOM.render(<MypageSquarePosts />, document.querySelector($entryPoint));
} else {
  ReactDOM.render(
    <MypagePosts />,
    document.querySelector('[data-react-entry="MypagePosts"]')
  );
}
