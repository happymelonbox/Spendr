class StoresController < ApplicationController
    before_action :authentication_redirect, :only => [:index, :show]
    before_action :current_user, :only => [:show]
    
    def show
        @user = current_user
        @store = @user.stores.find(params[:id])
    end

    def index
        @user = current_user
        @stores = @user.stores.all
    end

    def new
        @user ||= current_user
        @store = @user.stores.new
    end

    def create
        @user ||= current_user
        @store = @user.stores.new(store_params)
        if @store.save
            redirect_to store_path(@store)
        else
            render :new
        end
    end

    private

    def store_params
        params.require(:store).permit(:name, :unit_or_building, :street_number, :street_name, :suburb, :postcode, :city)
    end


end