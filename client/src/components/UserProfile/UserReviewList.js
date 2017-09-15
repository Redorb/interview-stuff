
import UserReviewListItem from './UserReviewListItem'
import UserReviewListEmptyItem from './UserReviewListEmptyItem'
import { Link } from 'react-router-dom'
import React from 'react'

const UserReviewList = props => {
  let isNotEmpty = props.reviews.length > 0;
  return (
    <div className="section">
      {isNotEmpty ?
        props.reviews.map(review => {
          return (
            <Link to={`/user_profiles/${review.pet_owner_id}`} key={review.pet_owner_id} >
              <UserReviewListItem
                review={review}
                key={review.id} />
            </Link>
          );
        }) :
        <UserReviewListEmptyItem />
      }
    </div>
  );
};

export default UserReviewList;