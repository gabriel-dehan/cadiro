import * as mobx from 'mobx';
import autoSave from './localStorageAutoSave';
import userStore from './userStore';

const initialState = {
  season: null,
};

class analysesStore {
  constructor() {
    mobx.extendObservable(this, initialState);
    autoSave(this, 'analysesStore');
  }

  @mobx.action 
  setSeason(season) {
    this.season = season;
  }

  updateSeasonAnalysis(id, params) {
    const url = `${window.location.origin}/api/v1/analyses/update_season_analysis`;
        
    params = { id, poe_auth_token: userStore.token, ...params };
    
    fetch(url, {
      method: 'POST', 
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(params),
    })
  }
}

export default new analysesStore();