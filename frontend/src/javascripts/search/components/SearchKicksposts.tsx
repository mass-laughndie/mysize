import * as React from 'react';
import { gon } from '../../types/window';
import NormalPosts from '../../shared/components/NormalPosts';

const posts = gon.searchKicksposts;
const currentInfo = gon.currentInfo;

interface Props {}

class SearchKicksposts extends React.Component<Props> {
  render() {
    return <NormalPosts posts={posts} currentInfo={currentInfo} />;
  }
}

export default SearchKicksposts;
