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
    
    var translatedPlanetName: String {
        let translations: [Int: String] = [
            2: "Earth",
            4: "Frieza #79",
            11: "North Kai",
            15: "Tsufur (Universe 6)",
            16: "Unknown",
            18: "Other World",
            19: "Beerus' Planet",
            20: "Grand Kai's Planet",
            21: "World Core",
            22: "Sacred Planet",
            23: "New Tsufrui Planet",
            24: "Zeno's Moving Temple",
            25: "Universe 11"
        ]
        return translations[id] ?? name
    }
    
    var planetStatus: String {
        isDestroyed ? "Destroyed" : "Undestroyed"
    }
    
    var translatedPlanetDescription: String {
        let translations: [Int: String] = [
            1: "Home planet of the Namekians. Scene of important battles and the acquisition of the Namek Dragon Balls.",
            2: "Earth, also called Dragon World, is the main planet where the Dragon Ball series takes place. It is located in the Solar System of the Milky Way in the Northern Galaxies of Universe 7, supervised by the North Kaio, and has its equivalent in Universe 6. Home to Earthlings and the Z Fighters. It has been attacked several times by powerful enemies.",
            3: "Planet Vegeta, known as Planet Plant before the end of the Saiyan-Tsufurian War in year 730, is a fictional rocky planet from the Dragon Ball manga and anime series. It was located in the Milky Way of the Northern Galaxies of Universe 7 until its destruction by Frieza in the years 737-739. Home planet of the Saiyans, destroyed by Frieza. Previously known as Planet Plant.",
            4: "Artificial planet used by Frieza as a base of operations and cloning center.",
            5: "Planet inhabited by the Kanassans, known for the battle between Bardock and the inhabitants of the planet.",
            6: "Planet where Gohan and Krillin found the Dragon Balls to revive their friends during the Namek Saga.",
            7: "Planet of the Instant Transmission technique, learned by Goku during his stay.",
            11: "The Kaio Planet is located at the end of the long Snake Way. It is where the North Kaio, his pet Bubbles (whom he uses for training), and Gregory live.",
            13: "Makyo is a planet and the power source of all the malevolent beings, especially Garlic Jr., who only appears during the Garlic Jr. Arc in Dragon Ball Z.",
            14: "Planet inhabited by the Babari, a terrestrial planet in Universe 10 where the Babarians reside. It first appeared in episode 54 of Dragon Ball Super. It is where Tarble, Vegeta's brother, took refuge.",
            15: "Home planet of the Tsufur, the race to which Dr. Raichi belonged.",
            16: "No information available.",
            18: "The Other World, in contrast to the World of the Living, is, in Dragon Ball, the version of the world of the dead. It is where characters go when they die and also where the higher deities of the universe reside. In episode 53 of the anime, the Other World was described as 'the next dimension,' and the act of wishing someone back to life with the Dragon Balls is called 'bringing them to this dimension.'",
            19: "Beerus' Planet is a celestial body located within the world of the living in Universe 7. It first appeared in the movie Dragon Ball Z: Battle of Gods.",
            20: "The Grand Kaio's Planet is where the Other World Martial Arts Tournament is held in honor of the death of the North Kaio (Kaito), where powerful warriors participate.",
            21: "The Core of the World is the native planet of the entire nucleic species, from which the benevolent Kaio and Kaio-shin, as well as the malevolent Makaio, Makaio-shin, and Demon Gods, originate.",
            22: "The Sacred Planet is located in the Kaio-shin Realm, where the Kaio-shin of Universe 7 reside. It should not be confused with the Core of the World. The Kaio-shin Realm, where the planet is located, is a special realm completely separate from the macrocosm of Universe 7, meaning it is separate from the Other World, the World of the Living, and the Dark Demon Realm.",
            23: "The New Planet Plant, also known as New Tsufrui Planet, is the name given to the new home of the Tsufruians controlled by Vegeta Baby, created thanks to the wish granted by the Ultimate Dragon Balls to restore Planet Plant into Earth's orbit.",
            24: "The mobile temple of the King of All (throne room) is, as its name suggests, a mobile temple where the thrones of the two Kings of All reside in the Place of Survival in Dragon Ball Super.",
            25: "Universe 11, as its name suggests, is the eleventh of the twelve universes currently existing in the Dragon Ball world. It is twin to Universe 2 and the origin of the Pride Troopers."
        ]
        return translations[id] ?? "Planet description not available"
    }
}

// MARK: - Transformation
struct Transformation: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
    let ki: String
}
