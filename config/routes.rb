Blogit::Engine.routes.draw do

  # Keep these above the posts resources block
  get "posts/page/:page" => "posts#index"
  get "posts/tagged/:tag" => 'posts#tagged', as: :tagged_blog_posts
  get "categories/:category(/page/:page)" => 'categories#show', as: :category

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  get "/" => "posts#index", as: :blog_root
end
