import * as React from 'react';
import { SquarePostProp } from '../../types/commonTypes';

type Props = SquarePostProp;

const SquarePost = (props: Props) => {
  const { id, title, size, picture_url } = props;
  return (
    <li id={`square-${id}`} className="square-list">
      <div className="square-picture">
        <a href={`/-/kicksposts/${id}`}>
          <img
            className="cover lazyload"
            src="/images/grey.gif"
            data-src={picture_url}
            alt={title}
          />
        </a>
      </div>
      <div className="square-size">{size.toFixed(1)}</div>
    </li>
  );
};

export { SquarePost };
