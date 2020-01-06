/* eslint-disable react/prefer-stateless-function */
import React, { Component } from 'react';
import { Provider } from 'mobx-react';
import analysesStore from './analysesStore';
import seasonsStore from './seasonsStore';
import userStore from './userStore';

function withStores(WrappedComponent) {
  return class bannerRenderer extends Component { 
    get stores() {
      return {
        analysesStore,
        seasonsStore,
        userStore,
      };
    }

    render() {
      return (
        <Provider {...this.stores}>
          <WrappedComponent {...this.props} />
        </Provider>
      );
    }
  };
}

export default withStores;
