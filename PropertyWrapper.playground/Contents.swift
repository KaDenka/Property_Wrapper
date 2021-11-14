import UIKit
import Foundation



@propertyWrapper
struct Transformed {
    public var wrappedValue: String {
        get { get() }
        set { set(newValue) }
    }
    
    private var value: String
    private var formatTo: StringCases
    public enum StringCases {
        case camelCase
        case kebabCase
        case shakeCase
    }
    
    init(wrappedValue: String, formatTo: StringCases) {
        self.value = wrappedValue
        self.formatTo = formatTo
    }
    
    public func get() -> String {
        return value
    }
    
    public mutating func set(_ newValue: String) {
        switch formatTo {
        case .camelCase:
            value = newValue.components(separatedBy: CharacterSet.alphanumerics.inverted)
                .filter { !$0.isEmpty }
                .map { $0.capitalized }
                .joined()
        case .kebabCase :
            value = newValue.components(separatedBy: CharacterSet.alphanumerics.inverted)
                .filter { !$0.isEmpty }
                .map { $0.capitalized }
                .joined()
                .unicodeScalars.reduce("") {
                    if CharacterSet.uppercaseLetters.contains($1) {
                        if $0.count > 0 {
                            return ($0 + "-" + String($1).lowercased())
                        }
                    }
                    return $0 + String($1).lowercased()
                }
        case .shakeCase:
            value = newValue.components(separatedBy: CharacterSet.alphanumerics.inverted)
                .filter { !$0.isEmpty }
                .map { $0.capitalized }
                .joined()
                .unicodeScalars.reduce("") {
                    if CharacterSet.uppercaseLetters.contains($1) {
                        if $0.count > 0 {
                            return ($0 + "_" + String($1).lowercased())
                        }
                    }
                    return $0 + String($1).lowercased()
                }
        }
    }
}


class MyClass {
    @Transformed(formatTo: .kebabCase) var property = ""
}

let myClass = MyClass()

myClass.property = "What are you doing"
print(myClass.property)
