import * as mobx from 'mobx';
import autoSave from './localStorageAutoSave';

const initialState = {
  id: null,
  email: null, 
  token: null,
};

class userStore {
  constructor() {
    mobx.extendObservable(this, initialState);
    autoSave(this, 'userStore');
  }

  @mobx.action 
  setUser(user) {
    this.id = user.id;
    this.email = user.email;
    this.token = user.token;
  }
}

export default new userStore();