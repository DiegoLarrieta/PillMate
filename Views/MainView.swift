import SwiftUI

struct MainView: View {
    @State private var medications: [MedicationModel] = [] // Lista de medicamentos
    @State private var selectedMedication: MedicationModel? // Medicamento seleccionado
    @State private var isCameraVisible = false // Estado de visibilidad de la cámara
    @State private var capturedImage: UIImage? // Imagen capturada de la cámara

    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                VStack {
                    List {
                        ForEach(medications) { medication in
                            HStack {
                                // Imagen del medicamento
                                if let image = medication.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "pills.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                }
                                
                                // Nombre del medicamento
                                Text(medication.name)
                                    .font(.headline)
                                
                                Spacer()
                                
                                // Casilla de selección para marcar si se tomó la pastilla
                                Button(action: {
                                    toggleMedicationTaken(medication: medication)
                                }) {
                                    Text(medication.isTaken ? "I took it" : "Take it")
                                        .padding(6)
                                        .background(medication.isTaken ? Color.green : Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                        }
                    }
                    .navigationTitle("Medications")

                    // Botón para agregar un medicamento manualmente
                    NavigationLink(destination: AddMedicationView(medications: $medications)) {
                        Text("Add Medication")
                            .font(.title2)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                
                // Botón flotante para la cámara
                Button(action: {
                    isCameraVisible.toggle()
                }) {
                    Image(systemName: "camera.fill")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .padding()

                // Mostrar la cámara si está visible
                if isCameraVisible {
                    CameraView(capturedImage: $capturedImage)
                        .edgesIgnoringSafeArea(.all) // Asegura que la cámara ocupe toda la pantalla
                }
            }
        }
    }
    

    private func toggleMedicationTaken(medication: MedicationModel) {
        if let index = medications.firstIndex(where: { $0.id == medication.id }) {
            medications[index].isTaken.toggle() // Cambiar el estado de "tomado"
        }
    }
}

