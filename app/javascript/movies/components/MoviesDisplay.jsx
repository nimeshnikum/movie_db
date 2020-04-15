import React from 'react';
import { Link } from 'react-router-dom';
import queryString from 'query-string';
import axios from 'axios';

class MoviesDisplay extends React.Component {
  constructor () {
    super();
    this.state = {
      movie: {}
    };
  }

  fetchMovie (id) {
    axios.get( `api/movies/${id}` )
        .then(response => {
          this.setState({ movie: response.data });
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
    this.setMovieIdFromQueryString(this.props.location.search);
    this.fetchMovie(this.movieID);
  }

  // componentWillReceiveProps (nextProps) {
  //   this.setMovieIdFromQueryString(nextProps.location.search);
  //   this.fetchMovie(this.movieID);
  // }

  render () {

    return (
      <div>
        <Link to={`/?movie=${nextMovieId}`}>Next</Link>
        <p>{this.state.movie.title}</p>
        <p>{this.state.movie.text}</p>
      </div>
    );
  }
}

export default MoviesDisplay;
