#!/bin/bash
mkdir api && touch api/server.js
yarn init -y
echo "Do you want to install Express framework? (y/N):"
read installexpress
echo "Do you want to enable logging? (y/N):"
read installmorgan
echo "Do you want to add a database? (y/N):"
read installknex
echo "Do you want to use environment variables? (y/N):"
read installenv
echo "Will you be deploying API to Netlify? (y/N):"
read installnetlify

if [ "$installexpress" = 'y' ]; then
  echo "Installing Express, Helmet, and Cors modules"
  yarn add express helmet cors && yarn add nodemon --dev
else
  echo "Would you prefer to install Koa instead? (y/N):"
  read installkoa
  yarn add koa koa-helmet @koa/cors@2 && yarn add nodemon --dev
fi

if [ "$installmorgan" = 'y' ]; then
  echo "Installing Morgan logging module"
  yarn add morgan
fi

if [ "$installknex" = 'y' ]; then
  echo "Which database will you use (sqlite3/pg/both): "
  read databasetype

  if [ "$databasetype" = 'both']; then
    echo "Installing knex and database connector $databasetype"
    yarn add knex sqlite3 pg
  else
    yarn add knex $databasetype
  fi

  echo "Creating default data directory and configuration file"
  mkdir data && touch data/dbConfig.js &&
  mkdir data/models && touch data/models/index.js &&
  yarn knex init
fi

if [ "$installenv" = 'y' ]; then
  echo "Setting up project to use environment variables"
  yarn add dotenv && touch .env
fi

if [ "$installnetlify" = 'y' ]; then
  echo "Installing Netlify Lambda tools"
  yarn add serverless-http && yarn add netlify-lambda --dev &&
  touch netlify.toml
else
  echo
  touch index.js
  echo "Node project setup complete"
fi