import * as React from 'react';
import classnames from 'classnames';
import { User } from '../../../types/commonTypes';
import { FollowButton } from './FollowButton';
import { UnfollowButton } from './UnfollowButton';
import * as styles from './FollowForm.module.scss';
import { followUser, unfollowUser } from '../apis';

const DummyFollowButton = () => {
  const cx = classnames.bind(styles);

  return (
    <div className={cx('follow-form', 'c')}>
      <div className={cx('form-follow')}>
        <a href='#' className='ban'>
          <i className='fa fa-user' />
          <i className='fa fa-plus' />
        </a>
      </div>
    </div>
  );
};

interface Props {
  user: User;
  isLoggedIn: boolean;
}

interface State {
  followingId: number | null;
  isFollow: boolean;
}

class FollowForm extends React.Component<Props, State> {
  state: State = {
    followingId: this.props.user.followingId,
    isFollow: this.props.user.isFollow,
  };

  private renderFollowButton() {
    const { user, isLoggedIn } = this.props;
    const { isFollow } = this.state;

    if (isLoggedIn) {
      if (isFollow) {
        return <UnfollowButton user={user} onClick={this.handleUnfollowUser} />;
      } else {
        return <FollowButton user={user} onClick={this.handleFollowUser} />;
      }
    } else {
      return <DummyFollowButton />;
    }
  }

  private handleFollowUser = async (event: React.SyntheticEvent<HTMLElement>) => {
    event.preventDefault();

    const { id } = this.props.user;
    const new_relationship = await followUser(id);

    this.setState({
      followingId: new_relationship.id,
      isFollow: true,
    });
  };

  private handleUnfollowUser = async (event: React.SyntheticEvent<HTMLElement>) => {
    event.preventDefault();

    const { followingId } = this.state;
    await unfollowUser(followingId);

    this.setState({
      followingId: null,
      isFollow: false,
    });
  };

  public render() {
    const cx = classnames.bind(styles);
    const { id } = this.props.user;

    return (
      <div id={`follow-form-${id}`} className={cx('follow-form', 'c')}>
        {this.renderFollowButton()}
      </div>
    );
  }
}

export default FollowForm;
