import * as React from 'react';
import { Post } from '../../types/commonTypes';
import { PostDelete } from './PostDelete';
import classnames from 'classnames';
import * as styles from './PostMenu.module.scss';
import $ from 'jquery';

interface Props {
  post: Post;
  twitterShareUrl: string;
}

class PostMenu extends React.Component<Props> {
  private;

  public render() {
    const { id, postType, postUser } = this.props.post;
    const { twitterShareUrl } = this.props;
    const isKickspost = postType == 'kickspost';

    return (
      <React.Fragment>
        <div id={`post-nav-${postType}-${id}`} className={styles['post-nav']}>
          <i className="fa fa-angle-down" />
        </div>
        <ul id={`nav-list-${postType}-${id}`} className={styles['nav-list']}>
          <li>
            <PostDelete post={this.props.post} />
          </li>
          {isKickspost && (
            <React.Fragment>
              <li className={styles['bar']} />
              <li>
                <a href={`/${postUser.mysize_id}/kicksposts/${id}/edit`}>
                  <i className="fa fa-pencil-square-o" />
                  {' 投稿を編集する'}
                </a>
              </li>
              <li className="bar" />
              <li>
                <a
                  className={styles['kpost-alink']}
                  href={twitterShareUrl}
                  onClick={() =>
                    "window.open(encodeURI(decodeURI(this.href)), 'tweetwindow', 'width=650, height=470, personalbar=0, toolbar=0, scrollbars=1, sizable=31'); return false;"
                  }
                >
                  <div className={styles['kpost-aicon']}>
                    <i className="fa fa-twitter" />
                    {' Twitterでシェア'}
                  </div>
                </a>
              </li>
            </React.Fragment>
          )}
        </ul>
      </React.Fragment>
    );
  }
}

export { PostMenu };
