import React from 'react';
import { Link } from 'react-router-dom';
import queryString from 'query-string';
import axios from 'axios';

class MoviesList extends React.Component {
  constructor () {
    super();
    this.state = {
      movies: []
    };
  }

  fetchMovies() {
    axios.get( `api/movies` )
        .then(response => {
          this.setState({ movies: response.data });
        })
        .catch(error => {
          console.error(error);
        });
  }

  setMovieIdFromQueryString (qs) {
    this.qsParams = queryString.parse(qs);
    if (this.qsParams.quote) {
      // assign movie ID from the URL's query string
      this.movieID = Number(this.qsParams.movie);
    } else {
      this.movieID = 1;
      this.props.history.push(`/?movie=${this.movieID}`);
    }
  }

  componentDidMount () {
    this.fetchMovies();
  }

  // componentWillReceiveProps (nextProps) {
  //   this.setMovieIdFromQueryString(nextProps.location.search);
  //   this.fetchMovie(this.movieID);
  // }

  render () {
    let moviesList = this.state.movies.map((movie, index) => (
      <li key={index} className='list-group-item'>
        {movie.title}
      </li>
    ));

    return (
      <div>
        <ul>
          {moviesList}
        </ul>
      </div>
    );
  }
}

export default MoviesList;
