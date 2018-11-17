import axios from './common/axios';

export const addGoodList = (id: number, type: string) => {
  const formatPoatType = type.charAt(0).toUpperCase() + type.slice(1);
  axios.post('/goods', {
    post_id: id,
    post_type: formatPoatType
  });
};

export const removeGoodList = (id: number | null) => {
  if (typeof id == 'number') {
    axios.delete(`/goods/${id}`);
  }
};
