import * as React from 'react';
import { User } from '../../../types/commonTypes';
import { FollowButton } from './FollowButton';
import { UnfollowButton } from './UnfollowButton';

const DummyFollowButton = () => {
  return (
    <div className="c form-follow">
      <a href="#" className="ban">
        <i className="fa fa-user" />
        <i className="fa fa-plus" />
      </a>
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
      if (user.isFollow) {
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
