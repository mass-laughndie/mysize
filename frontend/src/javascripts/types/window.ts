export interface GonFollowingKickspost {
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

export interface Gon {
  test: string;
  followingKicksposts: GonFollowingKickspost[];
}

export const gon: Gon = (window as any).gon;
