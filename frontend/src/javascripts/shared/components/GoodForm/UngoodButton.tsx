import * as React from 'react';
import { HiddenAuthenticityToken } from '../HiddenAuthenticityField';
import classnames from 'classnames';
import * as styles from './GoodForm.module.scss';

interface Props {
  id: number;
}

const UngoodButton = (props: Props) => {
  const { id } = props;
  return (
    <div className={classnames(styles['form-ungood'])}>
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
          <i className={classnames(styles.fa, 'fa', 'fa-thumbs-up')} />
        </button>
      </form>
    </div>
  );
};

export { UngoodButton };
