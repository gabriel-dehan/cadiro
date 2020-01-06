import React from 'react';
import seasonsStore from '../stores/seasonsStore';

const currencyIcons = {
  exalted: "http://web.poecdn.com/image/Art/2DItems/Currency/CurrencyAddModToRare.png?scale=1&w=1&h=1",
  chaos: "http://web.poecdn.com/image/Art/2DItems/Currency/CurrencyRerollRare.png?scale=1&w=1&h=1",
};

export const formatPrice = (price, currency) => {
  return (
    <div className={`formatted-price currency-${currency}`}>
      <span className="price">{price}</span>
      <img src={currencyIcons[currency]} />
    </div>
  )

};

export const priceToCurrency = (priceInChaos) => {
  const exaltedPrice = seasonsStore.current.currencies_prices.exalted;
  if (priceInChaos >= exaltedPrice) {
    return {
      price: (priceInChaos / exaltedPrice).toFixed(2),
      currency: 'exalted'
    };
  } 
  return { 
    price: priceInChaos,
    currency: 'chaos'
  };
}

export const chaosSubstraction = (currencyDataA, currencyDataB) => {
  const [priceInChaosA, priceInChaosB] = [currencyDataA, currencyDataB].map((currencyData) => priceInChaos(currencyData.price, currencyData.currency));
  return priceInChaosA - priceInChaosB;
};

export const priceInChaos = (price, from = 'exalted') => {
  const currentFromPrice = seasonsStore.current.currencies_prices[from];
  return price * currentFromPrice;
}