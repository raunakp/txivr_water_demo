class UsersController < ApplicationController


  # HEAD /match_account_number
  # GET  /match_account_number

    def match
      acc_number = request.env["HTTP_TX_ACCOUNT_NUMBER"]
      ani = request.env["HTTP_TX_ANI"]
      @user = User.where(:account_number => acc_number).limit(1)[0]
      respond_to do |format|
        format.json do
          if @user.present?
            response.headers["TX_MATCH_STATUS"] = "ok"
            response.headers["TX_MATCH_STATUS_CODE"] = "200"
            response.headers["TX_USER_FNAME"] = @user[:fname]
            response.headers["TX_USER_LNAME"] = @user[:lname]
            response.headers["TX_USER_PHONE_NUMBER"] = @user[:phone_number].to_s
            response.headers["TX_USER_PHONE_NUMBER_LENGTH"] = @user[:phone_number].to_s.length.to_s
            response.headers["TX_USER_ID"] = @user[:id].to_s
            if ani.index(@user[:phone_number])
              response.headers["TX_ANI_MATCHED"] = "yes"
            else
              response.headers["TX_ANI_MATCHED"] = "no"
            end
          else
            response.headers["TX_MATCH_STATUS"] = "not matched"
            response.headers["TX_MATCH_STATUS_CODE"] = "400"
          end
          render json: @user
        end
      end
    end

  # GET /users
  # GET /users.json
  def index
    
    if params[:number]
      @users = User.where(:phone_number => params[:number]).limit(1)
    else
      @users = User.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json do 
        #head(:tx_user => "ron")
        response.headers["tx_fname"] = @users[0][:fname]
        response.headers["tx_lname"] = @users[0][:lname]
        response.headers["tx_acc_number"] = @users[0][:account_number]
        response.headers["tx_address"] = @users[0][:address]
        response.headers["tx_email"] = @users[0][:email]
        response.headers["tx_user_id"] = @users[0][:id].to_s
        render json: @users
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
