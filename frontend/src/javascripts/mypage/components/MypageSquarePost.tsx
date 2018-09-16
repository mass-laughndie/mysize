import * as React from 'react';
import { gon } from '../../types/window';
import { SquarePosts } from '../../shared/components/SqurePosts';

const posts = gon.mypageKicksposts;

class MypageSquarePosts extends React.Component {
  render() {
    return <SquarePosts posts={posts} />;
  }
}

export { MypageSquarePosts };
