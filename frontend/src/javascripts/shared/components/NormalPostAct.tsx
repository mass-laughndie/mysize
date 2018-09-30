import * as React from 'react';

interface Props {
  post_id: number;
  mysize_id: string;
  encodedURI: string;
  goodNum: number;
  commentNum: number;
}

const NormalPostAct = (props: Props) => {
  const { post_id, mysize_id, encodedURI, goodNum, commentNum } = props;
  return (
    <div className="kpost-act  kickspost-act clear">
      <div className="kpost-alist">
        <div className="kpost-aicon">
          {/* <%= render partial: 'goods/good_form',
                            locals: { post: post,
                                      type: type } %> */}
        </div>
        <div className="kpost-num" id={`good-num-kickspost-${post_id}`}>
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
