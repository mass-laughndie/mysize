import * as React from 'react';
import GoodForm from '../GoodForm/GoodForm';
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
          <GoodForm isLoggedIn={isLoggedIn} post={props.post} />
        </div>
        <div className={styles['kpost-num']} id={`good-num-${postType}-${id}`}>
          <a href={`/${postType}s/${id}/gooders`}>{goodNum}</a>
        </div>
      </div>
      {isKickspost ? (
        <React.Fragment>
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
          <div
            className={classnames(styles['kpost-alist'], styles['alist-last'])}
          >
            <div className={styles['kpost-aicon']}>
              <i className="fa fa-comment-o" />
            </div>
            <div className={styles['kpost-num']}>
              <span>{commentNum}</span>
            </div>
          </div>
        )
      )}
    </div>
  );
};

export { NormalPostAct };
