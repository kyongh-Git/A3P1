import UIKit


var temp :String = "10.00"
while temp.last == "0"{
    if temp.last == "."{
        temp.removeLast()
        break
    }
    temp.removeLast()
}
temp.removeLast()
print(temp)
