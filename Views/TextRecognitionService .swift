import Vision
import UIKit

// Declaramos la clase como pública para que sea accesible desde otros archivos
public class TextRecognitionService {
    
    // Esta función se encarga de hacer el reconocimiento de texto en una imagen
    public static func recognizeTextInImage(image: UIImage) {
        guard let cgImage = image.cgImage else {
            print("No se pudo convertir la imagen en cgImage")
            return
        }
        
        // Crear la solicitud de reconocimiento de texto
        let request = VNRecognizeTextRequest { request, error in
            // Manejar cualquier error en el reconocimiento
            if let error = error {
                print("Error reconociendo texto: \(error.localizedDescription)")
                return
            }
            
            // Extraer los resultados del reconocimiento de texto
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("No se encontró texto reconocido")
                return
            }
            
            // Aquí procesamos el texto que se ha reconocido
            for observation in observations {
                if let topCandidate = observation.topCandidates(1).first {
                    print("Texto reconocido: \(topCandidate.string)")
                    
                    // Aquí puedes procesar la información extraída de la receta, como el nombre del medicamento, dosis, etc.
                }
            }
        }
        
        // Crear el handler para ejecutar la solicitud
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Ejecutar la solicitud
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error al ejecutar la solicitud de reconocimiento: \(error.localizedDescription)")
        }
    }
}

