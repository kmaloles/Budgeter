//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var airports = Dictionary<String, AnyObject>()
airports = ["YYZ": "Toronto Pearson"
                , "DUB": 0
                , "Date": NSDate()]

airports["expense"] = 12345
print(airports["expense"])
