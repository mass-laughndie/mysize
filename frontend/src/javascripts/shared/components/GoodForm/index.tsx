import * as React from 'react';
import { GoodButton } from './GoodButton';
import { UngoodButton } from './UngoodButton';
import { Post } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './GoodForm.module.scss';
import { addGoodList, removeGoodList } from '../../apis/GoodApi';

const DummyGoodButton = () => {
  return (
    <div className={classnames(styles.c, styles['form-good'])}>
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

class GoodForm extends React.Component<Props> {
  private renderGoodButton() {
    const { isLoggedIn, post } = this.props;

    if (isLoggedIn) {
      if (post.isGood) {
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
    await addGoodList(id, postType);
  };

  private handleRemoveGoodList = async (
    event: React.SyntheticEvent<HTMLElement>
  ) => {
    event.preventDefault();

    const { goodId } = this.props.post;
    await removeGoodList(goodId);
  };

  public render() {
    const { postType, id } = this.props.post;
    return (
      <div id={`good-form-${postType}-${id}`} className={styles['good-form']}>
        {this.renderGoodButton()}
      </div>
    );
  }
}

export default GoodForm;
