import React from 'react'

const UserReviewListEmptyItem = props => {
  return (
    <div className="card">
      <div className="card-content">
        <div className="media">
          <div className="media-content has-text-centered">
            <p className="title is-12">This sitter currently has no reviews.</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default UserReviewListEmptyItem;