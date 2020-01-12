import * as mobx from 'mobx';
import autoSave from './localStorageAutoSave';
import userStore from './userStore';

const initialState = {
  league: null,
};

class analysesStore {
  constructor() {
    mobx.extendObservable(this, initialState);
    autoSave(this, 'analysesStore');
  }

  @mobx.action 
  setLeague(league) {
    this.league = league;
  }

  updateLeagueAnalysis(id, params) {
    const url = `${window.location.origin}/api/v1/analyses/update_league_analysis`;
        
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