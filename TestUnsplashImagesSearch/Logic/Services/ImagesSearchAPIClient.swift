//
//  ImagesSearchAPIClient.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import Foundation

//MARK: - GitHub Users API client protocol
protocol ImagesSearchAPIClientProtocol {
    func getImages() async throws -> ImageAPIResponse?
}


//MARK: - GitHub Users API client
final class ImagesSearchAPIClient: APIHelper, ImagesSearchAPIClientProtocol {
    
    //MARK: Internal
    func getImages() async throws -> ImageAPIResponse? {
        do {
            let data = try await self.get()
            if let response: ImageAPIResponse = JSONHelper.decode(data) {
                return response
            } else {
                return nil
            }
        } catch {
            throw APIError.ACRequestError.unknownApplicationAPIGetError
        }
    }
}
