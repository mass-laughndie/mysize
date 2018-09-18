import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { SquarePost } from './SquarePost';

const posts = {
  id: 29,
  title: 'Air Max',
  size: 28,
  picture_url: '/uploads/kickspost/picture/29/x0jUhnaA8g.jpg'
};

storiesOf('SquarePost', module).add('default', () => <SquarePost {...posts} />);
