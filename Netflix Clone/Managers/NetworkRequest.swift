//
//  NetworkRequest.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 14/03/2023.
//

import Foundation
import RxSwift
import Alamofire


class NetworkRequest {
    
    
    func request<T: Decodable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<T>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
            let request = AF.request(urlConvertible).responseDecodable(of: T.self) { (response) in
                //Check the result from Alamofire's response and check if it's a success or a failure
                switch response.result {
                case .success(let value):
                    //Everything is fine, return the value in onNext
                
                    guard let responseData = response.data else {
                        return
                    }
                    do {
                        debugPrint(responseData)
                        let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                        debugPrint(json)
                        let obj = try JSONDecoder().decode(T.self, from: responseData)
                        observer.onNext(obj)
                    } catch {
                        observer.onError(error)
                    }
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    //Something went wrong, switch on the status code and return the error
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ApiError.forbidden)
                    case 404:
                        observer.onError(ApiError.notFound)
                    case 409:
                        observer.onError(ApiError.conflict)
                    case 500:
                        observer.onError(ApiError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
                            
                   
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    
    
}
