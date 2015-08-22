//: Playground - noun: a place where people can play

import UIKit

/*
* Monday
* Return the min and max of an array in a tuple
*
*/

var array = [43,23,52,3,12,3,5,1, -10, 5004]

func minMax(array: [Int]) -> (min: Int, max: Int) {
  var min = array[0]
  var max = array[0]
  
  for number in array {
    if number > max {
      max = number
    }
    if number < min {
      min = number
    }
  }
  
  return (min: min , max: max)
}

let minmax = minMax(array)
println(minmax)

/*
* Tuesday
* Given an array of ints of odd length, return a new array length 3 containing the elements from the middle of the array. The array length will be at least 3.
*
*/

let oddArray = [1, 4, 5, 6, 9, 5, 4, 4, 5]
let evenArray = [3, 4, 3, 2]

func middleArray<T>(array: [T]) -> [T]? {
  if array.count % 2 != 0 {
    let start = array.count / 2 - 1
    var retArray = Array(array[start..<start + 3])
    return retArray
  }
  return nil
}

middleArray(oddArray)
middleArray(evenArray)

/*
* Wednesday
* Given a non-negative number "num", return true if num is within 2 of a multiple of 10. Note: (a % b) is the remainder of dividing a by b, so (7 % 5) is 2
*
*/

func checkMultipleOfTen(number: Int) -> Bool {
  if number >= 0 {
    if number % 10 <= 2 || number % 10 >= 8 {
      println(number)
      return true
    }
    return false
  }
  println("Negative Number")
  return false
}

checkMultipleOfTen(20)
checkMultipleOfTen(22)
checkMultipleOfTen(23)
checkMultipleOfTen(18)
checkMultipleOfTen(17)
checkMultipleOfTen(-10)

/*
* Thursday
* Given a string, return a string where for every char in the original, there are two chars.
*
*/

func doubleCharsInString(originalString: String) -> String {
  var newString = ""
  for char in originalString {
    newString.append(char)
    newString.append(char)
  }
  
  return newString
}

let string = doubleCharsInString("abc")