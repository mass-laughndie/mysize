import axios from './common/axios';

export const addGoodList = async (id: number, type: string): Promise<any> => {
  const formatPoatType = type.charAt(0).toUpperCase() + type.slice(1);
  await axios.post('/goods.json', {
    post_id: id,
    post_type: formatPoatType
  });
};

export const removeGoodList = async (id: number | null): Promise<any> => {
  if (typeof id == 'number') {
    await axios.delete(`/goods/${id}`);
  }
};
