import * as React from 'react';
import GoodForm from '../GoodForm/GoodForm';
import { Post } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './NormalPost.module.scss';
import * as moment from 'moment';

interface Props {
  post: Post;
  twitterShareUrl: string;
  logged_in: boolean;
}

const NormalPostAct = (props: Props) => {
  const { id, postType, goodNum, commentNum, created_at } = props.post;
  const { mysize_id } = props.post.postUser;
  const { twitterShareUrl, logged_in } = props;
  const isKickspost = props.post.postType === 'kickspost';
  moment.locale('ja');

  return (
    <div
      className={classnames({
        [styles['kpost-act']]: true,
        [styles[`${postType}-act`]]: true,
        [styles['reply-act']]: isKickspost,
        [styles.clear]: true
      })}
    >
      <div className={styles['kpost-time']}>{moment(created_at).fromNow()}</div>
      <div className={styles['kpost-alist']}>
        <div className={styles['kpost-aicon']}>
          <GoodForm logged_in={logged_in} post={props.post} />
        </div>
        <div className={styles['kpost-num']} id={`good-num-${postType}-${id}`}>
          <a href={`/${postType}s/${id}/gooders`}>{goodNum}</a>
        </div>
      </div>
      {isKickspost && (
        <div className={styles['kpost-alist']}>
          <a
            className={styles['kpost-alink']}
            href={`${mysize_id}/kicksposts/${id}`}
          >
            <div className={styles['kpost-aicon']}>
              <i className="fa fa-comment-o" />
            </div>
            <div className={styles['kpost-num']}>
              <span>{commentNum}</span>
            </div>
          </a>
        </div>
      )}
      <div className={classnames(styles['kpost-alist'], styles['alist-last'])}>
        <a
          className={styles['kpost-alink']}
          href={twitterShareUrl}
          onClick={() =>
            "window.open(encodeURI(decodeURI(this.href)), 'tweetwindow', 'width=650, height=470, personalbar=0, toolbar=0, scrollbars=1, sizable=31'); return false;"
          }
        >
          <div className={styles['kpost-aicon']}>
            <i className="fa fa-twitter" />
          </div>
        </a>
      </div>
    </div>
  );
};

export { NormalPostAct };
