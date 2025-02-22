import Vision
import UIKit

// Define a struct to hold recognized medication details
public struct RecognizedMedication {
    var name: String
    var dosage: String
    var frequency: String
    var duration: String
}

public class TextRecognitionService {
    
    // Function to recognize text in an image and return recognized details
    public static func recognizeTextInImage(image: UIImage, completion: @escaping (RecognizedMedication) -> Void) {
        guard let cgImage = image.cgImage else {
            print("No se pudo convertir la imagen en cgImage")
            return
        }
        
        // Create the text recognition request
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("Error reconociendo texto: \(error.localizedDescription)")
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("No se encontró texto reconocido")
                return
            }
            
            // Variables to store recognized medication details
            var medicationName = ""
            var medicationDosage = ""
            var medicationFrequency = ""
            var medicationDuration = ""
            
            // Process the recognized text
            for observation in observations {
                if let topCandidate = observation.topCandidates(1).first {
                    let recognizedString = topCandidate.string.lowercased()
                    
                    // Identify the relevant information
                    if recognizedString.contains("mg") || recognizedString.contains("g") {
                        medicationDosage = topCandidate.string
                    } else if recognizedString.contains("once a day") || recognizedString.contains("daily") {
                        medicationFrequency = topCandidate.string
                    } else {
                        medicationName = topCandidate.string
                    }
                }
            }
            
            // Return the recognized details via the completion handler
            let recognizedMedication = RecognizedMedication(
                name: medicationName,
                dosage: medicationDosage,
                frequency: medicationFrequency,
                duration: medicationDuration
            )
            
            completion(recognizedMedication)
        }
        
        // Create the request handler
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Perform the text recognition request
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error al ejecutar la solicitud de reconocimiento: \(error.localizedDescription)")
        }
    }
}

