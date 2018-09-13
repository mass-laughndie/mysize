import * as React from 'react';
import { Post } from '../../types/commonTypes';
import { gon } from '../../types/window';
import { SquarePosts } from '../../shared/components/SqurePosts';

const posts = gon.followingKicksposts;

class FollowingSquarePosts extends React.Component {
  render() {
    return <SquarePosts posts={posts} />;
  }
}

export { FollowingSquarePosts };
