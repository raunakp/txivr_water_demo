class ReadingsController < ApplicationController


  # HEAD /create_meter_reading
  # GET /create_meter_reading
  def create_meter_reading
    userid = Integer(request.env["HTTP_TX_USER_ID"])
    meterreading = request.env["HTTP_TX_METER_READING"]
    @reading = Reading.create(:user_id => userid, :meter_reading => meterreading)
    respond_to do |format|
      format.json do
        if @reading.save
          response.headers["TX_UPDATE_STATUS"] = "ok"
          response.headers["TX_UPDATE_STATUS_CODE"] = "200"
        else
          response.headers["TX_UPDATE_STATUS"] = "could not create reading entry"
          response.headers["TX_UPDATE_STATUS_CODE"] = "400"
        end
        render json: @reading
      end
    end
  end

  # GET /readings
  # GET /readings.json
  def index
    @readings = Reading.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @readings }
    end
  end

  # GET /readings/1
  # GET /readings/1.json
  def show
    @reading = Reading.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reading }
    end
  end

  # GET /readings/new
  # GET /readings/new.json
  def new
    @reading = Reading.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reading }
    end
  end

  # GET /readings/1/edit
  def edit
    @reading = Reading.find(params[:id])
  end

  # POST /readings
  # POST /readings.json
  def create
    if (params[:readingvalue] && params[:userid])
      @reading = Reading.create(:user_id => params[:userid], :meter_reading => params[:readingvalue])
      respond_to do |format|
        if @reading.save
          format.json do
            response.headers["tx_status"] = "ok"
            response.headers["tx_reading_id"] = @reading[:id].to_s
            response.headers["tx_dummy_header"] = request.env["HTTP_DUMMY_HEADER"]<<"_hahaha"
            #response.headers["tx_dummy_header"] = request.env["HTTP_DUMMY_HEADER"]

             # for header in request.env.select {|k,v| k.match("^HTTP.*")}
             #   response.headers["#{header[0].split('_',2)[1]}"] = "#{header[1]}"
             # end

            render json: @reading
          end
        else
          format.json do
            response.headers["tx_status"] = "error"
          end
        end
      end
    else
      @reading = Reading.new(params[:reading])

      respond_to do |format|
        if @reading.save
          format.html { redirect_to @reading, notice: 'Reading was successfully created.' }
          format.json { render json: @reading, status: :created, location: @reading }
        else
          format.html { render action: "new" }
          format.json { render json: @reading.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /readings/1
  # PUT /readings/1.json
  def update
    @reading = Reading.find(params[:id])

    respond_to do |format|
      if @reading.update_attributes(params[:reading])
        format.html { redirect_to @reading, notice: 'Reading was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /readings/1
  # DELETE /readings/1.json
  def destroy
    @reading = Reading.find(params[:id])
    @reading.destroy

    respond_to do |format|
      format.html { redirect_to readings_url }
      format.json { head :no_content }
    end
  end
end
