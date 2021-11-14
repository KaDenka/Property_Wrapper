import SwiftUI
@propertyWrapper
public struct TextStatesWrapper {
    public var wrappedValue: String {
        get { get() }
        set { set(newValue) }
    }
 //MARK: The neccesary variables and enums
    private var formatedString: String
    private var formatTo: StringCases
    public enum StringCases {
        case camelCase
        case kebabCase
        case shakeCase
    }
    
    init(wrappedValue: String, formatTo: StringCases) {
        self.formatedString = wrappedValue
        self.formatTo = formatTo
    }
//MARK: The function for receiving the value of the property:
    public func get() -> String {
        return formatedString
    }
//MARK: The function for updating the value of the property:
    public mutating func set(_ newValue: String) {
        switch formatTo {
        case .camelCase:
            formatedString = newValue.components(separatedBy: CharacterSet.alphanumerics.inverted)
                .filter { !$0.isEmpty }
                .map { $0.capitalized }
                .joined()
        case .kebabCase :
            formatedString = newValue.components(separatedBy: CharacterSet.alphanumerics.inverted)
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
            formatedString = newValue.components(separatedBy: CharacterSet.alphanumerics.inverted)
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
