import * as React from 'react';
import { NormalPost } from './NormalPost';
import { Post, User } from '../../../types/commonTypes';

interface Props {
  posts: Post[];
  users: User[];
  logged_in: boolean;
}

class NormalPosts extends React.Component<Props> {
  private renderNormalPost(post: Post) {
    const { logged_in } = this.props;
    return <NormalPost post={post} logged_in={logged_in} />;
  }

  public render() {
    const { posts } = this.props;
    return <ul>{posts.map(this.renderNormalPost)}</ul>;
  }
}

export { NormalPosts };
