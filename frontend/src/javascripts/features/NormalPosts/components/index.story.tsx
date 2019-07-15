import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs, boolean } from '@storybook/addon-knobs/react';
import NormalPosts from '.';
import { posts, baseStyle } from '../../../../../stories/dummyData';

storiesOf('NormalPosts', module)
  .addDecorator(withKnobs)
  .add('default', () => {
    const currentInfo = {
      isLoggedIn: boolean('isLoggedIn', true),
      isPostPage: boolean('isPostPage', true),
    };

    return (
      <ul style={baseStyle}>
        <NormalPosts posts={posts} currentInfo={currentInfo} />
      </ul>
    );
  });
