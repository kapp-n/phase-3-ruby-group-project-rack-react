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
        shelf = Shelf.create(genre: input["genre"])
        return [200, {'Content-Type' => 'application/json'}, [ shelf.to_json({:include => :books}) ]]
      elsif req.env['REQUEST_METHOD']=="DELETE"
        input = JSON.parse(req.body.read)
        shelf = Shelf.find_by(id: input)
        shelf.destroy
        return [200, {'Content-Type' => 'application/json'}, [ {:message => "deleted"}.to_json ] ]
      end
    shelves = Shelf.all
    return [200, {'Content-Type' => 'application/json'}, [ shelves.to_json({:include => :books}) ] ]
  


    elsif req.path.match(/book/)
        books = Book.all
        book_id = req.path.split("/book/").last
        return [200, { 'Content-Type' => 'application/json' }, [ books.find_by(id: book_id).to_json ]]
    else
      resp.write "Path Not Found"
      binding.pry

    end

    resp.finish
  end

end
