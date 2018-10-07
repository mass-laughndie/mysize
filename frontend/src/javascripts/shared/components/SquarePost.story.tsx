import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { SquarePost } from './SquarePost';

const posts = {
  id: 29,
  title: 'Air Max',
  size: 28,
  picture_url: '/uploads/kickspost/picture/29/x0jUhnaA8g.jpg'
};

const post = {
  id: 2,
  user_id: 1,
  brand: 'Nike',
  color: 'Black Emerald',
  title: 'Air Jordan1',
  content: 'カメレオン',
  size: 27,
  picture_url: '/uploads/kickspost/picture/2/NAW30EGDow.jpg',
  postType: 'kickspost',
  postUser: {
    content: 'test1',
    id: 1,
    image_url: '',
    mysize_id: 'test1',
    name: 'test1',
    size: 27
  },
  goodNum: 2,
  commentNum: 4,
  isGood: true,
  isMyPost: false
};

storiesOf('SquarePost', module).add('default', () => (
  <SquarePost post={post} />
));
