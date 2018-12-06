import axios from '../../Shared/apis/common/axios';

export const removeGoodList = async (goodId: number | null): Promise<any> => {
  if (typeof goodId == 'number') {
    await axios.delete(`/goods/${goodId}`).catch(value => console.log(value));
  }
};
