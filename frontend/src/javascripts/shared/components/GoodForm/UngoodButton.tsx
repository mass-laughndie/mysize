import * as React from 'react';
import { HiddenAuthenticityToken } from '../HiddenAuthenticityField';

interface Props {
  id: number;
}

const UngoodButton = (props: Props) => {
  const { id } = props;
  return (
    <div className="form-good">
      <form
        className="edit_good"
        id={`edit_good_${id}`}
        action={`/goods/${id}`}
        accept-charset="UTF-8"
        data-remote="true"
        method="post"
      >
        <HiddenAuthenticityToken />
        <input type="hidden" name="_method" value="delete" />
        <button name="button" type="submit">
          <i className="fa fa-thumbs-up" />
        </button>
      </form>
    </div>
  );
};

export { UngoodButton };
