export interface GonFollowingKickspost {
  id: number;
  user_id: number;
  brand: string | null;
  color: string | null;
  title: string | null;
  content: string | null;
  size: number;
  picture: {
    url: string;
  };
}

export interface Gon {
  test: string;
  followingKicksposts: Array<{ [key: number]: GonFollowingKickspost }>;
}

export const gon: Gon = (window as any).gon;
