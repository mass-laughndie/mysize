import * as React from 'react';
import { HiddenAuthenticityToken } from '../HiddenAuthenticityField';

interface Props {
  id: number;
}

const GoodButton = (props: Props) => {
  const { id } = props;
  return (
    <div className="form-good">
      <form
        className="new_good"
        id="new_good"
        action="/goods"
        accept-charset="UTF-8"
        data-remote="true"
        method="post"
      >
        <HiddenAuthenticityToken />
        <div>
          <input
            type="hidden"
            name="post_type"
            id="post_type"
            value="Kickspost"
          />
        </div>
        <div>
          <input type="hidden" name="post_id" id="post_id" value={id} />
        </div>
        <button name="button" type="submit">
          <i className="fa fa-thumbs-o-up" />
        </button>
      </form>
    </div>
  );
};

export { GoodButton };
