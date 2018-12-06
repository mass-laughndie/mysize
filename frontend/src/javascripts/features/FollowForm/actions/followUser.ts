import * as apis from '../apis';
import { Action, ActionTypes } from '../actionTypes';

const followUserRequest = (id: number): Action => ({
  type: ActionTypes.FOLLOW_USER_REQUEST,
  paylaod: { id }
});

const followUserSuccess = (followingId: number): Action => ({
  type: ActionTypes.FOLLOW_USER_SUCCESS,
  payload: { followingId }
});

const followUserFailure = (): Action => ({
  type: ActionTypes.FOLLOW_USER_FAILURE
});

export const followUser = (id: number) => {
  return async dispatch => {
    dispatch(followUserRequest(id));

    try {
      const followingId = await apis.followUser(id);
      dispatch(followUserSuccess(followingId.id));
    } catch (error) {
      dispatch(followUserFailure());
      console.log(error);
    }
  };
};
