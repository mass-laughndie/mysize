import * as React from 'react';
import { gon } from '../../types/window';
import NormalPosts from '../../shared/components/NormalPosts/NormalPosts';

const posts = gon.followingKicksposts;
const currentInfo = gon.currentInfo;

class FollowingPosts extends React.Component {
  render() {
    return <NormalPosts posts={posts} currentInfo={currentInfo} />;
  }
}

export default FollowingPosts;
