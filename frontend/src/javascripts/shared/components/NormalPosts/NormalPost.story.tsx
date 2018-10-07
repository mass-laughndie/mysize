import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs, boolean } from '@storybook/addon-knobs/react';
import { NormalPost } from './NormalPost';
import { post } from '../SquarePosts/SquarePost.story';

const logged_in = boolean('logged_in', true);

storiesOf('NormalPost', module)
  .addDecorator(withKnobs)
  .add('default', () => <NormalPost post={post} logged_in={logged_in} />);
