//
//  FirebaseUser.swift
//  TwinMVP
//
//  Created by Firuza Raiymkul on 22.01.2024.
//

import Foundation
import Firebase

class FirebaseUser: Equatable {
    static func == (lhs: FirebaseUser, rhs: FirebaseUser) -> Bool {
        lhs.objectId == rhs.objectId
    }
    
        let objectId: String
        var email: String
        var username: String
        var dateOfBirth: Date
        var isMale: Bool
        var avatarImage: UIImage?
        var profession: String
        var jobTitle: String
        var about: String
        var city: String
        var country: String
        // возможно надо тип Int:
        var height: Double
    //    var weight: String
        var lookingFor: String
        var avatarLink: String
        
        var likedArray: [String]?
        var imageLinks: [String]?
        var registeredDate = Date()
        var pushId: String?
    
    var userDictionary: NSDictionary {
        
        return NSDictionary(objects: [
            self.objectId,
            self.email,
            self.username,
            self.dateOfBirth,
            self.isMale,
            self.profession,
            self.jobTitle,
            self.about,
            self.city,
            self.country,
            self.height,
            //  self.ar weight:
            self.lookingFor,
            self.avatarLink,
            
            self.likedArray ?? [],
            self.imageLinks ?? [],
            self.registeredDate,
            self.pushId ?? "",
        ],
                            
        forKeys: [kOBJECTID as NSCopying,
                  kEMAIL as NSCopying,
                  kUSERNAME as NSCopying,
                  kDATEOFBIRTH as NSCopying,
                  kISMALE as NSCopying,
                  kJOBTITLE as NSCopying,
                  kPROFESSION as NSCopying,
                  kABOUT as NSCopying,
                  kCITY as NSCopying,
                  kCOUNTRY as NSCopying,
                  kHEIGHT as NSCopying,
                  kLOOKINGFOR as NSCopying,
                  kAVATARLINK as NSCopying,
                  kIMAGELINKS as NSCopying,
                  kLIKEDIDARRAY as NSCopying,
                  kREGISTEREDDATE as NSCopying,
                  kPUSHID as NSCopying,
        ])
        
    }
    
    
    //MARK: - Inits
    
    init(_objectId: String, _email: String, _username: String, _city: String, _dateOfBirth: Date, _isMale: Bool, _avatarLink: String = "") {
        
        objectId = _objectId
        email = _email
        username = _username
        dateOfBirth = _dateOfBirth
        isMale = _isMale
        profession = ""
        jobTitle = ""
        about = ""
        city = _city
        country = ""
        height = 0.0
        lookingFor = ""
        avatarLink = _avatarLink
        likedArray = []
        imageLinks = []
        
        
    }
    
    
    //MARK: Login
    class func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            
            if error == nil {
                
                if authDataResult!.user.isEmailVerified {
                    completion(error, true)
                } else {
                    print("Email not verified!")
                    completion(error, false)
                }
            
            } else {
                completion(error, false)
            }
        }
        
    }
    
    
    //MARK: Register
    class func registerUserWith(email: String, password: String, userName: String, city: String, isMale: Bool, dateOfBirth: Date, completion: @escaping(_ error: Error?) -> Void) {
        
        print("Register", Date())
        
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            print("Finished register with error", error)
            print(Date())
            completion(error)
            
            if error == nil {
                
                authData!.user.sendEmailVerification { (error) in print("auth email verification sent ", error?.localizedDescription)
                    
                    //create user in Database
                    
                }
                
                if authData?.user != nil {
                    
                    let user = FirebaseUser(_objectId: authData!.user.uid, _email: email, _username: userName, _city: city, _dateOfBirth: dateOfBirth, _isMale: isMale)
                    
                    user.saveUserLocally()
                }
            }
        }
    }
    
    func saveUserLocally() {
        
        userDefaults.set(self.userDictionary as! [String : Any], forKey: kCURRENTUSER)
        userDefaults.synchronize()
        
    }

}
