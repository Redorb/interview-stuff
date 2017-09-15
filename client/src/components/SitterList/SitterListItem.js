import React from 'react'
import Rating from 'react-rating'

const SitterListItem = props => {
  const sitter = props.sitter;
  return (
    <div className="card">
      <div className="card-content">
        <div className="media">
          <div className="media-left">
            <figure className="avatar image is-48x48">
              <img src={sitter.avatar_url} alt="avatar" />
            </figure>
          </div>
          <div className="media-content">
            <p className="title is-4 is-marginless">{sitter.first_name} {sitter.last_name}</p>
            <p className="subtitle is-6 is-marginless">{sitter.email}</p>
            <p className="subtitle is-6">{sitter.phone_number}</p>
            <p className="subtitle is-6">
              <Rating
                empty="fa fa-star-o is-size-4"
                full="fa fa-star is-size-4"
                initialRate={parseFloat(sitter.overall_score)}
                readonly/>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SitterListItem;