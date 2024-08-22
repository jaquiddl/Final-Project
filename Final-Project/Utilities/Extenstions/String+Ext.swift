//
//  String+Ext.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 08/08/24.
//

import Foundation
import RegexBuilder

extension String {
    
    var isValidEmail: Bool {
//        let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
//        return emailPredicate.evaluate(with: self)

        let emailRegex = Regex {
            OneOrMore {
                CharacterClass(
                    .anyOf("._%+-"),
                    ("A"..."Z"),
                    ("0"..."9"),
                    ("a"..."z")
                )
            }
            "@"
            OneOrMore {
                CharacterClass(
                    .anyOf("-"),
                    ("A"..."Z"),
                    ("a"..."z"),
                    ("0"..."9")
                )
            }
            "."
            Repeat(2...64) {
                CharacterClass(
                    ("A"..."Z"),
                    ("a"..."z")
                )
            }
        }

        return self.wholeMatch(of: emailRegex) !=  nil
    }
    var isValidPassword: Bool {
            // Define the criteria for a valid password
            let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$&*]).{8,}$"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            return passwordTest.evaluate(with: self)
        }
}


