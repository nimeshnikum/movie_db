import React from 'react'
import {
  BrowserRouter as Router,
  Route
} from 'react-router-dom'
import MoviesList from './MoviesList'

const App = (props) => (
  <Router>
	<div>
	  <Route
	    path='/'
	    component={MoviesList}
	  />
	</div>
  </Router>
)

export default App
