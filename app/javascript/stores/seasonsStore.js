import * as mobx from 'mobx';
import autoSave from './localStorageAutoSave';

const initialState = {
  current: null,
};

class seasonsStore {
  constructor() {
    mobx.extendObservable(this, initialState);
    autoSave(this, 'seasonsStore');
  }

  @mobx.action 
  setCurrent(season) {
    this.current = season;
  }
}

export default new seasonsStore();