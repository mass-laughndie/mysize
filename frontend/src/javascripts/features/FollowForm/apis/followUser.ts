import axios from '../../Shared/apis/common/axios';

export const followUser = async (id: number): Promise<any> => {
  const response = await axios
    .post('/relationships.json', {
      followed_id: id,
    })
    .catch((error) => console.log(error));

  return response.data;
};
