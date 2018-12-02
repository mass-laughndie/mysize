export enum ActionTypes {
  FOLLOW_USER_REQUEST = 'FOLLOW_USER_REQUEST',
  FOLLOW_USER_SUCCESS = 'FOLLOW_USER_SUCCESS',
  FOLLOW_USER_FAILURE = 'FOLLOW_USER_FAILURE'
}

export type Action =
  | { type: ActionTypes.FOLLOW_USER_REQUEST; paylaod: { id: number } }
  | { type: ActionTypes.FOLLOW_USER_SUCCESS; payload: { followingId: number } }
  | { type: ActionTypes.FOLLOW_USER_FAILURE };
