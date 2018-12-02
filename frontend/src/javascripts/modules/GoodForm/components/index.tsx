import * as React from 'react';
import { GoodButton } from './GoodButton';
import { UngoodButton } from './UngoodButton';
import { Post } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './GoodForm.module.scss';
import { addGoodList, removeGoodList } from '../../../shared/apis/GoodApi';

const DummyGoodButton = () => {
  const cx = classnames.bind(styles);
  return (
    <div className={cx('c', 'form-good')}>
      <a className="ban" href="#">
        <i className="fa fa-thumbs-o-up" />
      </a>
    </div>
  );
};

interface Props {
  isLoggedIn: boolean;
  post: Post;
}

interface State {
  goodId: number | null;
  isGood: boolean;
  goodNum: number;
}

class GoodForm extends React.Component<Props, State> {
  state: State = {
    goodId: this.props.post.goodId,
    isGood: this.props.post.isGood,
    goodNum: this.props.post.goodNum
  };

  private renderGoodButton() {
    const { isLoggedIn, post } = this.props;
    const { isGood } = this.state;

    if (isLoggedIn) {
      if (isGood) {
        return <UngoodButton post={post} onClick={this.handleRemoveGoodList} />;
      } else {
        return <GoodButton post={post} onClick={this.handleAddGoodList} />;
      }
    } else {
      return <DummyGoodButton />;
    }
  }

  private handleAddGoodList = async (
    event: React.SyntheticEvent<HTMLElement>
  ) => {
    event.preventDefault();

    const { id, postType } = this.props.post;
    const new_good = await addGoodList(id, postType);

    this.setState({
      goodId: new_good.id,
      isGood: true,
      goodNum: this.state.goodNum + 1
    });
  };

  private handleRemoveGoodList = async (
    event: React.SyntheticEvent<HTMLElement>
  ) => {
    event.preventDefault();

    const { goodId } = this.state;
    await removeGoodList(goodId);

    this.setState({
      goodId: null,
      isGood: false,
      goodNum: this.state.goodNum - 1
    });
  };

  public render() {
    const cx = classnames.bind(styles);
    const { postType, id } = this.props.post;
    const { goodNum } = this.state;

    return (
      <React.Fragment>
        <div className={cx('kpost-aicon')}>
          <div
            id={`good-form-${postType}-${id}`}
            className={styles['good-form']}
          >
            {this.renderGoodButton()}
          </div>
        </div>
        <div className={cx('kpost-num')} id={`good-num-${postType}-${id}`}>
          <a href={`/${postType}s/${id}/gooders`}>{goodNum}</a>
        </div>
      </React.Fragment>
    );
  }
}

export default GoodForm;
