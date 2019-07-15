import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs, boolean } from '@storybook/addon-knobs';
import UserLists from '.';
import { users, baseStyle } from '../../../../../stories/dummyData';

storiesOf('UserLists', module)
  .addDecorator(withKnobs)
  .add('default', () => {
    const currentInfo = {
      isLoggedIn: boolean('isLoggedIn', true),
      isPostPage: false,
    };

    return (
      <div style={baseStyle}>
        <UserLists users={users} currentInfo={currentInfo} />
      </div>
    );
  });
