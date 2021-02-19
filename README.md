# Rails Engine - An E-Commerce API

  <h3 align="center">Rails Engine</h3>

  <p align="left">
    Rails Engine is an API developed for an E-Commerce Application. The fictitious company utilizes a service-oriented architecture, and therefore utilizes this API as a separate back-end service. This repo exposes the data that powers the company's site through a RESTful JSON API in addition to custom endpoints for Business Intelligence Analytics.
    <br />
    <a href="https://github.com/cowens87/rails-engine/issues">Report Bug</a>
    ·
    <a href="https://github.com/cowens87/rails-engine/issues">Request Feature</a>
  </p>
</p>


<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
  * [Schema](#schema)
* [Usage](#usage)
  * [Endpoints](#endpoints)
    * [Index of Resource](#index-of-resource)
    * [Show Record](#show-record)
    * [Create Record](#create-record)
    * [Update Record](#update-record)
    * [Destroy Record](#destroy-record)
    * [Merchant Items Relationship](#merchant-items-relationship)
    * [Item Merchant Relationship](#item-merchant-relationship)
    * [Find One Resource By Attribute](#find-one-resource-by-attribute)
    * [Find Many Resources By Attribute](#find-many-resources-by-attribute)
    * [Merchants with Most Revenue](#merchants-with-most-revenue)
    * [Merchants with Most Items Sold](#merchants-with-most-items-sold)
    * [Potential Revenue For Unshipped Orders](#potential-revenue-for-unshipped-orders)
    * [Revenue for a Merchant](#revenue-for-a-merchant)


<!-- ABOUT THE PROJECT -->
## About The Project

Rails Engine exposes business data based on the [JSON API Specification](https://jsonapi.org) via multiple API endpoints allowing other developers access to CRUD functionality for Merchants and Items, obtaining relationship information for Merchants and Items, and exposes more complex endpoints including: merchants with the most revenue, merchants with the most items sold, revenue across a date range, and revenue for a specific merchant.


<!-- GETTING STARTED -->
## Getting Started

To use Rails Engine locally, you can fork or clone [this](https://github.com/helloeduardo/rails-engine) repo.

### Prerequisites
* [Ruby 2.5.3](https://github.com/ruby/ruby)
* [Rails 5.2.4.4](https://github.com/rails/rails)

### Installation
Below are the commands you will need to run in your terminal once you are inside the rails-engine directory.

* Bundle Install
```
$ bundle exec install
```
* Set up Database
```
$ rails db:create
$ rails db:migrate
$ rails db:seed
```
### Schema

After running your migrations, your schema will look something like this!
<br />
<p align="center">
    <img src="https://user-images.githubusercontent.com/67389821/108520457-8c963780-727f-11eb-98e7-074b489438a0.png">
</p>

Run ```rails s``` in your terminal and utilize ```http://localhost:3000/``` as the base url in your API client of choice (Postman, etc.)

### Endpoints

#### Index of Resource

This endpoint renders a JSON representation of all records of the requested resource.

`GET /api/v1/<resource>` where `<resource>` is `merchants` or `items`


#### Show Record

This endpoint renders a JSON representation of the corresponding record.

`GET /api/v1/<resource>/:id` where `<resource>` is `merchants` or `items`

#### Create Record

This endpoint creates a record and renders a JSON representation of the new record.

`POST /api/v1/<resource>` where `<resource>` is `merchants` or `items`

#### Update Record

This endpoint updates the corresponding record and renders a JSON representation of the updated record.

`PATCH /api/v1/<resource>/:id` where `<resource>` is `merchants` or `items`

#### Destroy Record

This endpoint destroys the corresponding record and any associated data.

`DELETE /api/v1/<resource>/:id` where `<resource>` is `merchants` or `items`

The response returns a 204 HTTP status code.

#### Merchant Items Relationship
`GET /api/v1/merchants/:id/items` - returns all items associated with a merchant.

#### Item Merchant Relationship
`GET /api/v1/items/:id/merchants` - returns the merchant associated with an item

#### Find One Resource By Attribute
This endpoint returns a single record that matches a set of criteria. Criteria will be input through query parameters.

`GET /api/v1/<resource>/find?<attribute>=<value>`

#### Find Many Resources By Attribute
This endpoint returns all records that match a set of criteria. Criteria will be input through query parameters.

`GET /api/v1/<resource>/find_all?<attribute>=<value>`

#### Merchants with Most Revenue

This endpoint returns a variable number of merchants ranked by total revenue.

`GET /api/v1/merchants/most_revenue?quantity=x` where x is the number of merchants to be returned.

#### Merchants with Most Items Sold

This endpoint returns a variable number of merchants ranked by total number of items sold:

`GET /api/v1/merchants/most_items?quantity=x` where x is the number of merchants to be returned.

#### Potential Revenue for Unshipped Orders

This endpoint should return the potential revenue across all merchants who have unshipped orders.

`GET /api/v1/revenue/unshipped`

#### Revenue for a Merchant

This endpoint should return the total revenue for a single merchant.

`GET /api/v1/merchants/:id/revenue`

