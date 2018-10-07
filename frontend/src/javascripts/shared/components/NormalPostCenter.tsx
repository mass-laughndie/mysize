import * as React from 'react';
import { Post } from '../../types/commonTypes';

interface Props {
  post: Post;
}

const NormalPostCenter = (props: Props) => {
  const { brand, color, title, content } = props.post;
  const { name, mysize_id } = props.post.postUser;

  return (
    <div className="kpost-center kickspost-center">
      <div className="kpost-name over-name">
        <a href={`/${mysize_id}`}>
          {name}
          <span>{`@${mysize_id}`}</span>
        </a>
      </div>
      <div className="kpost-brand">
        <span>{brand}</span>
      </div>
      <div className="kpost-title">
        <h2>
          {`${title} `}
          <span>{`( ${color} )`}</span>
        </h2>
      </div>
      <div className="kpost-content autolink over-text">
        <span>{content}</span>
      </div>
    </div>
  );
};

export { NormalPostCenter };
