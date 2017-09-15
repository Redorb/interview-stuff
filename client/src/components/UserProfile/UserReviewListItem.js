import PropTypes from 'prop-types'
import React, { Component } from 'react'
import agent from '../../libs/agent'
import Rating from 'react-rating'

class UserReviewListItem extends Component {
  static propTypes = {
    review: PropTypes.object,
    pet_owner: PropTypes.object,
  };

  componentDidMount() {
    this.loadUserProfile(this.props.review.pet_owner_id)
  }

  loadUserProfile(id) {
    agent.PetOwners
    .get(id)
    .then(pet_owner => {
      this.setState({ 
        pet_owner: pet_owner
      })
    });
  }

  constructor(props) {
    super(props);
    this.state = { 
      pet_owner: {}
    };
  }

  render() {
    return (
      <div className="card">
        <div className="card-content">
          <div className="media">
            <div className="media-left">
              <figure className="image is-48x48 avatar">
                <img src={this.state.pet_owner.avatar_url} alt="avatar" />
              </figure>
            </div>
            <div className="media-content">
              <p className="title is-4">{this.state.pet_owner.first_name} {this.state.pet_owner.last_name}</p>
              <p className="subtitle is-6">
                <Rating
                  empty="fa fa-star-o is-size-4"
                  full="fa fa-star is-size-4"
                  initialRate={parseFloat(this.props.review.rating)}
                  readonly/>
              </p>
              <p className="subtitle is-6">{this.props.review.text}</p>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default UserReviewListItem;