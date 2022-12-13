//
//  API.swift
//  CallPratice
//
//  Created by PeterLin on 2021/11/10.
//

import UIKit
import Alamofire

class API: NSObject {
    private let TAG = "API"
    static let shared = API()
    private let trustIP: String
    private lazy var sharedSession: Session = {
        let manager = ServerTrustManager(evaluators: [trustIP: DisabledTrustEvaluator()])
           let configuration = URLSessionConfiguration.af.default
           configuration.timeoutIntervalForRequest = 30
           return Session(configuration: configuration, serverTrustManager: manager)
       }()
    var statusCode: Int? = 404
    
    init(trustIP: String = "0.0.0.0") {
        self.trustIP = trustIP
    }
    
    func connectToServer<T: Codable>(url: String, method: HTTPMethod = .get, dataStruct struct: T.Type, params: Parameters? = nil, completion: @escaping (Int?, Codable?) -> Void) {
        
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
