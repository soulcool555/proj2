# config/routes.rb
Proj1::Application.routes.draw do
  root :to => "workshops#summary"
  match "workers" => "workers#index"
  match "workshops" => "workshops#index"
  match "workshops/insert" => "workshops#insert"
  match "workshops/display" => "workshops#display"
  match "workers/admin" => "workers#admin"
  match "workshops/department" => "workshops#department"
  match "workshops/success" => "workshops#success"
  match "workers/login" => "workers#login"
  match "workshops/deptsummary" => "workshops#deptsummary"
  match "workshops/select_workshop" => "workshops#select_workshop"
  match "workers/logout" => "workers#logout"
  match "workshops/summary" => "workshops#summary"
  match "workers/create" => "workers#create"
  match "workshops/show_participants" => "workshops#show_participants"
end
