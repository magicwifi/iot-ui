require 'rest-client'
require 'json'



class LimoesController < ApplicationController

  def show_mains
deviceid = params[:deviceid]
date = params[:date]

  testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7restart", {"date"=>date,"deviceid"=>deviceid}.to_json, {content_type: :json, accept: :json}
  testjson = JSON.parse(testbody)

  @totalSpendtime =testjson['totalSpendtime'][0]['totalSpendtime']


  devicelist =  testjson['devicelist']
  avglist =  testjson['AvgSpendtimeList']
  @datelist =[]
  @spendtimes = []
  @restarts = []
  @avgSpendtimes = []

@avgSpendtime = 0
@restart = 0
@spendtime = 0


devicelist.each {|x|
@datelist.push(x['date'].to_s);
@spendtimes.push(x['spendtime']);
@restarts.push(x['restartCount']);
if x['date'] == date
@restart = x['restartCount']
@spendtime = x['spendtime']
@avgSpendtime = x['avgSpendtime']

end
}
avglist.each {|x|
@avgSpendtimes.push(x['avgSpendtime']);
if x['date'] == date
@avgSpendtime = x['avgSpendtime']
end
}

sumbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getPeriodExceed", {"date"=>date,"deviceid"=>deviceid}.to_json, {content_type: :json, accept: :json}
sumjson = JSON.parse(sumbody)

period_array = sumjson['timePeriodSum']
@periodlist = []
@sumlist = []
@sumcount = 0

period_array.each {|x|

@periodlist.push(x['timePeriod'])
@sumlist.push(x['sum'])
@sumcount+= x['sum']
}



    render :layout => "application_page"
  end

  def show_temperature
    deviceid = params[:deviceid]
    date = params[:date]
testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0092"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)

@datelist = []
@l92_list_max = []
@l92_list_avg = []

l92_list = testjson['sensorMaxMinlist']

l92_list.each { |x|
 @datelist.push(x['date'])
 @l92_list_max.push(x['max'])
 @l92_list_avg.push(x['avg'])
}

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0080"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)

@l80_list_max = []
@l80_list_avg = []

l80_list = testjson['sensorMaxMinlist']

l80_list.each { |x|
 @l80_list_max.push(x['max'])
 @l80_list_avg.push(x['avg'])
}



testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0075"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)

@l75_list_max = []
@l75_list_avg = []

l75_list = testjson['sensorMaxMinlist']

l75_list.each { |x|
 @l75_list_max.push(x['max'])
 @l75_list_avg.push(x['avg'])
}



    render :layout => "application_page"
  end

  def show_temperature_topvalue

deviceid = params[:deviceid]
date = params[:date]

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0092"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@datelist = []
@l92_list_max = []

l92_list = testjson['sensorMaxMinlist']

l92_list.each { |x|
 @datelist.push(x['date'])
 @l92_list_max.push(x['max'])
}


testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0080"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l80_list_max = []

l80_list = testjson['sensorMaxMinlist']

l80_list.each { |x|
 @l80_list_max.push(x['max'])
}


testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0075"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l75_list_max = []

l75_list = testjson['sensorMaxMinlist']

l75_list.each { |x|
 @l75_list_max.push(x['max'])
}

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7TopValue", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0092"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l92_list_topvalue = []


l92_list = testjson['sensorTopValuelist']

l92_list.each { |x|
 @l92_list_topvalue.push(x['topvalue'])
}


testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7TopValue", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0080"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l80_list_topvalue = []


l80_list = testjson['sensorTopValuelist']

l80_list.each { |x|
 @l80_list_topvalue.push(x['topvalue'])
}

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7TopValue", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0075"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l75_list_topvalue = []


l75_list = testjson['sensorTopValuelist']

l75_list.each { |x|
 @l75_list_topvalue.push(x['topvalue'])
}



    render :layout => "application_page"
  end

  def show_temperature_24h

    deviceid = params[:deviceid]
date = params[:date]

    testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getSensorHour", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0092"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@hourlist = []
@l92_list_max = []
@l92_list_avg = []

l92_list = testjson['sensorHourlist']

l92_list.each { |x|
 @hourlist.push(x['hour'])
 @l92_list_max.push(x['max'])
 @l92_list_avg.push(x['avg'])
}

    testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getSensorHour", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0080"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)



@l80_list_max = []
@l80_list_avg = []

l80_list = testjson['sensorHourlist']

l80_list.each { |x|
 @hourlist.push(x['date'])
 @l80_list_max.push(x['max'])
 @l80_list_avg.push(x['avg'])
}

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getSensorHour", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0075"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)



@l75_list_max = []
@l75_list_avg = []

l75_list = testjson['sensorHourlist']

l75_list.each { |x|
 @hourlist.push(x['date'])
 @l75_list_max.push(x['max'])
 @l75_list_avg.push(x['avg'])
}


    render :layout => "application_page"
  end


  def show_temperature_boxplot
date = params[:date]
    testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7Boxplot", {"date"=>date,"sensor"=>"L0080"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


totalList =testjson['sensorBoxplotList']

@boxplot_list = []


totalList.each { |x|

 lower =  x['lower']
 if(lower <0)
  lower = 0
 end
 q1 = x['q1']
 median = x['median']
 q3 = x['q3']
 upper = x['upper']
 boxplot = [lower,q1,median,q3,upper]

 @boxplot_list.push(boxplot)
}

    render :layout => "application_page"
  end


  def show_pressure
    deviceid = params[:deviceid]
    date = params[:date]
testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0065"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)

@datelist = []
@l65_list_max = []
@l65_list_min = []


l65_list = testjson['sensorMaxMinlist']

