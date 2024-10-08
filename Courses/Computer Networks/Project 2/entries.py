#Marzieh Alidadi 9631983

import httplib
import json

class StaticFlowPusher(object):
  
    def __init__(self, server):
        self.server = server
  
    def get(self, data):
        ret = self.rest_call({}, 'GET')
        return json.loads(ret[2])
  
    def set(self, data):
        ret = self.rest_call(data, 'POST')
        return ret[0] == 200
  
    def remove(self, objtype, data):
        ret = self.rest_call(data, 'DELETE')
        return ret[0] == 200
  
    def rest_call(self, data, action):
        path = '/wm/staticflowpusher/json'
        headers = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            }
        body = json.dumps(data)
        conn = httplib.HTTPConnection(self.server, 8080)
        conn.request(action, path, body, headers)
        response = conn.getresponse()
        ret = (response.status, response.reason, response.read())
        print ret
        conn.close()
        return ret

pusher = StaticFlowPusher('127.0.0.1')
  
flow1 = {
    'switch':"00:00:00:00:00:00:00:01",
    "name":"flow1",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.5",
    "priority":"32768",
    "in_port":"4",
    "active":"true",
    "actions":"output=1"
    }

flow2 = {
    'switch':"00:00:00:00:00:00:00:02",
    "name":"flow2",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.5",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=2"
    }

flow3 = {
    'switch':"00:00:00:00:00:00:00:05",
    "name":"flow3",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.5",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=3"
    }

flow4 = {
    'switch':"00:00:00:00:00:00:00:08",
    "name":"flow4",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.5",
    "priority":"32768",
    "in_port":"3",
    "active":"true",
    "actions":"output=2"
    }

flow5 = {
    'switch':"00:00:00:00:00:00:00:0a",
    "name":"flow5",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.5",
    "priority":"32768",
    "in_port":"2",
    "active":"true",
    "actions":"output=3"
    }

flow6 = {
    'switch':"00:00:00:00:00:00:00:09",
    "name":"flow6",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.5",
    "priority":"32768",
    "in_port":"3",
    "active":"true",
    "actions":"output=5"
    }

pusher.set(flow1)
pusher.set(flow2)
pusher.set(flow3)
pusher.set(flow4)
pusher.set(flow5)
pusher.set(flow6)
