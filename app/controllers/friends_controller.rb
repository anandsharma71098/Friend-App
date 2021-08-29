class FriendsController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]
    before_action :correct_user, only: [:edit, :update ,:destroy]

    def index
        @friends=Friend.all
    end

    def new
        #@friend=Friend.new
        @friend= current_user.friends.build
    end

    def show
        @friend=Friend.find(params[:id])
    end

    def create
        #@friend=Friend.new(friend_params)
        @friend= current_user.friends.build(friend_params)

        if @friend.save
            flash[:notice]="Friend added successfully!!!"
            #redirect_to article_path(@article)
            #   or   #
            redirect_to friend_path(@friend)
        else
            render 'new'
        end
    end

    def edit
        @friend=Friend.find(params[:id])
    end
    
    def update
        @friend=Friend.find(params[:id])
        if @friend.update(friend_params)
            flash[:notice]="Friend was updated successfully!!!"
            redirect_to friend_path(@friend)
        else
            render 'edit'
        end
    end

    def correct_user
        @friend=current_user.friends.find_by(id: params[:id])
        if @friend.nil?
            flash[:notice]="Not Authorized to the friend"
            redirect_to friends_path
        end
    end

    def destroy
        @friend=Friend.find(params[:id])
        if @friend.destroy
            flash[:notice]="Friend was deleted successfully!!!"
        end
        redirect_to friends_path
    end

    def friend_params
        params.require(:friend).permit(:first_name,:last_name,:email,:phone,:twitter,:user_id)
    end


end