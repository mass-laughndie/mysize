import * as React from 'react';
import HiddenAuthenticityToken from '../HiddenAuthenticityField';
import classnames from 'classnames';
import * as styles from './GoodForm.module.scss';
import { Post } from '../../../types/commonTypes';

interface Props {
  post: Post;
}

const UngoodButton = (props: Props) => {
  const cx = classnames.bind(styles);
  const { id } = props.post;
  return (
    <div className={cx('form-ungood')}>
      <form
        className="edit_good"
        id={`edit_good_${id}`}
        action={`/goods/${id}`}
        acceptCharset="UTF-8"
        data-remote="true"
        method="post"
      >
        <HiddenAuthenticityToken />
        <input type="hidden" name="_method" value="delete" />
        <button name="button" type="submit">
          <i className={cx('fa', 'fa-thumbs-up')} />
        </button>
      </form>
    </div>
  );
};

export { UngoodButton };
