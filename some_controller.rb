class SomeController
  def show
  end

  _GetAndPost
  def edit
    if request.post?
      # update item
    else
      # display item
    end
  end

  _PostOnly
  def delete
    # Destroy the item
  end

end
