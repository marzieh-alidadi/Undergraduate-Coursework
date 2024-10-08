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
  
####first path

flow1_1 = {
    'switch':"00:00:00:00:00:00:00:06",
    "name":"flow1_1",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.12",
    "priority":"32768",
    "in_port":"2",
    "active":"true",
    "actions":"output=1"
    }

flow1_2 = {
    'switch':"00:00:00:00:00:00:00:02",
    "name":"flow1_2",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.12",
    "priority":"32768",
    "in_port":"2",
    "active":"true",
    "actions":"output=1"
    }

flow1_3 = {
    'switch':"00:00:00:00:00:00:00:01",
    "name":"flow1_3",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.12",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=4"
    }

flow1_4 = {
    'switch':"00:00:00:00:00:00:00:05",
    "name":"flow1_4",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.12",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=4"
    }

flow1_5 = {
    'switch':"00:00:00:00:00:00:00:11",
    "name":"flow1_5",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.01",
    "ipv4_dst":"10.0.0.12",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=2"
    }


####second path

flow2_1 = {
    'switch':"00:00:00:00:00:00:00:08",
    "name":"flow2_1",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.03",
    "ipv4_dst":"10.0.0.11",
    "priority":"32768",
    "in_port":"2",
    "active":"true",
    "actions":"output=1"
    }

flow2_2 = {
    'switch':"00:00:00:00:00:00:00:02",
    "name":"flow2_2",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.03",
    "ipv4_dst":"10.0.0.11",
    "priority":"32768",
    "in_port":"4",
    "active":"true",
    "actions":"output=1"
    }

flow2_3 = {
    'switch':"00:00:00:00:00:00:00:01",
    "name":"flow2_3",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.03",
    "ipv4_dst":"10.0.0.11",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=4"
    }

flow2_4 = {
    'switch':"00:00:00:00:00:00:00:05",
    "name":"flow2_4",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.03",
    "ipv4_dst":"10.0.0.11",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=3"
    }

flow2_5 = {
    'switch':"00:00:00:00:00:00:00:10",
    "name":"flow2_5",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.03",
    "ipv4_dst":"10.0.0.11",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=2"
    }



####third path

flow3_1 = {
    'switch':"00:00:00:00:00:00:00:0b",
    "name":"flow3_1",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.06",
    "ipv4_dst":"10.0.0.09",
    "priority":"32768",
    "in_port":"2",
    "active":"true",
    "actions":"output=1"
    }

flow3_2 = {
    'switch':"00:00:00:00:00:00:00:03",
    "name":"flow3_2",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.06",
    "ipv4_dst":"10.0.0.09",
    "priority":"32768",
    "in_port":"4",
    "active":"true",
    "actions":"output=1"
    }

flow3_3 = {
    'switch':"00:00:00:00:00:00:00:01",
    "name":"flow3_3",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.06",
    "ipv4_dst":"10.0.0.09",
    "priority":"32768",
    "in_port":"2",
    "active":"true",
    "actions":"output=3"
    }

flow3_4 = {
    'switch':"00:00:00:00:00:00:00:04",
    "name":"flow3_4",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.06",
    "ipv4_dst":"10.0.0.09",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=4"
    }

flow3_5 = {
    'switch':"00:00:00:00:00:00:00:0e",
    "name":"flow3_5",
    "eth_type":"0x0800",
    "ipv4_src":"10.0.0.06",
    "ipv4_dst":"10.0.0.09",
    "priority":"32768",
    "in_port":"1",
    "active":"true",
    "actions":"output=2"
    }

pusher.set(flow1_1)
pusher.set(flow1_2)
pusher.set(flow1_3)
pusher.set(flow1_4)
pusher.set(flow1_5)

pusher.set(flow2_1)
pusher.set(flow2_2)
pusher.set(flow2_3)
pusher.set(flow2_4)
pusher.set(flow2_5)

pusher.set(flow3_1)
pusher.set(flow3_2)
pusher.set(flow3_3)
pusher.set(flow3_4)
pusher.set(flow3_5)
