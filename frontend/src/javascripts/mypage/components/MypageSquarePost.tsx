import * as React from 'react';
import { gon } from '../../types/window';
import SquarePosts from '../../shared/components/SquarePosts/SquarePosts';

const posts = gon.mypageKicksposts;

class MypageSquarePosts extends React.Component {
  render() {
    return <SquarePosts posts={posts} />;
  }
}

export default MypageSquarePosts;
