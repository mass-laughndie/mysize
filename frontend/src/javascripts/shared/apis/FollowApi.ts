import axios from './common/axios';

export const followUser = async (id: number): Promise<any> => {
  const response = await axios
    .post('/relationships.json', {
      followed_id: id
    })
    .catch(error => console.log(error));

  console.log(response);

  return response.data;
};

export const unfollowUser = async (
  followingId: number | null
): Promise<any> => {
  if (typeof followingId == 'number') {
    await axios.delete(`/relationships/${followingId}`);
  }
};
