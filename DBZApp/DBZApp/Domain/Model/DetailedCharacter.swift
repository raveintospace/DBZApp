//
//  DetailedCharacter.swift
//  DBZApp
//  https://dragonball-api.com/api/characters/1
//  Created by Uri on 6/10/24.
//

import Foundation

struct DetailedCharacter: Codable {
    let originPlanet: OriginPlanet
    let transformations: [Transformation]
    
    static var mock: DetailedCharacter {
        DetailedCharacter(
            originPlanet: OriginPlanet(
                id: 3,
                name: "Vegeta",
                isDestroyed: true,
                description: "Planet Vegeta, known as planet Plant before the end of the Saiyan-Tsufruian War in 730, is a fictional rocky planet in the Dragon Ball manga and anime series and located in the Northern Galaxy Milky Way of Universe 7 until its destruction at the hands of Freezer in the years 737-739. Home planet of the Saiyans, destroyed by Freezer. Formerly known as Planet Plant.",
                image: "https://dragonball-api.com/planetas/Planeta_Vegeta_en_Dragon_Ball_Super_Broly.webp"
            ),
            transformations: [
                Transformation(
                    id: 1,
                    name: "Goku SSJ",
                    image: "https://dragonball-api.com/transformaciones/goku_ssj.webp",
                    ki: "3 Billion"
                ),
                Transformation(
                    id: 2,
                    name: "Goku SSJ2",
                    image: "https://dragonball-api.com/transformaciones/goku_ssj2.webp",
                    ki: "6 Billion"
                )
            ]
        )
    }
}

// MARK: - Origin Planet
struct OriginPlanet: Codable, Identifiable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
    
    var translatedName: String {
        let translations: [String: String] = [
            "Tierra": "Earth",
            "Freezer No. 79": "Frieza #79",
            "Kaiō del Norte": "North Kai",
            "Otro Mundo": "Other World",
            "Planeta de Bills": "Beerus' Planet",
            "Planeta del Gran Kaio": "Grand Kai's Planet",
            "Nucleo del Mundo": "World Core",
            "Planeta sagrado": "Sacred Planet",
            "Nuevo Planeta Tsufrui": "New Tsufrui Planet",
            "Templo móvil del Rey de Todo": "Zeno's Moving Temple",
            "Universo 11": "Universe 11"
        ]
        return translations[name] ?? name
    }
}

// MARK: - Transformation
struct Transformation: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
    let ki: String
}
