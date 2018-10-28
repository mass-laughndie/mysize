import * as React from 'react';
import HiddenAuthenticityToken from '../HiddenAuthenticityField';
import { User } from '../../../types/commonTypes';
import * as styles from './FollowForm.module.scss';

interface Props {
  user: User;
}

const UnfollowButton = (props: Props) => {
  const { id } = props.user;
  return (
    <div className={styles['form-unfollow']}>
      <form
        className="edit_relationship"
        id={`edit_relationship_${id}`}
        action={`/relationships/${id}`}
        acceptCharset="UTF-8"
        data-remote="true"
        method="post"
      >
        <HiddenAuthenticityToken />
        <input type="hidden" name="_method" value="delete" />
        <button name="button" type="submit">
          <i className="fa fa-user" />
          <i className="fa fa-check" />
        </button>
      </form>
    </div>
  );
};

export { UnfollowButton };
