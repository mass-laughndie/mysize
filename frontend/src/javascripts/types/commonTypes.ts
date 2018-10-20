export interface Post {
  id: number;
  user_id: number;
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

export interface User {
  id: number;
  name: string;
  mysize_id: string;
  image_url: string | undefined;
  size: number;
  content: string;
}
