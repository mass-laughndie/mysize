import * as React from 'react';
import { Post } from '../../../types/commonTypes';

interface Props {
  post: Post;
}

const PostDelete = (props: Props) => {
  const postDeleteUrl = (post: Post): string => {
    const rootUrl = location.protocol + '//' + location.host;
    const { id, postType, postUser } = post;

    if (postType == 'kickspost') {
      return `${rootUrl}/users/${postUser.mysize_id}/kickspost/${id}`;
    } else {
      return `${rootUrl}/postcomment/${id}`;
    }
  };

  return (
    <a
      data-confirm='本当に削除してよろしいですか？'
      rel='nofollow'
      data-method='delete'
      href={postDeleteUrl(props.post)}
    >
      <i className='fa fa-trash' />
      {' 投稿を削除する'}
    </a>
  );
};

export { PostDelete };
