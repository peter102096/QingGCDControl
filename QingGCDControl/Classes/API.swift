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
    private var trustIP: String = "0.0.0.0"
    private var trustPort: Int = 443
    private lazy var sharedSession: Session = {
        let manager = ServerTrustManager(evaluators: [trustIP: DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    var statusCode: Int? = 404
    
    public override init() {
        super.init()
    }
    
    public func setAddress(trustIP: String, port: Int) {
        self.trustIP = trustIP
        self.trustPort = port
        sharedSession = {
            let manager = ServerTrustManager(evaluators: [trustIP: DisabledTrustEvaluator()])
            let configuration = URLSessionConfiguration.af.default
            configuration.timeoutIntervalForRequest = 30
            return Session(configuration: configuration, serverTrustManager: manager)
        }()
    }
    
    public var publicAddress: String {
        return "\(trustIP):\(trustPort)"
    }
    
    public func connectToServer<T: Codable>(url: String, method: HTTPMethod = .get, dataStruct struct: T.Type, params: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, completion: @escaping (Int?, Codable?) -> Void) {
        
        sharedSession.request(url, method: method, parameters: params, encoding: encoding).responseDecodable(of: T.self) { [unowned self] (data) in
            statusCode = data.response?.statusCode
            print("statusCode : \(statusCode ?? 9999)")
            switch data.result {
            case .success(_):
                completion(statusCode, data.value)
                break
            case .failure(_):
                print("\(TAG) connectToServer failure")
                if data.error == nil {
                    let errorData = ResultModel(result: "Data decode failed")
                    completion(statusCode, errorData)
                } else {
                    let errorData = ResultModel(result: "\(data.error!.localizedDescription)")
                    completion(statusCode, errorData)
                }
                break
            }
        }
    }
}
