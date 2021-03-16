class BooksController < ApplicationController
  def top
  end
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
       flash[:notice] = "Book was successfully created."
       redirect_to book_path(@book.id)
    else
       @books = Book.all
       render :index
    end
  end
  def edit
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
   else
      render :edit
   end
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find_by(id: @book.user_id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end