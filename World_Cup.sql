psql --username=freecodecamp --dbname=postgres
CREATE DATABASE worldcup;
\c worldcup
CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    round VARCHAR(50) NOT NULL,
    winner_id INT NOT NULL REFERENCES teams(team_id),
    opponent_id INT NOT NULL REFERENCES teams(team_id),
    winner_goals INT NOT NULL,
    opponent_goals INT NOT NULL
);
chmod +x insert_data.sh
#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

# Clear existing data
$($PSQL "TRUNCATE TABLE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # Insert winner team
    $($PSQL "INSERT INTO teams(name) VALUES('$WINNER') ON CONFLICT(name) DO NOTHING")
    # Insert opponent team
    $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT') ON CONFLICT(name) DO NOTHING")
    
    # Get team ids
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    
    # Insert game
    $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
             VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")
  fi
done
chmod +x queries.sh
#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

# 1) Total goals from all winning teams
echo $($PSQL "SELECT SUM(winner_goals) FROM games;")

# 2) Total goals from all games (winning + opponent)
echo $($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games;")

# 3) Average goals of winning teams
echo $($PSQL "SELECT AVG(winner_goals) FROM games;")

# 4) Maximum goals scored by a single team in a game
echo $($PSQL "SELECT MAX(GREATEST(winner_goals, opponent_goals)) FROM games;")

# 5) Count of games where winner scored more than 2 goals
echo $($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2;")

# Continue for remaining queries in single-line format as required
