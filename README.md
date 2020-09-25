## Heroku

Make sure you have a working Docker installation (eg. docker ps) and that you’re logged in to Heroku (heroku login) and Log in to Container Registry:

```
heroku container:login

```
Navigate to the app’s directory and create a Heroku app:

```
heroku create

```

Build the image and push to Container Registry:

```
heroku container:push web

```

Then release the image to your app:

```
heroku container:release web

```

Now open the app in your browser:

```
heroku open

```
