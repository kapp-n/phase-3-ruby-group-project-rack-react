class Application
require 'pry'

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]

    elsif req.path.match(/shelves/)
      if req.env['REQUEST_METHOD']=="POST"
        input = JSON.parse(req.body.read)
       
        if input.include?("author")
          shelf = Shelf.find_by(id: input["shelf_id"])
          book = shelf.books.create(name: input["name"], author: input["author"], summary: input["summary"], pages: input["pages"], image: input["image"])
          shelves = Shelf.all
          return [200, {'Content-Type' => 'application/json'}, [shelves.to_json({:include => :books}) ]]
        else
          shelf = Shelf.create(genre: input["genre"])
          return [200, {'Content-Type' => 'application/json'}, [ shelf.to_json({:include => :books}) ]]
        end

      elsif req.env['REQUEST_METHOD']=="DELETE"
        input = JSON.parse(req.body.read)
        shelf = Shelf.find_by(id: input)
        shelf.destroy
        return [200, {'Content-Type' => 'application/json'}, [ {:message => "deleted"}.to_json ] ]
      end

    shelves = Shelf.all
    return [200, {'Content-Type' => 'application/json'}, [ shelves.to_json({:include => :books}) ] ]
  

    elsif req.path.match(/book/)

      if req.env['REQUEST_METHOD']=="DELETE"
      
        input = JSON.parse(req.body.read)
        book = Book.find_by(id: input)
        book.destroy
      else
        books = Book.all
        book_id = req.path.split("/book/").last
        return [200, { 'Content-Type' => 'application/json' }, [ books.find_by(id: book_id).to_json ]]
      end

    else
      resp.write "Path Not Found"
      binding.pry

    end

    resp.finish
  end

end
