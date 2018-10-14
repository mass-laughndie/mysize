import * as React from 'react';
import { GoodButton } from './GoodButton';
import { UngoodButton } from './UngoodButton';
import { Post } from '../../../types/commonTypes';
import classnames from 'classnames';
import * as styles from './GoodForm.module.scss';

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
  logged_in: boolean;
  post: Post;
}

class GoodForm extends React.Component<Props> {
  private renderGoodButton() {
    const { logged_in } = this.props;
    const { id, isGood } = this.props.post;

    if (logged_in) {
      if (isGood) {
        return <UngoodButton id={id} />;
      } else {
        return <GoodButton id={id} />;
      }
    } else {
      return <DummyGoodButton />;
    }
  }

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
