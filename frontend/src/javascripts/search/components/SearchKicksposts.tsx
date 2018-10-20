import * as React from 'react';
import { gon } from '../../types/window';
import NormalPosts from '../../shared/components/NormalPosts/NormalPosts';

const posts = gon.searchKicksposts;
const logged_in = gon.logged_in;

interface Props {}

class SearchKicksposts extends React.Component<Props> {
  render() {
    return <NormalPosts posts={posts} logged_in={logged_in} />;
  }
}

export default SearchKicksposts;
