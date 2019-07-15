export enum ActionTypes {
  FOLLOW_USER_REQUEST = 'FOLLOW_USER_REQUEST',
  FOLLOW_USER_SUCCESS = 'FOLLOW_USER_SUCCESS',
  FOLLOW_USER_FAILURE = 'FOLLOW_USER_FAILURE',
  UNFOLLOW_USER_REQUEST = 'UNFOLLOW_USER_REQUEST',
  UNFOLLOW_USER_SUCCESS = 'UNFOLLOW_USER_SUCCESS',
  UNFOLLOW_USER_FAILURE = 'UNFOLLOW_USER_FAILURE',
}

export type Action =
  | { type: ActionTypes.FOLLOW_USER_REQUEST; paylaod: { id: number } }
  | { type: ActionTypes.FOLLOW_USER_SUCCESS; payload: { followingId: number } }
  | { type: ActionTypes.FOLLOW_USER_FAILURE }
  | { type: ActionTypes.UNFOLLOW_USER_REQUEST }
  | { type: ActionTypes.UNFOLLOW_USER_SUCCESS }
  | { type: ActionTypes.UNFOLLOW_USER_FAILURE };
