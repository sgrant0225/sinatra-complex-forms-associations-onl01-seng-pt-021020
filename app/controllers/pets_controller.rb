class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
     if params[:new_owner] != ""
      @owner = Owner.create(name: params[:new_owner])
    else
      @owner = Owner.find(params[:owners][:id])
    end
    if params[:pet][:name] != ""
      @pet = Pet.create(name: params[:pet][:name])
      @owner.pets << @pet
      @owner.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all 
    erb :'/pets/edit'
  end
  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  patch '/pets/:id' do 
   if !params[:pet].keys.include?("owner_id")
  params[:pet]["owner_id"] = []
  end
  #######
  @pet = Pet.find(params[:id])
  @pet.update(params["pet"])
  if !params["owner"]["name"].empty?
    @pet.owner = Owner.create(name: params["owner"]["name"])
  end
  @pet.save
  redirect "/pets/#{@pet.id}"
  end
end 
    