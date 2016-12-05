//
//  StringSearch.swift
//  TestingPolymorphism
//
//  Created by M. Ahmed on 6/10/15.
//  Copyright (c) 2015 Syheed Ahmed. All rights reserved.
//

import Foundation
extension String {
    func length() -> Int{ // finds length of string
        return self.characters.count
    }
    func length(includeWhiteSpace includeWhiteSpace :Bool){// finds length with includeWhiteSpace option
        if includeWhiteSpace {
            self.length()
        }
        else{
            self.removeWhitespace().length()
        }
    }
    func index(str: String) -> Int{ // finds index of string ex: str["Find"] = 8
        var index: Int
        if let range = self.rangeOfString(str){
            index = self.startIndex.distanceTo(range.startIndex)
        }
        else {
            return -1
        }
        return index
    }
 
    func occurancesOfString(str: String) -> Int // Counts occurances ex: Str.occurancesOfString["This"]
    {
        let num =  self.componentsSeparatedByString(str)
        return num.count-1
    }
    
    func jumpTo(str: String) -> String{ // Returns all of string after given string ex: str.stringFrom("Find This")
        if (self.index(str) != -1){
            let start = self.index(str) + str.length()
            let end = self.length() - 1
            if (start <= end){
            return self[start...end]
            }
            else {return "Not Found"}
        }
       
        return "Not Found"
    }
    func findStringBetween(startPoint startPoint: String, endPoint: String) -> String{// Returns the first occurance of string
        if (self.index(startPoint) != -1 && self.index(endPoint) >= -1){
            let start = self.index(startPoint) + startPoint.length()
            let end = self[startPoint].index(endPoint) - 1 + start
            if end > 0 && self[startPoint].index(endPoint) != -1{ // make this better
            return self[start...end]
            }
            else {
                
                return self
            }
        }
        return "Not Found"
    }
    func findAllBetween(startPoint startPoint: String, endPoint: String) -> [String]{// Returns an array of all occurances string
        var items: [String] = []
        var str = self
        var info = str.findStringBetween(startPoint: startPoint, endPoint: endPoint)
        while (info != "Not Found"){
            items.append(info)
            str = str[info]
            info = str.findStringBetween(startPoint: startPoint, endPoint: endPoint)
        }
        return items
    }
    
    func findStringBetween(startPoint startPoint: String, endPoint: String, removeWhiteSpace: Bool) -> String{// Returns the first occurance of string + WhiteSpace option
        if (self.index(startPoint) != -1 && self.index(endPoint) != -1){
            let start = self.index(startPoint) + startPoint.length()
            let end = self[startPoint].index(endPoint) - 1 + start
            var info = self[start...end]
            if (removeWhiteSpace){
                info = info.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            }
            return info
        }
        return "Not Found"
    }
    func findAllBetween(startPoint startPoint: String, endPoint: String, removeWhiteSpace: Bool) -> [String]{// Returns an array of all occurances string + WhiteSpace option
        var items: [String] = []
        var str = self
        var info = str.findStringBetween(startPoint: startPoint, endPoint: endPoint, removeWhiteSpace: true)
        while (info != "Not Found"){
            items.append(info)
            str = str[info]
            info = str.findStringBetween(startPoint: startPoint, endPoint: endPoint, removeWhiteSpace: true)
        }
        return items
    }
    func toArray(separatedBy sep: String) ->[String]{
        return self.findAllBetween(startPoint: sep, endPoint: sep)
    }
    
    func hasLetters() -> Bool {
        for chr in self.characters {
            if ((chr >= "a" && chr <= "z") || (chr >= "A" && chr <= "Z") ) {
                return true
            }
        }
        return false
    }
    func hasNumbers() -> Bool {
        for chr in self.characters {
            if ((chr >= "0" && chr <= "9")) {
                return true
            }
        }
        return false
    }
    func hasCharacters() -> Bool {
        if self.hasLetters() || self.hasNumbers() {
            return true
        }
        return false
    }
    
    subscript(str: String) -> String { // Returns all of string after given string ex: str["Find This"]
        return self.jumpTo(str)
    }
    subscript (i: Int) -> Character { // Returns character at Index ex: str[4]
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String { // Returns character at Index as String ex: str[4]
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
    func removeWhitespace() -> String {
            let components = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({!$0.characters.isEmpty})
            return components.joinWithSeparator(" ")
    }
    


}
    
