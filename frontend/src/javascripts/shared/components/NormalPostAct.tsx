import * as React from 'react';
import GoodForm from './GoodForm';

interface Props {
  post_id: number;
  mysize_id: string;
  encodedURI: string;
  logged_in: boolean;
  postType: string;
  goodNum: number;
  commentNum: number;
  isGood: boolean;
}

const NormalPostAct = (props: Props) => {
  const {
    post_id,
    mysize_id,
    encodedURI,
    logged_in,
    postType,
    goodNum,
    commentNum,
    isGood
  } = props;
  return (
    <div className={`kpost-act  ${postType}-act clear`}>
      <div className="kpost-alist">
        <div className="kpost-aicon">
          <GoodForm logged_in={logged_in} id={post_id} isGood={isGood} />
        </div>
        <div className="kpost-num" id={`good-num-${postType}-${post_id}`}>
          <a href={`/kicksposts/${post_id}/gooders`}>{goodNum}</a>
        </div>
      </div>
      <div className="kpost-alist">
        <a className="kpost-alink" href={`${mysize_id}/kicksposts/${post_id}`}>
          <div className="kpost-aicon">
            <i className="fa fa-comment-o" />
          </div>
          <div className="kpost-num">
            <span>{commentNum}</span>
          </div>
        </a>
      </div>
      <div className="kpost-alist alist-last">
        <a
          className="kpost-alink"
          href={`https://twitter.com/intent/tweet?text=${encodedURI}&url=${
            window.location.origin
          }/${mysize_id}/kicksposts/${post_id}`}
          // onclick="window.open(encodeURI(decodeURI(this.href)), 'tweetwindow', 'width=650, height=470, personalbar=0, toolbar=0, scrollbars=1, sizable=31'); return false;"
        >
          <div className="kpost-aicon">
            <i className="fa fa-twitter" />
          </div>
        </a>
      </div>
    </div>
  );
};

export { NormalPostAct };
