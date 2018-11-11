import * as React from 'react';
import classnames from 'classnames';
import { User, CurrentInfo } from '../../../types/commonTypes';
import { FollowButton } from './FollowButton';
import { UnfollowButton } from './UnfollowButton';
import * as styles from './FollowForm.module.scss';

const DummyFollowButton = () => {
  const cx = classnames.bind(styles);

  return (
    <div className={cx('follow-form', 'c')}>
      <a href="#" className="ban">
        <i className="fa fa-user" />
        <i className="fa fa-plus" />
      </a>
    </div>
  );
};

interface Props {
  user: User;
  currentInfo: CurrentInfo;
}

class GoodForm extends React.Component<Props> {
  private renderFollowButton() {
    const { user, currentInfo } = this.props;

    if (currentInfo.isLoggedIn) {
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
      <div id={`follow-form-${id}`} className="follow-form">
        {this.renderFollowButton()}
      </div>
    );
  }
}

export default GoodForm;
