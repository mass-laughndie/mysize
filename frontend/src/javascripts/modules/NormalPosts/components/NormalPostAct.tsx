import * as React from 'react';
import GoodForm from '../../../shared/components/GoodForm';
import { Post, CurrentInfo } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './NormalPost.module.scss';
import * as moment from 'moment';

interface Props {
  post: Post;
  twitterShareUrl: string;
  currentInfo: CurrentInfo;
}

const NormalPostAct = (props: Props) => {
  const cx = classnames.bind(styles);
  const {
    id,
    kickspost_id,
    postType,
    goodNum,
    commentNum,
    created_at,
    isMyPost
  } = props.post;
  const { mysize_id } = props.post.postUser;
  const { twitterShareUrl, currentInfo } = props;
  const { isLoggedIn, isPostPage } = currentInfo;
  const isKickspost = props.post.postType === 'kickspost';
  const isReply = props.post.reply_id != undefined && props.post.reply_id != 0;
  moment.locale('ja');

  return (
    <div
      className={cx(
        'kpost-act',
        `${postType}-act`,
        {
          'reply-act': isReply
        },
        'clear'
      )}
    >
      <div className={cx('kpost-time')}>{moment(created_at).fromNow()}</div>
      <div className={cx('kpost-alist')}>
        <GoodForm isLoggedIn={isLoggedIn} post={props.post} />
      </div>
      {isKickspost ? (
        <React.Fragment>
          <div className={cx('kpost-alist')}>
            <a
              className={cx('kpost-alink')}
              href={`${mysize_id}/kicksposts/${id}`}
            >
              <div className={cx('kpost-aicon')}>
                <i className="fa fa-comment-o" />
              </div>
              <div className={cx('kpost-num')}>
                <span>{commentNum}</span>
              </div>
            </a>
          </div>
          <div className={cx('kpost-alist', 'alist-last')}>
            <a
              className={cx('kpost-alink')}
              href={twitterShareUrl}
              onClick={() =>
                "window.open(encodeURI(decodeURI(this.href)), 'tweetwindow', 'width=650, height=470, personalbar=0, toolbar=0, scrollbars=1, sizable=31'); return false;"
              }
            >
              <div className={cx('kpost-aicon')}>
                <i className="fa fa-twitter" />
              </div>
            </a>
          </div>
        </React.Fragment>
      ) : (
        !isMyPost && (
          <div className={cx('kpost-alist', 'alist-last')}>
            <div className={cx('kpost-aicon')} id={`comment-reply-${id}`}>
              {isPostPage ? (
                <i className={cx('fa', 'fa-reply')} />
              ) : isLoggedIn ? (
                <a
                  className={cx('kpost-alink', 'jump')}
                  data-scroll="-51"
                  href={`/${mysize_id}/kicksposts/${kickspost_id}?reply=on#comment-${id}`}
                >
                  <i className={cx('fa', 'fa-reply')} />
                </a>
              ) : (
                <a href="#" className="ban">
                  <i className={cx('fa', 'fa-reply')} />
                </a>
              )}
            </div>
          </div>
        )
      )}
    </div>
  );
};

export { NormalPostAct };
