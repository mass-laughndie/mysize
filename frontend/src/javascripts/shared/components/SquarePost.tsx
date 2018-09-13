import * as React from 'react';
import { Post } from '../../types/commonTypes';

interface Props {
  id: number;
  title: string;
  size: number;
  picture: {
    url: string;
  };
}

const SquarePost = (props: Props) => {
  const { id, title, size, picture } = props;
  return (
    <li id={`square-${id}`} className="square-list">
      <div className="square-picture">
        <a href={`/-/kicksposts/${id}`}>
          <img
            className="cover lazyload"
            src="/images/grey.gif"
            data-src={picture.url}
            alt={title}
          />
        </a>
      </div>
      <div className="square-size">{size.toFixed(1)}</div>
    </li>
  );
};

export { SquarePost };
