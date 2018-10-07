import * as React from 'react';
import GoodForm from './GoodForm';
import { Post } from '../../types/commonTypes';

interface Props {
  post: Post;
  twitterShareUrl: string;
  logged_in: boolean;
}

const NormalPostAct = (props: Props) => {
  const { id, postType, goodNum, commentNum } = props.post;
  const { mysize_id } = props.post.postUser;
  const { twitterShareUrl, logged_in } = props;

  return (
    <div className={`kpost-act  ${postType}-act clear`}>
      <div className="kpost-alist">
        <div className="kpost-aicon">
          <GoodForm logged_in={logged_in} post={props.post} />
        </div>
        <div className="kpost-num" id={`good-num-${postType}-${id}`}>
          <a href={`/kicksposts/${id}/gooders`}>{goodNum}</a>
        </div>
      </div>
      <div className="kpost-alist">
        <a className="kpost-alink" href={`${mysize_id}/kicksposts/${id}`}>
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
          href={twitterShareUrl}
          onClick={() =>
            "window.open(encodeURI(decodeURI(this.href)), 'tweetwindow', 'width=650, height=470, personalbar=0, toolbar=0, scrollbars=1, sizable=31'); return false;"
          }
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
