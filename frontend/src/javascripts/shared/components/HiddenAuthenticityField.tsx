import * as React from 'react';
import getCsrfToken from '../utils/getCsrtToken';

interface Props {}

interface State {
  authenticityToken: string;
}

class HiddenAuthenticityToken extends React.Component<Props, State> {
  state: State = {
    authenticityToken: getCsrfToken()
  };

  public render() {
    return (
      <div style={{ display: 'none' }}>
        <input name="utf8" type="hidden" value="✓" />
        <input
          type="hidden"
          name="authenticity_token"
          value={this.state.authenticityToken}
        />
      </div>
    );
  }
}

export { HiddenAuthenticityToken };
