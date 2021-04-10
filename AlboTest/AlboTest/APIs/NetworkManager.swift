//
//  NetworkManager.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 09/04/21.
//

import Foundation
import UIKit

protocol URL_SessionDelegate {
    func connectionFinishSuccessfull(session: URL_Session, response: ResponseAirport)
    func connectionFinishWithError(session: URL_Session, error: Error)
}

class URL_Session: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    var dataTask: URLSessionDataTask?
    var responseData: Data = Data()
    var httpResponse: HTTPURLResponse?
    var delegate: URL_SessionDelegate?
    
    override init() {
        super.init()
    }

    func executeAirports(parameters: RequestAirportsStruct) {
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let flight = parameters.flight
        let lat = parameters.lat
        let lon = parameters.lon
        let radius = parameters.radius
        let limit = parameters.limit

        let headers = [
            "x-rapidapi-key": "5c6f644f03msh6bf92a915f09b6ap106979jsn1e636fa0aba2",
            "x-rapidapi-host": "aerodatabox.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: NSURL(string: "https://aerodatabox.p.rapidapi.com/airports/search/location/\(lat)/\(lon)/km/\(radius)/\(limit)?withFlightInfoOnly=\(flight)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        let sessionCofiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionCofiguration, delegate: self, delegateQueue: OperationQueue.main)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        responseData = Data()
        
        let session = URLSession.shared
        var dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard error == nil else { return }
            guard data != nil else { return }
        })
        dataTask = defaultSession.dataTask(with: request)
        dataTask.resume()
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(ResponseAirport.self, from: responseData)
                self.delegate?.connectionFinishSuccessfull(session: self, response: response)
            } catch {
                self.delegate?.connectionFinishWithError(session: self, error: error)
            }
        } else {
            delegate?.connectionFinishWithError(session: self, error: error!)
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData.append(data)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        httpResponse = response as? HTTPURLResponse
        switch httpResponse?.statusCode {
        case 200:
            completionHandler(URLSession.ResponseDisposition.allow)
        case 404:
            completionHandler(URLSession.ResponseDisposition.allow)
        case 400:
            completionHandler(URLSession.ResponseDisposition.allow)
        case 500:
            completionHandler(URLSession.ResponseDisposition.allow)
        default:
            completionHandler(URLSession.ResponseDisposition.cancel)
        }
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
