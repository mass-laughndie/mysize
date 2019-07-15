import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { withKnobs, boolean } from '@storybook/addon-knobs/react';
import { UserList } from './UserList';
import { user, baseStyle } from '../../../../../stories/dummyData';

storiesOf('UserList', module)
  .addDecorator(withKnobs)
  .add('default', () => {
    const currentInfo = {
      isLoggedIn: boolean('isLoggedIn', true),
    };
    const userProps = {
      ...user,
      isFollow: boolean('isFollow', false),
      isMyself: boolean('isMyself', false),
    };
    return (
      <ul style={baseStyle}>
        <UserList user={userProps} currentInfo={currentInfo} />
      </ul>
    );
  });
