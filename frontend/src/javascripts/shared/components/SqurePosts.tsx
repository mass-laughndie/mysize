import * as React from 'react';
import { SquarePost } from './SquarePost';
import { Post } from '../../types/commonTypes';

interface Props {
  posts: Post[];
}

class SquarePosts extends React.Component<Props> {
  private renderSquarePost(post: Post) {
    return <SquarePost key={post.id} {...post} />;
  }

  public render() {
    const { posts } = this.props;
    return <ul>{posts.map(this.renderSquarePost)}</ul>;
  }
}

export { SquarePosts };
