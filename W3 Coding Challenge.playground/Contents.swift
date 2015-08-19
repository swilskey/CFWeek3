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
* Tuesday
* Given an array of ints of odd length, return a new array length 3 containing the elements from the middle of the array. The array length will be at least 3.
*
*/