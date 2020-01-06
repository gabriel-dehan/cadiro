import React from "react"
import PropTypes from "prop-types"
import { observer, inject } from 'mobx-react';

import withStores from '../stores/withStores';
import Analysis from './Analysis';

@inject('analysesStore', 'seasonsStore', 'userStore')
@observer
class AnalysesTable extends React.Component {
  static propTypes = {
    data: PropTypes.object.isRequired,
  };
  
  state = {
    loaded: false,
  }

  componentDidMount() {
    this.props.userStore.setUser(this.props.data.current_user);
    this.props.seasonsStore.setCurrent(this.props.data.current_season);
    this.setState({ loaded: true });
  }

  renderAnalyses() {
    const { analyses } = this.props.data;
    
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
        <table className="table table-striped analyses-table">
          <thead>
            <tr>
              <th className="watch" scope="col"></th>
              <th colspan="2" scope="col">Item</th>
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
      </div>
    );
  }
}

export default withStores(AnalysesTable);
