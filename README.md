# N+1 Errors game

Welcome to N+1 Errors game! A developer was tasked to create a Rails API from scratch that would list upcoming movie releases on Brazil. After some time, the team realized that the codebase might need a bit of a refactoring, and you were given this amazing opportunity to help foster the growth of an aspiring developer! We ask the following things from you:

- Analyze the code from the repository (available on /nextflix) and check for possible problems/improvement oportunities;
- Open one or more PRs with your suggestions:
  - You can refactor the code (explaining the reasons why you changed the code on commit messages) or write a markdown document with your ideias, it's up to you.
- You can also add new functionalities if you'd like!

# Proposed application - NextFlix

list upcoming movie releases on Brazil.

- API written in Rails;
- All endpoints should return JSON unless specified.

## Endpoints:

### GET /movies
List all movies on a reverse chronological order.

Data from the movie that should be shown:
- title
- release_date
- genre
- runtime
- parental_rating
- plot
- user ratings (from 1 to 5)

### GET /movies/:id
Show information about a particular movie

### GET /movies/search?title=
Search movies given a title

### POST /movies
Add a new movie

### DELETE /movies/:id
Remove a movie

### POST /ratings/:movie_id
Rate a movie.

WARNING: This is a fictional piece of work. No real codebases were harmed on the production of this test.
