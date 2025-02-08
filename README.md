
# Miguel Castellanos
## CatApp
![Cat_Placeholder](https://github.com/user-attachments/assets/c8956f66-5b0f-462d-9200-df4546aedeaf)


- This App displays a list of breeds and their detailed view, obtained from an API using URLSession.
- UI has a searchable text field, which allows users to filter breeds by name.
- Breed data is retrieved with pagination, which ensures better performance of the app, loading data partialy.
- The architechture used in this project is MVVM.
- This project also abstracts Data Manage, therefore we can find a DataManager which fullfills Repository Pattern requirements.
- Its interface is implemented using SwiftUI, which ensures a reactive response.
- The app uses Kingfisher third party library,to manage images.
- Third party libraries are handled using Swift Package Manager.

# How it works
- Just below you can find a video of the project running.

### Loading View
https://github.com/user-attachments/assets/d49c48ef-5768-4dd0-b50e-18944d727339

### Empty State View
<img width="359" alt="Captura de pantalla 2025-02-07 a la(s) 7 00 51 p m" src="https://github.com/user-attachments/assets/bf8b2fe6-a42c-4058-ba6b-efd23c3474ea" />

### Running App
https://github.com/user-attachments/assets/ba0d4cd3-5492-4957-8aaa-be5b2d4824ed

# Testing
- Project Have tests for basic network functionalities and for basic UI navigation and views loading

![Captura de pantalla 2025-02-07 a la(s) 11 39 17 a m](https://github.com/user-attachments/assets/240d60e4-8614-4964-93a1-2996ed0ed5a2)


