import * as React from 'react';
import renderReact from 'hypernova-react';

interface Props {}

interface State {}

class Hello extends React.Component<Props, State> {
  render() {
    return <div>Hello!!</div>;
  }
}

export default renderReact('Hello', Hello);
