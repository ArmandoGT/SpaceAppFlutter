# 🚀 **Diário Espacial – Flutter**
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![NASA API](https://img.shields.io/badge/API-NASA-0b3d91?logo=nasa&logoColor=white)](https://api.nasa.gov/)
[![Status](https://img.shields.io/badge/Status-Concluído-success)]()
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)]()

## 1. Descrição do Projeto

Este aplicativo foi desenvolvido como parte da disciplina de **Programação Mobile I** do curso de Análise e Desenvolvimento de Sistemas do **Instituto Federal de Rondônia (IFRO)**.

O objetivo do projeto é criar um diário espacial interativo utilizando o framework **Flutter** que consome a **API oficial da NASA (Astronomy Picture of the Day - APOD)**. A aplicação permite que o usuário visualize a imagem astronômica do dia, navegue por datas anteriores através de um calendário e gerencie uma galeria pessoal de imagens favoritas.

O projeto implementa conceitos fundamentais de desenvolvimento mobile, incluindo:
*   **Arquitetura de Software:** Separação de responsabilidades em Camadas (Models, Screens, Services, Providers).
*   **Integração de API:** Consumo de dados remotos via HTTP (GET) com tratamento de imagens e vídeos.
*   **Gerenciamento de Estado:** Uso do padrão Provider para reatividade entre a tela do dia e a lista de favoritos.
*   **Persistência de Dados:** Armazenamento local dos favoritos utilizando `shared_preferences`.

### Capturas de Tela

|                        Imagem do Dia                        |                        Seleção de Data                         |                       Galeria de Favoritos                        |
|:----------------------------------------------------------:|:--------------------------------------------------------------:|:------------------------------------------------------------:|
| ![Tela Inicial](assets/images/printscreen/Home_Screen_Print.jpeg) | ![Calendário](assets/images/printscreen/DatePicker_Print.jpeg) | ![Favoritos](assets/images/printscreen/.jpeg) |
> *Figura 1: Tela principal exibindo a Imagem Astronômica do Dia (APOD).*

> *Figura 2: Funcionalidade de DatePicker para viajar no tempo e ver fotos antigas.*

> *Figura 3: Lista de favoritos persistente, onde o usuário guarda suas descobertas espaciais.*

> *Plataformas testadas: Android (Emulador: Pixel 4 API 36.0 / Dispositivo Físico: Xiaomi Redmi Note 13 Pro)*

---

## 2. API Utilizada

A aplicação consome dados públicos da **NASA Open APIs**.

*   **Documentação Oficial:** [https://api.nasa.gov/](https://api.nasa.gov/)
*   **Endpoint principal utilizado:**
    *   `GET /planetary/apod`: Utilizado para recuperar a "Astronomy Picture of the Day".
    *   Parâmetros usados: `api_key` (autenticação) e `date` (para buscar imagens de datas específicas).

---

## 3. Principais Packages e Dependências

Para atender aos requisitos funcionais e não-funcionais, foram utilizados os seguintes pacotes externos:

*   **`http`**: Responsável por realizar as requisições HTTP para a API da NASA e converter os dados JSON.
*   **`provider`**: Utilizado para o gerenciamento de estado centralizado, controlando o fluxo de dados entre a busca da API e a persistência dos favoritos.
*   **`shared_preferences`**: Implementado para salvar a lista de favoritos no dispositivo, garantindo que os dados permaneçam mesmo após fechar o app.
*   **`intl`**: Utilizado para formatação de datas e localização do calendário para Português (pt-BR).

---

## **4. Instruções de Execução**

Certifique-se de ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.
```bash
git clone https://github.com/ArmandoGT/SpaceAppFlutter.git
cd spaceappflutter 
flutter pub get 
flutter run
```

*Obs: Configure sua chave da API da NASA em `lib/services/nasa_service_example.dart`, substitua 'DEMO_KEY' pela a sua ou deixe para testes, retire "_example" do nome do arquivo.*


### ➭ **Gerar APK (Instalação)**

Caso deseje gerar o arquivo de instalação otimizado para Android (Release):
```bash
flutter build apk
```
Após o término do processo, o arquivo instalável (`app-release.apk`) estará localizado em:
**`build/app/outputs/flutter-apk/app-release.apk`**


---

**Criado com dedicação 🧭 por [ArmandoGT](https://github.com/ArmandoGT)**