l65_list.each { |x|
 @datelist.push(x['date'])
 @l65_list_max.push(x['max'])
 @l65_list_min.push(x['min'])

}

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0010"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)

@l10_list_max = []
@l10_list_min = []

l10_list = testjson['sensorMaxMinlist']

l10_list.each { |x|
 @l10_list_max.push(x['max'])
 @l10_list_min.push(x['min'])
}





    render :layout => "application_page"
  end

  def show_pressure_topvalue

deviceid = params[:deviceid]
date = params[:date]

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0065"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@datelist = []
@l65_list_avg = []

l65_list = testjson['sensorMaxMinlist']

l65_list.each { |x|
 @datelist.push(x['date'])
 @l65_list_avg.push(x['avg'])
}


testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0010"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l10_list_avg = []

l10_list = testjson['sensorMaxMinlist']

l10_list.each { |x|
 @l10_list_avg.push(x['avg'])
}



testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7TopValue", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0065"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l65_list_topvalue = []


l65_list = testjson['sensorTopValuelist']

l65_list.each { |x|
 @l65_list_topvalue.push(x['topvalue'])
}


testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7TopValue", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0010"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l10_list_topvalue = []


l10_list = testjson['sensorTopValuelist']

l10_list.each { |x|
 @l10_list_topvalue.push(x['topvalue'])
}


    render :layout => "application_page"
  end

  def show_pressure_24h

    deviceid = params[:deviceid]
date = params[:date]

    testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getSensorHour", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0065"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@hourlist = []
@l65_list_max = []
@l65_list_min = []

l65_list = testjson['sensorHourlist']

l65_list.each { |x|
 @hourlist.push(x['hour'])
 @l65_list_max.push(x['max'])
 @l65_list_min.push(x['min'])
}

    testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getSensorHour", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0010"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)



@l10_list_max = []
@l10_list_min = []

l10_list = testjson['sensorHourlist']

l10_list.each { |x|
 @hourlist.push(x['date'])
 @l10_list_max.push(x['max'])
 @l10_list_min.push(x['min'])
}

    render :layout => "application_page"
  end



  def show_speed
    deviceid = params[:deviceid]
    date = params[:date]
testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0003"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)

@datelist = []
@l03_list_max = []
@l03_list_avg = []
@l03_list_min = []
@l03_list_topvalue = []


l03_list = testjson['sensorMaxMinlist']

l03_list.each { |x|
 @datelist.push(x['date'])
 @l03_list_max.push(x['max'])
 @l03_list_avg.push(x['avg'])
  @l03_list_min.push(x['min'])

}


testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7TopValue", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0003"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


l03_list = testjson['sensorTopValuelist']

l03_list.each { |x|
 @l03_list_topvalue.push(x['topvalue'])
}

    render :layout => "application_page"
  end


  def show_speed_24h

    deviceid = params[:deviceid]
date = params[:date]

    testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getSensorHour", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0003"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@hourlist = []
@l03_list_max = []
@l03_list_avg = []

l03_list = testjson['sensorHourlist']

l03_list.each { |x|
 @hourlist.push(x['hour'])
 @l03_list_max.push(x['max'])
 @l03_list_avg.push(x['avg'])
}

    render :layout => "application_page"
  end



  def show_vibration
    deviceid = params[:deviceid]
    date = params[:date]

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0091"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)

@datelist = []
@l91_list_max = []
@l91_list_min = []


l91_list = testjson['sensorMaxMinlist']

l91_list.each { |x|
 @datelist.push(x['date'])
 @l91_list_max.push(x['max'])
 @l91_list_min.push(x['min'])
}


testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0077"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)

@l77_list_max = []
@l77_list_min = []

l77_list = testjson['sensorMaxMinlist']

l77_list.each { |x|
 @l77_list_max.push(x['max'])
 @l77_list_min.push(x['min'])
}


    render :layout => "application_page"
  end

  def show_vibration_topvalue

deviceid = params[:deviceid]
date = params[:date]

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0091"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@datelist = []
@l91_list_avg = []

l91_list = testjson['sensorMaxMinlist']

l91_list.each { |x|
 @datelist.push(x['date'])
 @l91_list_avg.push(x['avg'])
}


testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData//last7MaxMin", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0077"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l77_list_avg = []

l77_list = testjson['sensorMaxMinlist']

l77_list.each { |x|
 @l77_list_avg.push(x['avg'])
}



testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7TopValue", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0091"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l91_list_topvalue = []


l91_list = testjson['sensorTopValuelist']

l91_list.each { |x|
 @l91_list_topvalue.push(x['topvalue'])
}


testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/last7TopValue", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0077"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@l77_list_topvalue = []


l77_list = testjson['sensorTopValuelist']

l77_list.each { |x|
 @l77_list_topvalue.push(x['topvalue'])
}


    render :layout => "application_page"
  end

  def show_vibration_24h

    deviceid = params[:deviceid]
date = params[:date]

    testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getSensorHour", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0091"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


@hourlist = []
@l91_list_max = []
@l91_list_min = []

l91_list = testjson['sensorHourlist']

l91_list.each { |x|
 @hourlist.push(x['hour'])
 @l91_list_max.push(x['max'])
 @l91_list_min.push(x['min'])
}

    testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getSensorHour", {"date"=>date,"deviceid"=>deviceid,"sensor"=>"L0077"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)



@l77_list_max = []
@l77_list_min = []

l77_list = testjson['sensorHourlist']

l77_list.each { |x|
 @hourlist.push(x['date'])
 @l77_list_max.push(x['max'])
 @l77_list_min.push(x['min'])
}

    render :layout => "application_page"
  end


end
