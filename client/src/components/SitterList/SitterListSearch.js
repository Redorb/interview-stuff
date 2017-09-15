import PropTypes from 'prop-types'
import React from 'react'
import Rating from 'react-rating'

class SitterSearch extends React.Component {
  static propTypes = {
    filter: PropTypes.object
  };

  constructor(props) {
    super(props);
    this.state = { 
      filter: {
        rating: 0,
        isAsc: false
      } 
    };
  }

  updateOrdering(value) {
    let newState = {
      filter: {
        rating: this.state.filter.rating,
        isAsc: value === 'asc'
      }
    }
    this.setState(newState);
    this.props.onChange(newState.filter);
  }

  updateCurrentRating(rating) {
    let newState = {
      filter: {
        rating: rating,
        isAsc: this.state.filter.isAsc
      }
    }
    this.setState(newState);
    this.props.onChange(newState.filter);
  }

  render() {
    return (
      <div className="filters content has-text-centered is-flex">
        <div className="filterItem">
          <p className="is-size-4 is-marginless">Sitter Rating Ordering:</p>
          <div className="select">
            <select onChange={(e) => this.updateOrdering(e.target.value)}>
              <option value='desc'>Descending</option>
              <option value='asc'>Ascending</option>
            </select>
          </div>
        </div>
        <div className="filterItem">
          <p className="is-size-4 is-marginless">Minimum Rating:</p>
          <Rating
            empty="fa fa-star-o is-size-3"
            full="fa fa-star is-size-3"
            initialRate={this.state.filter.rating}
            onChange={(rate) => this.updateCurrentRating(rate)}
            fractions={2} />
        </div>
      </div>
    );
  }
}

export default SitterSearch;