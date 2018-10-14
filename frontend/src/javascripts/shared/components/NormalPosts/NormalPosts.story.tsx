import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs, boolean } from '@storybook/addon-knobs/react';
import { NormalPosts } from './NormalPosts';
import { posts, baseStyle } from '../../../../../stories/dummyData';

storiesOf('NormalPosts', module)
  .addDecorator(withKnobs)
  .add('default', () => {
    const logged_in = boolean('logged_in', true);

    return (
      <ul style={baseStyle}>
        <NormalPosts posts={posts} logged_in={logged_in} />
      </ul>
    );
  });
