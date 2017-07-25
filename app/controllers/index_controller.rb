require 'rest-client'
require 'json'
require 'date'



class IndexController < ApplicationController

  def index
    testbody = RestClient.get "http://10.76.2.63:8080/gcis/getResData/getDeviceType"
    testjson = JSON.parse(testbody)
    @devices = testjson['deviceTypeList']

    @findday =(Date.today-1).to_s
    render :layout => "application_page"
  end

  def show_log

testbody = RestClient.post "http://10.76.2.63:8080/gcis/getResData/getDataCount", {"year"=>"2017"}.to_json, {content_type: :json, accept: :json}
testjson = JSON.parse(testbody)


count_hash = {}

count_array = []

@count_arr = []


count_list = testjson['sensorDataCountlist']

count_list.each { |x|

 date = x['date']
 count = x['count']


 count_hash[date] = count
}


start = Date.new(2017,1,1)
stop = Date.new(2017,12,31)


while(start<=stop) do

start_str = start.to_s

if(!count_hash[start_str].nil?)
    count_val = count_hash[start_str]
    count_array = [start_str,count_val]
    @count_arr.push(count_array)
else
    count_val = 1
    count_array = [start_str,0]
    @count_arr.push(count_array)

end
start = start + 1

end


    render :layout => "application_page"
  end

end
