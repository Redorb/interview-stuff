
import SitterListItem from './SitterListItem'
import SitterListEmptyItem from './SitterListEmptyItem'
import { Link } from 'react-router-dom'
import React from 'react'

const SitterList = props => {
  let isNotEmpty = props.sitters.length
  return (
    <div>
      {isNotEmpty ?
        props.sitters.map(sitter => {
          return (
            <Link to={`/user_profiles/${sitter.id}`} key={sitter.id}>
              <SitterListItem
                sitter={sitter} />
            </Link>
          );
        }) :
        <SitterListEmptyItem />
      }
    </div>
  );
};

export default SitterList;