import React from "react"
import PropTypes from "prop-types"
import { observer, inject } from 'mobx-react';
import { capitalize, map, sortBy, indexOf } from 'lodash';
import { isBool, hasManyKeys, filterObject } from '../helpers/utils';

const MISC_TAGS_DISPLAY = {
  corrupted: {
    true: 'corrupted',
    false: 'uncorrupted'
  },
  enchanted: {
    true: 'enchanted',
    false: 'not enchanted'
  },
  identified: {
    true: 'identified',
    false: 'unidentified'
  },
  shaper_item: {
    true: 'shaper',
    false: 'not shaper',
  },
  elder_item: {
    true: 'elder',
    false: 'not elder',
  }
}

const CATEGORIES_DISPLAY = {

}

// This component mainly parses the data from the pathofexile.com/trade website and displays it properly
// Expects lots of maps and filters :D 
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

  formatType(type) {
    return type.split("_").map(w => capitalize(w)).join(" ");
  }

  sortFilterData(data) {
    var order = ['r', 'g', 'b', 'min', 'max', 'option'];
    var sortedData = sortBy(
      map(data, (v, k) => { let o = {}; o[k] = v; return o; }), // creates an array of object instead of one full object, easier to sort
      obj => {
        let index = indexOf(order, Object.keys(obj)[0]);
        return index != -1 ? index : 1000; // If index not found make sure it's after
      }
    );
    
    return Object.assign({}, ...sortedData);
  }

  // Loop through affixes
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

  // Render filters on affixes
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

  // Loop through filters (ilvl, etc...)
  renderFilters() {
    const { search: { filters }, item } = this.props;
    const enabledFilters = filterObject(filters.table, f => !f.table.disabled);

    return map(enabledFilters, (filter, key) => {
      const category = key.split("_").map(w => capitalize(w)).join(" ").replace(/filters?/i, '');

      return (
        <div key={`item-${item.slug}-${category}`} className={`filter ${key}`}>
          <strong className="category-name">{category}</strong>
          {this.renderCategory(filter.table.filters.table)}
        </div>
      );
    })
  }

  // Render and loops through a filter category 
  renderCategory(categoryFilters) {
    const { item } = this.props;

    return map(categoryFilters, (filter, type) => {
      const data = filter.table;
      
      return (
        <div key={`item-${item.slug}-${type}`} className="category-container">
          {this.renderFilterData(type, data)}
        </div>
      )
    });
  }

  // Renders a specific filter from a category
  renderFilterData(type, data) {
    const { item } = this.props;

    // If we are not working with what we consider a misc filter tag
    if (!(data.option && isBool(data.option) && !hasManyKeys(data))) {
      const orderedData = this.sortFilterData(data);

      return (
        <>
          <span className="filter-name">{this.formatType(type)}</span>
          <ul className="filter-params">
            {map(filterObject(orderedData, v => !!v), (value, key) => (
              <li key={`item-${item.slug}-${type}-param-${key}`}>
                <span className="param-key">{key}</span>: <span className="param-value">{value}</span>
              </li>
            ))}
          </ul>
        </>
      )
    }
  }

  // Takes all misc filters that only have boolean values, and renders them as "tags"
  renderMiscFiltersAsTags() {
    const { search: { filters }, item } = this.props;
    const miscFilters = filters.table.misc_filters && filters.table.misc_filters.table.filters.table;

    if (miscFilters) {
      // If we only have one property, a boolean named option
      const relevantFilters = filterObject(miscFilters, (filter) => {
        const data = filter.table;
        return data.option && isBool(data.option) && !hasManyKeys(data);
      })

      const tags = map(relevantFilters, (filter, type) => {
        const data = filter.table;
        const isTrue = data.option === "true";

        return (
          <div key={`item-${item.slug}-misc-tag-${type}`} className={`misc-filter-tag type-${type}`}>
            {MISC_TAGS_DISPLAY[type][isTrue]}
          </div>
        );
      });

      return (
        <div className="misc-filters-tags">
          {tags}
        </div>
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
          {this.state.showFilters && 
            <div className="inner-filters">
              {this.renderMiscFiltersAsTags()}
              <div className="filters-list">
                {this.renderFilters()}
              </div>
            </div>
          }
        </div>
      </div>
    );
  }
}

export default SearchBreakdown;
