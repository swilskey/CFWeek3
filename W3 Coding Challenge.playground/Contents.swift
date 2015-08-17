//: Playground - noun: a place where people can play

import UIKit

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