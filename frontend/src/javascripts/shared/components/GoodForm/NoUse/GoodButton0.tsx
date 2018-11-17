// import * as React from 'react';
// import HiddenAuthenticityToken from '../../HiddenAuthenticityField';
// import classnames from 'classnames';
// import * as styles from './GoodForm.module.scss';
// import { Post } from '../../../../types/commonTypes';

// interface Props {
//   post: Post;
// }

// const GoodButton0 = (props: Props) => {
//   const cx = classnames.bind(styles);
//   const { id, postType } = props.post;
//   const formatPoatType = postType.charAt(0).toUpperCase() + postType.slice(1);
//   return (
//     <div className={cx('form-good')}>
//       <form
//         className="new_good"
//         id="new_good"
//         action="/goods"
//         acceptCharset="UTF-8"
//         data-remote="true"
//         method="post"
//       >
//         <HiddenAuthenticityToken />
//         <div>
//           <input
//             type="hidden"
//             name="post_type"
//             id="post_type"
//             value={formatPoatType}
//           />
//         </div>
//         <div>
//           <input type="hidden" name="post_id" id="post_id" value={id} />
//         </div>
//         <button name="button" type="submit">
//           <i className="fa fa-thumbs-o-up" />
//         </button>
//       </form>
//     </div>
//   );
// };

// export { GoodButton0 };
