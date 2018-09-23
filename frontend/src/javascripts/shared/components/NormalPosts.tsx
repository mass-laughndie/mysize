import * as React from 'react';
import { NormalPost } from './NormalPost';
import { Post, User } from '../../types/commonTypes';

interface Props {
  posts: Post[];
  users: User[];
}

class NormalPosts extends React.Component<Props> {
  private renderNormalPost(post: Post) {
    const { users } = this.props;
    return <NormalPost post={post} user={users[post.user_id]} />;
  }

  public render() {
    const { posts } = this.props;
    return <ul>{posts.map(this.renderNormalPost)}</ul>;
  }
}

export { NormalPosts };
