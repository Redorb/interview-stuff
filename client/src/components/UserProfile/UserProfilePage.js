import PropTypes from 'prop-types'
import React, { Component } from 'react'
import agent from '../../libs/agent'
import UserProfile from './UserProfile'
import UserBooking from './UserBooking'
import UserReviewList from './UserReviewList'

class UserProfilePage extends Component {
  static propTypes = {
    user: PropTypes.object,
  }

  componentDidUpdate(prevProps, prevState) {
    if (prevProps.match.params.id !==
        this.props.match.params.id) {
      this.loadUserProfile(this.props.match.params.id);
    }
  }

  componentDidMount() {
    this.loadUserProfile(this.props.match.params.id);
  }

  loadUserProfile(id) {
    agent.UserProfiles
    .get(parseInt(id, 10))
    .then(user => {
      this.setState({ 
        user: user
      })
    });
  }

  constructor(props) {
    super(props);
    this.state = { 
      user: {
        sittings: [],
        bookings: [],
        pets: []
      }
    };
  }

  render() {
    return (
      <div className="section">
        <UserProfile 
          user={this.state.user} />
        
        <UserReviewList 
          reviews={this.state.user.sittings}
          currentRating={this.state.user.rating}/>
        <UserBooking />
      </div>
    );
  }
}

export default UserProfilePage;
