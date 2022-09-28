# DataQuest

This repository contains an exercise for Rovio data engineer candidates. It uses a data set for imaginary game called 'Flock Party'.

## Flock Party!!!

On September 1st 2017 Rovio soft launched a game called 'Flock Party'. Your mission, should you choose to accept it, is to play with the data and complete the trophy challenges listed below.

The data itself is in compressed CSV format split in multiple files. We have two datasets ```data/profiles``` and ```data/activity``` in their distinct folders. Data does not have a header row. The ```profiles``` dataset contains user profiles with following columns:

* player_id (integer) - unique identifier of the player
* registration_date (yyyy-MM-dd) - date when the player 1st played the game
* country code (integer) - country of the user
* operating system (integer) - operating system of the user
* device type (integer) - type of device used by the player

The ```activity``` contains the information on players' daily visits in the game. E.g. if player with ID ```123``` plays the game at least once on ```2018-09-02``` then there is a row with those values in the data set.
Complete schema of ```activity``` dataset contains columns:

* event_date (yyyy-MM-dd) 
* player_id (integer) - unique identifier of the player
* money_spent (float) - Total money spent during the day
* session_count (integer) - Number of game sessions for the day
* purchase_count (integer) - Number of purchases during the day
* time_spent_seconds (integer) - Total time spent playing during the day
* ads_impressions (integer) - Total number of seen ads during the day
* ads_clicks (integer) - Total number of clicked ads during the day

Let's get cracking!!!

## Trophies

| Trophy | Description | Completed |
|--------|-------------|-----------|
| And so it begins | Read both data sets and print out 10 rows from each data set | | 
| It's all about daily users | Find out what is the daily user count on 17th of September 2017 for operating system 1 |  |
| It's all about new users | Find out what is the daily new user count on 20th of October 2017 for country 1 and operating system 2 |  |
| It's all about retention | Find out what is the D7 retention (1) for players that registered on 20th of September 2017 |  |
| It's all important | Build a reporting table where daily user, new user and retention metrics can be easily queried per cohort (2). Then show how to get the answers to the previous questions from this new table. |  |
| Ugh.. CSV files suck | Convert the data to a more optimal data format |  |
| Big Data | Use any dynamically scalable big data framework for any of the tasks |  |
| Sparkling! | Use Spark to for any of the tasks |  |
| Cup of Java | Use Java for any of the tasks |  |
| Big snake | Use Python for any of the tasks |  |
| SQL 4 Ever | Use SQL for any of the tasks |  |
| DB Geek | Store at least one of the resulting data sets to any relational database |  |
| For data science | Find insights from the data through explorative data analysis |  |
| Please don't go | Implement a churn (3) prediction model, and report its accuracy using the metric you think is the most fitting one |  |
| Service guy | Implement a REST API that serves the reporting metrics |  |
| No SQL | Store profile data to any NoSQL database |  |
| Plotter | Visualize some results |  |
| Full stack | Data visualization has a JavaScript front end connecting to a service backend |  |

1) D7 retention is the percentage from total players from the registration date who played the game on the 7th
2) Cohort is a group of players that have the same original registration date, country, and operating system
3) Predict which players are not seen after 7th day from the registration
