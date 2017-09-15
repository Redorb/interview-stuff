
import React from 'react';

const UserProfile = props => {
  return (
    <div>
      <div className="section profile-heading">
        <div className="columns">
          <div className="column is-2">
            <div className="image is-128x128 avatar">
              <img src={props.user.avatar_url} alt="avatar" />
            </div>
          </div>
          <div className="column is-4 name">
            <p>
              <span className="title is-bold">{props.user.first_name} {props.user.last_name}</span>
            </p>
            <p className="tagline is-marginless">{props.user.email}</p>
            <p className="tagline">{props.user.phone_number}</p>
          </div>
          <div className="column is-2 sittings has-text-centered">
            <p className="stat-val">{props.user.sittings.length}</p>
            <p className="stat-key">Sittings</p>
          </div>
          <div className="column is-2 bookings has-text-centered">
            <p className="stat-val">{props.user.bookings.length}</p>
            <p className="stat-key">Bookings</p>
          </div>
          <div className="column is-2 pets has-text-centered">
            <p className="stat-val">{props.user.pets.length}</p>
            <p className="stat-key">Pets</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default UserProfile;