export interface GonFollowingKickspost {
  id: number;
  user_id: number;
  brand: string | null;
  color: string | null;
  title: string;
  content: string | null;
  size: number;
  picture_url: string;
}

export type GonMypageKickspost = GonFollowingKickspost;
export type GonLatestKickspost = GonFollowingKickspost;

export interface Gon {
  test: string;
  followingKicksposts: GonFollowingKickspost[];
  mypageKicksposts: GonMypageKickspost[];
  latestKicksposts: GonLatestKickspost[];
}

export const gon: Gon = (window as any).gon;
