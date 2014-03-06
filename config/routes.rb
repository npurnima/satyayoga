Satyayoga::Application.routes.draw do

  get 'welcome/index',:as=> 'homepages'
  get 'welcome/continue_page'

  get 'users/signin',:collections => {:method =>'post'}

  resources :emails do
    collection do
      put 'contact_guide'
    end
  end

  resources :practices

  resources :expcomments

  resources :experiences

  resources :schedules

  resources :eventcomments

  resources :usercourses  do
    collection do
      put 'add_attendence'
    end
  end
#  resources :homepages do
 #   collection do
     # get 'admin'
    #  get 'guide'
   #   get 'saadhaka'
  #    get 'mypage'
 #   end
#  end

  resources :photos do
    collection do
      #  get 'slideshow'
    end
  end

  resources :albums

  resources :users do
    collection do
      #  get 'list_of_all_roles'
    end
  end

  resources :events  do
    collection do
      get 'special_events', :as =>'special'
      get 'regular_events', :as =>'regular'
      get 'past_events', :as =>'past'
      get 'upcoming_events', :as =>'upcoming'
    end
  end

  resources :courses

  resources :magazines do

    collection do
      get 'latest_telugu',:as =>'latest_telugu'
      get 'latest_english',:as =>'latest_english'
      get 'latest_telugu_english',:as=>'latest_telugu_english'
   end
 end

  resources :roles

  resources :userroles

  resources :introduction

  match 'uploads/:id' => 'upload#uploadfile'

  match 'courses/:id/read_file' => 'courses#read_file', :as => 'reading_course'

  match 'courses/:id/user_courses' => 'courses#user_courses', :as => 'user_courses'

  match 'magazines/:id/read_file' => 'magazines#read_file', :as => 'reading_magazine'

  match 'magazines/:id/user_magazines' => 'magazines#user_magazines', :as => 'user_magazines'

  match 'albums/:id/user_albums' => 'albums#user_albums', :as => 'user_albums'

  match 'photos/:id/new' => 'photos#new', :as => 'album_new_photos'

  match 'photos/:id/multiple_photos' => 'photos#multiple_photos', :as => 'album_new_multiple_photos'

  match 'photos/:id/album_photos' => 'photos#album_photos', :as => 'all_album_photos'

  match 'photos/:id/slideshow' => 'photos#slideshow', :as => 'slideshow'

  match 'photos/:id/:photo_id/photos_show' => 'photos#photos_show', :as => 'photos_show'

  match 'photos/:id/create_multiple' => 'photos#cretate_multiple', :as => 'create_multiple_photos', :collections => { :method => 'post'}

  match '/rule1' =>'homepages#rule1', :as => 'rule1'
  match '/rule2' =>'homepages#rule2', :as => 'rule2'
  match '/rule3' =>'homepages#rule3', :as => 'rule3'
  match '/faq' =>'homepages#faq', :as => 'faq'

  match 'homepages/:id/mypage'=> 'homepages#mypage',:as=> 'mypage'

  match 'introduction/:id/user_files' => 'introduction#user_files', :as => 'user_files'

  match 'introduction/:id/read_file' => 'introduction#read_file', :as => 'reading_file'

  match 'users/:id/signin' => 'users#signin', :as => 'user_signin',
        :collections => {:method =>'post'}

  match 'users/:id/signout' => 'users#signout', :as => 'user_signout'

  match 'users/:id/forgot_password'=> 'users#forgot_password', :as => 'user_forgot_password',
        :collections=>{:method=>'post'}

  match 'users/:id/change_password'=> 'users#change_password', :as => 'user_change_password',
        :collections=>{:method=>'post'}

  match  'events/:id/user_events' =>'events#user_events', :as => 'user_events'

  match 'userroles/:id/new' => 'userroles#new', :as => 'new_userrole'

  match  'userroles/:id/edit' => 'userroles#edit', :as => 'edit_userrole'

  match  'userroles/:id/show' => 'userroles#show', :as => 'show_userrole'

  match 'userroles/:id/saadhakas_by_guide' => 'userroles#saadhakas_by_guide', :as=>'saadhakas_by_guide'

  match 'magazines/:id/telugu_archives' => 'magazines#telugu_archives', :as =>'telugu_archives'

  match 'magazines/:id/english_archives' => 'magazines#english_archives', :as =>'english_archives'

  match 'users/:role_id/list_of_all_roles' => 'users#list_of_all_roles', :as =>'list_of_all_roles'

  match 'usercourses/:id/new' => 'usercourses#new', :as => 'new_usercourse'

  match 'usercourses/:id/saadhakas_by_course'=>'usercourses#saadhakas_by_course', :as =>'saadhakas_by_course'

  match 'usercourses/:id/courses_by_saadhaka'=>'usercourses#courses_by_saadhaka', :as =>'courses_by_saadhaka'

  match 'usercourses/:id/assign_a_course' => 'usercourses#assign_a_course', :as=>'assign_a_course_to_saadhaka',:collections => {:method =>'post'}

  match 'usercourses/:id/assign_a_practice'=> 'usercourses#assign_a_practice',:as=>'assign_a_practice'

  match 'usercourses/:id/change_status' => 'usercourses#change_status', :as=>'change_status'

  match 'eventcomments/:id/new' => 'eventcomments#new', :as => 'new_event_comment'

  match 'eventcomments/:id/event_comments' => 'eventcomments#event_comments', :as => 'event_comments'

  match 'eventcomments/:id/user_eventcomments' => 'eventcomments#user_eventcomments', :as => 'user_eventcomments'

  match 'expcomments/:id/index' => 'expcomments#index', :as => 'expcomments'

  match 'expcomments/:id/new' => 'expcomments#new', :as => 'new_expcomment'

  match 'expcomments/:id/exp_user_comments' => 'expcomments#exp_user_comments', :as=> 'exp_user_comment'

  match 'schedules/:id/:date/new'=> 'schedules#new',:as=>'new_schedule'

  match  'schedules/:id/index' => 'schedules#index', :as=>'schedules'

  match 'schedules/:id/multiple_schedules' => 'schedules#multiple_schedules', :as => 'event_new_multiple_schedules'

  match 'schedules/:id/edit' => 'schedules#edit', :as => 'edit_schedule'

  match 'practices/:id/user_practices'=> 'practices#user_practices', :as=>'user_practices'

  match 'emails/:id/contact_guide' => 'emails#contact_guide', :as => 'contact_guide' , :collections => { :method => 'post'}

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  root :to => 'welcome#index'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
