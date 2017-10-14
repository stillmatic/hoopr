CURRENT_YEAR <- 2017

nba_stats_call <- function(endpoint, ...) {
  links <- nba_api_data()
  stopifnot(endpoint %in% names(links))
}

nba_api_data <- function() {
  # TODO: cache this call
  link_data <- jsonlite::fromJSON("http://data.nba.net/10s/prod/v1/today.json")
  current_year <- link_data$seasonScheduleYear
  links <- link_data$links
  return(links)
}

teams_from_year <- function(year = CURRENT_YEAR) {
  teams_url <- sprintf("http://data.nba.net/10s/prod/v1/%s/teams.json", year)
  teams_df <- jsonlite::fromJSON(teams_url)$league$standard
}


players_from_year <- function(year = CURRENT_YEAR) {
  players_url <- sprintf("http://data.nba.net/10s/prod/v1/%s/players.json", year)
  players_df <- jsonlite::fromJSON(players_url)$league$standard
  return(players_df)
}

current_calendar <- function() {
    # i think this is the number of games per day?
    cal_data <- jsonlite::fromJSON("http://data.nba.net/10s/prod/v1/calendar.json")
    cal_data <- cal_data[-c(1:4)]
    dates <- names(cal_data)
    games <- unlist(cal_data)
    return(data.frame(date = dates, games = games, row.names = NULL))
}
