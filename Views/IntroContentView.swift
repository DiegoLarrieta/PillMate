import SwiftUI

struct IntroContentView: View {
    @State private var currentPage = 0 // Estado para gestionar las pantallas de la introducción

    var body: some View {
        VStack {
            // Título y contenido basado en la página actual
            switch currentPage {
            case 0:
                WelcomeView(currentPage: $currentPage)
            case 1:
                HowItWorksView(currentPage: $currentPage)
            case 2:
                BenefitsView(currentPage: $currentPage)
            default:
                MainView()
            }
        }
    }
}


struct WelcomeView: View {
    @Binding var currentPage: Int

    var body: some View {
        ZStack {
            // Imagen de fondo
            Image("FondoPillMate") // Usamos el nombre de la imagen que has puesto en Assets
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Asegura que la imagen cubra toda la pantalla

            VStack {
                Text("Bienvenido a PillMate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()

                Text("La app para llevar un control fácil y efectivo de tus medicamentos.")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()

                Button(action: {
                    currentPage = 1
                }) {
                    Text("Siguiente")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()

                // Mensaje en la parte inferior
                Text("Developed by Diego Larrieta")
                    .font(.footnote)
                    .foregroundColor(.black)
                    .padding(.bottom, 20) // Ajustamos la distancia desde el fondo
            }
            .padding()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(currentPage: .constant(0))
    }
}

struct HowItWorksView: View {
    @Binding var currentPage: Int

    var body: some View {
        ZStack {
            // Imagen de fondo
            Image("FondoPillMate") // Usamos el nombre de la imagen que has puesto en Assets
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Asegura que la imagen cubra toda la pantalla
            
            VStack {
                Text("¿Cómo funciona?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("1. Escanea tu receta médica.\n2. Configura los horarios de toma.\n3. Recibe recordatorios.")
                    .font(.title2)
                    .padding()
                
                Button(action: {
                    currentPage = 2
                }) {
                    Text("Siguiente")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct BenefitsView: View {
    @Binding var currentPage: Int

    var body: some View {
        ZStack {
            // Imagen de fondo
            Image("FondoPillMate") // Usamos el nombre de la imagen que has puesto en Assets
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all) // Asegura que la imagen cubra toda la pantalla
            
            VStack {
                Text("Beneficios")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Con PillMate, podrás llevar un control preciso de tus medicamentos y nunca olvidarás tomarlos.")
                    .font(.title2)
                    .padding()
                
                Button(action: {
                    currentPage = 3
                }) {
                    Text("Comenzar")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IntroContentView()
    }
}


