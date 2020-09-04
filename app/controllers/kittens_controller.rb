class KittensController < ApplicationController
    def index
        @kittens = Kitten.all
        respond_to do |format|
            format.html
            format.json { render :json => @kittens }
        end
    end

    def create
        @kitten = Kitten.new(kitten_params)
        if @kitten.save
            flash[:notice] = "You have created a kitten called #{@kitten.name}!"
            redirect_to kitten_path(@kitten.id)
        else
            flash[:notice] = "Please enter valid data (age, cuteness and softness are integers)"
            redirect_to new_kitten_path
        end
    end

    def new
        @kitten = Kitten.new
    end

    def edit
        @kitten = Kitten.find(params[:id])
    end

    def show
        @kitten = Kitten.find(params[:id])
        respond_to do |format|
            format.html
            format.json { render :json => @kitten }
        end
    end

    def update
        @kitten = Kitten.find(params[:id])
        if @kitten.update(kitten_params)
            flash[:notice] = "You have updated #{@kitten.name}'s information!"
            redirect_to kitten_path(params[:id])
        else
            flash[:notice] = "You entered something wrong you numpty"
            redirect_to edit_kitten_path(params[:id])
        end
    end

    def destroy
        @kitten = Kitten.find(params[:id])
        if @kitten.delete
            flash[:notice] = "Wow... I can't believe you just destroyed #{@kitten.name}!"
        else
            flash[:notice] = "Ugh oh! Something went wrong. #{@kitten.name} lives another day!"
        end
        redirect_to kittens_path
    end

    private

    def kitten_params
        params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
