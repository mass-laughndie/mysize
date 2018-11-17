export interface GonKickspost {
  id: number;
  user_id: number;
  kickspost_id?: number;
  reply_id?: number;
  brand: string | null;
  color: string | null;
  title: string;
  content: string | null;
  size: number;
  created_at: string;
  picture_url: string;
  postType: 'kickspost';
  postUser: GonUser;
  goodNum: number;
  commentNum: number;
  isGood: boolean;
  isMyPost: boolean;
  goodId: number | null;
}

export interface GonComment {
  id: number;
  user_id: number;
  kickspost_id: number;
  reply_id: number;
  content: string | null;
  created_at: string;
  brand?: string | null;
  color?: string | null;
  title?: string;
  size?: number;
  picture_url?: string;
  postType: 'comment';
  postUser: GonUser;
  goodNum: number;
  commentNum?: number;
  isGood: boolean;
  isMyPost: boolean;
  goodId: number | null;
}

export type GonPost = GonKickspost | GonComment;

export interface GonUser {
  id: number;
  name: string;
  mysize_id: string;
  image_url: string;
  size: number;
  content: string;
  isFollow?: boolean;
  isMyself?: boolean;
}

export interface GonCurrentInfo {
  isLoggedIn: boolean;
  isPostPage?: boolean;
}

export interface Gon {
  test: string;
  followingKicksposts: GonKickspost[];
  mypageKicksposts: GonKickspost[];
  latestKicksposts: GonKickspost[];
  searchKicksposts: GonKickspost[];
  searchComments: GonComment[];
  currentInfo: GonCurrentInfo;
  followingUsers: GonUser[];
  followedUsers: GonUser[];
}

export const gon: Gon = (window as any).gon;
