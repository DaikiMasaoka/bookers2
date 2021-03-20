class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :edit]
  def top
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
       @books = Book.all
       render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to  books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.user != current_user
       redirect_to new_user_session_path
    else
      if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to book_path(@book.id)
      else
        render :edit
      end
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def show
   @book_new = Book.new
   @book = Book.find(params[:id])
   @user = User.find_by(id: @book.user_id)
  end

  def destroy
    @books = Book.all
    @book = Book.find(params[:id])
    if @book.user != current_user
       redirect_to new_user_session_path
    else
       @book.destroy
       flash[:notice] = "Book was successfully destroyed."
       redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end