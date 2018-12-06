import * as React from 'react';
import { NormalPost } from './NormalPost';
import { Post, CurrentInfo } from '../../../types/commonTypes';

interface Props {
  posts: Post[];
  currentInfo: CurrentInfo;
}

class NormalPosts extends React.Component<Props> {
  private renderNormalPost(post: Post) {
    const { currentInfo } = this.props;
    return (
      <NormalPost
        key={`${post.postType}-${post.id}`}
        post={post}
        currentInfo={currentInfo}
      />
    );
  }

  public render() {
    const { posts } = this.props;
    return <ul>{posts.map(post => this.renderNormalPost(post))}</ul>;
  }
}

export default NormalPosts;
