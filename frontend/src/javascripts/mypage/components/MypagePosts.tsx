import * as React from 'react';
import { gon } from '../../types/window';
import NormalPosts from '../../shared/components/NormalPosts/NormalPosts';

const posts = gon.mypageKicksposts;
const currentInfo = gon.currentInfo;

class MypagePosts extends React.Component {
  render() {
    return <NormalPosts posts={posts} currentInfo={currentInfo} />;
  }
}

export default MypagePosts;
