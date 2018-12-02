import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs } from '@storybook/addon-knobs';
import SquarePosts from '.';
import { posts, baseStyle } from '../../../../../stories/dummyData';

storiesOf('SquarePosts', module)
  .addDecorator(withKnobs)
  .add('default', () => (
    <ul style={baseStyle}>
      <SquarePosts posts={posts} />
    </ul>
  ));
