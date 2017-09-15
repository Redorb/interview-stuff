
import React from 'react';
import Rating from 'react-rating'

const UserBooking = props => {
  return (
    <div className="section">
      <p className="is-size-4">Leave a Review</p>
      <div className="field">
        <label className="label">Pet Owner ID</label>
        <div className="control">
          <input className="input" type="text" />
        </div>
      </div>
      
      <div className="field">
        <label className="label">Rating</label>
        <div className="control">
          <Rating
            empty="fa fa-star-o is-size-4"
            full="fa fa-star is-size-4"
            initialRate={0}
            fractions={2} />
        </div>
      </div>
      
      <div className="field">
        <label className="label">Review</label>
        <div className="control">
          <textarea className="textarea" placeholder="Textarea"></textarea>
        </div>
      </div>
      
      <div className="field is-grouped">
        <div className="control">
          <button className="button is-primary">Submit</button>
        </div>
        <div className="control">
          <button className="button is-link">Cancel</button>
        </div>
      </div>
    </div>
  );
};

export default UserBooking;