import * as React from 'react';

interface Props {
  mysize_id: string;
  image_url: string;
  size: number;
}

const NormalPostLeft = (props: Props) => {
  const { mysize_id, image_url, size } = props;
  return (
    <div className="c index-left kpost-left">
      <div className="index-image kpost-icon abs-center">
        <a className="list-image" href={`/${mysize_id}?display=square`}>
          <img src={image_url} alt={mysize_id} width="40" height="40" />
        </a>
        <div className="index-size kpost-shoesize">
          <span>{size}</span>
        </div>
      </div>
    </div>
  );
};

export { NormalPostLeft };
