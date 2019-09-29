# CryptoPunks API

## Description

CryptoPunksAPI is a webservice app that provides API endpoints to show information from the CryptoPunks marketplace. CryptoPunks marketplace is a marketplace for buying and selling digital characters built on top of Ethereum using the concept of Non-Fungible Tokens.
The app is built in Ruby on Rails and uses Postgres database to store information related to the CryptoPunks. It uses the ethereum.rb library meant to interact with ethereum blockchain from ruby. Using this library the information related to the sales of CryptoPunks is fetched from the smart contract deployed on the Ethereum Mainnet.

The app consists of an import script which can be executed on demand to fetch the latest sales listings from the Ethereum blockchain. The import script can be executed as a background job or a scheduler as well. However, subscribing to events in the smart contracts will be a good solution to remove the delay and it needs to be implemented next.

## Demo

A demo of the app can be found hosted on Heroku: https://cryptopunks-api.herokuapp.com

#### CryptoPunks Sales Listings:
URL: <https://cryptopunks-api.herokuapp.com/api/v1/punks/listings>

This end point returns all cryptopunks which are listed for sale.

#### CryptoPunk Information:
Example URL: <https://cryptopunks-api.herokuapp.com/api/v1/punks/2969>

This end point returns the for-sale price and information about the cryptopunk with numeric identifier 2969.


## Dependencies:
The project uses **Ruby 2.5.3**, **Rails 5.2.3** and **Postgres 11.4**.

## Instructions:

- Run bundle install: ```bundle install```
- Create database: ```rails db:create```
- Run database migrations: ```rails db:migrate```
- Import information of cryptopunks from mappings: ```bundle exec rake imports:import_punks```
- Import sales listings of cryptopunks from Ethereum Mainnet: ```bundle exec rake imports:import_punk_listings```
- Logs are written for the sales listings import to: ```log/punks_listings.log```
- Run rails server: ```rails s```
- Access the web application at localhost:3000

## API Details:

### CryptoPunks Sales Listings:
This end point returns all cryptopunks which are listed for sale.

#### GET /api/v1/punks/listings

### CryptoPunk Information:
This end point returns the for-sale price and information about a single punk, from its numeric identifier.

#### GET /api/v1/punks/:punk-identifier

