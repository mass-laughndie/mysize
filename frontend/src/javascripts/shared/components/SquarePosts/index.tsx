import * as React from 'react';
import { Post } from '../../../types/commonTypes';
import { SquarePost } from './SquarePost';

interface Props {
  posts: Post[];
}

class SquarePosts extends React.Component<Props> {
  private renderSquarePost(post: Post) {
    return <SquarePost key={post.id} post={post} />;
  }

  public render() {
    const { posts } = this.props;
    return (
      <ul>
        {posts.map(
          post => post.postType == 'kickspost' && this.renderSquarePost(post)
        )}
      </ul>
    );
  }
}

export default SquarePosts;
