![Logo of the project](https://i.imgur.com/KV79Of9.png)

# Music Emporium
> An customizable eCommerce app

This app lets users add items to a cart and checkout. There is also admin functionality complete with a suite to add items, view metrics, and view orders.

## Installing / Getting started

A quick introduction of the minimal setup you need to get this setup:

First, clone the repo

```shell
git clone git@github.com:amhursh/music_shop.git
```

Next, run

```shell
bundle install
```

Note: You may have to run that with `bundle exec`

After you've bundled you will need to create the database and migrations

```shell
rake db:create
rake db:migrate
```

If you would like an example set of data, run
```shell
rake db:seed
```
This seed will create an administrator account with the username `admin` and password `admin`

Finally, launch the server with `rails s`

You can visit the application locally at http://localhost:3000/

## Developing

To develop the project simply clone the repo and follow the installation steps above. The image assets are stored in `/app/assets/images`

### Deploying / Publishing

To deploy this to Heroku, simple create a new Heroku app with
```shell
heroku create
```

And upload the master branch
```shell
git push heroku master
```

After that, migrate and seed if you so wish.

## Features

This application features
* Many to many relationship between categories and items
* Full admin functionality for creating, editing, and destroying accounts, orders, and items
* Administrator metrics

## Contributing

What we would like to implement:
* Rating system
* Paypal integration
* oAuth
* Review system

Please make a PR to this repo with your code. 

Thank you!

## Licensing

One really important part: Give your project a proper license. Here you should
state what the license is and how to find the text version of the license.
Something like:

"The code in this project is licensed under MIT license."
