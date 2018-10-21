export interface Kickspost {
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
  postType: string;
  postUser: User;
  goodNum: number;
  commentNum: number;
  isGood: boolean;
  isMyPost: boolean;
}

export interface Comment {
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
  postType: string;
  postUser: User;
  goodNum: number;
  commentNum?: number;
  isGood: boolean;
  isMyPost: boolean;
}

export type Post = Kickspost | Comment;

export interface User {
  id: number;
  name: string;
  mysize_id: string;
  image_url: string | undefined;
  size: number;
  content: string;
}

export interface CurrentInfo {
  isLoggedIn: boolean;
  isPostPage: boolean;
}
