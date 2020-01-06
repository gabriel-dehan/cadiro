import * as mobx from 'mobx';
import store from 'store';

export default function(_this, storeName, transforms = {}) {
  let firstRun = true;

  // will run on change
  mobx.autorun(() => {
    // on load check if there's an existing store on localStorage and extend the store
    if (firstRun) {
      let existingStore = store.get(storeName);

      if (existingStore) {
        existingStore = transforms.read ? transforms.read(existingStore) : existingStore;
        mobx.set(_this, existingStore);
      }
    }
    
    // from then on serialize and save to localStorage
    let storeToWrite = mobx.toJS(_this);
    storeToWrite = transforms.read ? transforms.write(storeToWrite) : storeToWrite;
    store.set(storeName, storeToWrite);
  });

  firstRun = false;
}
