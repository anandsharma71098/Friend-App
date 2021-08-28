class FriendsController < ApplicationController
    def index
        @friends=Friend.all
    end

    def new
        @friend=Friend.new
    end

    def show
        @friend=Friend.find(params[:id])
    end

    def create
        @friend=Friend.new(friend_params)

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

    def destroy
        @friend=Friend.find(params[:id])
        @friend.destroy
        redirect_to friends_path
    end

    def friend_params
        params.require(:friend).permit(:first_name,:last_name,:email,:phone,:twitter)
    end


end