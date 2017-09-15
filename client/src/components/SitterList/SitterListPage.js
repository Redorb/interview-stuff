import PropTypes from 'prop-types'
import React, { Component } from 'react'
import agent from '../../libs/agent'
import SitterList from './SitterList'
import SitterListSearch from './SitterListSearch'
import SitterListPagination from './SitterListPagination'

class SitterListPage extends Component {
  static propTypes = {
    paginatedSitters: PropTypes.array,
    sitters: PropTypes.array,
    initialSitters: PropTypes.array,
    pagingAmount: PropTypes.number,
    currentPage: PropTypes.number
  };

  async componentDidMount() {
    agent.Sitters.all().then((sitters) => {
      this.setState({ 
        sitters: sitters,
        initialSitters: sitters,
        paginatedSitters: this.createPageSitters(sitters, 1)
      })
    });
  }

  constructor(props) {
    super(props);
    this.state = { 
      sitters: [], 
      initialSitters: [],
      paginatedSitters: [],
      currentPage: 1,
      pagingAmount: 10
    };
  }

  filterReviews(filter) {
    console.log(filter);
    let updatedList = this.state.initialSitters;
    let sortDirection = filter.isAsc ? 
      this.ascendingReviews : this.descendingReviews;

    updatedList = updatedList.filter((sitter) => {
      return sitter.overall_score >= filter.rating;
    }).sort((a, b) => sortDirection(a, b));
    this.setState({
      sitters: updatedList,
      paginatedSitters: this.createPageSitters(updatedList, 1),
      currentPage: 1,
    });
  }

  descendingReviews(a, b) {
    return b.overall_score - a.overall_score;
  }

  ascendingReviews(a, b) {
    return a.overall_score - b.overall_score;
  }

  calcStart(currentPage) {
    let { pagingAmount } = this.state;
    return currentPage * pagingAmount - pagingAmount;
  }
  
  calcEnd(currentPage) {
    let { pagingAmount } = this.state;
    return currentPage * pagingAmount;
  }
  
  calcLastPage() {
    let { sitters, pagingAmount } = this.state;
    return parseFloat(sitters.length) / pagingAmount
  }

  createPageSitters(sitters, currentPage) {
    return sitters.slice(this.calcStart(currentPage), this.calcEnd(currentPage))
  }

  paginateSitters(nextPage) {
    this.setState({
      paginatedSitters: this.createPageSitters(this.state.sitters, nextPage),
      currentPage: nextPage
    })
  }

  render() {
    return (
      <div className="section">
        <SitterListSearch onChange={this.filterReviews.bind(this)}/>
        <SitterList
          sitters={this.state.paginatedSitters}
        />
        <SitterListPagination 
          onChange={this.paginateSitters.bind(this)}
          currentPage={this.state.currentPage}
          lastPage={this.calcLastPage()}
          />
      </div>
    );
  }
}

export default SitterListPage;
