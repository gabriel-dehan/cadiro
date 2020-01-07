import React from "react"
import PropTypes from "prop-types"
import { observer, inject } from 'mobx-react';
import { capitalize, map } from 'lodash';
import { isBool, hasManyKeys, filterObject } from '../helpers/utils';

@inject('seasonsStore')
@observer
class SearchBreakdown extends React.Component {
  static propTypes = {
    search: PropTypes.object.isRequired,
    item: PropTypes.object.isRequired,
  };

  constructor(props) {
    super(props);

    this.state = {
      showFilters: false,
    }
  }

  toggleFilters() {
    this.setState({ showFilters: !this.state.showFilters });
  }

  renderStats() {
    const { search: { stats }, item } = this.props;

    return stats.map((stat, i) => {
      const { type, filters } = stat;
      if (type === 'and') {
        return (
          <div key={`item-${item.slug}-stat-${i}`} className="stats-separator type-and">
            {this.renderStatFilters(filters)}
          </div>
        );
      } else if (type === 'or') {
        return (
          <div key={`item-${item.slug}-stat-${i}`} className="stats-separator type-or">
            {this.renderStatFilters(filters)}
          </div>
        );
      }
    });
  }

  renderStatFilters(filters) {
    const { item } = this.props;

    return filters.map(filter => (
      <div key={`item-${item.slug}-${filter.id}`} className="filter">
        <span className="filter-text">{filter.data.text}</span>
        {filter.data.value && 
          <span className="filter-value">{filter.data.value}</span>
        }
      </div>
    ));
  }

  renderFilters() {
    const { search: { filters }, item } = this.props;
    const enabledFilters = filterObject(filters.table, f => !f.table.disabled);

    return map(enabledFilters, (filter, key) => {
      const category = key.split("_").map(w => capitalize(w)).join(" ");
      
      return (
        <div key={`item-${item.slug}-${category}`} className={`filter ${key}`}>
          <strong className="category-name">{category}</strong>
          {this.renderCategory(filter.table.filters.table)}
        </div>
      );
    })
  }

  renderCategory(categoryFilters) {
    const { item } = this.props;

    return map(categoryFilters, (filter, type) => {
      const data = filter.table;
      
      return (
        <div key={`item-${item.slug}-${type}`}>
          {this.renderFilterData(type, data)}
        </div>
      )
    });
  }

  renderFilterData(type, data) {
    const { item } = this.props;
    const formattedType = type.split("_").map(w => capitalize(w)).join(" ");

    // If we only have one property, a boolean named option
    if (data.option && isBool(data.option) && !hasManyKeys(data)) {
      return (
        <>
          <span className={`property property-${type}`}>{formattedType}</span>
        </>
      );
    } else {
      return (
        <>
          <span className="filter-name">{formattedType}</span>
          <ul className="filter-params">
            {map(filterObject(data, v => !!v), (value, key) => (
              <li key={`item-${item.slug}-${type}-param-${key}`}>
              <span className="param-key">{key}</span>: <span className="param-value">{value}</span>
              </li>
            ))}
          </ul>
        </>
      )
    }
  }
  
  render () {
    const { search: { stats, filters }, item } = this.props;
    console.log(stats, filters, item);
    
    return (
      <div>
        <div className="item-stats">
          {this.renderStats()}
        </div>
        <div className="item-filters">
          <strong className="filter-toggle" onClick={() => this.toggleFilters()}>Filters <span className="caret">{this.state.showFilters ? '▼' : '▶'}</span></strong>
          <div className={`inner-filters ${this.state.showFilters && 'show-filters'}`}>
            {this.renderFilters()}
          </div>
        </div>
      </div>
    );
  }
}

export default SearchBreakdown;
