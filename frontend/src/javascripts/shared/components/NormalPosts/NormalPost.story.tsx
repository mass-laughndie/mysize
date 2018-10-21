import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs, boolean } from '@storybook/addon-knobs/react';
import { NormalPost } from './NormalPost';
import { post, baseStyle } from '../../../../../stories/dummyData';

storiesOf('NormalPost', module)
  .addDecorator(withKnobs)
  .add('default', () => {
    const currentInfo = {
      isLoggedIn: boolean('isLoggedIn', true),
      isPostPage: boolean('isPostPage', true)
    };
    const postProps = {
      ...post,
      isGood: boolean('isGood', false),
      isMyPost: boolean('isMypost', false)
    };
    return (
      <ul style={baseStyle}>
        <NormalPost post={postProps} currentInfo={currentInfo} />
      </ul>
    );
  });
