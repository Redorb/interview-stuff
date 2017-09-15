import React from 'react'

const SitterListEmptyItem = props => {
  return (
    <div className="card">
      <div className="card-content">
        <div className="media">
          <div className="media-content has-text-centered">
            <p className="title is-12">No Sitters With Current Rating</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SitterListEmptyItem;