import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs, boolean } from '@storybook/addon-knobs/react';
import { NormalPost } from './NormalPost';
import { post } from '../SquarePosts/SquarePost.story';

const baseStyle = {
  marginLeft: 50,
  width: 420,
  background: 'white'
};

storiesOf('NormalPost', module)
  .addDecorator(withKnobs)
  .add('default', () => {
    const logged_in = boolean('logged_in', true);
    const postProps = {
      ...post,
      isGood: boolean('isGood', false),
      isMyPost: boolean('isMypost', false)
    };
    return (
      <ul style={baseStyle}>
        <NormalPost post={postProps} logged_in={logged_in} />
      </ul>
    );
  });
