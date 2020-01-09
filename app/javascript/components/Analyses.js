import React from "react"
import PropTypes from "prop-types"
import { observer, inject } from 'mobx-react';
import Fuse from "fuse.js";

import withStores from '../stores/withStores';
import Analysis from './Analysis';

@inject('analysesStore', 'seasonsStore', 'userStore')
@observer
class Analyses extends React.Component {
  static propTypes = {
    data: PropTypes.object.isRequired,
  };
  
  constructor(props) {
    super(props);

    this.state = {
      loaded: false,
      analyses: this.props.data.analyses,
    }
  }

  setupSearch() {
    this.fuse = new Fuse(this.props.data.analyses, {
      keys: [
        { name: 'item.name', weight: 0.7 }, 
        { name: 'item.item_type', weight: 0.7 },
        { name: 'item.rarity', weight: 0.3 },
        { name: 'item.tags', weight: 0.5 },
        { name: 'season_analyses.season.name', weight: 0.3 },
        { name: 'season_analyses.buyout.currency', weight: 0.1 },
        { name: 'season_analyses.sellout.currency', weight: 0.1 },
        { name: 'season_analyses.comments', weight: 0.4 },
      ],
      tokenize: true,
      shouldSort: true,
      findAllMatches: true,
      threshold: 0.4,
      // includeMatches: true,
      distance: 50,
      maxPatternLength: 48,
      minMatchCharLength: 2,
    });
  }

  componentDidMount() {
    this.props.userStore.setUser(this.props.data.current_user);
    this.props.seasonsStore.setCurrent(this.props.data.current_season);

    this.setupSearch();

    this.setState({ loaded: true });
  }

  search(value) {
    if (value.length > 2) {
      const result = this.fuse.search(value);
      // console.log(result);
      this.setState({ analyses: result });
    } else {
      this.setState({ analyses: this.props.data.analyses });
    }
  }

  renderTable() {
    const { analyses } = this.state;

    if (analyses.length > 0) {
      return (
        <table className="table table-striped analyses-table">
          <thead>
            <tr>
              <th className="watch" scope="col"></th>
              <th colSpan="2" scope="col">Item</th>
              <th scope="col">Search</th>
              <th scope="col">B/O price</th>
              <th scope="col">S/O price</th>
              <th scope="col">~ Profit</th>
              <th scope="col">ESD</th>
              <th scope="col">Occurence</th>
              <th scope="col">Trades</th>
              <th scope="col">Tags</th>
              <th scope="col">Comment</th>
            </tr>
          </thead>
          <tbody>
            {this.renderAnalyses()}
          </tbody>
        </table>
      );
    } else {
      return (
        <div className="search-no-result">
          Sorry, Cadiro didn't find any result for your query :'(
        </div>
      )
    }
  }

  renderAnalyses() {
    const { analyses } = this.state;
    
    return analyses.map(analysis => {
        const season_analysis = analysis.season_analyses
          .filter(sa => sa.season.name !== 'Standard')
          .sort((a, b) => new Date(b.season.start_date) - new Date(a.season.start_date))
          [0];

        return <Analysis 
          key={analysis.id} 
          item={analysis.item}
          analysis={season_analysis} 
        />
      }
    )
  }

  render () {
    // Todo: loader
    if (!this.state.loaded) { return null }

    return (
      <div className="analyses-container">
        <div className="search-container">
          <input onChange={(e) => { this.search(e.target.value) }} type="text" className="analyses-search form-control" placeholder="Ring, Boots, Circle of Nostalgia..." />
        </div>
        
        {this.renderTable()}
      </div>
    );
  }
}

export default withStores(Analyses);
