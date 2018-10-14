import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { SquarePost } from './SquarePost';
import { post, baseStyle } from '../../../../../stories/dummyData';

storiesOf('SquarePost', module).add('default', () => (
  <ul style={baseStyle}>
    <SquarePost post={post} />
  </ul>
));
