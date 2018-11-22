import * as React from 'react';
import { gon } from '../../types/window';
import UserLists from '../../shared/components/UserLists';

const users = gon.searchUsers;
const currentInfo = gon.currentInfo;

interface Props {}

class SearchUsers extends React.Component<Props> {
  render() {
    return <UserLists users={users} currentInfo={currentInfo} />;
  }
}

export default SearchUsers;
