import React from 'react'
import { Switch, Route } from 'react-router-dom'
import SitterListPage from '../SitterList/SitterListPage'
import UserProfilePage from '../UserProfile/UserProfilePage'
import Home from '../Home'

const Main = () => (
  <main>
    <Switch>
      <Route exact path='/' component={Home}/>
      <Route path='/sitters' component={SitterListPage}/>
      <Route path='/user_profiles/:id' component={UserProfilePage}/>
    </Switch>
  </main>
)

export default Main
