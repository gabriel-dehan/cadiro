import { reduce } from 'lodash';

export const isBool = (val) => {
  if (typeof val === "string") {
    return val === "true" || val === "false";
  } else {
    return typeof val === "boolean";
  }
}

export const hasManyKeys = (obj) => {
  return Object.keys(obj).length > 1;
}

export const filterObject = (obj, predicate) => {
  return Object.keys(obj)
    .filter( key => predicate(obj[key]) )
    .reduce( (res, key) => (res[key] = obj[key], res), {} );
}