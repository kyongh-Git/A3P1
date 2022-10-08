// Assignment1 Program1 YongHwan Kim fibonacci
import UIKit

//fibonacci function returning the sum of the odd term's values
func fibonacci(n: Int) -> Int {
    
    var seq1 = 0
    var seq2 = 1
    var fiboArray: [Int] = []
    
    var sum = 0
    var count = 1
    
    // fibonacci logic
    for _ in 0..<n {
        let temp = seq1
        seq1 = seq2
        seq2 = seq1 + temp
        fiboArray.append(seq2)
    }
    // sum of the odd fibonacci terms
    for seq in fiboArray {
        if count % 2 != 0
        {
            sum += seq
        }
        count += 1
    }
    return sum
}

// Generate random numbers
var ranArray: [Int] = []
var count = 0

while count < 3 {
    let num = Int.random(in: 10 ... 20)
    if ranArray.contains(num) {
        continue
    }
    ranArray.append(num)
    count += 1
    print("Random number \(count):",num)
}
// Test Fibonacci function
count = 1
for i in ranArray {
    print("Fibo \(count):",fibonacci(n: i))
    count += 1
}

