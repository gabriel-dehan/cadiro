import React from "react"
import PropTypes from "prop-types"
import { observer, inject } from 'mobx-react';
import { formatPrice, chaosSubstraction, priceToCurrency } from '../helpers/currency';
import SearchBreakdown from './SearchBreakdown';

import PoeTradeIcon from '@assets/images/poetrade.png';

@inject('leaguesStore', 'analysesStore')
@observer
class Analysis extends React.Component {
  static propTypes = {
    analysis: PropTypes.object.isRequired,
    item: PropTypes.object.isRequired,
  };

  constructor(props) {
    super(props);

    this.state = {
      showItem: false,
      comments: this.props.analysis.comments,
    }
  }
  
  get watchUrl() {
    const { analysis, leaguesStore } = this.props;
    return `https://pathofexile.com/trade/search/${leaguesStore.current.name}/${analysis.search_id}`;
  }

  updateComments(comments) {
    this.setState({ comments })
  }

  updateAnalysis() {
    // Todo: add loading
    this.props.analysesStore.updateLeagueAnalysis(this.props.analysis.id, {
      comments: this.state.comments
    });
  }

  toggleItem(value) {
    this.setState({ showItem: value });
  }

  render () {
    const { item, analysis } = this.props;
    const { showItem } = this.state;

    const profitInCurrency = priceToCurrency(chaosSubstraction(analysis.sellout, analysis.buyout));
    // console.log(analysis);
    return (
      <tr>
        <td title="pathofexile.com/trade livesearch">
          <a href={this.watchUrl} _target="blank">
            <img src={PoeTradeIcon} alt="poe trade search" />
          </a>
        </td>
        <td className="item-image" onMouseEnter={() => this.toggleItem(true)} onMouseLeave={() => this.toggleItem(false)}>
          <img src={item.image} />
          {showItem && 
            <div className="item-tooltip" dangerouslySetInnerHTML={{__html: item.wiki_item_card}}></div>
          }
        </td>
        <td className="item">
          <h2 className={`item-name item-text-${item.rarity.toLowerCase()}`}>{item.name}</h2>
          <span className="item-type">
            {item.item_type}
          </span>
        </td>
        <td className="search-breakdown">
          <SearchBreakdown item={item} search={analysis.search_params} />
        </td>
        <td className="buyout">
          {formatPrice(analysis.buyout.price, analysis.buyout.currency)}
        </td>
        <td className="sellout">
          {formatPrice(analysis.sellout.price, analysis.sellout.currency)}
        </td>
        <td className="profit">
          {formatPrice(profitInCurrency.price, profitInCurrency.currency)}
        </td>
        <td className="esd">
          {analysis.estimated_swipe_difficulty}
        </td>
        <td className="occurences">{analysis.occurences}</td>
        <td className="trades">{analysis.trades}</td>
        <td className="tags">{item.tags}</td>
        <td className="comments">
          <div className="comments-input-container">
            <textarea rows="1" onChange={(e) => this.updateComments(e.target.value)} defaultValue={this.state.comments} />
            <button className="save-button" onClick={() => this.updateAnalysis()}>save</button>
          </div>
        </td>
      </tr>
    );
  }
}

export default Analysis;
