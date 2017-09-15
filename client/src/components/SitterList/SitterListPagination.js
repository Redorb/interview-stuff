import PropTypes from 'prop-types'
import React, { Component } from 'react'

class SitterListPagination extends Component {
  static propTypes = {
    currentPage: PropTypes.number
  };

  isFirstPage() {
    return this.state.currentPage === 1
  }

  isLastPage() {
    return this.state.currentPage === this.props.lastPage
  }

  prevPage() {
    if (!this.isFirstPage()) {
      let newState = {
        currentPage: this.state.currentPage - 1
      }
      this.setState(newState)
      this.props.onChange(newState.currentPage)
    }
  }

  nextPage() {
    if (!this.isLastPage()) {
      let newState = {
        currentPage: this.state.currentPage + 1
      }
      this.setState(newState)
      this.props.onChange(newState.currentPage)
    }
  }

  constructor(props) {
    super(props);
    this.state = { 
      currentPage: 1
     };
  }

  render() {
    return (
      <nav className="pagination" aria-label="pagination">
        <a className="pagination-previous" 
           disabled={this.isFirstPage()}
           onClick={this.prevPage.bind(this)}>Previous</a>
        <a className="pagination-next"
           disabled={this.isLastPage()}
           onClick={this.nextPage.bind(this)}>Next</a>
      </nav>
    );
  }
}

export default SitterListPagination;
