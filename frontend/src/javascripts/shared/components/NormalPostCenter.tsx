import * as React from 'react';

interface Props {
  name: string;
  mysize_id: string;
  brand: string | null;
  color: string | null;
  title: string;
  content: string | null;
}

const NormalPostCenter = (props: Props) => {
  const { name, mysize_id, brand, color, title, content } = props;
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
