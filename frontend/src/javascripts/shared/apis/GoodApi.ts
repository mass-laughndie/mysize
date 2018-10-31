import axios from './common/axios';

export const addGoodList = (id, type) => {
  axios.post('/goods', {
    id,
    type
  });
};

export const removeGoodList = id => {
  axios.delete(`/goods/${id}`);
};
