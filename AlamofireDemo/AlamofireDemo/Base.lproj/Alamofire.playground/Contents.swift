//: Playground - noun: a place where people can play

import UIKit

//使用协议扩展进行数据类型的转换
protocol BaseNumberStringConvertible {
    var intValue: Int? { get }
    var doubleValue: Double? { get }
    var floatValue: Float? { get }
}

extension String: BaseNumberStringConvertible {
    public var intValue: Int? {
        if let floatValue = self.floatValue {
            return Int(floatValue)
        }
        return nil
    }
    
    public var floatValue: Float? {
        return Float(self)
    }
    
    public var doubleValue: Double? {
        return Double(self)
    }
}

var numberString = "1.22"
numberString.intValue
numberString.floatValue
numberString.doubleValue




//下标属性的使用==========------------=========
class CustomUserData {
    let userId: Int
    let userName: String
    init(userId: Int, userName: String) {
        self.userId = userId
        self.userName = userName
    }
}

//定义下标
class SubscriptClassTest {
    var userInfo: [Int : String] = [:]
    
    subscript(userData: CustomUserData) -> String? {
        get {
            return userInfo[userData.userId]
        }
        
        set {
            userInfo[userData.userId] = newValue
        }
    }
}

let myData = CustomUserData(userId: 000001, userName: "ZeluLi")

let testSubscript = SubscriptClassTest()

testSubscript[myData] = myData.userName

testSubscript[myData]




class MySubscriptClass {
    
    var value : String = "default"
    
    subscript(myValue: String) -> String {
        get {
            return value
        }
        set {
            value = newValue  //newValue代表着所赋的值
        }
    }
}

let mySubscriptObj = MySubscriptClass()

mySubscriptObj["key"] = "Vlaue1"
mySubscriptObj.value

mySubscriptObj.value = "Vlaue2"
mySubscriptObj["key"]





//尾随闭包初始化=======-------========-------========---------==========

class TestClass1 {
    var closure: (p1: String, p2: String, p3: String) -> String
    init(myClosure: (p1: String, p2: String, p3: String) -> String) {
        self.closure = myClosure
    }
}

let testObj01 = TestClass1{(p1, p2, p3) in
    return (p1 + p2 + p3)
}
testObj01.closure(p1: "a", p2: "b", p3: "c")



let testObj02 = TestClass1 { (p1, p2, p3) -> String in
    return (p1 + p2 + p3)
}
testObj02.closure(p1: "a", p2: "b", p3: "c")


let testObj03 = TestClass1(myClosure: {(p1, p2, p3) -> String in
        return (p1 + p2 + p3)
    }
)
testObj03.closure(p1: "a", p2: "b", p3: "c")



/// 另一种使用方式
typealias MyClosureType = (p1: String, p2: String, p3: String) -> String

class TestClass2 {
    var closure: MyClosureType
    
    init(myClosure: MyClosureType) {
        self.closure = myClosure
    }
    
}

let testObj04 = TestClass2 { (p1, p2, p3) -> String in
    return (p1 + p2 + p3)
}
testObj04.closure(p1: "A", p2: "B", p3: "C")







//协议中的泛型=======-------========-------========---------==========
protocol StringConvertibleProtocolType {
    associatedtype MyCustomAssociatedType                       //定义协议中的泛型----关联类型
    var convertible: (String)->MyCustomAssociatedType? { get }
}

class ConvertibleClass<T>: StringConvertibleProtocolType {
    
    var convertible: (String) -> T?
    
    init(parameter:  (String) -> T?) {
        self.convertible = parameter
    }
}


let stringToInt = ConvertibleClass<Int> { (stringValue) -> Int? in
    return Int(stringValue)
}
stringToInt.convertible("666")


let stringToDouble = ConvertibleClass<Double> { (stringValue) -> Double? in
    return Double(stringValue)
}
stringToDouble.convertible("10.12")







//运算符重载============-----------===========------
public enum NetworkReachabilityStatus {
    case Unknown
    case NotReachable
    case Reachable(ConnectionType)
}

public enum ConnectionType {
    case EthernetOrWiFi
    case WWAN
}

let netState = NetworkReachabilityStatus.Reachable(.EthernetOrWiFi)



extension NetworkReachabilityStatus: Equatable {}
public func ==(lhs: NetworkReachabilityStatus, rhs: NetworkReachabilityStatus) -> Bool{
    //Switch进行元组匹配
    switch (lhs, rhs) {
        case (.Unknown, .Unknown):
            return true
        case (.NotReachable, .NotReachable):
            return true
        case let (.Reachable(lhsConnectionType), .Reachable(rhsConnectionType)):
            return lhsConnectionType == rhsConnectionType
        default:
            return false
    }
}


netState == NetworkReachabilityStatus.Reachable(.EthernetOrWiFi)








//=====-----=====动态属性关联======-----=====
extension NSURLSession {
    
    private struct AssociatedKeys {
        static var AssociatedValueKey = "NSURLSession.AssociatedStringValue"
    }
    
    var associatedStringValue : String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.AssociatedValueKey) as? String
        }
        set (associateValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.AssociatedValueKey, associateValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

let session = NSURLSession.sharedSession()
session.associatedStringValue = "associate string value"
print(session.associatedStringValue)




