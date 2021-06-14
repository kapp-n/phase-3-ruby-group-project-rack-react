This is the Rack backend for my Bookshelf app. 
The React frontend can be found here: https://github.com/kapp-n/bookshelf

This app will allow a user to build a personal library full of their favorite books, organized by genre. To do this, I built two models with Active Record: books and shelves, where a Shelf has many books, and Book belongs to a Shelf. The frontend can make GET, POST, and DELETE requests that are fufilled through this backend.
