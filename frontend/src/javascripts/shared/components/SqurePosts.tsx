import * as React from 'react';
import { SquarePostProp } from '../../types/commonTypes';
import { SquarePost } from './SquarePost';

interface Props {
  posts: SquarePostProp[];
}

class SquarePosts extends React.Component<Props> {
  private renderSquarePost(post: SquarePostProp) {
    return (
      <SquarePost
        key={post.id}
        id={post.id}
        title={post.title}
        size={post.size}
        picture_url={post.picture_url}
      />
    );
  }

  public render() {
    const { posts } = this.props;
    return <ul>{posts.map(this.renderSquarePost)}</ul>;
  }
}

export { SquarePosts };
