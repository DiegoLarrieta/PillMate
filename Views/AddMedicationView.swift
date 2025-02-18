import SwiftUI

struct AddMedicationView: View {
    @State private var name: String = ""
    @State private var dosage: String = ""
    @State private var selectedDosageUnit: String = "mg" // Default unit for dosage
    @State private var frequencyValue: String = "" // Default frequency value
    @State private var selectedFrequencyUnit: String = "Hours" // Default unit for frequency
    @State private var schedule: Date = Date()
    @Binding var medications: [MedicationModel]

    
    // Unidades para el Picker de Dosage
    let dosageUnits = ["mg", "g", "ml", "L", "unit", "packet"] // Agregamos las opciones
    // Unidades para el Picker de Frequency
    let frequencyUnits = ["Seconds", "Minutes", "Hours", "Days", "Weeks", "Months", "Years"]

    var body: some View {
        Form {
            Section {
                TextField("Medication Name", text: $name)
                
                HStack {
                    // Entrada de cantidad para Dosage
                    TextField("Dosage", text: $dosage)
                        .keyboardType(.decimalPad) // Usamos el teclado para números decimales
                        .frame(width: 100)

                    // Picker para seleccionar la unidad de dosage
                    Picker("", selection: $selectedDosageUnit) {
                        ForEach(dosageUnits, id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // Estilo de menú para el Picker
                }
                
                // HStack para Frequency
                HStack {
                    // Campo de texto para la cantidad de frecuencia
                    TextField("Frequency Value", text: $frequencyValue)
                        .keyboardType(.decimalPad) // Usamos el teclado para números
                        .frame(width: 50)
                    
                    // Picker para seleccionar la unidad de frecuencia
                    Picker("", selection: $selectedFrequencyUnit) {
                        ForEach(frequencyUnits, id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // Estilo de menú para el Picker
                }

                DatePicker("Schedule", selection: $schedule, displayedComponents: .hourAndMinute)
            }

            Button(action: addMedication) {
                Text("Add Medication")
            }
        }
        .navigationTitle("Add Medication")
    }

    private func addMedication() {
        // Asegúrate de agregar la unidad seleccionada en la dosis
        let newMedication = MedicationModel(
            name: name,
            dosage: dosage + " " + selectedDosageUnit, // Unimos la dosis con la unidad seleccionada
            frequency: frequencyValue + " " + selectedFrequencyUnit, // Unimos la frecuencia con la unidad seleccionada
            schedule: schedule,
            image: nil,
            isTaken: false
        )
        medications.append(newMedication)
        print("Medication Added: \(name), \(dosage) \(selectedDosageUnit), \(frequencyValue) \(selectedFrequencyUnit), \(schedule)")
    }
}

