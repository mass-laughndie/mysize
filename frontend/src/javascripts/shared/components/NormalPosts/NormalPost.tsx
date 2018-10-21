import * as React from 'react';
import classnames from 'classnames';
import * as $ from 'jquery';
import { Post, CurrentInfo } from '../../../types/commonTypes';
import { NormalPostLeft } from './NormalPostLeft';
import { NormalPostCenter } from './NormalPostCenter';
import { NormalPostAct } from './NormalPostAct';
import { NormalPostRight } from './NormalPostRight';
import * as styles from './NormalPost.module.scss';

interface Props {
  post: Post;
  currentInfo: CurrentInfo;
}

class NormalPost extends React.Component<Props> {
  public componentDidMount() {
    const { postType, id } = this.props.post;
    const $linkList = $(`#${postType}-${id}`);
    const height = $linkList.find('.content-height').height();
    $linkList.height(height);
    $linkList.find('.content-link').css('padding-bottom', height);
  }

  private twitterShareUrl = (post: Post): string => {
    const encodedURI = encodeURI(
      `${post.postUser.name}さんの投稿｜${post.title}\n`
    );
    return `https://twitter.com/intent/tweet?text=${encodedURI}&url=${
      window.location.origin
    }/${post.postUser.mysize_id}/kicksposts/${post.id}`;
  };

  public render() {
    const { post, currentInfo } = this.props;
    const isKickspost = post.postType === 'kickspost';
    const isReply = post.reply_id != undefined && post.reply_id != 0;

    return (
      <li
        id={`${post.postType}-${post.id}`}
        className={classnames({
          [styles['link-list']]: true,
          [styles['kpost-main']]: true,
          [styles[`reply-${post.reply_id}`]]: !isKickspost,
          [styles.clear]: true
        })}
      >
        <a
          className={classnames({
            [styles['content-link']]: true,
            jump: !isKickspost
          })}
          data-scroll={!isKickspost ? '-51' : ''}
          href={`/${post.postUser.mysize_id}/kicksposts/${
            isKickspost
              ? post.id
              : `${post.kickspost_id}#${post.postType}-${post.id}`
          }`}
        />
        <div className={classnames(styles['content-abs'])}>
          <div className={classnames(styles['content-height'])}>
            <div
              className={classnames({
                [styles['list-content']]: true,
                [styles['reply-main']]: isReply,
                [styles.clear]: true
              })}
            >
              {isReply && (
                <div
                  className={classnames(styles['kpost-reply-icon'], styles.c)}
                >
                  <i className="fa fa-caret-right" />
                </div>
              )}
              <NormalPostLeft postUser={post.postUser} />
              <NormalPostCenter post={post} />
              <NormalPostAct
                post={post}
                twitterShareUrl={this.twitterShareUrl(post)}
                currentInfo={currentInfo}
              />
              <NormalPostRight
                post={post}
                twitterShareUrl={this.twitterShareUrl(post)}
              />
            </div>
          </div>
        </div>
      </li>
    );
  }
}

export { NormalPost };
