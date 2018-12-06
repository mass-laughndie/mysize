import * as React from 'react';
import classnames from 'classnames';
import * as $ from 'jquery';
import { Post, CurrentInfo } from '../../../types/commonTypes';
import { NormalPostLeft } from './NormalPostLeft';
import { NormalPostCenter } from './NormalPostCenter';
import { NormalPostAct } from './NormalPostAct';
import { NormalPostRight } from './NormalPostRight';
import * as styles from '../../Shared/components/List.module.scss';

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
    const cx = classnames.bind(styles);
    const { post, currentInfo } = this.props;
    const isKickspost = post.postType === 'kickspost';
    const isReply = post.reply_id != undefined && post.reply_id != 0;

    return (
      <li
        id={`${post.postType}-${post.id}`}
        className={cx(
          'link-list',
          'kpost-main',
          {
            [`reply-${post.reply_id}`]: !isKickspost
          },
          'clear'
        )}
      >
        <a
          className={cx('content-link', {
            jump: !isKickspost
          })}
          data-scroll={!isKickspost ? '-51' : ''}
          href={`/${post.postUser.mysize_id}/kicksposts/${
            isKickspost
              ? post.id
              : `${post.kickspost_id}#${post.postType}-${post.id}`
          }`}
        />
        <div className={cx('content-abs')}>
          <div className={cx('content-height')}>
            <div
              className={cx(
                'list-content',
                {
                  'reply-main': isReply
                },
                'clear'
              )}
            >
              {isReply && (
                <div className={cx('kpost-reply-icon', 'c')}>
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
