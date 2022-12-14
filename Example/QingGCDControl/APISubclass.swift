//
//  APISubclass.swift
//  QingGCDControl_Example
//
//  Created by PeterLin on 2022/12/13.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Alamofire
import QingGCDControl

class APISubclass: API {
    private let TAG = String(describing: APISubclass.self)
    public static let shared = APISubclass()
    
    private lazy var apiPerfix = "https://\(publicAddress)/app/api"
    private var loginPerfix = "auth/v1/login"
    private var myLessonsPerfix = "class/v1/mylesson"
    private var lessonsPerfix = "lesson/v1"
    
    private(set) var resultDM: ResultModel? = nil
    
    private override init() {
        super.init()
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        let url = "\(apiPerfix)/\(loginPerfix)"
        print("\(TAG) url: \(url)")
        let jsonParams: [String: Any] = ["account": "teacher", "password": "teacher"]
        connectToServer(url: url, method: .post, dataStruct: LoginDM.self, params: jsonParams, encoding: JSONEncoding.default) { [unowned self] (statusCode, result) in
            if let statusCode = statusCode {
                switch statusCode {
                case 200, 201:
                    if result is LoginDM {
                        Global.loginDM = (result as! LoginDM)
                        completion(true)
                        return
                    }
                    completion(false)
                    break
                default:
                    if result is ResultModel {
                        resultDM = (result as! ResultModel)
                    }
                    completion(false)
                    break
                }
            }
        }
    }
}

// MARK: - LoginDM
struct LoginDM: Codable {
    let message: String
    let data: LoginDatum
}

// MARK: - LoginData
struct LoginDatum: Codable {
    let userID, userAccount, userName, accessToken: String
    let refreshToken, expireAt, refreshTokenExpire: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userAccount, userName, accessToken, refreshToken, expireAt, refreshTokenExpire
    }
}
