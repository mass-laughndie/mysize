import * as React from 'react';
import HiddenAuthenticityToken from '../HiddenAuthenticityField';
import { User } from '../../../types/commonTypes';

interface Props {
  user: User;
}

const FollowButton = (props: Props) => {
  const { id } = props.user;
  return (
    <div className="form-follow">
      <form
        className="new_relationship"
        id="new_relationship"
        action="/relationships"
        acceptCharset="UTF-8"
        data-remote="true"
        method="post"
      >
        <HiddenAuthenticityToken />
        <div>
          <input type="hidden" name="followed_id" id="followed_id" value={id} />
        </div>
        <button name="button" type="submit">
          <i className="fa fa-user" />
          <i className="fa fa-plus" />
        </button>
      </form>
    </div>
  );
};

export { FollowButton };
