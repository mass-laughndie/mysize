import * as React from 'react';
import { User } from '../../../types/commonTypes';
import { FollowButton } from './FollowButton';
import { UnfollowButton } from './UnfollowButton';

const DummyFollowButton = () => {
  return (
    <div className="c form-follow">
      {/* <%= link_to fa_icon("user") + fa_icon("plus"), '#', class: 'ban' %> */}
    </div>
  );
};

interface Props {
  isLoggedIn: boolean;
  user: User;
}

class GoodForm extends React.Component<Props> {
  private renderFollowButton() {
    const { isLoggedIn, user } = this.props;

    if (isLoggedIn) {
      if (/*user.isFollow*/ false) {
        return <UnfollowButton user={user} />;
      } else {
        return <FollowButton user={user} />;
      }
    } else {
      return <DummyFollowButton />;
    }
  }

  public render() {
    const { id } = this.props.user;
    return (
      <div id={`user-follow-form-${id}`} className="form-follow">
        {this.renderFollowButton()}
      </div>
    );
  }
}

export default GoodForm;
