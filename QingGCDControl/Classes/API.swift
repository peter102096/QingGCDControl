//
//  API.swift
//  CallPratice
//
//  Created by PeterLin on 2021/11/10.
//

import UIKit
import Alamofire

open class API: NSObject {
    private let TAG = "API"
    public static let shared = API()
    private var trustIP: String = "0.0.0.0"
    private lazy var sharedSession: Session = {
        let manager = ServerTrustManager(evaluators: [trustIP: DisabledTrustEvaluator()])
           let configuration = URLSessionConfiguration.af.default
           configuration.timeoutIntervalForRequest = 30
           return Session(configuration: configuration, serverTrustManager: manager)
       }()
    var statusCode: Int? = 404
    
    private override init() {
        super.init()
    }
    
    public func setIP(trustIP: String) {
        self.trustIP = trustIP
        sharedSession = {
            let manager = ServerTrustManager(evaluators: [trustIP: DisabledTrustEvaluator()])
            let configuration = URLSessionConfiguration.af.default
            configuration.timeoutIntervalForRequest = 30
            return Session(configuration: configuration, serverTrustManager: manager)
        }()
    }
    
    public func connectToServer<T: Codable>(url: String, method: HTTPMethod = .get, dataStruct struct: T.Type, params: Parameters? = nil, completion: @escaping (Int?, Codable?) -> Void) {
        
        sharedSession.request(url, method: method, parameters: params).responseJSON(completionHandler: {
            [self] data in
            statusCode = data.response?.statusCode
            print("statusCode : \(statusCode ?? 9999)")
            guard data.error == nil else {
                print("error : \(data.error!.localizedDescription)")
                let errorData = ResultModel(result: data.error!.localizedDescription)
                completion(statusCode, errorData)
                return
            }
            if let responseData = data.data, statusCode != nil, (statusCode == 200 || statusCode == 201) {
                guard let result = try? JSONDecoder().decode(T.self, from: responseData) else {
                    print("\(TAG) decode failed")
                    let errorData = ResultModel(result: "Data decode failed")
                    completion(statusCode, errorData)
                    return
                }
                completion(statusCode, result)
                return
            }
        })
    }
}
