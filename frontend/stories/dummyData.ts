import { Post, User } from '../src/javascripts/types/commonTypes';

export const baseStyle = {
  marginLeft: 50,
  width: 420,
  background: 'white'
};

export const user: User = {
  id: 1,
  image_url: '/uploads/data/icon1.jpg',
  mysize_id: 'mysize1',
  name: 'Mysize1',
  size: 27,
  content: 'My size is 27. My favorite brand is KITH.'
};

export const user2: User = {
  id: 2,
  image_url: '/uploads/data/icon2.jpg',
  mysize_id: 'mysize2',
  name: 'Mysize2',
  size: 28.5,
  content: 'My size is 28.5.'
};

export const post: Post = {
  id: 1,
  user_id: 1,
  brand: 'Nike',
  color: 'Black Emerald',
  title: 'Air Jordan1',
  content: 'カメレオン',
  size: 27,
  picture_url: '/uploads/data/kicks1.jpg',
  postType: 'kickspost',
  postUser: {
    id: 1,
    image_url: '/uploads/data/icon1.jpg',
    mysize_id: 'mysize1',
    name: 'Mysize1',
    size: 27,
    content: 'My size is 27. My favorite brand is KITH.'
  },
  goodNum: 2,
  commentNum: 1,
  isGood: false,
  isMyPost: true
};

export const post2: Post = {
  id: 2,
  user_id: 2,
  brand: 'Adidas',
  color: 'Beluga',
  title: 'Yeezy Boost 350 V2',
  content: 'Test Test Test Test Test Test',
  size: 28.5,
  picture_url: '/uploads/data/kicks8.jpg',
  postType: 'kickspost',
  postUser: {
    id: 2,
    image_url: '/uploads/data/icon2.jpg',
    mysize_id: 'mysize2',
    name: 'Mysize2',
    size: 28.5,
    content: 'My size is 28.5.'
  },
  goodNum: 6,
  commentNum: 3,
  isGood: false,
  isMyPost: false
};

export const post3: Post = {
  id: 3,
  user_id: 2,
  brand: 'Nike',
  color: 'Black',
  title: 'Nike × Supreme Air More Uptempo',
  content:
    'Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test',
  size: 28.5,
  picture_url: '/uploads/data/kicks4.jpg',
  postType: 'kickspost',
  postUser: {
    id: 1,
    image_url: '/uploads/data/icon1.jpg',
    mysize_id: 'mysize1',
    name: 'Mysize1',
    size: 27,
    content: 'My size is 27. My favorite brand is KITH.'
  },
  goodNum: 4,
  commentNum: 0,
  isGood: true,
  isMyPost: true
};

export const posts: Post[] = [post, post2, post3];
