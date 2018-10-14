import * as React from 'react';
import { storiesOf } from '@storybook/react';
import { SquarePost } from './SquarePost';

export const post = {
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
    image_url: '/images/default1.png',
    mysize_id: 'test1',
    name: 'test1',
    size: 27
  },
  goodNum: 2,
  commentNum: 4,
  isGood: false,
  isMyPost: true
};

storiesOf('SquarePost', module).add('default', () => (
  <SquarePost post={post} />
));
