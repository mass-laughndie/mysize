import * as React from 'react';
import { NormalPost } from './NormalPost';
import { Post } from '../../../types/commonTypes';

interface Props {
  posts: Post[];
  logged_in: boolean;
}

class NormalPosts extends React.Component<Props> {
  private renderNormalPost(post: Post) {
    const { logged_in } = this.props;
    return <NormalPost key={post.id} post={post} logged_in={logged_in} />;
  }

  public render() {
    const { posts } = this.props;
    return <ul>{posts.map(post => this.renderNormalPost(post))}</ul>;
  }
}

export default NormalPosts;
