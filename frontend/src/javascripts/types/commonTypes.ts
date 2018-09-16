export interface Post {
  id: number;
  user_id: number;
  brand: string | null;
  color: string | null;
  title: string;
  content: string | null;
  size: number;
  picture: {
    url: string;
  };
}

export interface SquarePostProp {
  id: number;
  title: string;
  size: number;
  picture: {
    url: string;
  };
}
