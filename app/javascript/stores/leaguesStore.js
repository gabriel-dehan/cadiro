import * as mobx from 'mobx';
import autoSave from './localStorageAutoSave';

const initialState = {
  current: null,
};

class leaguesStore {
  constructor() {
    mobx.extendObservable(this, initialState);
    autoSave(this, 'leaguesStore');
  }

  @mobx.action 
  setCurrent(league) {
    this.current = league;
  }
}

export default new leaguesStore();