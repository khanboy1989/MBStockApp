# 📈 MBStockApp

![iOS CI](https://github.com/khanboy1989/MBStockApp/actions/workflows/ios-ci.yml/badge.svg)

MBStockApp is a modern iOS application that provides real-time stock market summaries and quote details. Built using **SwiftUI**, **Combine**, and **Clean Architecture**, it focuses on modularity, testability, and a smooth user experience.

---

## 🚀 Features

- 🔍 Searchable stock market index list
- 💹 Real-time price updates every 8 seconds
- ✅ Market summary and detailed quote screen
- 🌙 Always in Dark Mode
- 📱 Built entirely with SwiftUI and Combine
- 🧪 Includes complete unit test coverage

---

## 🧱 Architecture (Deep Dive)

MBStockApp is built using **Clean Architecture** principles. Each layer has a dedicated responsibility, which improves testability, scalability, and future flexibility.

### 🔁 Layered Flow Overview

- **View (SwiftUI)**  
  Displays the UI and binds to state via `ViewModel`.
  ↓
- **ViewModel (State, Binding)**  
  Contains logic for managing view state, search, and timers.
  ↓
- **UseCase (Scenario-Specific Logic)**  
  Executes a specific action like fetching market data.
  ↓
- **Repository (Bridge, Transformation)**  
  Maps and transforms data from the source for the use case.
  ↓
- **DataSource (Concrete Data Access)**  
  Provides raw data (e.g., from an API or local cache).
---

### 1. **View Layer (UI)**

- Built with SwiftUI.
- Displays data and listens to state changes from the `ViewModel`.
- Stateless and reactive — no business logic.
- Handles search bar, navigation stack, loading states, and refresh visuals.
- **Examples:** `MarketSummaryView`, `MarketRowView`, `MarketListView`

---

### 2. **ViewModel Layer (Presentation Logic)**

- Uses Combine for reactive state management.
- Handles user interaction, search text debounce, and auto-refresh.
- Calls the appropriate **UseCase** and updates `@Published` properties.
- Maintains UI-specific state such as:
  - `.summaries`
  - `.filteredSummaries`
  - `.searchText`
  - `.state`
- **Example:** `MarketSummaryViewModel`

---

### 3. **UseCase Layer (Scenario Logic)**

- Represents a single business operation (e.g., fetching a market summary).
- Contains no UI or data source logic.
- Easy to test and reuse across features.
- One use case per user scenario — separation ensures lean and focused business logic.
- **Example:** `GetMarketSummaryUseCase`

---

### 4. **Repository Layer (Bridge + Mapper)**

- Acts as a bridge between UseCases and DataSources.
- Transforms raw data into domain-specific models.
- Keeps UseCases unaware of the data source (network, cache, local).
- **Why have it?**
  - Encapsulates logic for transforming remote models to domain models.
  - Can combine multiple DataSources if needed (e.g., cache + API).
  - Future-proof: changing the backend affects only this layer.
- **Example:** `DefaultMarketRepository`

---

### 5. **DataSource Layer (Low-Level Data Access)**

- Provides raw data from remote or local sources.
- Can simulate results using `MarketDataSourceMock`, or connect to an actual API in future.
- **Why this layer exists:**
  - It separates the **implementation** (e.g., HTTP, database) from the rest of the app.
  - Future support for **both local (CoreData/Realm)** and **remote (REST/GraphQL)** sources.
  - Keeps the Repository and UseCase code clean and focused on app logic, not I/O.
- **Example:** `MarketDataSourceMock`, `MarketQuoteResponseModel`, etc.

---

## 📦 Technologies Used

- Swift 5.10 / Swift 6 ready
- SwiftUI
- Combine
- XCTest (unit testing)
- SwiftLint
- Swinject for Dependency Injection

---

## 📁 Project Structure

```text
MBStockApp/
├── Views/          → SwiftUI views and navigation components
├── ViewModels/     → State management, business flow, Combine publishers
├── UseCases/       → Scenario-specific business logic abstractions
├── Repository/     → Bridges between data sources and use cases (mapping, orchestration)
├── DataSource/     → Low-level raw data providers (mocked or remote)
├── Models/         → DTOs and domain models (parsed and mapped)
├── Resources/      → Localized strings, assets, constants
├── Tests/          → Unit tests and test mocks

---

## 🧪 Running Tests

MBStockApp includes unit tests for ViewModels, UseCases, and Repository logic.

To run all tests:

### ➤ In Xcode:
Use the following shortcut:

### ➤ From Terminal:

```bash
xcodebuild test -scheme MBStockApp -destination 'platform=iOS Simulator,name=iPhone 14,OS=17.4'
```

📇 Author
	•	👨‍💻 Name: Serhan Khan
	•	🌐 Website / Portfolio: [Add if available]
	•	📧 Email: serhankhan0@gmail.com
	•	🔗 LinkedIn: linkedin.com/in/serhan-khan-97b577103
	•	🐙 GitHub: github.com/khanboy1989
	•	✍️ Medium: medium.com/@serhankhan
	•	🎥 YouTube: youtube.com/@SwiftwithSerhan-d7x
