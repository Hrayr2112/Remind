//
//  Constants.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import Foundation

struct ErrorMessage {
    static let invalidEmail = "please enter a valid email"
    static let takenEmail = "this email is taken"
    static let emailsDoNotMatch = "email addresses do not match"
    static let invalidUsernameMinChars = "username should contain at least 4 characters"
    static let invalidUsernameMaxChars = "username can contain up to 20 characters"
    static let invalidUsernameNoLetter = "username can contain only letters, numbers, underline and a dot"
    static let invalidUsernameSpace = "username cannot contain a space"
    static let takenUsername = "this username is taken"
    static let emptyOldPassword = "please enter current password"
    static let invalidPassword = "password should contain at least 6 characters"
    static let apiError = "something went wrong, please check your connection"
}
