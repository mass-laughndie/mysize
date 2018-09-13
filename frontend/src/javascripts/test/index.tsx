import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { Hello } from './components/Hello';
import { gon } from '../types/window';

const message = gon.test;

ReactDOM.render(
  <Hello message={message} />,
  document.querySelector('[data-react-entry="root"]')
);
