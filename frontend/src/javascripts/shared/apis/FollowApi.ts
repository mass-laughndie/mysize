import axios from './common/axios';

export const follow = id => {
  axios.post('/relationships', {
    id
  });
};

export const unfollow = id => {
  axios.delete(`/relationships/${id}`);
};
