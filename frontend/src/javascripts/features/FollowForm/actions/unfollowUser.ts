import * as apis from '../apis';
import { Action, ActionTypes } from '../actionTypes';

const unfollowUserRequest = (): Action => ({
  type: ActionTypes.UNFOLLOW_USER_REQUEST,
});

const unfollowUserSuccess = (): Action => ({
  type: ActionTypes.UNFOLLOW_USER_SUCCESS,
});

const unfollowUserFailure = (): Action => ({
  type: ActionTypes.UNFOLLOW_USER_FAILURE,
});

export const unfollowUser = (followingId: number) => {
  return async (dispatch) => {
    dispatch(unfollowUserRequest());

    try {
      await apis.unfollowUser(followingId);
      dispatch(unfollowUserSuccess());
    } catch (error) {
      dispatch(unfollowUserFailure());
      console.log(error);
    }
  };
};
