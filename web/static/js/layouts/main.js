import React, { Component } from 'react';
import { Link } from 'react-router';

class MainLayout extends Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <div>
        {this.props.children}
      </div>
    );
  }
}

export default MainLayout;
