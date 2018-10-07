import * as React from 'react';
import { Post } from '../../types/commonTypes';
import { PostDelete } from './PostDelete';

interface Props {
  post: Post;
  twitterShareUrl: string;
}

const PostMenu = (props: Props) => {
  const { id, postType, postUser } = props.post;
  const { twitterShareUrl } = props;
  const isKickspost = postType == 'kickspost';
  return (
    <React.Fragment>
      <div id={`post-nav-${postType}-${id}`} className="post-nav">
        <i className="fa fa-angle-down" />
      </div>
      <ul id={`nav-list-${postType}-${id}`} className="nav-list">
        <li>
          <PostDelete post={props.post} />
        </li>
        {isKickspost && (
          <React.Fragment>
            <li className="bar" />
            <li>
              <a href={`/${postUser.mysize_id}/kicksposts/${id}/edit`}>
                <i className="fa fa-pencil-square-o" />
                {' 投稿を編集する'}
              </a>
            </li>
            <li className="bar" />
            <li>
              <a
                className="kpost-alink"
                href={twitterShareUrl}
                onClick={() =>
                  "window.open(encodeURI(decodeURI(this.href)), 'tweetwindow', 'width=650, height=470, personalbar=0, toolbar=0, scrollbars=1, sizable=31'); return false;"
                }
              >
                <div className="kpost-aicon">
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
};

export { PostMenu };
