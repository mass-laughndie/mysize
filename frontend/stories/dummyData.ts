import {
  Post,
  User,
  Kickspost,
  Comment
} from '../src/javascripts/types/commonTypes';

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
  content: 'My size is 27. My favorite brand is KITH.',
  isFollow: false,
  followingId: null,
  isMyself: true
};

export const user2: User = {
  id: 2,
  image_url: '/uploads/data/icon2.jpg',
  mysize_id: 'mysize2',
  name: 'Mysize2',
  size: 28.5,
  content: 'My size is 28.5.',
  isFollow: false,
  followingId: null,
  isMyself: false
};

export const user3: User = {
  id: 3,
  image_url: '/uploads/data/icon3.jpg',
  mysize_id: 'mysize3',
  name: 'Mysize3',
  size: 25.5,
  content: 'My size is 25.5.',
  isFollow: true,
  followingId: 1,
  isMyself: false
};

export const kickspost: Kickspost = {
  id: 1,
  user_id: 1,
  brand: 'Nike',
  color: 'Black Emerald',
  title: 'Air Jordan1',
  content: 'カメレオン',
  size: 27,
  created_at: '2018-09-30T23:31:45.000+09:00',
  picture_url: '/uploads/data/kicks1.jpg',
  postType: 'kickspost',
  postUser: {
    id: 1,
    image_url: '/uploads/data/icon1.jpg',
    mysize_id: 'mysize1',
    name: 'Mysize1',
    size: 27,
    content: 'My size is 27. My favorite brand is KITH.',
    isFollow: false,
    followingId: null
  },
  goodNum: 2,
  commentNum: 1,
  isGood: false,
  isMyPost: true,
  goodId: null
};

export const kickspost2: Kickspost = {
  id: 2,
  user_id: 2,
  brand: 'Adidas',
  color: 'Beluga',
  title: 'Yeezy Boost 350 V2',
  content: 'Test Test Test Test Test Test',
  size: 28.5,
  created_at: '2018-10-04T11:00:00.000+09:00',
  picture_url: '/uploads/data/kicks8.jpg',
  postType: 'kickspost',
  postUser: {
    id: 2,
    image_url: '/uploads/data/icon2.jpg',
    mysize_id: 'mysize2',
    name: 'Mysize2',
    size: 28.5,
    content: 'My size is 28.5.',
    isFollow: false,
    followingId: null
  },
  goodNum: 6,
  commentNum: 3,
  isGood: false,
  isMyPost: false,
  goodId: null
};

export const kickspost3: Kickspost = {
  id: 3,
  user_id: 2,
  brand: 'Nike',
  color: 'Black',
  title: 'Nike × Supreme Air More Uptempo',
  content:
    'Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test',
  size: 28.5,
  created_at: '2018-10-09T11:00:00.000+09:00',
  picture_url: '/uploads/data/kicks4.jpg',
  postType: 'kickspost',
  postUser: {
    id: 1,
    image_url: '/uploads/data/icon1.jpg',
    mysize_id: 'mysize1',
    name: 'Mysize1',
    size: 27,
    content: 'My size is 27. My favorite brand is KITH.',
    isFollow: false,
    followingId: null
  },
  goodNum: 4,
  commentNum: 0,
  isGood: true,
  isMyPost: true,
  goodId: 1
};

export const comment: Comment = {
  id: 1,
  user_id: 2,
  kickspost_id: 1,
  reply_id: 0,
  content: 'Nice kicks!!',
  created_at: '2018-10-01T11:00:00.000+09:00',
  postType: 'comment',
  postUser: {
    id: 2,
    image_url: '/uploads/data/icon2.jpg',
    mysize_id: 'mysize2',
    name: 'Mysize2',
    size: 28.5,
    content: 'My size is 28.5.',
    isFollow: false,
    followingId: null
  },
  goodNum: 1,
  isGood: true,
  isMyPost: false,
  goodId: 2
};

export const reply: Comment = {
  id: 2,
  user_id: 1,
  kickspost_id: 1,
  reply_id: 1,
  content: 'Thanks!!',
  created_at: '2018-10-02T11:00:00.000+09:00',
  postType: 'comment',
  postUser: {
    id: 1,
    image_url: '/uploads/data/icon1.jpg',
    mysize_id: 'mysize1',
    name: 'Mysize1',
    size: 27,
    content: 'My size is 27. My favorite brand is KITH.',
    isFollow: false,
    followingId: null
  },
  goodNum: 1,
  isGood: false,
  isMyPost: true,
  goodId: null
};

export const posts: Post[] = [
  kickspost,
  comment,
  reply,
  kickspost2,
  kickspost3
];

export const users: User[] = [user, user2, user3];
