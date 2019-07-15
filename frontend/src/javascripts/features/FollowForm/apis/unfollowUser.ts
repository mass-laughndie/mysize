import axios from '../../Shared/apis/common/axios';

export const unfollowUser = async (followingId: number | null): Promise<any> => {
  if (typeof followingId == 'number') {
    await axios.delete(`/relationships/${followingId}`);
  }
};
