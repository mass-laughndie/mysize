import * as React from 'react';
import { gon } from '../../types/window';

const posts = gon.latestKicksposts;

class LatestPosts extends React.Component {
  render() {
    return <div>LatestPosts</div>;
  }
}

export { LatestPosts };
