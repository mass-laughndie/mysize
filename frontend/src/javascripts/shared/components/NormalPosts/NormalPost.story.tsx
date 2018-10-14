import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs, boolean } from '@storybook/addon-knobs/react';
import { NormalPost } from './NormalPost';
import { post } from '../SquarePosts/SquarePost.story';

const logged_in = boolean('logged_in', true);

const baseStyle = {
  marginLeft: 50,
  width: 420,
  background: 'white'
};

storiesOf('NormalPost', module)
  .addDecorator(withKnobs)
  .add('default', () => (
    <ul style={baseStyle}>
      <NormalPost post={post} logged_in={logged_in} />
    </ul>
  ));
