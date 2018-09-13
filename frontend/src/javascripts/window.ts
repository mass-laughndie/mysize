export interface Gon {
  test: string;
}

export const gon: Gon = (window as any).gon;
