# Staff Attendance System (Staff App)

A Flutter-based mobile application designed for staff members to manage and track their attendance, view upcoming holidays, and interact with college-specific data.

## 1. Project Overview
- **Tech Stack**: Flutter, Riverpod (State Management), Firebase (Auth & Firestore), `intl` (Date Formatting).
- **Architecture**: Adheres to **Clean Architecture** principles, maintaining a strict separation between data, domain, and presentation layers.
- **Key Features**: Location-based attendance tracking, holiday indicators, attendance percentage calculation, and shift management.

## 2. Recent Changes
- **College Holiday Fetching**: Added a new use case to retrieve upcoming college holiday details.
- **Controller Implementation**: Developed `CollegeHolidayController` to manage the fetching logic and state transitions (Data, Error, Loading).
- **UI Updates**:
    - **UpcomingHolidayIndicatorWidget**: Refactored the static `Column` to a `ListView.builder` for dynamic holiday rendering.
    - **Item Limiting**: Configured the dashboard to show only the **first 2** upcoming holidays using `min(2, holidays.length)`.
    - **HolidayCardWidget Refinement**: Fixed alignment issues and reduced vertical spacing between text elements (holiday name and type/date) using adjusted line heights (`height: 1.1`).
- **Attendance Percentage Logic**: Optimized the attendance percentage calculation use case to handle null checks and refined working day logic.

## 3. Project Structure
The project is organized by features, each following a Clean Architecture pattern:
- `lib/core/`: Common utilities, themes, and shared logic.
- `lib/features/home/`:
    - `data/`: Data sources (Firebase/Local) and repository implementations.
    - `domain/`: Business logic.
        - `entities/`: Plain data classes.
        - `usescases/`: (Note: current folder misspelling `usescases`) Interactors for specific business tasks (e.g., `GetCollegeHolidayUseCase`).
        - `repositories/`: Abstract repository definitions.
    - `presentation/`: UI components.
        - `controllers/`: State Notifiers managing business logic for the UI.
        - `controllers/states/`: Definitions for UI states (e.g., `CollegeHolidayDataState`).
        - `screens/`: Main page-level widgets.
        - `widgets/`: Reusable components (e.g., `UpcomingHolidayIndicatorWidget`).

## 4. Key Concepts
- **State Management (Riverpod)**: Uses `StateNotifierProvider` and `FutureProvider` to handle asynchronous operations and UI state updates.
- **Use Case Pattern**: All business logic is encapsulated in `UseCase` classes, typically extending a base `FutureUseCase`.
- **Data Flow**: `UI (ConsumerWidget) → Controller (Notifier) → UseCase → Repository → DataSource`.
- **Dependency Injection**: Dependencies are managed and provided via Riverpod providers in `dependency.dart`.

## 5. How to Continue Development
- **Adding Features**: Create a new directory under `lib/features/` and follow the `data/domain/presentation` pattern.
- **Business Logic**: Always place business logic in a `UseCase`. Avoid putting side effects directly in the Controller if they are reusable.
- **UI Consistency**: Use existing widgets in `presentation/widgets` or `core` for consistent styling. When creating new cards or indicators, ensure they are responsive and use the established margin/padding tokens.
- **States**: Use sealed classes or union-like patterns (when possible via Riverpod) to represent Loading, Data, and Error states explicitly.

## 6. Coding Standards
- **Clean Architecture**: Never import `data` layer components directly into the `presentation` layer; use the abstract repository from `domain`.
- **Separation of Concerns**: Keep widgets focused on UI. Complex logic belongs in controllers or use cases.
- **Naming Conventions**: 
    - Use `PascalCase` for classes and `camelCase` for variable names. 
    - Append `UseCase`, `Controller`, `State`, or `Widget` to file types for clarity.
- **Null Safety**: Always handle potential nulls from backend services (Firebase/Firestore) gracefully in the data/domain layer.

## 7. Setup Instructions
1. **Clone the repository.**
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Firebase Setup**: Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are correctly configured in their respective platform directories.
4. **Run the project**:
   ```bash
   flutter run
   ```

---
*Optimized for AI Agents: This README serves as a context manifest for automated development tools. When adding logic, refer to the `dependency.dart` for provider definitions.*
