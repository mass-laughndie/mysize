import * as React from 'react';
import { gon } from '../../types/window';
import NormalPosts from '../../shared/components/NormalPosts';

const posts = gon.latestKicksposts;
const currentInfo = gon.currentInfo;

class LatestPosts extends React.Component {
  render() {
    return <NormalPosts posts={posts} currentInfo={currentInfo} />;
  }
}

export default LatestPosts;
