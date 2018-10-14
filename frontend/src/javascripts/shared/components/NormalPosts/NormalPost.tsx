import * as React from 'react';
import classnames from 'classnames';
import * as $ from 'jquery';
import { Post } from '../../../types/commonTypes';
import { NormalPostLeft } from './NormalPostLeft';
import { NormalPostCenter } from './NormalPostCenter';
import { NormalPostAct } from './NormalPostAct';
import { NormalPostRight } from './NormalPostRight';
import * as styles from './NormalPost.module.scss';

interface Props {
  post: Post;
  logged_in: boolean;
}

class NormalPost extends React.Component<Props> {
  public componentDidMount() {
    const $linkList = $('.link-list');
    $linkList.each(function() {
      //子要素(=absolute要素内の固定長要素)の高さ
      const height = $linkList.find('.content-height').height();
      $linkList.height(height);
      $linkList.find('.content-link').css('padding-bottom', height);
    });
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
    const { post, logged_in } = this.props;

    return (
      <li
        id={`kickspost-${post.id}`}
        className={classnames(
          styles['link-list'],
          'link-list',
          styles['kpost-main'],
          'kpost-main',
          styles.clear,
          'clear'
        )}
      >
        <a
          className={classnames(styles['content-link'], 'content-link')}
          href={`/${post.postUser.mysize_id}/kicksposts/${post.id}`}
        />
        <div className={classnames(styles['content-abs'], 'content-abs')}>
          <div
            className={classnames(styles['content-height'], 'content-height')}
          >
            <div
              className={classnames(
                styles['list-content'],
                'list-content',
                styles.clear,
                'clear'
              )}
            >
              <NormalPostLeft postUser={post.postUser} />
              <NormalPostCenter post={post} />
              <NormalPostAct
                post={post}
                twitterShareUrl={this.twitterShareUrl(post)}
                logged_in={logged_in}
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
