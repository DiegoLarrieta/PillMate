import Foundation
import SwiftUI

// Definir el modelo de datos para un medicamento
struct MedicationModel: Identifiable {
    var id = UUID() // ID único para cada medicamento
    var name: String // Nombre del medicamento
    var dosage: String // Dosis (por ejemplo, 100mg)
    var frequency: String // Frecuencia de toma (por ejemplo, una vez al día)
    var schedule: Date // Horario de toma
    var image: UIImage? // Imagen del medicamento (opcional)
    var isTaken: Bool = false // Estado de si la pastilla ha sido tomada
    
}


